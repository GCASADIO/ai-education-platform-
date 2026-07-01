<#
.SINOSSI
    Gestisce la rigenerazione dei copioni narrati (TTS/*.txt) e la sincronizzazione del manifest.

.DESCRIZIONE
    Il CONTENUTO dei copioni e' prosa parlata scritta da Claude Code: non e' derivabile
    automaticamente da uno script. Questo comando quindi:

      - Senza argomenti: elenca i copioni DA AGGIORNARE / MANCANTI / MAI GENERATI e stampa
        l'istruzione da dare a Claude per riscriverli.

      - Con -Stamp: dopo che i copioni sono stati (ri)scritti, aggiorna nel manifest
        l'hash SHA-256 del sorgente e il timestamp, marcando le voci come allineate.
        Usare -Solo <nome> per timbrare una sola voce (match sul nome file del copione).

    Flusso tipico:
      1) powershell -File TTS\tts-status.ps1              # vedo cosa e' cambiato
      2) chiedo a Claude: "rigenera i copioni TTS segnalati come DA AGGIORNARE"
      3) powershell -File TTS\tts-regen.ps1 -Stamp        # ri-sincronizzo il manifest

.ESEMPIO
    powershell -ExecutionPolicy Bypass -File TTS\tts-regen.ps1
    powershell -ExecutionPolicy Bypass -File TTS\tts-regen.ps1 -Stamp
    powershell -ExecutionPolicy Bypass -File TTS\tts-regen.ps1 -Stamp -Solo legale-daAscoltare.txt
#>
[CmdletBinding()]
param(
    [switch]$Stamp,
    [string]$Solo
)

$ErrorActionPreference = 'Stop'
$repoRoot     = Split-Path $PSScriptRoot -Parent
$manifestPath = Join-Path $PSScriptRoot 'manifest.json'

if (-not (Test-Path $manifestPath)) {
    Write-Error "Manifest non trovato: $manifestPath"
    exit 2
}

$manifest = Get-Content -Raw -Path $manifestPath | ConvertFrom-Json

if ($Stamp) {
    $now = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
    $timbrate = 0
    foreach ($voce in $manifest.voci) {
        if ($Solo -and ((Split-Path $voce.copione -Leaf) -ne $Solo)) { continue }

        $sorgentePath = Join-Path $repoRoot $voce.sorgente
        $copionePath  = Join-Path $repoRoot $voce.copione

        if (-not (Test-Path $sorgentePath)) {
            Write-Warning "Sorgente mancante, salto: $($voce.sorgente)"
            continue
        }
        if (-not (Test-Path $copionePath)) {
            Write-Warning "Copione mancante, salto: $($voce.copione)"
            continue
        }

        $voce.sourceSha256 = (Get-FileHash -Algorithm SHA256 -Path $sorgentePath).Hash
        $voce.generatoIl   = $now
        $timbrate++
        Write-Host "Timbrato: $(Split-Path $voce.copione -Leaf)" -ForegroundColor Green
    }

    $manifest | ConvertTo-Json -Depth 5 | Set-Content -Path $manifestPath -Encoding UTF8
    Write-Host "Manifest aggiornato ($timbrate voci) -> $manifestPath" -ForegroundColor Green
    exit 0
}

# Senza -Stamp: report di cosa va rigenerato.
$daFare = @()
foreach ($voce in $manifest.voci) {
    $sorgentePath = Join-Path $repoRoot $voce.sorgente
    $copionePath  = Join-Path $repoRoot $voce.copione

    if (-not (Test-Path $sorgentePath)) { continue }

    $motivo = $null
    if (-not (Test-Path $copionePath)) {
        $motivo = 'COPIONE MANCANTE'
    }
    elseif ([string]::IsNullOrEmpty($voce.sourceSha256)) {
        $motivo = 'MAI GENERATO'
    }
    else {
        $hashAttuale = (Get-FileHash -Algorithm SHA256 -Path $sorgentePath).Hash
        if ($hashAttuale -ne $voce.sourceSha256) { $motivo = 'DA AGGIORNARE' }
    }

    if ($motivo) {
        $daFare += [PSCustomObject]@{ Motivo = $motivo; Copione = $voce.copione; Sorgente = $voce.sorgente }
    }
}

if ($daFare.Count -eq 0) {
    Write-Host "Nessun copione da rigenerare: tutto allineato." -ForegroundColor Green
    exit 0
}

Write-Host "Copioni da rigenerare:" -ForegroundColor Yellow
$daFare | Format-Table -AutoSize
Write-Host ""
Write-Host "Passi:" -ForegroundColor Cyan
Write-Host "  1) Chiedi a Claude Code di riscrivere i copioni elencati (dai sorgenti indicati)."
Write-Host "  2) Poi esegui: powershell -ExecutionPolicy Bypass -File TTS\tts-regen.ps1 -Stamp"
exit 1
