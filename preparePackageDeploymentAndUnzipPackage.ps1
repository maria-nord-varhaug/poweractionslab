param ($environment, $fileVersion)
$fileName = "Annata365Dataverse.$fileVersion.pdpkg.zip"

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
    