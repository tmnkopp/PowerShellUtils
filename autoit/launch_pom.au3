
; Launch Remote Desktop and connect to remote machine
Run("cmd.exe /K C:\Users\timko\anaconda3\Scripts\activate.bat C:\Users\timko\anaconda3")
sleep(1000)
Send('cd C:\Users\timko\source\repos\PythonBoiler\CodeGenerators{ENTER}')
sleep(500)
Send('python pom.py --help{ENTER}')



