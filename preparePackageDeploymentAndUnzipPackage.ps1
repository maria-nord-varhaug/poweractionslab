param ($path, $environment)
$knownPartOfFileName = "Annata365Dataverse."
$file = Get-ChildItem -Filter "$knownPartOfFileName*.zip" | Select-Object -First 1
if ($file)
  {
    $pattern = "[0-9]+\.[0-9]+\.[0-9]+"
    $versionNumber = [regex]::Match($file.FullName, $pattern).Value
    $folderName = "DealerUI installation v." + $versionNumber + "\" + $environment
    mkdir $folderName
    Set-Location $folderName
    $rootDir = Get-Location

    $sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
    $targetNugetExe = ".\nuget.exe"
    Remove-Item .\Tools -Force -Recurse -ErrorAction Ignore
    Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe
    Set-Alias nuget $targetNugetExe -Scope Global -Verbose

    ##
    ##Download Package Deployer
    ##
    ./nuget install Microsoft.CrmSdk.XrmTooling.PackageDeployment.WPF -O .\Tools
    mkdir .\Tools\PackageDeployment
    $pdFolder = Get-ChildItem ./Tools | Where-Object {$_.Name -match 'Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf.'}
    Move-Item "$rootDir\Tools\$pdFolder.Name\tools\*.*" "$rootDir\Tools\PackageDeployment"
    Remove-Item .\Tools\$pdFolder -Force -Recurse

    ##
    ##Remove NuGet.exe
    ##
    Remove-Item nuget.exe

    $extractionPath = $path + "\" + $foldername +"\Tools"

    # Use Expand-Archive to extract the file
    Expand-Archive -Path $file.FullName -DestinationPath $extractionPath
  } else
  {
    Write-Host "No file found starting with $knownPartOfFileName"
  }