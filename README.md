### Installer

This is a script for download binary from Github Release and install in your computer.

For a long time, I wrote a lot of tools and released them on Github Release, but I had to write an installation script for each tool.

This took me a lot of time and did a lot of repetitive work.

So I decided to write a universal script, which applies to all repo.

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
curl -fsSL https://github.com/release-lab/install/raw/v1/install.sh | bash -s -- -r={owner}/{repo}
```

install specified version

```bash
curl -fsSL https://github.com/release-lab/install/raw/v1/install.sh | bash -s -- -r={owner}/{repo} -v={version}
```

specified the filename

```bash
curl -fsSL https://github.com/release-lab/install/raw/v1/install.sh | bash -s -- -r={owner}/{repo} -e={exe}
```

### 2. PowerShell (Windows):

install latest version

```powershell
$r="{owner}/{repo}";iwr https://github.com/release-lab/install/raw/v1/install.ps1 -useb | iex
```

install specified version

```powershell
$r="{owner}/{repo}";$v="{version}";iwr https://github.com/release-lab/install/raw/v1/install.ps1 -useb | iex
```

specified the filename

```bash
$r="{owner}/{repo}";$exe="{exe}";iwr https://github.com/release-lab/install/raw/v1/install.ps1 -useb | iex
```
