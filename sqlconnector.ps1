
$instance = "Cyberscope123"
$userId = "CSAdmin"
$password = "P@ssword1" 
$connectionString = "Data Source=$instance;Integrated Security=SSPI;Initial Catalog=master; User Id=$userId; Password=$password;"


$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionstring
$connection.Open()


$command = New-Object System.Data.SqlClient.SqlCommand
$command.Connection = $connection

$sqltoexecute = Get-Content("D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Sprocs\OrgSubSelect.sql");
$command.CommandText = $sqltoexecute 
$command.CommandTimeout = 0
$command.ExecuteNonQuery()
  