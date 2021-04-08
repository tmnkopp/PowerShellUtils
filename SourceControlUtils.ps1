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
    cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database; svn update ; 
    cd D:\dev\CyberBalance\trunk\projects; svn update; 
    cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code; svn update; dotnet build;   
   
    cd D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\database; svn update ;  
    cd D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code; svn update; dotnet build;     
}