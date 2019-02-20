#Get-Service remoteregistry -ComputerName $computer | start-service
Copy-item "\\leia\mis\New Installs\RemoteApp" -container -recurse \\$computer\c$\windows\temp\
msiexec /i  "C:\Windows\Temp\RemoteApp\RemoteApp\Leia RA.MSI"  
