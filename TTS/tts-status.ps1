<#
.SINOSSI
    Mostra lo stato dei copioni narrati (TTS/*.txt) rispetto ai documenti sorgente (docs/*.md).

.DESCRIZIONE
    Per ogni voce del manifest confronta l'hash SHA-256 attuale del documento sorgente
    con quello registrato quando il copione e' stato scritto (campo sourceSha256).

    Stati possibili:
      OK                -> il sorgente non e' cambiato dall'ultima stesura del copione.
      DA AGGIORNARE     -> il sorgente e' cambiato: chiedere a Claude di riscrivere il copione.
      MAI GENERATO      -> nel manifest manca l'hash (copione mai "timbrato"): eseguire tts-regen.ps1 -Stamp.
      COPIONE MANCANTE  -> il file .txt del copione non esiste.
      SORGENTE MANCANTE -> il file .md sorgente non esiste.

    Esce con codice 0 se tutto e' OK, 1 se almeno una voce non lo e'.

.ESEMPIO
    powershell -ExecutionPolicy Bypass -File TTS\tts-status.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot     = Split-Path $PSScriptRoot -Parent
$manifestPath = Join-Path $PSScriptRoot 'manifest.json'

if (-not (Test-Path $manifestPath)) {
    Write-Error "Manifest non trovato: $manifestPath"
    exit 2
}

$manifest = Get-Content -Raw -Path $manifestPath | ConvertFrom-Json
$rows = @()
$tuttoOk = $true

foreach ($voce in $manifest.voci) {
    $sorgentePath = Join-Path $repoRoot $voce.sorgente
    $copionePath  = Join-Path $repoRoot $voce.copione

    if (-not (Test-Path $sorgentePath)) {
        $stato = 'SORGENTE MANCANTE'
    }
    elseif (-not (Test-Path $copionePath)) {
        $stato = 'COPIONE MANCANTE'
    }
    else {
        $hashAttuale = (Get-FileHash -Algorithm SHA256 -Path $sorgentePath).Hash
        if ([string]::IsNullOrEmpty($voce.sourceSha256)) {
            $stato = 'MAI GENERATO'
        }
        elseif ($hashAttuale -eq $voce.sourceSha256) {
            $stato = 'OK'
        }
        else {
            $stato = 'DA AGGIORNARE'
        }
    }

    if ($stato -ne 'OK') { $tuttoOk = $false }

    $rows += [PSCustomObject]@{
        Stato    = $stato
        Copione  = Split-Path $voce.copione -Leaf
        Sorgente = $voce.sorgente
        Generato = if ($voce.generatoIl) { $voce.generatoIl } else { '-' }
    }
}

$rows | Format-Table -AutoSize

if ($tuttoOk) {
    Write-Host "Tutti i copioni sono allineati ai sorgenti." -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Alcuni copioni vanno rigenerati. Vedi tts-regen.ps1." -ForegroundColor Yellow
    exit 1
}
