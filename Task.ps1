param (  
    [Parameter(Mandatory = $false, Position = 0)] 
    [string] $Foo  = 'bar' 
)

Write-Host $Foo  

function UnitTest(){

  [CmdletBinding()]
   param (  
    [Parameter(Mandatory = $false, Position = 0)] 
    [string] $Bar = 'default' 
   )
   Write-Host $Bar  
}  
 