---
description: Rigenera i copioni narrati TTS disallineati (riscrive il testo dai sorgenti e ri-sincronizza il manifest)
argument-hint: "[nome-doc opzionale, es. legale]"
---
Rigenera i copioni narrati TTS che sono disallineati rispetto ai loro documenti sorgente.
Argomento (opzionale): `$ARGUMENTS` — se presente, limita la rigenerazione al documento indicato
(match sul nome, es. `legale` → `TTS/legale-daAscoltare.txt`); altrimenti rigenera **tutti** i disallineati.

Passi:

1. Individua i copioni da (ri)generare, tramite lo strumento Bash:
   `powershell -ExecutionPolicy Bypass -File TTS/tts-regen.ps1`
   Questo elenca i copioni **DA AGGIORNARE / MANCANTI / MAI GENERATI**. Se non c'è nulla e non è
   stato passato un argomento, fermati e dillo.

2. Per **ciascun** copione da generare, leggi:
   - il documento sorgente `docs/<doc>.md` (la fonte di verità dei contenuti);
   - `TTS/livello1-daAscoltare.txt` come **riferimento di stile**.

3. Riscrivi `TTS/<doc>-daAscoltare.txt` seguendo queste regole di stile (le stesse dei copioni esistenti):
   - **Prosa parlata continua**, pensata per essere ascoltata: niente elenchi puntati, niente tabelle,
     niente Markdown, niente titoli con `#`.
   - Apri con `"<Titolo del documento>. Il racconto."` seguito da una frase che dice cos'è il documento.
   - Rendi i marcatori di sezione come frasi parlate (es. "La tensione centrale."), non come heading.
   - **Espandi le sigle a parole** alla prima occorrenza (es. "il coefficiente di correlazione
     intraclasse", "la valutazione d'impatto sulla protezione dei dati"); evita acronimi nudi.
   - Scrivi i **numeri e le soglie in lettere** (es. "zero virgola quindici", "quattordici anni").
   - Resta **fedele** al contenuto e all'ordine del sorgente; non aggiungere claim nuovi. In particolare
     non derivare mai validità dalla sola affidabilità.
   - Chiudi con la sintesi del documento, in forma parlata.
   - Se il documento contiene un'immagine/diagramma o tabelle, descrivine a parole la logica e avvisa
     che la parte visiva non è ascoltabile.

4. Per **ciascun** copione rigenerato, scrivi un file di changelog in
   `TTS/changelog/<AAAA-MM-GG>-<doc>.md` (data odierna, `<doc>` = nome del documento senza
   suffisso `-daAscoltare`). Contenuto, breve e concreto:
   - cosa è cambiato nel documento sorgente rispetto alla versione precedente (in base al diff
     `git diff` sul file `docs/<doc>.md`, se disponibile; altrimenti descrivi lo stato attuale
     rilevante);
   - come si riflette la modifica nel copione riscritto (nuove sezioni narrate, parti rimosse,
     cambi di enfasi);
   - non ripetere tutto il contenuto del copione: solo la differenza.
   Se più copioni vengono rigenerati nella stessa sessione, crea un file di changelog separato
   per ciascuno (stesso nome, `<doc>` diverso).

5. Ri-sincronizza il manifest, tramite lo strumento Bash:
   - se hai rigenerato **tutti** i disallineati: `powershell -ExecutionPolicy Bypass -File TTS/tts-regen.ps1 -Stamp`
   - se ne hai rigenerato **uno solo**: `powershell -ExecutionPolicy Bypass -File TTS/tts-regen.ps1 -Stamp -Solo <file>-daAscoltare.txt`

6. Verifica con `powershell -ExecutionPolicy Bypass -File TTS/tts-status.ps1` che risulti tutto **OK**
   e riporta un riepilogo conciso di cosa hai rigenerato, inclusi i file di changelog creati.
