<#
.SYNOPSIS
    Uninstalls the GitRepoUpdater PowerShell module (user and/or all-users locations).

.DESCRIPTION
    Removes module files from standard PowerShell module locations and unloads the module
    and alias from the current session.
#>

# Detect admin and edition
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
$editionFolder = if ($PSVersionTable.PSEdition -eq 'Core') { 'PowerShell' } else { 'WindowsPowerShell' }

# Standard locations used by the installer
$userModule = Join-Path $env:USERPROFILE "Documents\$editionFolder\Modules\GitRepoUpdater"
$allModule  = Join-Path $env:ProgramFiles "$editionFolder\Modules\GitRepoUpdater"

$existsUser = Test-Path $userModule
$existsAll  = Test-Path $allModule

if (-not ($existsUser -or $existsAll)) {
    Write-Host "No GitRepoUpdater installation found in standard locations." -ForegroundColor Yellow
    exit 0
}

Write-Host "Detected installations:" -ForegroundColor Cyan
if ($existsUser) { Write-Host "  [U] Current user: $userModule" -ForegroundColor Gray }
if ($existsAll)  { Write-Host "  [A] All users   : $allModule" -ForegroundColor Gray }

# Choose target(s)
if ($existsUser -and $existsAll) {
    $choice = Read-Host "Remove (U)ser, (A)llUsers, (B)oth or (C)ancel? [B]"
    switch ($choice.ToUpper()) {
        'U' { $targets = @($userModule) }
        'A' { 
            if (-not $isAdmin) { Write-Host "Removing all-users installation requires elevation. Rerun this script as Administrator." -ForegroundColor Red ; exit 1 }
            $targets = @($allModule)
        }
        'B' { 
            if (-not $isAdmin) { Write-Host "Removing all-users installation requires elevation. Rerun this script as Administrator." -ForegroundColor Red ; exit 1 }
            $targets = @($userModule, $allModule)
        }
        default { Write-Host "Cancelled." ; exit 0 }
    }
}
elseif ($existsAll) {
    if (-not $isAdmin) { Write-Host "All-users installation detected. Run this script as Administrator to remove it." -ForegroundColor Red ; exit 1 }
    $confirm = Read-Host "Remove all-users installation at $allModule ? (Y/N)"
    if ($confirm.ToUpper() -ne 'Y') { Write-Host "Cancelled." ; exit 0 }
    $targets = @($allModule)
}
else {
    $confirm = Read-Host "Remove current-user installation at $userModule ? (Y/N)"
    if ($confirm.ToUpper() -ne 'Y') { Write-Host "Cancelled." ; exit 0 }
    $targets = @($userModule)
}

# Unload module & remove alias in current session
Remove-Module -Name GitRepoUpdater -Force -ErrorAction SilentlyContinue
Remove-Item -Path Alias:per -ErrorAction SilentlyContinue

# Remove folders
foreach ($t in $targets) {
    try {
        if (Test-Path $t) {
            Remove-Item -LiteralPath $t -Recurse -Force -ErrorAction Stop
            Write-Host "Removed: $t" -ForegroundColor Green
        } else {
            Write-Host "Not found (skipped): $t" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "Failed to remove ${t}: $($_.Exception.Message)" -ForegroundColor Red
        if (-not $isAdmin -and $t -like "$env:ProgramFiles*") {
            Write-Host "Permission denied. Rerun this script as Administrator to remove the all-users installation." -ForegroundColor Yellow
        }
    }
}

Write-Host "Uninstall complete." -ForegroundColor Cyan