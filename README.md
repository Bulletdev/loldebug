# LoL Reconnect Fix

Script para resolver o bug de reconexão do League of Legends sem precisar reiniciar o PC.

## O problema

Durante partidas, o cliente trava na tela de reconexão e o botão não funciona. 

A solução manual envolve vários passos chatos — péssimo para quem está ao vivo.

## O que o script faz

1. Encerra todos os processos do LoL e Riot Client
2. Para o Vanguard (vgtray + serviços vgc/vgk)
3. Limpa o cache DNS (`ipconfig /flushdns`)
4. Renova o IP (`ipconfig /release` + `ipconfig /renew`)
5. Reinicia o Vanguard
6. Abre o Riot Client direto no LoL

## Como usar

1. Coloque o `lol_reconnect_fix.bat` na área de trabalho
2. Quando o bug ocorrer, dê dois cliques no arquivo
3. Aceite o prompt de administrador (UAC)
4. Aguarde — o cliente abrirá automaticamente

## Configuração

Se o Riot Games ou o Vanguard estiverem instalados em caminhos diferentes dos padrões, edite as variáveis no início do script:

```bat
set VGTRAY_PATH=C:\Program Files\Riot Vanguard\vgtray.exe
set RIOT_CLIENT=C:\Riot Games\Riot Client\RiotClientServices.exe
```
