
function SVNCommitter
{ 
    [CmdletBinding()]
        param (  
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $With = '  ' 
    ) 
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  
    cd ($config.BALANCE)
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1] ;  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file;  }     
        if($stat -match 'A|M'){ } # CS-8450    CS-8412 update remove default literal tc not building 
        svn commit $file -m 'CS-8816 Modify Allow Read Only Insert for batch '; # CS-8494 EINS  CS-8614 CIO
    }    
    cd (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\') # database\
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ;   #  CS-8764  validate apprive remove EO CS-8757  Update Section 2  CSHELP-3160 Adding New BOD 18-02 Remediation Plan CQ Parameter 
        if($stat -match '\?'){  svn add $file;  }      # CS-8764 FY22 FISMA CIO Q2 Data Call CS-8753 justification field requirement update
        svn commit $file -m ' CS-8816 add seeding for gtt 7a for q1 & q2 '; 
    }    
    # start chrome https://dayman.cyber-balance.com/TeamCity/project/_Root?mode=builds    
    # CS-8764  validate apprive remove EO 
    # CS-8764 FY22 FISMA CIO Q2 Data Call CS-8753 justification field requirement update
    # CS-8812 Move upload control from agency to admin  
    # CS-8816 Modify BOD 22-01 KEV - Section 2 Grid and Validations
    # CS-8459	 Selenium Browser Automator Refactor  
    # CS-8816 Modify Allow Read Only Insert for batch  
}   

function Committer(){ 
    [CmdletBinding()]
     param (  
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $commitm = 'CS-8132 updated metrics' ,
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $with = ' ' ,        
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $fromdate = (Get-Date -date ((Get-Date).AddDays(-2)) -format "MM/dd/yyyy")
    )
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
    $inc = @("*.aspx","*.vb","*.ascx","*.master", "*.css", "*.js", "*.sql") 
    $exc = @("Archive") 
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''
    ####### DB ###### 
    if( $with -match '.*db.*'){
        $src = ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\') 
        cd $src  
        $fs = Get-ChildItem -Include $inc -Recurse -path $src `
            | WHERE-OBJECT{ $_.LastWriteTime -gt $fromdate } 
        Set-Content -Path 'C:\temp\svnupdates.txt' -Value $fs 
    }   
    if( $with -match '.*commit.*'){
        cd $src 
        svn commit --targets 'C:\temp\svnupdates.txt' -m $commitm;
    } 
    ####### CODE ###### 
    if( $with -match '.*code.*'){
        $src = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope' 
        $nams = Get-ChildItem -Include $inc -Recurse -path $src `
            | WHERE-OBJECT{ $_.LastWriteTime -gt $fromdate -and $_.FullName -match "\."  }    
        Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams
    } 
    if( $with -match '.*commit.*'){
        cd $src 
        svn commit --targets 'C:\temp\svnupdates.txt' -m $commitm; svn status;
    } 
    ####### STAGE ######
    if( $with -match '.*stage.*'){
        notepad.exe 'C:\temp\svnupdates.txt'; cls; svn status ;
    }   
} 
Committer -with '  codestage '