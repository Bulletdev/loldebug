@echo off
:: Verifica e solicita privilégios de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando permissao de administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title LoL Reconnect Fix
color 0A

echo ============================================
echo         LoL RECONNECT FIX
echo ============================================
echo.

:: ---- 1. Mata processos do LoL e Riot Client ----
echo [1/5] Encerrando processos do LoL...

set PROCS=LeagueClient.exe LeagueClientUx.exe LeagueClientUxRender.exe "League of Legends.exe" RiotClientServices.exe RiotClientUx.exe RiotClientUxRender.exe

for %%P in (%PROCS%) do (
    taskkill /F /IM "%%P" /T >nul 2>&1
)
echo     OK - Processos encerrados.

:: ---- 2. Mata o Vanguard ----
echo [2/5] Encerrando Vanguard (vgtray)...
taskkill /F /IM vgtray.exe /T >nul 2>&1
sc stop vgc >nul 2>&1
sc stop vgk >nul 2>&1
echo     OK - Vanguard encerrado.

:: Aguarda os serviços liberarem
timeout /t 2 /nobreak >nul

:: ---- 3. Limpa DNS ----
echo [3/5] Limpando DNS...
ipconfig /flushdns >nul
echo     OK - DNS limpo.

:: ---- 4. Renova IP ----
echo [4/5] Renovando IP (release + renew)...
ipconfig /release >nul
ipconfig /renew >nul
echo     OK - IP renovado.

:: ---- 5. Reinicia o Vanguard ----
echo [5/5] Reiniciando Vanguard...
set VGTRAY_PATH=C:\Program Files\Riot Vanguard\vgtray.exe

if exist "%VGTRAY_PATH%" (
    start "" "%VGTRAY_PATH%"
    echo     OK - vgtray iniciado.
) else (
    echo     AVISO: vgtray.exe nao encontrado em "%VGTRAY_PATH%"
    echo     Abra o vgtray manualmente antes de iniciar o LoL.
)

timeout /t 3 /nobreak >nul

:: ---- Abre o Riot Client ----
set RIOT_CLIENT=C:\Riot Games\Riot Client\RiotClientServices.exe

if exist "%RIOT_CLIENT%" (
    echo.
    echo Abrindo Riot Client...
    start "" "%RIOT_CLIENT%" --launch-product=league_of_legends --launch-patchline=live
) else (
    echo.
    echo AVISO: Riot Client nao encontrado em "%RIOT_CLIENT%"
    echo Abra o LoL manualmente.
)

echo.
echo ============================================
echo  Pronto! Aguarde o cliente carregar.
echo ============================================
timeout /t 4 /nobreak >nul
