### install script for all package

1. Shell (Mac/Linux)

install latest version

```bash
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh \
  | bash -s release-lab/whatchanged
```

install specified version

```bash
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh \
  | bash -s release-lab/whatchanged -v=v0.4.1
```

specified the filename

```bash
curl -fsSL https://github.com/release-lab/install/raw/master/install.sh |
  | bash -s release-lab/whatchanged -e=whatchanged
```

2. PowerShell (Windows):

install latest version

```powershell
$repo=release-lab/whatchanged; $exe=whatchanged; \
  iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
```

install specified version

```powershell
$repo=release-lab/whatchanged; $exe=whatchanged; $v="v0.4.1"; \
  iwr https://github.com/release-lab/install/raw/master/install.ps1 -useb | iex
```
