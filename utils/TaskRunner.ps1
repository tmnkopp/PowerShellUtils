cls; 
$connectionString = ";Initial Catalog=Cyberscope123;Data Source=DESKTOP-OM9UKAC;User ID=CSAdmin;Password=;Max Pool Size=200" 
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionstring
$connection.Open() 
$command = New-Object System.Data.SqlClient.SqlCommand
$command.Connection = $connection

dir -Path D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Views -Filter *.sql -Recurse | `  
where { ($_.FullName -notmatch '(DBUpdate|DB_Update)' -and $_.LastWriteTime -gt (Get-Date).AddDays(-30)) }  | `
% { 
    Write-Host $_.FullName
    $c = Get-Content $_.FullName  -Raw
    $c -split '(?:\bGO\b)' | % { 
        if( $_ -ne ''){ 
            #Write-Host $_ 
            $command.CommandText = $_ 
            $command.CommandTimeout = 0
            $command.ExecuteNonQuery() 
        } 
    } 
}

 
