# CLAUDE.md — Istruzioni di progetto per Claude Code

## Cos'è questo progetto

**ai-education-platform** è una piattaforma AI-assisted per l'edtech che copre:
1. **Correzione automatica dei compiti** (core NLP)
2. **Certificazione psicometrica** dei motori AI di correzione (ICC, QWK, SMD, con ricertificazione automatica al cambio versione del modello)
3. **Store dei compiti** (in roadmap)
4. **Autolearning degli studenti tramite AI** (in roadmap)

Non è "solo un correttore automatico": la differenziazione reale è la combinazione di certificazione psicometrica rigorosa + rubriche eseguibili versionate + supporto multi-motore on-premise + compliance EU-native (GDPR/AI Act). Nessun competitor unifica tutti questi elementi.

## Chi sono l'autore e il contesto

- Progetto ideato e guidato da GC, esperto di psicometria (inter-rater reliability, ICC, QWK, SMD) con percorso di apprendimento autodidatta in AI applicata e computer vision, orientato al ruolo di mentore (non sviluppatore hands-on).
- GC non scrive codice direttamente: il lavoro con Claude Code è la modalità primaria di sviluppo.
- Obiettivo collaterale: creare un percorso di mentorship impegnativo per il figlio di GC (aspirante nel settore).

## Principi tecnici chiave (da rispettare in ogni decisione di design)

- **Bias è correggibile via offset; bassa affidabilità e bassa validità sono squalificanti.** Questa asimmetria deve riflettersi nel framework di certificazione dei motori.
- **Alta affidabilità NON implica alta validità** — non confondere le due dimensioni in nessuna metrica o messaggio di prodotto.
- **SMD** cattura solo il bias di severità media, **non** l'accordo punto-per-punto — per quello servono QWK o ICC.
- Un singolo modello AI a temperatura fissa ha un'ICC di self-consistency molto alta (~0.94–0.99); questo NON equivale ad accuratezza rispetto a rater umani.
- I modelli closed-source superano gli open-source sia in consistency che in allineamento con rater umani; **non esiste miglioramento monotono** tra generazioni di modelli — ogni nuova versione va ricertificata, mai assunta come "migliore a priori".

## Documenti di riferimento (in `docs/`)

| File | Contenuto |
|---|---|
| `legale.md` | Vincoli normativi e regolatori (GDPR, AI Act, IP/titolarità marketplace) |
| `governanceModelli.md` | Framework di governance dei modelli AI e ricertificazione |
| `backlogPrioritizzato.md` | Backlog di prodotto prioritizzato (MoSCoW) |
| `roadmap.md` | Sequenza di sviluppo per fasi (Fase 0–5) e metodo di fasatura |
| `analisiBisogniEMercato.md` | Esigenze docenti/studenti, scelta del segmento, fonti dati |
| `ruoliEPermessi.md` | Ruoli, permessi, RBAC |
| `architetturaMotori.md` (+ SVG) | Architettura multi-motore |
| `statoDellArte.md` | Evidenze empiriche (affidabilità AI) e panorama competitivo |

Claude Code deve consultare questi file prima di proporre modifiche architetturali o di prodotto che li riguardano, e mantenerli aggiornati se una decisione presa in sessione li rende obsoleti.

## Cartella `Commerciale/` (riservata)

- La cartella `Commerciale/` è un **git submodule** che punta a un repository privato separato (`GCASADIO/ai-education-platform-Commerciale`). Il repo pubblico registra solo il puntatore in `.gitmodules`; **i contenuti vivono nel repo privato** e non compaiono nel pubblico. Chi clona senza accesso al privato vede la cartella vuota (per popolarla: `git submodule update --init`).
- Se ne può menzionare **solo l'esistenza**. **Nessun elemento, contenuto o dato presente al suo interno** può essere citato, riportato o riutilizzato negli altri file del progetto **senza esplicita approvazione di GC** — anche quando l'operazione avverrebbe in automatico.
- In `Commerciale/` vivono anche uno o più **registri di «idee da integrare»** (file `IdeeDaIntegrare_<data>.md`): raccolgono idee nuove — di GC e del team — in attesa di essere **migrate nei `docs/`** in un secondo momento. La migrazione di ogni voce verso `docs/` richiede l'**esplicita approvazione di GC**, voce per voce (vale la regola di riservatezza sopra).

### Gestione operativa del submodule (GC non usa i submodule)

GC non conosce e non deve gestire i submodule: quando GC modifica qualcosa sotto `Commerciale/`, **Claude Code gestisce l'intero flusso a due repo per lui**, trattandoli come se fossero un repo unico e tenendo i commit **allineati**. Regola pratica ad ogni modifica dentro `Commerciale/`:

1. **Commit + push nel repo privato** (dentro `Commerciale/`): `git -C Commerciale add -A && git -C Commerciale commit -m "…" && git -C Commerciale push`. Il push verso il repo privato è verso l'esterno → chiedere conferma a GC prima.
2. **Aggiorna il puntatore nel repo pubblico**: dal repo padre `git add Commerciale && git commit -m "Aggiorna puntatore Commerciale"`, poi `git push` (chiedere conferma).
3. **Non lasciare mai i due repo disallineati**: se il puntatore del padre non riflette l'ultimo commit del privato, `git status` nel padre segnala `Commerciale` come modificato — vanno sempre committati insieme, nella stessa sessione.

Claude Code deve **eseguire questi passaggi al posto di GC** e riepilogargli in linguaggio semplice cosa è stato committato/pushato dove, senza pretendere che conosca la meccanica dei submodule.

## Riferimenti accademici (letteratura 2023–2026 su AI grading reliability)

- RULERS (arXiv 2601.08654) — *identificativo verificato su arXiv (luglio 2026)*
- GradeAgentOps
- arXiv 2509.19329

## Come lavorare con GC

- Risposte concise, tecnicamente precise, formattazione leggera.
- Conversazioni in italiano.
- GC non scrive codice: Claude Code implementa, GC decide direzione e valida.
- Prima di implementare feature con impatto su certificazione psicometrica, verificare coerenza con i principi tecnici sopra elencati.
- Consolidare in documenti strutturati ai breakpoint naturali, evitare di disperdere decisioni solo nella chat.

## Cosa NON fare

- Non introdurre claim di validità implicita dalla sola affidabilità (vedi principio sopra).
- Non assumere che un modello più recente sia automaticamente più affidabile: ogni cambio versione richiede ricertificazione.
- Non rimuovere o bypassare la clausola di non-esclusività quando si documenta la paternità del progetto nei file di attribuzione.
