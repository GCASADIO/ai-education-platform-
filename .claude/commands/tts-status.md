---
description: Mostra quali copioni narrati TTS sono da aggiornare rispetto ai documenti sorgente
---
Esegui, tramite lo strumento Bash, il comando:

`powershell -ExecutionPolicy Bypass -File TTS/tts-status.ps1`

Poi riporta in modo conciso il risultato, evidenziando quali copioni sono **DA AGGIORNARE**,
**MANCANTI** o **MAI GENERATI**. Se è tutto allineato, dillo in una riga.

Se qualche copione è disallineato, ricorda che si rigenera con `/tts-regen`.
