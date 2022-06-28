 
  
function SVNUpdate 
{ 
    [CmdletBinding()]
        param (  
            [Alias("b")]
            [Parameter(Mandatory = $false, Position = 0)] 
            [bool] $BuildCode = $false 
    )  
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
    cd ($config.BALANCE+''); svn update; 
    cd ($config.BRANCH+'\CSwebdev\database'); svn update ;    
    cd ($config.BRANCH+'\CSwebdev\code'); svn update;  
    if( $BuildCode ){
        try
        {  
            $paths=[Environment]::GetEnvironmentVariable('PATH', 'Machine') -split ';' 
            $msbuild = '';
            foreach($p in $paths){
                if($p -match 'MSBUILD'){
                    $msbuild = ($p+'\MSBuild.exe');
                } 
            }
            & $msbuild -v:q  -clp:ErrorsOnly  -p:WarningLevel=0 ;    
        }
        catch
        { 
            Write-Host "msbuild fail " + $config.MSBUILD
        } 
    } 
}
  