param ($environment, $versionNumber)
Set-ExecutionPolicy -ExecutionPolicy AllSigned
Install-Module Microsoft.Xrm.Tooling.PackageDeployment.Powershell    
Get-CrmPackages -PackageDirectory "$startDir\DealerUI installation v.$versionNumber\$environment\Tools"