param ($environment, $fileVersion)
$file = Get-ChildItem -Filter "Annata365Dataverse.*.zip" | Select-Object -First 1
if ($file)
  {
    $startDir = Get-Location
    $sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
    $workingDir = "$startDir\DealerUI installation v.$fileVersion\$environment"

    mkdir $workingDir
    $tools = "$workingDir\Tools"
    mkdir "$tools\PackageDeployment"

    Invoke-WebRequest $sourceNugetExe -OutFile "$workingDir\nuget.exe" -TimeoutSec 10
    & "$workingDir\nuget.exe" install Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O "$tools"

    Move-Item "$tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*\tools\*.*" "$tools\PackageDeployment"
    Remove-Item "$tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*" -Force -Recurse
    Remove-Item "$workingDir\nuget.exe"
    Expand-Archive -Path "$startDir\$knownPartOfFileName*.zip" -DestinationPath "$tools"
    } else
  {
    Write-Host "No file found starting with $knownPartOfFileName"
  }