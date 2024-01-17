param ($environment, $fileVersion)
$startDir = Get-Location
Set-ExecutionPolicy -ExecutionPolicy AllSigned
Install-Module Microsoft.Xrm.Tooling.PackageDeployment.Powershell    
Get-CrmPackages -PackageDirectory "$startDir\DealerUI installation v.$fileVersion\$environment\Tools"