# Removes temporary tables created by ReportInitalise script

Import-Module DbProjectSupport -Force -DisableNameChecking

$destServer      ="Server"
$destDatabaseName="Data Store"
$destTableName   ="dbo._tempTable"

$dropDestProviderTableScript="
IF OBJECT_ID('$destTableName') IS NOT NULL
    DROP TABLE $destTableName
"

Invoke-Sqlcmd -ServerInstance $destServer -Database $destDatabaseName -Query $dropDestProviderTableScript
