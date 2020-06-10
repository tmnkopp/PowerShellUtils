Get-Item *3.4.1*.js | foreach{ svn rm --keep-local $_   } -WhatIf
Get-Item *3.4.1*[.js|.map] | foreach{ svn rm --keep-local $_   }

svn rm  jquery-3.4.1.min.js
svn st  -v

svn cleanup --remove-unversioned

svn --help rm

