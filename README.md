# Power platform package deployment

This project automatically deploys zip files created with the package deployer, using the package deployer for windows terminal. Works for any package as long as it is created using the package deployer tool, maybe more too - see https://learn.microsoft.com/en-us/power-platform/alm/package-deployer-tool?tabs=cli

# How
To use this pipeline, a zip file containing the package that needs to be deployed has to be uploaded to the repository's root foler. The workflow will then find the version, and perform necessary steps to deploy. 

There can be cases when the deploy fails; the step will then have to be re-run when the solution in dataverse is finished.

# Regarding powershell 
The powerplatform modules use the .NET framework. This means they are incompatible with powershell 6.0 and later, which uses .NET Core. Powershell on linux and mac use .NET core, so all commands in this project has to be run using a windows-shell. 