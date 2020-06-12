cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev 
svn  update
svn --help update

#Get-Item *3.4.1*.js | foreach{ svn rm --keep-local $_   } -WhatIf
#Get-Item *3.4.1*[.js|.map] | foreach{ svn rm --keep-local $_   } -WhatIf
 
#svn cleanup --remove-unversioned  -WhatIf



