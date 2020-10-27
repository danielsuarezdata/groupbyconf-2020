
# Backup a specific database
Backup-DbaDatabase -Sqlinstance SQL2014 -Database Test -Type Full -Path D:\Temp -FilePath Test_Full.bak -CompressBackup -CheckSum -Verify
Backup-DbaDatabase -Sqlinstance SQL2014 -Database Test -Type Differential -Path D:\Temp -FilePath Test_Diff.bak
Backup-DbaDatabase -Sqlinstance SQL2014 -Database Test -Type Log -Path D:\Temp -FilePath Test_Diff_Log1.trn
Backup-DbaDatabase -Sqlinstance SQL2014 -Database Test -Type Log -Path D:\Temp -FilePath Test_Diff_Log2.trn
Backup-DbaDatabase -Sqlinstance SQL2014 -Database Test -Type Log -Path D:\Temp -FilePath Test_Diff_Log3.trn

# Backup a set of databases
Backup-DbaDatabase -SqlInstance SQL2014 -Path "D:\Temp" -ExcludeDatabase master,model,msdb -CompressBackup -Initialize -Type Full
Backup-DbaDatabase -SqlInstance SQL2014 -Path "D:\Temp" -Database Test,DBATools -CompressBackup -Initialize -Type Full

# Get backup history
Get-DbaDbBackupHistory -SqlInstance SQL2014 -Database Test
Get-DbaDbBackupHistory -SqlInstance SQL2014 -Database Test -Type Full
Get-DbaDbBackupHistory -SqlInstance SQL2014 -Database Test -Since '2020-10-01'

# Restore those databases
Restore-DbaDatabase -SqlInstance SQL2014 -Path "D:\Temp" -WithReplace -IgnoreDiffBackup -OutputScriptOnly -WhatIf

# Get Restore history
Get-DbaDbRestoreHistory -SqlInstance SQL2014 | Select-Object Database,Date,From,Username

#Copy a database from one server to another one
Copy-DbaDatabase -Source SQL2008R2 -Destination SQL2012 -Database TestTLS -BackupRestore -SharedPath "\\sql2012\temp" -WithReplace
Copy-DbaDatabase -Source SQL2012 -Destination SQL2019 -Database SourceInSQL2012 -BackupRestore -SharedPath "\\sql2012\temp" -WithReplace
