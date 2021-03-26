 
cd 'D:\PS'
git remote set-url origin   https://github.com/tmnkopp/PowerShellUtils.git
git push --set-upstream origin master
git remote -v
git status
git add .; git commit -m "added ps for git commands";git push;
 
cd C:\users\tim\source\repos\JiraPortal
git add .; git commit -m "updated formatting";git push; 
cd C:\users\tim\source\repos\JiraFormatter
git add .; git commit -m "updated formatting";git push; 
cd C:\users\tim\source\repos\JiraCore
git add .; git commit -m "updated formatting";git push;
  
cd C:\users\tim\source\repos\SOMData
git add .; git commit -m "added code gen";git push;

cd C:\users\tim\source\repos\somuing
git add .; git commit -m "added support for code gen";git push;

cd C:\users\tim\source\repos\SOM-API
git add .; git commit -m "added code gen supporting model";git push;

cd C:\users\tim\source\repos\SledgeOMatic;
git add .; git commit -m "refacted compiler "; git push;
