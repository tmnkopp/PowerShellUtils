Import-Module sqlserver

$Databases = Get-ChildItem -Path SQLSERVER:\SQL\LOCALHOST\DEFAULT\Databases

$Output = @()

ForEach ($d in $Databases) {

    ForEach ($t in $d.tables) {
        $Object = [PSCustomObject] @{
            ServerName = 'LOCALHOST'
            DatabaseName = $d.Name
            DatabaseSize = $d.Size
            TableSchema = $t.Schema
            TableName = $t.Name
            RowCount = $t.RowCount
            DataSpaceUsed = $t.DataSpaceUsed
            IndexSize = ($t.Indexes.SpaceUsed | Measure-Object -Sum).Sum
        }

        $Output += $Object
    }
}