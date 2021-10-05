#!/bin/sh

set -e

if [ $# -eq 0 ]; then
    echo "Need to specify the install repository"
    exit 1
fi

# eg. release-lab/whatchanged
args=(`echo $1 | tr '/' ' '`)

if [ ${#args[@]} -ne 2 ]; then
    echo "invalid params for repo '$1'"
    echo "the argument should be format like 'owner/repo'"
    exit 1
fi

downloadFolder="${HOME}/Downloads"
owner=${args[0]}
repo=${args[1]}
exe_name=""
version=""

get_arch() {
    # darwin/amd64: Darwin axetroydeMacBook-Air.local 20.5.0 Darwin Kernel Version 20.5.0: Sat May  8 05:10:33 PDT 2021; root:xnu-7195.121.3~9/RELEASE_X86_64 x86_64
    a=$(uname -m)
    case ${a} in
        "x86_64" | "amd64" )
            echo "amd64"
        ;;
        "i386" | "i486" | "i586")
            echo "386"
        ;;
        "aarch64" | "arm64" | "arm")
            echo "arm64"
        ;;
        *)
            echo ${NIL}
        ;;
    esac
}

get_os(){
    # darwin: Darwin
    echo $(uname -s | awk '{print tolower($0)}')
}

# parse flag
for i in "$@"; do
    case $i in
        -v=*|--version=*)
            version="${i#*=}"
            shift # past argument=value
        ;;
        -e=*|--exe=*)
            exe_name="${i#*=}"
            shift # past argument=value
        ;;
        *)
            # unknown option
        ;;
    esac
done

if [ -z "$exe_name" ]; then
    exe_name=$repo
    echo "file name is not specified, use '$repo'"
fi

mkdir -p ${downloadFolder}

os=$(get_os)
arch=$(get_arch)
dest_file="${downloadFolder}/${exe_name}_${os}_${arch}.tar.gz"

# if version is empty
if [ -z "$version" ]; then
    asset_path=$(
        command curl -sSf https://github.com/${owner}/${repo}/releases |
        command grep -o "/${owner}/${repo}/releases/download/.*/${exe_name}_${os}_${arch}.tar.gz" |
        command head -n 1
    )
    if [[ ! "$asset_path" ]]; then exit 1; fi
    asset_uri="https://github.com${asset_path}"
else
    asset_uri="https://github.com/${owner}/${repo}/releases/download/${version}/${exe_name}_${os}_${arch}.tar.gz"
fi

mkdir -p ${downloadFolder}

echo "[1/3] Download ${asset_uri} to ${downloadFolder}"
rm -f ${dest_file}
curl --fail --location --output "${dest_file}" "${asset_uri}"

binDir=/usr/local/bin

echo "[2/3] Install ${exe_name} to the ${binDir}"
mkdir -p ${HOME}/bin
tar -xz -f ${dest_file} -C ${binDir}
exe=${binDir}/${exe_name}
chmod +x ${exe}

echo "[3/3] Set environment variables"
echo "${exe_name} was installed successfully to ${exe}"
if command -v $exe_name --version >/dev/null; then
    echo "Run '$exe_name --help' to get started"
else
    echo "Manually add the directory to your \$HOME/.bash_profile (or similar)"
    echo "  export PATH=${HOME}/bin:\$PATH"
    echo "Run '$exe --help' to get started"
fi

exit 0