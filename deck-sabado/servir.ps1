# Serve o deck do sábado em http://localhost:8765/DECK-T3-SABADO.html e puxa do GitHub a cada 30 s.
# Rodar nesta pasta: powershell -ExecutionPolicy Bypass -File servir.ps1
$pasta = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $pasta
$srv = Start-Process python -ArgumentList "-m","http.server","8765","--bind","127.0.0.1" -WorkingDirectory $pasta -PassThru -WindowStyle Hidden
Write-Host "Deck em http://localhost:8765/DECK-T3-SABADO.html  (Ctrl+C encerra)"
try {
  while ($true) { git -C (Split-Path -Parent $pasta) pull -q 2>$null; Start-Sleep -Seconds 30 }
} finally { Stop-Process -Id $srv.Id -ErrorAction SilentlyContinue }
