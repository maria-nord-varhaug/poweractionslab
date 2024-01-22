param($username, [SecureString] $password)
Import-Module Microsoft.Xrm.Tooling.CrmConnector.PowerShell
$PSVersionTable.PSVersion
echo $env:PSModulePath
$cred = New-Object System.Management.Automation.PSCredential ("$username", ("$password"))
$conn = Get-CrmConnection -Credential $cred -ServerUrl "operations-weu-dev-develop.crm4.dynamics.com"
if($conn.IsReady) {
  Write-Output "Connected successfully to Dataverse"
} else {
  Write-Output "Failed to connect to Dataverse"
}
