param ($environment)
$knownPartOfFileName = "Annata365Dataverse."
$file = Get-ChildItem -Filter "$knownPartOfFileName*.zip" | Select-Object -First 1
if ($file)
  {
    $versionNumber = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
    $startDir = Get-Location
    $sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
    $workingDir = "$startDir\DealerUI installation v.$versionNumber\$environment"

    Write-Output "Make necessary folder structure"
    mkdir $workingDir
    $tools = "$workingDir\Tools"
    mkdir "$tools\PackageDeployment"

    Write-Output "Install nuget and package deployment tool"
    Invoke-WebRequest $sourceNugetExe -OutFile "$workingDir\nuget.exe" -TimeoutSec 10
    & "$workingDir\nuget.exe" install Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O "$tools"

    Write-Output "Remove unnecessary fill, move the necessary package tools to own folder, and remove nuget"
    Move-Item "$tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*\tools\*.*" "$tools\PackageDeployment"
    Remove-Item "$tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*" -Force -Recurse
    Remove-Item "$workingDir\nuget.exe"

    Write-Output "Use Expand-Archive to extract the file"
    Expand-Archive -Path $file.FullName -DestinationPath $tools
  } else
  {
    Write-Host "No file found starting with $knownPartOfFileName"
  }