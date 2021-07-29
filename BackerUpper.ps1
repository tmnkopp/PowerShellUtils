
function Invoke-BackerUpper
{ 
    [CmdletBinding()]
        param ( 
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $with = 'files' ,
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $from = ''  ,
        [Parameter(Mandatory = $true, Position = 2)] 
        [string] $to = 'D:\Backup\'       
    )
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  
    $dt = get-date -format yyyy-MM-ddTHH-mm-ss 
    if ($with -match 'files|dir' ){  
        $excludes = @("TempUp") 
        $files =  Get-ChildItem -Path $from -Exclude $excludes | %{ 
            $allowed = $true
            foreach ($exclude in $Excludes) { 
                if ((Split-Path $_.FullName -Parent) -match $exclude) { 
                    $allowed = $false
                    break
                }
            }
            if ($allowed) {
                $_.FullName
            }
        }
        # Write-Host $files
        Copy-Item $files $dest -force -recurse        

        # Copy-Item -Destination $to -Recurse -Force
        # Copy-Item -Path $from*  -Exclude $ex  -Destination $to  -Recurse -Force 
        # Compress-Archive -Path $to -Update -DestinationPath $to + "\files-" + $dt + ".zip"
        # Copy-Item -Path (Get-Item -Path $from -Exclude $ex).FullName -Destination $destination -Recurse -Force
   
        explorer.exe $to
    }
    if ($with -match 'merge' ){ 
        $ex = @( "tempdown\*", "TempUp\*", "*.config", "*.pubxml" ); 
        Copy-Item -Path $from*  -Exclude $ex  -Destination $to  -Recurse -Force 
    }
    if ($with -match 'db' ){

        $password = $config.CSDBPASS 
        $connectionString = ";Initial Catalog=Cyberscope123;Data Source=DESKTOP-OM9UKAC;User ID=timk0pp;Password=$password;Max Pool Size=200" 
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionstring
        $connection.Open() 

        $command = New-Object System.Data.SqlClient.SqlCommand
        $command.Connection = $connection
         
        $sql = " 
             BACKUP DATABASE [Cyberscope123] 
             TO DISK = N'D:\Backup\CyberScope.bak' 
             WITH DIFFERENTIAL, NOFORMAT, NOINIT
            , NAME = N'BK-CS  " + $dt +  "'
            , SKIP, NOREWIND, NOUNLOAD,  STATS = 10 
        "
        $command.CommandText = $sql 
        $command.CommandTimeout = 0
        $command.ExecuteNonQuery()
    }  
    
} 
Invoke-BackerUpper -with "files" -from D:\Dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\ -to D:\Backup\CS


# explorer.exe D:\Dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\
# Invoke-Sqlcmd -Database 'Cyberscope123' -InputFile 'C:\sql\Backup.sql'  -Password $config.CSDBPASS -Username CSAdmin 






