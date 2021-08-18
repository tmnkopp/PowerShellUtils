

function Invoke-CreateRelease(){ 
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory = $true, Position = 0)] 
        [string] $Version = 'tmp' , 
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $With = ''  , 
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $Env = '',
        [Parameter(Mandatory = $false, Position = 3)] 
        [string] $ScriptDate = ''
    )
    cls;  
    $to = 'G:\inetpub\wwwroot\builds\CyberScope\_releases\'+$Version+'\' 
    if($with -match '.*init.*'){ 
        Remove-Item ($to) -Recurse -Force
        New-Item $to -ItemType "directory" -Force             
    }
 
    if($with -match '.*config.*'){
        Write-Host $Version
        Write-Host $to
        Write-Host $with
        explorer.exe $to
    } 
    if($with -match '.*code.*'){
        $f = Get-ChildItem 'G:\inetpub\wwwroot\builds\CyberScope' -Filter *.zip | sort CreationTime -desc | select -f 1   
            $match = select-string ".*svn(\d{4,9}).*" -inputobject $f.FullName 
        $ver = $match.Matches.groups[1].value
            $match = select-string ".*tc(\d{4,5}).*" -inputobject $f.FullName 
        $tc = $match.Matches.groups[1].value 
        $new='t'+$tc +'s'+ $ver + '.zip'  
        Copy-Item -LiteralPath $f.FullName -Destination ($to + $new) -Force  
    } 
    if($with -match '.*scripts.*'){
        if($with -match '.*updatesvn.*'){
            cd G:\inetpub\wwwroot\database; svn status; svn update;  
        }
        if( $ScriptDate -eq ''){
            $ScriptDate = (Get-date).AddDays(-45)
        }
        Remove-Item ($to + 'scripts') -Recurse -Force
        New-Item ($to + 'scripts')  -ItemType "directory" 
        New-Item ($to + 'scripts\Sprocs')  -ItemType "directory"  
        New-Item ($to + 'scripts\Views')  -ItemType "directory"   
        New-Item ($to + 'scripts\Functions')  -ItemType "directory"  

        Get-ChildItem  -Path 'G:\inetpub\wwwroot\database' -Recurse -Filter *sql  | `
        Where-Object { ($_.LastWriteTime -gt  $ScriptDate) } | ` 
        Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress|\\Archive)') } | `    
        Sort-Object -Property $_.LastWriteTime -de |ForEach-Object  { #   Out-GridView -PassThru  |  
            $ff = $_.FullName -replace 'G:\\inetpub\\wwwroot\\database', ''   
            Copy-Item -LiteralPath $_.FullName -Destination ($to + 'scripts\' + $ff)  -Recurse -Force 
        }  
        Compress-Archive -Path ($to + 'scripts*') -Update -DestinationPath ($to + '\scripts.zip')
    }  
    if($with -match '.*inspect.*'){
        explorer.exe $to
    }   
}   
Invoke-CreateRelease -Version '7.36Stage' -With 'init|code|scripts' 
  