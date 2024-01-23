param([SecureString] $cred)
Import-Module Microsoft.Xrm.Tooling.CrmConnector.PowerShell
$PSVersionTable.PSVersion
Write-Output $PSVersionTable
Write-Output (Get-InstalledModule)
$cred = New-Object System.Management.Automation.PSCredential ("$username", $password)
$conn = Get-CrmConnection -Credential $cred -ServerUrl "operations-weu-dev-develop.crm4.dynamics.com"
if($conn.IsReady) {
  Write-Output "Connected successfully to Dataverse"
} else {
  Write-Output "Failed to connect to Dataverse"
}
