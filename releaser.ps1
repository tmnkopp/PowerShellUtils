
New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\  -ItemType "directory"
New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts  -ItemType "directory"
New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts\Sprocs  -ItemType "directory"
New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts\Views  -ItemType "directory"
New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts\Functions  -ItemType "directory"

$CREATE_CODE = $false
if ($CREATE_CODE -eq $true){
    $f = Get-ChildItem 'G:\inetpub\wwwroot\builds\CyberScope' -Filter *.zip | sort CreationTime -desc | select -f 1   
    $match = select-string ".*svn(\d{4,9}).*" -inputobject $f.FullName 
    $version = $match.Matches.groups[1].value
    $match = select-string ".*tc(\d{4,5}).*" -inputobject $f.FullName 
    $tc = $match.Matches.groups[1].value 
    $new='t_'+$tc +'_s'+ $version + '.zip' 
    $new
    Copy-Item -LiteralPath $f.FullName -Destination G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\$new -Force 
    explorer.exe G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\
}
 
$CREATE_SCRIPTS = $false
if ($CREATE_SCRIPTS -eq $true){ 
    Remove-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts
    New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts  -ItemType "directory"
    New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts\Sprocs  -ItemType "directory"
    New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts\Views  -ItemType "directory"
    New-Item G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts\Functions  -ItemType "directory"   
    Get-ChildItem  -Path 'G:\inetpub\wwwroot\database' -Recurse -Filter *sql  | `
    Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-45)) } | ` 
    Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress|\\Archive)') } | `    
    Sort-Object -Property $_.LastWriteTime -de |  Out-GridView -PassThru  |  ForEach-Object  { 
        $ff = $_.FullName -replace 'G:\\inetpub\\wwwroot\\database', ''
        #Write-Host $ff
        Write-Host $_.Name
        Copy-Item -LiteralPath $_.FullName -Destination G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts$ff  -Recurse -Force 
    }# 
    Compress-Archive -Path G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts* -Update -DestinationPath G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts.zip
  
}
explorer.exe G:\inetpub\wwwroot\database
explorer.exe G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts
explorer.exe G:\inetpub\wwwroot\builds\CyberScope\_releases\7.35.1Prod\scripts
explorer.exe G:\inetpub\wwwroot\builds\CyberScope\_releases

explorer.exe  G:\inetpub\wwwroot\


