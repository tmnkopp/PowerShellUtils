function DBUpdater
{
	[CmdletBinding()]
	param
	( 
        [Alias("cs", "conn")] 
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $ConnStr = '', 
        [Alias("d")] 
        [Parameter(Mandatory = $false, Position = 1)] 
        [int] $UpdateFromDays = 30,  
        [Alias("p")] 
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $SourcePath = '' ,
        [Alias("u")]
        [Parameter(Mandatory = $false, Position = 3)] 
        [bool] $UpdateSVN = $false   ,
        [Alias("f")]
        [Parameter(Mandatory = $false, Position = 4)] 
        [string] $FileFilter = '*.sql'  ,
        [Alias("m")]
        [Parameter(Mandatory = $false, Position = 5)] 
        [string] $OutGridMatch = '~'                 
	)
	begin
	{
        function RunScript {
            [CmdletBinding()] 
            param(    
                [Parameter(Mandatory = $true, Position = 0)] [String]$sql 
            ) 
            ($sql -split 'G[Oo]\s*\r|G[Oo]\s*\n').foreach({ 
                if($_ -ne ''){ 
                    $cmd = $_ -replace '\nG[Oo]|\rG[Oo]', ''   
                    try { 
                        $command.CommandText = $cmd
                        $command.CommandTimeout = 0
                        $null = $command.ExecuteNonQuery() 
                    }
                    catch { 
                        Write-Error $_.Exception.Message 
                    } 
                }  
            })  
        } 
        $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
        if($SourcePath -eq ''){ $SourcePath=($config.BRANCH + '\CSwebdev\database')}      
        if($UpdateSVN){  cd $SourcePath; svn update; }
       
        $ConnectionString=$config.CONNSTR
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $ConnectionString
        $connection.Open()  
	}
	process
	{
        $command = New-Object System.Data.SqlClient.SqlCommand
        $command.Connection = $connection  
		try {    
            $files = (Get-ChildItem $SourcePath -Recurse -Filter $FileFilter) 
            $files = $files.where({$_.FullName -notmatch 'Archive\\|Utils\\|Progress\\'})
            $files = $files.where({$_.LastWriteTime -gt (Get-Date).AddDays(-$UpdateFromDays)}) 
            ($files.where({$_.FullName -match  $OutGridMatch}) | sort $_.LastWriteTime | Out-GridView -PassThru).foreach({
                Write-Host $_.FullName 
                RunScript (Get-Content $_.FullName -Raw)     
            })
            ($files.where({$_.FullName -notmatch  $OutGridMatch}) | sort $_.LastWriteTime).foreach({
                Write-Host $_.FullName 
                RunScript (Get-Content $_.FullName -Raw)  
            })  
		} catch {
		    Write-Error $_.Exception.Message 
		} finally {
            $connection.close()
            Write-Host 'END'
        } 
	}
}  



