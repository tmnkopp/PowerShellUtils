
<#
Import-Module  ( 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\posh\DBUpdater.ps1'); DBUpdater -d 7  `
-p 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\' `
-c ';Initial Catalog=CS101122;Data Source=DESKTOP-OM9UKAC;User ID=CSadmin;Password=P@ssword1;Max Pool Size=200' `
-v ;   

-c = CONNECTION STRING
-d = SCRIPTS FROM 7 DAYS AGO 
-p = PATH TO SCRIPTS
-e = EXCLUDE REGEX 
-v = VERBOSE

#>
function DBUpdater
{
	[CmdletBinding()]
	param
	(  
        [Alias("d")] 
        [Parameter(Mandatory = $false, Position = 0)] 
        [int] $UpdateFromDays = 30,  
        [Alias("p")] 
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $SourcePath = '' , 
        [Alias("e")] 
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $Exclude = '~', 
        [Alias("c")] 
        [Parameter(Mandatory = $false, Position = 3)] 
        [string] $CONNSTR = '' 
	)
	begin
	{ 
        Write-Verbose (' -p ' + $SourcePath);
        Write-Verbose (' -c ' + $CONNSTR); 
        
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
                    catch { 
                        Write-Error $_.Exception.Message 
                    } 
                }  
            })  
        }  
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $CONNSTR
        $connection.Open()  
	}
	process
	{ 
        try { 
            cd $SourcePath; svn update ; 
        } catch {
            Write-Error $_.Exception.Message 
        }    

        $command = New-Object System.Data.SqlClient.SqlCommand
        $command.Connection = $connection  
		try {    
            $files = ( Get-ChildItem $SourcePath -Recurse -Filter '*.sql' ) 
            $files = $files.where({$_.FullName -notmatch 'Archive\\|Utils\\|InProgress\\'})
            $files = $files.where({$_.LastWriteTime -gt (Get-Date).AddDays(-$UpdateFromDays)})  
            ($files.where({$_.FullName -notmatch  $Exclude}) | sort $_.LastWriteTime).foreach({
                Write-Host $_.FullName 
                RunScript (Get-Content $_.FullName -Raw)  
            })  
		} catch {
		    Write-Error $_.Exception.Message 
		} finally {
            $connection.close() 
        } 
	}
}     