
## Dealing with data

## Export to CSV file
Get-DbaDatabase -Sqlinstance "SQL2016" -ExcludeSystem | Select-Object Name, Size | Export-Csv -Path d:\dbatools\Export2016.csv -NoTypeInformation
Get-DbaDatabase -Sqlinstance "SQL2017" -ExcludeSystem | Select-Object Name, Size | Export-Csv -Path d:\dbatools\Export2017.csv -NoTypeInformation

## Export to a table
Get-DbaDatabase -Sqlinstance "SQL2016" -ExcludeSystem | Select-Object Name, Size | Write-DbaDataTable -SqlInstance SQL2017 -Database Test -Table Tablas -AutoCreateTable

## Were the files created?
Get-ChildItem -Path d:\Dbatools\*.csv

## Import from a CSV to a table
Import-DbaCsv -Path d:\Dbatools\Export2016.csv -SqlInstance SQL2017 -Database Test -Table TableFromSQL2016 -AutoCreateTable

## Let's check how it went
Get-DbaDatabase -Sqlinstance SQL2017 -Database Test | Get-DbaDbTable | Select-Object Schema,Name, RowCount

## Import multiple CSV files
Get-ChildItem -Path d:\Dbatools\*.csv | Import-DbaCsv -SqlInstance SQL2017 -Database Test -AutoCreateTable

## Again...let's check how it went
Get-DbaDatabase -Sqlinstance SQL2017 -Database Test | Get-DbaDbTable | Select-Object Schema,Name, RowCount

## Copy both structure and data (with no FK's or indexes)
Copy-DbaDbTableData -SqlInstance "SQL2016" -Database ReportServer -Table ConfigurationInfo -Destination SQL2017 -DestinationDatabase Test -DestinationTable ConfigurationInfo -AutoCreateTable

## Run a query
$query = "SELECT [name], create_date, recovery_model_desc FROM sys.databases ORDER BY [name]"
Invoke-DbaQuery -SqlInstance SQL2017 -Query $query -Database Test

## Capture results
$results = Invoke-DbaQuery -SqlInstance SQL2017 -Query $query -Database Test
$results
$results | Out-File "d:\dbatools\export-results.txt"
$results | Out-GridView

