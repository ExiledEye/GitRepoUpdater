@{
    RootModule = 'GitRepoUpdater.psm1'
    ModuleVersion = '1.0.5'
    GUID = '04a1f289-d296-46e5-ab8f-54cbe562b3e4'
    Author = 'Exiled Eye'
    CompanyName = 'None'
    Copyright = '(c) 2025 Exiled Eye. Licensed under MIT License.'
    Description = 'A PowerShell module to easily pull updates from multiple Git repositories at once. Git must be installed and available in PATH.'
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    RequiredModules = @()
    ScriptsToProcess = @()
    TypesToProcess = @()
    FormatsToProcess = @()
    FunctionsToExport = 'Sync-EveryRepo'
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = 'ser'
    ModuleList = @()
    FileList = @(
        'GitRepoUpdater.psd1',
        'GitRepoUpdater.psm1',
        'Sync-EveryRepo.ps1',
        'LICENSE',
        'README.md'
    )
    PrivateData = @{
        PSData = @{
            Tags = @('Git', 'Productivity', 'Automation', 'Repository', 'OpenSource', 'Sync', 'Pull')
            LicenseUri = 'https://github.com/ExiledEye/GitRepoUpdater/blob/main/LICENSE'
            ProjectUri = 'https://github.com/ExiledEye/GitRepoUpdater'
            ReleaseNotes = 'Minor changes and QoL improvements.'
            RequireLicenseAcceptance = $false
        }
    }
}