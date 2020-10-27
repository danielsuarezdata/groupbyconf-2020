
## More Inventory

## Get details from the server
Get-DbaComputerSystem -ComputerName SQL2012

## Get details from the operating system
Get-DbaOperatingSystem -ComputerName SQL2012 | Select-Object OSVersion

## Get installed features
Get-DbaFeature -ComputerName SQL2012 | Select-Object ComputerName,Feature,Edition,Version

## Get services deployed
Get-DbaService -ComputerName SQL2014
Get-DbaService -ComputerName SQL2014 -Credential LOCAL\Administrator
Get-DbaService -ComputerName SQL2014,SQL2016 | Select-Object ComputerName,DisplayName,State

$servers = "SQL2012","SQL2014"
$servers | Get-DbaService | Select-Object ComputerName,DisplayName,State

## Get SQL Server Build Info
Get-DbaBuildReference -SqlInstance SQL2012
$servers | Get-DbaBuildReference | Select-Object SqlInstance,Build,NameLevel,BuildLevel

## Get databases on the instance
Get-DbaDatabase -Sqlinstance "SQL2017" -ExcludeSystem | Select-Object Name, Size, Status, LastFullBackup | Sort-Object Name
Get-DbaDatabase -Sqlinstance "SQL2017" -ExcludeSystem | Select-Object Name, Size, Status, LastFullBackup | clip             #Copy to clipboard
Get-DbaDatabase -Sqlinstance "SQL2017" -ExcludeSystem | Export-Csv -Path D:\dbatools\Export.csv -NoTypeInformation          #Export to CSV File

## Find objects owner by users on the instance
Find-DbaUserObject -SqlInstance SQL2016 | Select-Object ComputerName, Type, Owner, Name                         #Enum all instance-level objects
Find-DbaUserObject -SqlInstance SQL2016 -Pattern LOCAL\daniel | Select-Object ComputerName, Type, Owner, Name   #Find objects belonging to a user

## Get a list of tables on a database
Get-DbaDBTable -SqlInstance SQL2017 -Database ReportServer | Select-Object Schema, Name, RowCount

## Get a list of columns on a table
(Get-DbaDbTable -SqlInstance SQL2017 -Database ReportServer -Table ConfigurationInfo).Columns | Select-Object Parent, Name, Datatype