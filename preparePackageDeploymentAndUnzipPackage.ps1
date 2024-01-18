param ($environment)

$fileName = "Annata365Dataverse.*.pdpkg.zip"
$file = Get-ChildItem -Filter "$fileName" | Select-Object -First 1
if ($file)
{
  $fileVersion = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
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
  Expand-Archive -Path "$startDir\$fileName" -DestinationPath "$tools"
}
else {
  exit 1
}


    