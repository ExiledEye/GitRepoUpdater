# GitRepoUpdater PowerShell Module

A simple PowerShell module to manage multiple Git repositories at once.

<img title="Sync-EveryRepo execution result" alt="Sync-EveryRepo example" src="./Screenshots/Sync-EveryRepo example.png" width="50%">

## Features

- Recursively finds all Git repositories in a directory
- Pulls latest changes with clear visual feedback
- Provides detailed summary
- Safe error handling

## Requirements

- Windows PowerShell 5.1 or newer
- Git installed and in PATH

## Installation

1. Clone this repository or simply download it
2. Run the installer:  
 as administrator to install for all users  
 as regular user to install only for current user

```powershell
git clone https://github.com/ExiledEye/GitRepoUpdater
cd GitRepoUpdater && powershell -ExecutionPolicy Bypass -File .\Install-GitRepoUpdater.ps1
```
## Updating

1. Pull the repo (ironic, don't you think?)
2. Run the installer

```powershell
cd GitRepoUpdater && git pull
powershell -ExecutionPolicy Bypass -File .\Install-GitRepoUpdater.ps1
```

## Uninstalling

1. Run the uninstaller
2. Optionally also delete the local repo directory

```powershell
cd GitRepoUpdater
powershell -ExecutionPolicy Bypass -File .\Uninstall-GitRepoUpdater.ps1
```

## Usage Example

```powershell
cd *directory with multiple repos*
Sync-EveryRepo #Alias: ser
```

## Support

If you encounter any problems or have suggestions, please [open an issue](https://github.com/ExiledEye/GitRepoUpdater/issues).

## License

This project is licensed under the MIT License.  
See the [LICENSE](LICENSE) file for details.