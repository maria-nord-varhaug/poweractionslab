param ($environment, $version)

$fileName = "Annata365Dataverse.$version.pdpkg.zip"
$file = Get-ChildItem -Filter "$fileName" | Select-Object -First 1
if ($file)
{
  # $fileVersion = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
  $startDir = Get-Location
  $workingDir = "$startDir\DealerUI installation v.$version\$environment"
  
  mkdir $workingDir
  mkdir "$workingDir\Tools\PackageDeployment"
  
  & "$startDir\nuget.exe" install Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O "$workingDir\Tools"
  
  Move-Item "$workingDir\Tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*\tools\*.*" "$workingDir\Tools\PackageDeployment"
  Remove-Item "$workingDir\Tools\Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.*" -Force -Recurse
  Expand-Archive -Path "$file" -DestinationPath "$workingDir\Tools"
}
else {
  exit 1
}


    