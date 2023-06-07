Run("C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe")
WinWait("Connect to Server", "",9)
Send("!c")  
Sleep(900) 
Send("{DOWN}{RIGHT}")     
Sleep(900)
Send("{DOWN 4}")
Sleep(900) 
Send("^o") 
Sleep(900) 
Send("C:\Users\timko\Documents\SQL Server Management Studio\trace.sql{ENTER}")  
Sleep(900) 
Send("!t")  
Sleep(900)
Send("p") 
WinWait("Connect to Server", "",3)
Send("!c")  
WinWait("Trace Properties", "",3)
Send("!b")  
WinWait("Connect to Server", "",3)
Send("!c")  
WinWait("Destination table", "",3)
Send("{ENTER}") 
Sleep(900)
Send("!y")
Sleep(900)
Send("{ENTER}") 
WinSetState("SQL Server Profiler", "", @SW_MINIMIZE)


; #cs 

; #ce

