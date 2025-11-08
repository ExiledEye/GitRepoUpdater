Get-ChildItem -Directory | ForEach-Object {
    if (Test-Path "$($_.FullName)\.git") {
        Write-Host "Pulling changes for repository: $($_.Name)" -ForegroundColor Green
        Push-Location $_.FullName
        git pull
        Pop-Location
    } else {
        Write-Host "Skipping: $($_.Name) is not a Git repository" -ForegroundColor Yellow
    }
}