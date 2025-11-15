# GitRepoUpdater PowerShell Module
[![PSGallery Version](https://img.shields.io/powershellgallery/v/GitRepoUpdater.svg?style=flat&logo=powershell&label=PSGallery%20Version)](https://www.powershellgallery.com/packages/GitRepoUpdater) [![PowerShell](https://img.shields.io/badge/PowerShell-5.1-blue?style=flat&logo=powershell)](https://www.powershellgallery.com/packages/GitRepoUpdater) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/GitRepoUpdater.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)](https://www.powershellgallery.com/packages/GitRepoUpdater) 

A PowerShell module to easily pull updates from multiple Git repositories at once.

<img title="Sync-EveryRepo execution result" alt="Sync-EveryRepo example" src="./Screenshots/Sync-EveryRepo example.png" width="75%">

**Note**: if you need a simple script to copy paste and run once in a directory instead take a look at [this](./archive/pulleveryrepo.ps1)

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [Usage Example](#usage-example)
- [Support](#support)
- [License](#license)

## Features

- Recursively finds all Git repositories in a directory
- Pulls latest changes with clear visual feedback
- Provides detailed summary
- Safe error handling

## Requirements

- Windows PowerShell 5.1 or newer
- [Git](https://git-scm.com/) installed and in PATH

## Installation

1. Clone this repository or simply download it
2. Run the installer:  
 as administrator to install for all users  
 as regular user to install only for current user

```powershell
git clone https://github.com/ExiledEye/GitRepoUpdater
cd GitRepoUpdater && powershell -ExecutionPolicy Bypass -File .\Install-GitRepoUpdater.ps1
```

Or alternatively simply install it from PowerShell Gallery:
```powershell
Install-Module -Name GitRepoUpdater
```

## Updating

1. Pull the repo (ironic, don't you think?)
2. Run the installer

```powershell
cd GitRepoUpdater && git pull
powershell -ExecutionPolicy Bypass -File .\Install-GitRepoUpdater.ps1
```

Or alternatively simply update it from PowerShell Gallery:
```powershell
Update-Module -Name GitRepoUpdater
```

## Uninstalling

1. Run the uninstaller
2. Optionally also delete the local repo directory

```powershell
cd GitRepoUpdater
powershell -ExecutionPolicy Bypass -File .\Uninstall-GitRepoUpdater.ps1
```

Or alternatively simply uninstall it using:
```powershell
Remove-Module -Name GitRepoUpdater
```

## Usage Example

```powershell
cd *directory with multiple repos*
Sync-EveryRepo #Alias: ser
```

## Support

If you encounter any problems or have suggestions, please [open an issue](https://github.com/ExiledEye/GitRepoUpdater/issues).

## License

Copyright (c) 2025 Exiled Eye  
This project is licensed under the MIT License.  
See the [LICENSE](LICENSE) file for details.
