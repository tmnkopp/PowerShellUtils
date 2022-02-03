Import-Module  c:\posh\SourceControlUtils.ps1; SVNUpdate -b 1;  
Import-Module  c:\posh\DBUpdater.ps1; DBUpdater -u 1 -d 5  #  -m '.*DBUpdate.*' # -f 'cq_*.sql'  
cls; bom run -h -t cyber_init 
cls; bom run -t jira_list -k 
cls; bom run -t timesheet -k 
