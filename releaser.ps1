
$CREATE_CODE = $false
if ($CREATE_CODE -eq $true){ 
    
    $f = Get-ChildItem 'G:\inetpub\wwwroot\builds\CyberScope' -Filter *.zip | sort CreationTime -desc | select -f 1   
    $match = select-string ".*svn(\d{4,9}).*" -inputobject $f.FullName 
    $version = $match.Matches.groups[1].value
    $match = select-string ".*tc(\d{4,5}).*" -inputobject $f.FullName 
    $tc = $match.Matches.groups[1].value 
    $new='t'+$tc +'s'+ $version + '.zip' 
    $new
    Copy-Item -LiteralPath $f.FullName -Destination $PATH_releases\7.35.1Stage\$new -Force 

    explorer.exe $PATH_releases\7.35.1Stage\

}  
$CREATE_SCRIPTS = $false
if ($CREATE_SCRIPTS -eq $true){ 
    Remove-Item $PATH_releases\7.35.1Stage\scripts -Recurse -Force 
    New-Item $PATH_releases\7.35.1Stage\scripts  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts\Sprocs  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts\Views  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts\Functions  -ItemType "directory"   
    ## explorer.exe $PATH_releases\7.35Prod\script_1963\script1\script2
    Get-ChildItem  -Path 'G:\inetpub\wwwroot\database' -Recurse -Filter *sql  | `
    Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-45)) } | ` 
    Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress|\\Archive)') } | `    
    Sort-Object -Property $_.LastWriteTime -de |  Out-GridView -PassThru  |  ForEach-Object  { 
        $ff = $_.FullName -replace 'G:\\inetpub\\wwwroot\\database', '' 
        Write-Host $_.Name  #  $ff
        #Copy-Item -LiteralPath $_.FullName -Destination $PATH_releases\7.35.1Stage\scripts$ff  -Recurse -Force 
    }# 
    Compress-Archive -Path $PATH_releases\7.35.1Stage\scripts* -Update -DestinationPath $PATH_releases\7.35.1Stage\scripts.zip
  
}

$INIT = $false
if ($INIT -eq $true){ 
    New-Item $PATH_releases\7.35.1Stage\  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts\Sprocs  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts\Views  -ItemType "directory"
    New-Item $PATH_releases\7.35.1Stage\scripts\Functions  -ItemType "directory"

    explorer.exe G:\inetpub\wwwroot\
    explorer.exe G:\inetpub\wwwroot\database
    explorer.exe $PATH_releases
    explorer.exe $PATH_releases\7.35.1Stage\scripts 
}
 
 