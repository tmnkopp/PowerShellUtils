
; Launch Remote Desktop and connect to remote machine
Run("mstsc.exe /f /v:dayman.cyber-balance.com")
WinWaitActive("Remote Desktop Connection")
WinWaitActive("Remote Desktop")
sleep(8000)
