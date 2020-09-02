# Copies over temporary table for report, cleaned up by ReportClean script

Import-Module DbProjectSupport -Force -DisableNameChecking

$srcServer      ="srcServer"
$srcDatabaseName="srcDatabase"
$srcTableName   ="dbo.srcTableName"

$destServer      ="destServer"
$destDatabaseName="destDatabase"
$destTableName   ="dbo._destTableName"

$dropDestTableScript="
IF OBJECT_ID('$destTableName') IS NOT NULL
    DROP TABLE $destTableName
"

$createDestTableScript="
CREATE TABLE $destTableName (
	[id] [smallint] NULL,
	[code] [varchar](8) NOT NULL,
	[displayName] [varchar](100) NULL,
	[IsUsed] [bit] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Shortname] [varchar](100) NOT NULL,
	[AbbreviatedName] [varchar](8) NOT NULL,
	[Address1] [varchar](50) NULL,
	[Address2] [varchar](50) NULL,
	[Address3] [varchar](50) NULL,
	[Address4] [varchar](50) NULL,
	[Address5] [varchar](50) NULL,
	[Town] [varchar](255) NULL,
	[PostCode] [varchar](12) NULL,
) ON [PRIMARY]
"
# Read data set from source table
$providerDataSet = Invoke-Sqlcmd2 -ServerInstance $srcServer -Database $srcDatabaseName -Query "SELECT * FROM $srcTableName" -As DataTable

Invoke-Sqlcmd   -ServerInstance $destServer -Database $destDatabaseName -Query $dropDestProviderTableScript
Invoke-Sqlcmd   -ServerInstance $destServer -Database $destDatabaseName -Query $createDestProviderTableScript
Write-DataTable –ServerInstance $destServer –Database $destDatabaseName –TableName $destTableName –Data $providerDataSet
