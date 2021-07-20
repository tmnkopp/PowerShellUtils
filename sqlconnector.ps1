
 
$password = "P@ssword1"  
$connectionString = ";Initial Catalog=Cyberscope123;Data Source=DESKTOP-OM9UKAC;User ID=timk0pp;Password=$password;Max Pool Size=200"

$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionstring
$connection.Open()


$command = New-Object System.Data.SqlClient.SqlCommand
$command.Connection = $connection

$sqltoexecute = "SELECT TOP 10 * FROM INFORMATION_SCHEMA.TABLES" # Get-Content(".\select.sql");
$command.CommandText = $sqltoexecute 
$command.CommandTimeout = 0
$reader = $command.ExecuteReader()
while ($reader.Read())  { "[0] : " + $reader.GetValue(2)  }
$reader.Close() 
# $command.ExecuteNonQuery()
  