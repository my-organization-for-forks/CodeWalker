# Build initialization script for CodeWalker
# Restores NuGet packages using MSBuild

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# Import the Find-MSBuild function
. "$PSScriptRoot\Find-MSBuild.ps1"

# Find MSBuild (will exit if not found)
$msbuild = Find-MSBuild

Write-Host "Using MSBuild: $msbuild" -ForegroundColor Cyan
Write-Host "Restoring NuGet packages with MSBuild..." -ForegroundColor Cyan

# Use MSBuild to restore - this avoids .NET SDK compatibility issues
& $msbuild CodeWalker.sln /t:Restore /p:Configuration=Release "/p:Platform=x64" /v:minimal

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "NuGet packages restored successfully." -ForegroundColor Green
    Write-Host "Run 'powershell -ExecutionPolicy Bypass -File build.ps1' to build the solution." -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "NuGet restore failed!" -ForegroundColor Red
    exit 1
}
