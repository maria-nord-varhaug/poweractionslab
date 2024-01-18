param($environment)
$loc = Get-Location
$file = Get-ChildItem -Filter "Annata365Dataverse.*.pdpkg.zip" | Select-Object -First 1
$fileVersion = [regex]::Match($file.FullName, "[0-9]+\.[0-9]+\.[0-9]+").Value
Get-CrmPackages -PackageDirectory "$loc\DealerUI installation v.$fileVersion\$environment\Tools"