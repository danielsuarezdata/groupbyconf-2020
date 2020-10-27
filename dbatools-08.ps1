# What about patching?

######################################################################
# Get-DbaBuildReference -> Retrieves and updates
# Test-DbaBuild         -> Checks compliance
# Save-DbaKbUpdate      -> Downloads an update
# Get-DbaKbUpdate       -> Gets information about an update
# Update-DbaInstance    -> Updates one or more instances
######################################################################

# update latest versions numbers
Get-DbaBuildReference -Update

# Validate existing build for a server (and get the BuildTarget if different)
Test-DbaBuild -SqlInstance SQL2017 -Latest                   | Select-Object SqlInstance, Build, BuildTarget, MatchType, Compliant | Format-Table
Test-DbaBuild -SqlInstance SQL2017 -MinimumBuild "14.0.0999" | Select-Object SqlInstance, Build, BuildTarget, MatchType, Compliant | Format-Table
Test-DbaBuild -SqlInstance SQL2017 -MaxBehind "1CU"          | Select-Object SqlInstance, Build, BuildTarget, MatchType, Compliant | Format-Table

# Let's compare again, just to keep in mind the target build (14.0.3356)
Test-DbaBuild -SqlInstance SQL2017 -Latest | Select BuildTarget

# Get more information about the build target (in particular, we want the CULevel CU22 and KBLevel 4577467)
Get-DbaBuildReference -Build "14.0.3356" | Select CULevel, KBLevel

# Now, we can download the update by using KBLevel 4577467
Save-DbaKBUpdate -Path "\\sql2012\temp" -Name "4577467"

# And then, we can update update the instance to CULevel CU22
$cred = Get-Credential LOCAL\daniel
Update-DbaInstance -ComputerName SQL2017 -Path '\\sql2012\temp' -Credential $cred -Version "SQL2017CU22" -ExtractPath D:\Temp -Confirm:$false -Restart -WhatIf

# Could we do it for multiple servers?
$servers = "SQL2008R2","SQL2012","SQL2014","SQL2016","SQL2017","SQL2019"
$servers | Test-DbaBuild -Latest | Select-Object SqlInstance, Build, BuildTarget, MatchType, Compliant | Format-Table

######################################################################

## Community Tools

## First Responder Kit (Brent Ozar)
Install-DbaFirstResponderKit -SqlInstance SQL2019 -Force

## MaintenanceSolution (Ola Hallengren)
Install-DbaMaintenanceSolution -SqlInstance SQL2019 -ReplaceExisting
Get-DbaMaintenanceSolutionLog -SqlInstance SQL2019

## DbaSqlWatch (Marcin Gminski)
Install-DbaSqlWatch -SqlInstance SQL2019
Uninstall-DbaSqlWatch  -SqlInstance SQL2019

## sp_whoisactive (Adam Machanic)
Install-DbaWhoIsActive -SqlInstance SQL2019 -Database master
Invoke-DbaWhoIsActive -SqlInstance SQL2017 -GetOuterCommand -GetLocks

######################################################################


