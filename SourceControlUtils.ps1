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
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
    cd  ($config.CSDIR+':\dev\CyberBalance\trunk\projects'); svn update; 
    cd  ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database'); svn update ; 
    cd  ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code'); svn update; dotnet build;   
     
}