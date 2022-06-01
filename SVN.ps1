
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
        svn commit $file -m ' CS-8895 dependancy multi update '; # CS-8494 EINS  CS-8614 CIO
    }    
    $nams = ''; Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''; 
    $base = (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\')
    cd $base 
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file; }  
        $nams = ($nams + $base + $file + [Environment]::NewLine); 
    }   
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams;  notepad.exe 'C:\temp\svnupdates.txt';
    
    svn commit --targets 'C:\temp\svnupdates.txt' -m 'CS-8892 add meta data to batch query ';   #  CS-8894 1802 frmval update CS-8901 BOD1802 Update Sections 4,5
    
    # CS-8892 add meta data to batch query
    # CS-8895 dependancy multi js update
    svn commit --targets 'C:\temp\svnupdates.txt' -m ' CS-8895 HVA Prepop Orgsubs';  
    svn commit --targets 'C:\temp\svnupdates.txt' -m ' CS-8890 default toggle to hide optional ';   
    svn commit --targets 'C:\temp\svnupdates.txt' -m ' CS-8885 create data request/response service ';  
    # IG changes. Logic for the levels
    # IG warning text changes ass sections
    # toggle show/hide all pages
    # formatting 
    # help desk 
    # CS-8933 Update 'Show/Hide' Metric Display When Edit/Save is Clicked: FY22 Annual IG
    # CS-8934 Update Show/Hide Metric Toggle Format: FY22 Annual IG
    # CS-8932 Update Validation Logic/Text- FY22 Annual IG 
    #
    #
    # CS-8894 1802  
    # CS-8895 HVA Section 1 DB UPDATE
    # start chrome https://dayman.cyber-balance.com/TeamCity/project/_Root?mode=builds     
    # CS-8901 BOD1802 Annual 1A Db Dependancy Update- 
    # CS-8889 Add Additional Guidance Notes to Each Section: FY22 Annual IG
    # CS-8865 Create Toggle to Show/Hide Optional Metrics: FY22 FISMA Annual IG
    # CS-8883 Update IPv4 Validations - EINSTEIN Config 
    # CS-8816 Modify BOD 22-01 KEV - Section 2 Grid and Validations
    # CS-8459 Browser Automator IG Config
    # CS-8816 Modify Allow Read Only Insert for batch   
    # CS-8826 CDM date import - remove date logic
    # CS-8459 Browser Automator config attribute targets 
    # CS-8459 Browser Automator 2201 Config
    # CSHELP-3211 update section 4 validation
}