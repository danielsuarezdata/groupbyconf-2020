
## Administration

# Get instance configurations values
Get-DbaSpConfigure -SqlInstance SQL2016 | Select-Object SqlInstance, Name, DisplayName, ConfiguredValue | sort-Object SqlInstance,DisplayName

# And now for multiple instances!
$servers = "SQL2008R2","SQL2012","SQL2014","SQL2016","SQL2017","SQL2019"
$servers | Get-DbaSpConfigure -Name MaxDegreeOfParallelism,CostThresholdForParallelism,OptimizeAdhocWorkloads,DefaultBackupCompression | Select-Object SqlInstance, Name, RunningValue, ConfiguredValue 

# What about fixing these values?
Set-DbaSpConfigure -SqlInstance SQL2014 -Name MaxDegreeOfParallelism -Value 4
Set-DbaSpConfigure -SqlInstance SQL2014 -Name CostThresholdForParallelism -Value 55
Set-DbaSpConfigure -SqlInstance SQL2014 -Name OptimizeAdhocWorkloads -Value 1
Set-DbaSpConfigure -SqlInstance SQL2014 -Name DefaultBackupCompression -Value 1

# Let's break it again
Set-DbaSpConfigure -SqlInstance SQL2014 -Name MaxDegreeOfParallelism -Value 1
Set-DbaSpConfigure -SqlInstance SQL2014 -Name CostThresholdForParallelism -Value 5
Set-DbaSpConfigure -SqlInstance SQL2014 -Name OptimizeAdhocWorkloads -Value 0
Set-DbaSpConfigure -SqlInstance SQL2014 -Name DefaultBackupCompression -Value 0

# Am I setting the right values?
Test-DbaMaxMemory -SqlInstance SQL2016 | Select-Object InstanceName, MaxValue, RecommendedValue
Test-DbaMaxDop -SqlInstance SQL2016 | Select-Object InstanceName, CurrentInstanceMaxDop, RecommendedMaxDop

# Get Error log entries
Get-DbaErrorLog -SqlInstance SQL2016 -After (Get-Date).AddMonths(-5) | Select-Object LogDate, Source, Text
Get-DbaErrorLog -SqlInstance SQL2016 -After (Get-Date).AddMonths(-5) -Text "login failed" | Select-Object LogDate, Source, Text

# Test TempDb config
Test-DbaTempdbConfig -SqlInstance SQL2016 | Select-Object SqlInstance, Rule, Notes

#Get Wait stats
Get-DbaWaitStatistic -SqlInstance SQL2017 | Select-Object WaitType, WaitCount, WaitSeconds

# Test Disk speed
Test-DbaDiskSpeed -SqlInstance SQL2016  | Select-Object Database, ReadPerformance, WritePerformance

## Get an estimate for backups
Measure-DbaBackupThroughput -SqlInstance SQL2017 | Select-Object Database, AvgDuration

#Migration
Copy-DbaLogin -Source SQL2008R2 -Destination SQL2019
Copy-DbaLogin -Source SQL2008R2 -Destination SQL2019 -Login yoda
Copy-DbaLogin -Source SQL2008R2 -Destination SQL2019 -Login yoda -NewSid

#Since there a Copy-Dba for everything, we can also run a whole migration from one server to another one
Start-DbaMigration -Source SQL2014 -Destination SQL2019 -BackupRestore -SharedPath "\\sql2012\temp" -WhatIf 