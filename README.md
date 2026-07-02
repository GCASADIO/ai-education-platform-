# AI in Education

> AI-assisted educational assessment platform with psychometric certification (ICC/QWK/SMD) for automated grading, task management, and adaptive student learning.

## Panoramica

Piattaforma edtech multi-livello che unisce:

- **Correzione automatica dei compiti** basata su modelli AI/NLP
- **Certificazione psicometrica dei motori** (ICC, QWK, SMD per-engine, con ricertificazione automatica al cambio versione modello)
- **Rubriche eseguibili e versionate** (compilate, non solo testo libero)
- **Supporto multi-motore on-premise**, orientato a compliance EU-native (GDPR / AI Act)
- **Store dei compiti** *(in roadmap)*
- **Autolearning degli studenti tramite AI** *(in roadmap)*

## Cosa rende questa piattaforma diversa

La combinazione di certificazione psicometrica rigorosa + rubriche versionate + multi-engine on-premise + compliance EU-native non è, ad oggi, unificata in nessun prodotto commerciale esistente. Il layer di certificazione (ICC/QWK/SMD per motore, con ricertificazione automatica) è presente in letteratura accademica ma non ancora implementato commercialmente.

## Documentazione

La documentazione è organizzata su **due livelli**.

### Livello 1 — Presentazione (parti da qui)

- **[`docs/presentazione.md`](./docs/presentazione.md)** — il racconto organico del progetto, dall'inizio alla fine in ~10 minuti. Ogni sezione rimanda al dossier di dettaglio. **È il punto d'ingresso per capire o presentare il progetto.**
- [`docs/visione.md`](./docs/visione.md) — la stella polare a una pagina: scopo, segmento, loop fondamentale, differenziatore.

### Livello 2 — Approfondimenti (dossier di dettaglio in [`docs/`](./docs))

- [`analisiBisogniEMercato.md`](./docs/analisiBisogniEMercato.md) — bisogni, segmento, fonti dati
- [`statoDellArte.md`](./docs/statoDellArte.md) — evidenze empiriche e panorama competitivo
- [`governanceModelli.md`](./docs/governanceModelli.md) — certificazione e governance dei motori AI
- [`legale.md`](./docs/legale.md) — vincoli normativi (GDPR, AI Act, IP marketplace)
- [`architetturaMotori.md`](./docs/architetturaMotori.md) — architettura multi-motore (Strategy + Factory)
- [`ruoliEPermessi.md`](./docs/ruoliEPermessi.md) — ruoli, permessi, separazione dei compiti
- [`roadmap.md`](./docs/roadmap.md) — sequenza di sviluppo per fasi
- [`backlogPrioritizzato.md`](./docs/backlogPrioritizzato.md) — backlog prodotto (MoSCoW)
- [`modelloBusiness.md`](./docs/modelloBusiness.md) — economia dei crediti, go-to-market

### Copioni narrati (audio) — [`TTS/`](./TTS)

La cartella [`TTS/`](./TTS) contiene i **copioni narrati** dei documenti, riscritti in forma parlata per l'ascolto (input per Text-To-Speech). C'è un copione per la presentazione di Livello 1 ([`livello1-daAscoltare.txt`](./TTS/livello1-daAscoltare.txt), il racconto in nove punti, ~10 min) e uno per **ciascun documento di Livello 2** (`<doc>-daAscoltare.txt`). I copioni `.txt` sono versionati; gli eventuali file audio renderizzati (`.mp3`/`.wav`) no.

**Allineamento copione ↔ sorgente.** Ogni copione è tracciato in [`TTS/manifest.json`](./TTS/manifest.json), che registra l'hash del documento sorgente al momento della stesura.

- **Stato** — quali copioni sono da aggiornare perché il sorgente è cambiato:
  - da Claude Code: `/tts-status`
  - da PowerShell: `powershell -ExecutionPolicy Bypass -File TTS\tts-status.ps1`
- **Rigenerazione** — riscrive i copioni disallineati e ri-sincronizza il manifest:
  - da Claude Code: `/tts-regen`
  - da PowerShell: elenca i copioni da riscrivere; dopo che Claude Code li ha riscritti, `-Stamp` ri-sincronizza il manifest
    ```
    powershell -ExecutionPolicy Bypass -File TTS\tts-regen.ps1
    powershell -ExecutionPolicy Bypass -File TTS\tts-regen.ps1 -Stamp
    ```

Il contenuto dei copioni è prosa scritta da Claude Code, non derivabile da uno script: gli script/slash command segnalano cosa è disallineato e aggiornano il manifest, la riscrittura la fa Claude. Gli slash command sono la via preferita quando si lavora già dentro una sessione di Claude Code.

## Sviluppo

Questo progetto è sviluppato tramite [Claude Code](https://claude.com/claude-code). Le istruzioni di contesto persistenti per Claude Code sono in [`CLAUDE.md`](./CLAUDE.md).

## Stato

🚧 In fase di sviluppo iniziale. Non-esclusività dell'idea dichiarata esplicitamente: il concetto è condiviso, non rivendicato in esclusiva.

## Licenza

*(da definire)*
