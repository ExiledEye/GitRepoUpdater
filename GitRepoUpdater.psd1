@{
    RootModule = 'GitRepoUpdater.psm1'
    ModuleVersion = '1.0.0'
    GUID = '04a1f289-d296-46e5-ab8f-54cbe562b3e4'
    Author = 'Exiled Eye'
    CompanyName = 'None'
    Copyright = '(c) 2025 Exiled Eye. Licensed under MIT License.'
    Description = 'A PowerShell module to easily pull updates from multiple Git repositories at once'
    PowerShellVersion = '5.1'
    
    # Required modules
    RequiredModules = @()
    
    # Modules that must be imported before this module
    RequiredAssemblies = @()
    
    # Script files (.ps1) that are run in the caller's environment
    ScriptsToProcess = @()
    
    # Type files (.ps1xml) to be loaded
    TypesToProcess = @()
    
    # Format files (.ps1xml) to be loaded
    FormatsToProcess = @()
    
    # Functions to export from this module
    FunctionsToExport = 'Sync-EveryRepo'
    
    # Cmdlets to export from this module
    CmdletsToExport = @()
    
    # Variables to export from this module
    VariablesToExport = @()
    
    # Aliases to export from this module
    AliasesToExport = 'ser'
    
    # List of all modules packaged with this module
    ModuleList = @()
    
    # List of all files packaged with this module
    FileList = @(
        'GitRepoUpdater.psd1',
        'GitRepoUpdater.psm1',
        'Sync-EveryRepo.ps1'
    )
    
    # Private data to pass to the module specified in RootModule
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('Git', 'Productivity', 'Automation', 'Repository', 'OpenSource')
            
            # A URL to the license for this module.
            LicenseUri = 'https://github.com/ExiledEye/GitRepoUpdater/blob/main/LICENSE'
            
            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/ExiledEye/GitRepoUpdater'
            
            # A URL to an icon representing this module.
            # IconUri = ''
            
            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of GitRepoUpdater'
            
            # Prerelease string of this module
            # Prerelease = ''
            
            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            RequireLicenseAcceptance = $false
            
            # External dependent modules of this module
            # ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable
    
    # HelpInfo URI of this module
    # HelpInfoURI = ''
    
    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}