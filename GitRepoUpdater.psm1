# GitRepoUpdater Module
# Provides functions for managing multiple Git repositories

# Import the main function
. $PSScriptRoot\Sync-EveryRepo.ps1

# Export the function and alias
Export-ModuleMember -Function Sync-EveryRepo
Export-ModuleMember -Alias ser