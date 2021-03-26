$base = 'C:\inetpub\wwwroot\'
$builds = $base + 'builds\' 
$releasefrom = "C:\inetpub\wwwroot\somapi_Release\"
$releaseto = $base + "somapi\"
$temp = $base + "temp\" 
$webconf = $releasefrom + "web.config"

$content = Get-Content -Path $webconf 
$content = $content.Replace("AspNetCoreModule""","AspNetCoreModuleV2""")
Set-Content -Path $webconf  -Value $content 