param ($environment)

$fileName = "Annata365Dataverse.*.pdpkg.zip"
$file = Get-ChildItem -Filter "$fileName" | Select-Object -First 1
if ($file)
{
  $fileVersion = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
  $startDir = Get-Location
  $workingDir = "$startDir\DealerUI installation v.$fileVersion\$environment"
  
  mkdir $workingDir
  mkdir "$workingDir\Tools\PackageDeployment"
  
  & ".\nuget.exe" install Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O "$workingDir\Tools"
  
  Move-Item "$workingDir\Tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*\tools\*.*" "$workingDir\Tools\PackageDeployment"
  Remove-Item "$workingDir\Tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*" -Force -Recurse
  Remove-Item "$workingDir\nuget.exe"
  Expand-Archive -Path "$startDir\$file.FullName" -DestinationPath "$workingDir\Tools"
}
else {
  exit 1
}


    