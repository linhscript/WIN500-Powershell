New-PSSessionOption -IdleTimeout 7200000 

Invoke-Command -ComputerName (gc $home\Desktop\computers.txt) -FilePath C:\temp\script\Lab4_echoLineNumber.ps1 -InDisconnectedSession -Credential Administrator



