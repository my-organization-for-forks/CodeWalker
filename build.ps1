# Build script for CodeWalker
# Builds the solution using MSBuild

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# Import the Find-MSBuild function
. "$PSScriptRoot\Find-MSBuild.ps1"

# Find MSBuild (will exit if not found)
$msbuild = Find-MSBuild

Write-Host "Using MSBuild: $msbuild" -ForegroundColor Cyan
Write-Host ""
Write-Host "Building CodeWalker solution..." -ForegroundColor Cyan

# Build the solution with MSBuild
& $msbuild CodeWalker.sln /p:Configuration=Release "/p:Platform=x64" /m /v:minimal

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Build completed successfully!" -ForegroundColor Green
    Write-Host "Output location: */bin/Release/" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}
