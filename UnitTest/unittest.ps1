$Path =  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Functions\iter_stringlist_to_tbl.sql'
$content = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "");
$match = select-string ".*DROP\s{1,}(\w{2,255})\s{1,}([A-Za-z0-9\\_]{3,})" -inputobject  $content;
$obj = $match.Matches.groups[2].value
cls
$obj