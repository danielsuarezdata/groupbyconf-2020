
#Inventory

## Connect to a instance (Integrated Security)
Test-DbaConnection -Sqlinstance SQL2017
Test-DbaConnection -Sqlinstance "SQL2017,1433"
Test-DbaConnection -Sqlinstance "whateverservername.database.windows.net" -SqlCredential demo@domain.com

## Run as different user
Connect-DbaInstance -Sqlinstance SQL2017 -SqlCredential LOCAL\demo

## Using native security
Test-DbaConnection -Sqlinstance LINUX00 -SqlCredential dbatools
Test-DbaConnection -Sqlinstance SQL2017 -SqlCredential yoda

## Using native security and stored credentials in a variable
$cred = Get-Credential
Connect-DbaInstance -Sqlinstance SQL2017 -SqlCredential $cred 

## Test multiple instances
$servers = "SQL2008R2","SQL2012","SQL2014","SQL2016","SQL2017","SQL2019"
$servers | Test-DbaConnection
$servers | Test-DbaConnection | Select-Object ComputerName, InstanceName, SqlVersion, IPAddress | Format-Table

## Find SQL Server instances
Find-DbaInstance -DiscoveryType Domain -ScanType Browser
Find-DbaInstance -DiscoveryType DataSourceEnumeration -ScanType Browser         ##DNSResolve/Ping/SPN/SqlConnect/SqlService/All
Find-DbaInstance -DiscoveryType IPRange -IPAddress 172.16.0.1/16                ##It-will-take-a-lot-of-time-to-run
Find-DbaInstance -DiscoveryType DataSourceEnumeration -MinimumConfidence High
Find-DbaInstance -ComputerName SQL2012

