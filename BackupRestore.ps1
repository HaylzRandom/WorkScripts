# Will create a restore SQL script, that can be executed on SSMS
Restore-DbaDatabase -sqlinstance 'serverName' -databaseName 'databaseName' -path '\\path_where_backup_stored' -OutputScriptOnly