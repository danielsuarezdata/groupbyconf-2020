
## Is dbatools it installed?
Get-InstalledModule -Name dbatools

## How to install dbatools?
Install-Module dbatools

# The main reference
# https://dbatools.io/commands/

## Update from PowerShell Gallery
Update-Module dbatools

## View available commands 
Get-Command -Module Dbatools
(Get-Command -Module Dbatools).Count

## Now using wildcards
Get-Command -Module dbatools Start*

# Yet another way, but including (and searching for) description
Find-DbaCommand maxdop

## Additional information?
Find-DbaCommand -Tag Backup

## Get help for a specific command
Get-Help Test-DbaConnection -Detailed
Get-Help Start-DbaService -Full
