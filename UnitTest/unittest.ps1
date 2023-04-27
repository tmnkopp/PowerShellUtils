 
 function RunScript { 
    [CmdletBinding()] 
    param(    
        [Parameter(Mandatory = $true, Position = 0)] [String]$sql 
    ) 
    ($sql -split 'G[Oo]\s*\r|G[Oo]\s*\n').foreach({ 
        if($_ -ne ''){ 
            $cmd = $_ -replace '\nG[Oo]|\rG[Oo]', ''   
            try { 
                $command.CommandText = $cmd # Write-Debug $cmd
                $command.CommandTimeout = 0
                $null = $command.ExecuteNonQuery() 
            }
            catch {   Write-Error $_.Exception.Message   } 
        }  
    })  
} 
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = ';Data Source=localhost\SQLEXPRESS;Initial Catalog=Cyberscope123;Trusted_Connection=True;'
$connection.Open()  

$command = New-Object System.Data.SqlClient.SqlCommand
$command.Connection = $connection  
try {    
    $files = ( Get-ChildItem 'C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database'  -Filter '*.sql' )   
    ($files).foreach({
        Write-Host $_.FullName 
        RunScript (Get-Content $_.FullName -Raw)  
    })   
} catch {
    Write-Error $_.Exception.Message 
} finally {
    $connection.close() 
} 



 