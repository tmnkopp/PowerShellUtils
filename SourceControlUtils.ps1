function SCUnitTest(){

    [CmdletBinding()]
     param (  
      [Parameter(Mandatory = $false, Position = 0)] 
      [string] $pass = 'default' 
     )
     Write-Host $pass 
  }  

function SVNUpdate 
{ 
    [CmdletBinding()]
        param (  
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $With = '  ' 
    ) 
    cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database; svn update  
    cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code; svn update; dotnet build;   
    if( $With -match '.*test.*' ){
        $exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')  
        & $exe cmd -t ein -p cyber.yaml
    } 
}