### install script for all package

1. Shell (Mac/Linux)

```bash
# install latest version
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s release-lib/whatchanged
# or install specified version
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s release-lib/whatchanged -v=v0.4.1
# specified the filename or tar
# eg. -e=<name> means find <name>_<os>_arch_.tar.gz
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s release-lib/whatchanged -e=whatchanged
```

2. PowerShell (Windows):

```bash
# install latest version
iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
# or install specified version
$v="v0.4.1"; iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
```