param ($environment)
$knownPartOfFileName = "Annata365Dataverse."
$file = Get-ChildItem -Filter "$knownPartOfFileName*.zip" | Select-Object -First 1
if ($file)
  {
    $versionNumber = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
    $startDir = Get-Location
    $sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
    $workingDir = "$startDir\DealerUI installation v.$versionNumber\$environment"

    mkdir $workingDir
    $tools = "$workingDir\Tools"
    mkdir "$tools\PackageDeployment"

    Invoke-WebRequest $sourceNugetExe -OutFile "$workingDir\nuget.exe" -TimeoutSec 10
    & "$workingDir\nuget.exe" install Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O "$tools"

    Move-Item "$tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*\tools\*.*" "$tools\PackageDeployment"
    Remove-Item "$tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*" -Force -Recurse
    Remove-Item "$workingDir\nuget.exe"

    Expand-Archive -Path $file.FullName -DestinationPath $tools
  } else
  {
    Write-Host "No file found starting with $knownPartOfFileName"
  }