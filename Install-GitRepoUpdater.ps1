# ...existing code...
<#
.SYNOPSIS
    Installs the GitRepoUpdater PowerShell module

.DESCRIPTION
    This script installs the GitRepoUpdater module to the user's PowerShell modules directory
    and makes it available in all PowerShell sessions.

.EXAMPLE
    .\Install-GitRepoUpdater.ps1
#>

$scriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Definition }

# Admin check
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# Choose the correct dir depending on PowerShell edition
$editionFolder = if ($PSVersionTable.PSEdition -eq 'Core') { 'PowerShell' } else { 'WindowsPowerShell' }

# Determine the target module directory
if ($isAdmin) {
    # Install for all users
    $modulePath = Join-Path $env:ProgramFiles "$editionFolder\Modules\GitRepoUpdater"
    Write-Host "Installing for all users (administrator mode)" -ForegroundColor Yellow
} else {
    # Install for current user
    $modulePath = Join-Path $env:USERPROFILE "Documents\$editionFolder\Modules\GitRepoUpdater"
    Write-Host "Installing for current user only" -ForegroundColor Yellow
}

Write-Host "`nInstalling GitRepoUpdater module..." -ForegroundColor Cyan

# File unblocking failsafe
Write-Host "Checking file security blocks..." -ForegroundColor Cyan
try {
    if (Get-Command Unblock-File -ErrorAction SilentlyContinue) {
        Get-ChildItem -Path . -Include *.ps1, *.psm1, *.psd1 | Unblock-File
        Write-Host "✓ Removed download security blocks" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  Could not unblock files (non-critical)" -ForegroundColor Yellow
}

# Create module directory
if (Test-Path $modulePath) {
    Write-Host "Removing existing module..." -ForegroundColor Yellow
    Remove-Item $modulePath -Recurse -Force
}

New-Item -ItemType Directory -Path $modulePath -Force | Out-Null

# Copy module files from the script folder so the installer works regardless of current working directory
$files = @(
    'GitRepoUpdater.psd1',
    'GitRepoUpdater.psm1', 
    'Sync-EveryRepo.ps1',
    'LICENSE',
    'README.md'
)

$missing = $false
foreach ($file in $files) {
    $source = Join-Path $scriptRoot $file
    if (Test-Path $source) {
        Copy-Item -Path $source -Destination $modulePath -Force
        Write-Host "  Copied: $file" -ForegroundColor Green
    } else {
        Write-Host "  Missing: $file (expected at $source)" -ForegroundColor Red
        $missing = $true
    }
}

if ($missing) {
    Write-Host "  Installation failed! Make sure all files are in the same directory as this installer." -ForegroundColor Red
    exit 1
}

Write-Host "`n✅ Module installed successfully!" -ForegroundColor Green
Write-Host "📍 Location: $modulePath" -ForegroundColor Gray

# Import the module using its manifest path so PowerShell picks it up immediately regardless of PSModulePath differences
$manifestPath = Join-Path $modulePath 'GitRepoUpdater.psd1'
if (-not (Test-Path $manifestPath)) {
    # Fallback to psm1 if no manifest present
    $manifestPath = Join-Path $modulePath 'GitRepoUpdater.psm1'
}

Write-Host "`nTesting module import..." -ForegroundColor Cyan
try {
    Import-Module -Name $manifestPath -Force -ErrorAction Stop
    Write-Host "✅ Module imported successfully!" -ForegroundColor Green
    
    # Show usage information
    Write-Host "`n📖 USAGE EXAMPLES:" -ForegroundColor Cyan
    Write-Host "  Sync-EveryRepo" -ForegroundColor White
    Write-Host "  Sync-EveryRepo -Path `"C:\MyProjects`"" -ForegroundColor White
    Write-Host "  Sync-EveryRepo -Recurse:`$false" -ForegroundColor White
    Write-Host "  ser  # Short alias for Sync-EveryRepo" -ForegroundColor White
    Write-Host "  Get-Help Sync-EveryRepo # For more help" -ForegroundColor White
    
    Write-Host "`n✅ The module will be automatically available in future PowerShell sessions." -ForegroundColor Green
}
catch {
    Write-Host "❌ Error importing module: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Try restarting PowerShell or run Import-Module with the module path shown above." -ForegroundColor Yellow
}

# Instructions for manual installation if needed
Write-Host "`n🔧 If you need to manually import the module in the current session:" -ForegroundColor Yellow
Write-Host "  Import-Module '$manifestPath'" -ForegroundColor White
# ...existing code...