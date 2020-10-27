
## Security

## We can also use splatting
$paramSplatting = @{
	SqlInstance='SQL2016' 
	Database='ReportServer'
	Table='ConfigurationInfo'
	Destination='SQL2017'
	DestinationDatabase='Test'
	DestinationTable='ConfigurationInfo'
	AutoCreateTable=$true
}
Copy-DbaDbTableData @paramSplatting

# Create and retrieve logins
New-DbaLogin -SqlInstance SQL2017 -Login dbatools -Force
Get-DbaLogin -SqlInstance SQL2017 -Login dbatools | Select-Object Name, LoginType, LastLogin

# Create and retrieve users
New-DbaDbUser -SqlInstance SQL2017 -Database Test -Login dbatools -Username dbatools -Force
Get-DbaDbUser -SqlInstance SQL2017 -Database Test | Select-Object Login, Name, LoginType, LastLogin

# Identify and fix orphan users
Get-DbaDbOrphanUser -SqlInstance SQL2019 | Select-Object DatabaseName, User
Repair-DbaDbOrphanUser -SqlInstance SQL2016

# Get permissions detail on the instance
Get-DbaUserPermission -SqlInstance SQL2017 -Database Test | Select-Object Object, Securable, Member, RoleSecurableClass

# Export logins (sp_help_revlogin)
Export-DbaLogin -SqlInstance SQL2016 -Path d:\dbatools -ExcludePassword -ExcludeLogin sa

# Export permission
Export-DbaUser -SqlInstance SQL2017 -FilePath D:\dbatools\SQL2017-PermissionsExport.sql -Database Test

# What Active Directory a login belongs to?
Find-DbaLoginInGroup -SqlInstance SQL2017 -Login LOCAL\daniel
Find-DbaLoginInGroup -SqlInstance SQL2017 | Select-Object SqlInstance, Login, MemberOf

# Reset DbaAdmin
Reset-DbaAdmin -SqlInstance SQLServer2012 -Login dbatools -WhatIf

