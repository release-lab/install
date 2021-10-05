### Installer

This is a script for download binary from Github Release and install in your computer.

For a long time, I wrote a lot of tools and released them on Github Release, but I had to write an installation script for each tool.

This took me a lot of time and did a lot of repetitive work.

So I decided to write a universal script, which applies to all warehouses.

It needs to meet the following format `{name}_{os}_{arch}.tar.gz`

eg.

```
whatchanged_darwin_amd64.tar.gz
whatchanged_darwin_arm64.tar.gz
whatchanged_freebsd_amd64.tar.gz
whatchanged_windows_amd64.tar.gz
...
```

### 1. Shell (Mac/Linux)

install latest version

```bash
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s {owner}/{repo}

# example:
#curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s release-lab/whatchanged
```

install specified version

```bash
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s {owner}/{repo} -v={version}

# example:
#curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s release-lab/whatchanged -v=v0.4.1
```

specified the filename

```bash
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s {owner}/{repo} -e={exe}

# example:
#curl -fsSL https://github.com/release-lab/install/raw/master/install.sh | bash -s release-lab/whatchanged -e=whatchanged
```

### 2. PowerShell (Windows):

install latest version

```powershell
$repo="{owner}/{repo}";iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex

# example:
# $repo="release-lab/whatchanged";iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
```

install specified version

```powershell
$repo="{owner}/{repo}";$v="{version}";iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex

# example:
# $repo="release-lab/whatchanged";$v="v0.4.1";iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
```

specified the filename

```bash
$repo="{owner}/{repo}";$exe="{exe}";iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex

# example:
# $repo="release-lab/whatchanged";$exe="whatchanged";iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
```
