# Common function to find MSBuild
# Returns the path to MSBuild.exe or exits with error if not found

function Find-MSBuild {
    $msbuildPaths = @(
        "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe",
        "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
    )

    # Check common installation paths
    foreach ($path in $msbuildPaths) {
        if (Test-Path $path) {
            return $path
        }
    }

    # Try to find in PATH
    $msbuild = (Get-Command msbuild -ErrorAction SilentlyContinue).Source
    if ($null -ne $msbuild) {
        return $msbuild
    }

    # Not found
    Write-Host "ERROR: MSBuild not found!" -ForegroundColor Red
    Write-Host "Please install Visual Studio 2019 or 2022 with MSBuild." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You can download Visual Studio from:" -ForegroundColor Cyan
    Write-Host "  https://visualstudio.microsoft.com/downloads/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Make sure to install the '.NET desktop development' workload." -ForegroundColor Yellow
    exit 1
}
