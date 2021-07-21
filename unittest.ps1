function Invoke-UnitTest {
    [CmdletBinding()] 
    param(   
        [string] $Path = ''
    )
    $content = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "");
    $match = select-string ".*DROP\s{1,}(PROCEDURE|VIEW)\s{1,}([A-Za-z0-9\\_]*)" -inputobject  $content;
    $obj = $match.Matches.groups[2].value
    return $obj
    # $sql | Select-String '(DROP\s{1,}[PROCEDURE|VIEW|TRIGGER|FUNCTION]+)\s*([A-Za-z0-9\-\\_]+)' -AllMatches | Select -First 1 |  `
    #% {$_.matches.groups[2].value}`  
} 

cls
Invoke-UnitTest -Path D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Sprocs\OrgSubSelect.sql
