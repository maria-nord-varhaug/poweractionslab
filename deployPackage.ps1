param ($environment, $fileVersion)
$startDir = Get-Location
Get-CrmPackages -PackageDirectory "$startDir\DealerUI installation v.$fileVersion\$environment\Tools"