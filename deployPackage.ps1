param($url, $clientId, $clientSecret, $redirect, $environment, $version)

Import-Module Microsoft.Xrm.Tooling.CrmConnector.PowerShell     
$connectionString = "AuthType=ClientSecret;Url=$url;ClientId=$clientId;ClientSecret=$clientSecret;RedirectUri=$redirect"      
$crmConn = Get-CrmConnection -ConnectionString $connectionString     
if($crmConn.IsReady) {
  Write-Output "Connected successfully to Dataverse"

  # Import-CrmPackage -CrmConnection $CRMConn -PackageDirectory "(Get-Location)\DealerUI installation v.$version\$environment\Tools" -PackageName Annata365Package.dll -UnpackFilesDirectory c:\UnpackedFiles -Verbose
} else {
  Write-Output "Failed to connect to Dataverse"
  Exit 1
}