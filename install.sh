#!/bin/sh

set -e

if [ $# -eq 0 ]; then
    echo "ERROR: Need to specify the install repository"
    exit 1
fi

# eg. release-lab/whatchanged
target=""
owner=""
repo=""
exe_name=""
githubUrl=""
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
        -r=*|--repo=*)
            target="${i#*=}"
            shift # past argument=value
        ;;
        -v=*|--version=*)
            version="${i#*=}"
            shift # past argument=value
        ;;
        -e=*|--exe=*)
            exe_name="${i#*=}"
            shift # past argument=value
        ;;
        -g=*|--github=*)
            githubUrl="${i#*=}"
            shift # past argument=value
        ;;
        *)
            # unknown option
        ;;
    esac
done

args=(`echo $target | tr '/' ' '`)

if [ ${#args[@]} -ne 2 ]; then
    echo "ERROR: invalid params for repo '$1'"
    echo "ERROR: the argument should be format like 'owner/repo'"
    exit 1
else
    owner=${args[0]}
    repo=${args[1]}
fi

if [ -z "$ext_name" ]; then
    ext_name=$repo
    echo "INFO: file name is not specified, use '$repo'"
    echo "INFO: if you want to specify the name of the executable, set flag --exe=name"
fi

if [ -z "$githubUrl" ]; then
    githubUrl="https://github.com"
fi

downloadFolder="${HOME}/Downloads"
mkdir -p ${downloadFolder} # make sure download folder exists
os=$(get_os)
arch=$(get_arch)
file_name="${exe_name}_${os}_${arch}.tar.gz" # the file name should be download
downloaded_file="${downloadFolder}/${file_name}" # the file path should be download
executable_folder="/usr/local/bin" # Eventually, the executable file will be placed here

# if version is empty
if [ -z "$version" ]; then
    asset_path=$(
        command curl -sSf ${githubUrl}/${owner}/${repo}/releases |
        command grep -o "/${owner}/${repo}/releases/download/.*/${file_name}" |
        command head -n 1
    )
    if [[ ! "$asset_path" ]]; then exit 1; fi
    asset_uri="${githubUrl}${asset_path}"
else
    asset_uri="${githubUrl}/${owner}/${repo}/releases/download/${version}/${file_name}"
fi

echo "[1/3] Download ${asset_uri} to ${downloadFolder}"
rm -f ${downloaded_file}
curl --fail --location --output "${downloaded_file}" "${asset_uri}"

echo "[2/3] Install ${exe_name} to the ${executable_folder}"
tar -xz -f ${downloaded_file} -C ${executable_folder}
exe=${executable_folder}/${exe_name}
chmod +x ${exe}

echo "[3/3] Set environment variables"
echo "${exe_name} was installed successfully to ${exe}"
if command -v $exe_name --version >/dev/null; then
    echo "Run '$exe_name --help' to get started"
else
    echo "Manually add the directory to your \$HOME/.bash_profile (or similar)"
    echo "  export PATH=${executable_folder}:\$PATH"
    echo "Run '$exe_name --help' to get started"
fi

exit 0