param ($environment)
Set-ExecutionPolicy -ExecutionPolicy AllSigned
Install-Module Microsoft.Xrm.Tooling.PackageDeployment.Powershell    
$versionNumber = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
$startDir = Get-Location
Get-CrmPackages -PackageDirectory ""$startDir\DealerUI installation v.$versionNumber\$environment\Tools""