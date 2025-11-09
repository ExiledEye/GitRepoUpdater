function Sync-EveryRepo {
    <#
    .SYNOPSIS
        Pulls latest changes from all Git repositories in the current or specified directory.
    
    .DESCRIPTION
        Recursively checks all subdirectories for Git repositories and pulls the latest changes.
        Similar to 'git pull' but works on multiple repositories at once.
    
    .EXAMPLE
        Sync-EveryRepo
        
        Pulls latest changes from all Git repositories in the current directory.
    
    .EXAMPLE
        Sync-EveryRepo -Path "C:\Projects"
        
        Pulls latest changes from all Git repositories in the specified path.
        
    .EXAMPLE
        Sync-EveryRepo -Recurse:$false
        
        Pulls latest changes only from Git repositories in the immediate current directory (non-recursive).
    
    .EXAMPLE
        Sync-EveryRepo -Verbose
        
        Pulls latest changes with detailed verbose output.
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Position=0)]
        [string]$Path = ".",
        
        [Parameter()]
        [switch]$Recurse
    )

    if (-not $PSBoundParameters.ContainsKey('Recurse')) {
        $Recurse = $true
    }
    
    # Check Git
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error "Git is not installed or not in PATH. Please install Git and ensure it's available in your system PATH."
        return
    }

    $originalLocation = Get-Location
    
    try {
        $resolvedPath = Resolve-Path $Path
        Write-Host "Searching for Git repositories in: $resolvedPath" -ForegroundColor Cyan
        if ($Recurse) {
            Write-Host "Search mode: Recursive" -ForegroundColor Gray
        } else {
            Write-Host "Search mode: Current directory only" -ForegroundColor Gray
        }
        
        $reposUpdated = 0
        $reposSkipped = 0
        $reposWithErrors = 0
        
        Get-ChildItem -Path $Path -Directory -Recurse:$Recurse | ForEach-Object {
            $gitPath = Join-Path $_.FullName ".git"
            
            if (Test-Path $gitPath) {
                Write-Host "`n📁 Pulling repository: $($_.Name)" -ForegroundColor Green
                Write-Host "📍 Location: $($_.FullName)" -ForegroundColor Gray
                
                try {
                    Set-Location $_.FullName
                    
                    # Get current branch and remote info
                    $branch = git branch --show-current 2>$null
                    $remote = git remote 2>$null
                    
                    if ($remote) {
                        Write-Host "🌿 Branch: $branch" -ForegroundColor Yellow
                        Write-Host "📡 Remote: $remote" -ForegroundColor Gray
                        
                        # Execute git pull with output
                        $pullOutput = git pull 2>&1
                        
                        if ($LASTEXITCODE -eq 0) {
                            Write-Host "✅ Pull successful" -ForegroundColor Green
                            foreach ($line in $pullOutput) {
                                Write-Host "   $line" -ForegroundColor Gray
                            }
                            $reposUpdated++
                        } else {
                            Write-Host "❌ Pull failed" -ForegroundColor Red
                            foreach ($line in $pullOutput) {
                                Write-Host "   $line" -ForegroundColor Red
                            }
                            $reposWithErrors++
                        }
                    } else {
                        Write-Host "⚠️  No remote repository configured" -ForegroundColor Yellow
                        $reposSkipped++
                    }
                }
                catch {
                    Write-Host "❌ Error updating repository: $($_.Exception.Message)" -ForegroundColor Red
                    $reposWithErrors++
                }
            }
        }
        
        # Summary
        $separator = "=" * 60
        Write-Host "`n$separator" -ForegroundColor Cyan
        Write-Host "🏁 PULL SUMMARY" -ForegroundColor Cyan
        Write-Host "$separator" -ForegroundColor Cyan
        Write-Host "✅ Repositories successfully pulled: $reposUpdated" -ForegroundColor Green
        Write-Host "⚠️  Repositories skipped (no remote): $reposSkipped" -ForegroundColor Yellow
        Write-Host "❌ Repositories with errors: $reposWithErrors" -ForegroundColor Red
        Write-Host "📊 Total repositories processed: $($reposUpdated + $reposSkipped + $reposWithErrors)" -ForegroundColor White
        Write-Host "$separator" -ForegroundColor Cyan
        
    }
    finally {
        Set-Location $originalLocation
    }
}

# Alias
New-Alias -Name ser -Value Sync-EveryRepo -Description "Alias for Sync-EveryRepo"