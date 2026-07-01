# Visione di prodotto

### La stella polare — una pagina, stabile nel tempo

> **Natura del documento.** È il primo dei tre artefatti citati in [`roadmap.md`](./roadmap.md) §2: una pagina che dice *cosa fa l'app a regime, per quale segmento, qual è il loop fondamentale*. Non è uno spec e non elenca funzioni (quello è il [`backlogPrioritizzato.md`](./backlogPrioritizzato.md)). Serve a impedire alle singole release di divergere. Si aggiorna raramente e di proposito.

---

## Scopo

Ridurre il carico della **correzione descrittiva** (temi, saggi, risposte aperte) — la parte meno comprimibile del lavoro del docente — senza delegare il giudizio alla macchina e **senza barare sulla qualità della misura**: un voto AI più *ripetibile* non è automaticamente più *giusto*, e il prodotto tiene le due cose separate invece di confonderle.

Non è "un correttore automatico". È una piattaforma in cui la correzione AI è il **motore**, e il valore vero è la **certificabilità metrologica** di quel motore: si vende la fiducia nel giudizio, non la velocità di produrlo.

---

## Per chi

Baricentro della domanda dove coincidono **alto volume di correzione descrittiva + rubriche mature + bisogno di coerenza** (dettaglio in [`analisiBisogniEMercato.md`](./analisiBisogniEMercato.md)):

- **Primo segmento:** valutazione della scrittura in lingua straniera (certificazioni linguistiche), dove le rubriche sono già mature e standardizzate.
- **A seguire:** discipline umanistiche/giuridiche con esami a risposta aperta e alto numero di iscritti.

La scelta del segmento si fa sul **dolore** (quanta valutazione aperta), non sul volume.

---

## Il loop fondamentale

> Il docente carica gli elaborati → un **motore certificato** propone voto e feedback → il docente **rivede e sovrascrive** → esporta.

Human-in-the-loop **sempre**: la macchina propone, il docente decide. Questo non è solo design di prodotto — è la leva che regge la conformità (art. 22 GDPR, sorveglianza umana AI Act; vedi [`legale.md`](./legale.md)).

---

## Il differenziatore, in tre righe

Nessun prodotto oggi unifica questi strati (verifica in [`statoDellArte.md`](./statoDellArte.md) Parte B):

1. **Certificazione psicometrica per motore** — se ne misurano ripetibilità, allineamento al giudizio umano e bias di severità — con **ricertificazione automatica a ogni cambio versione** del modello.
2. **Rubriche eseguibili e versionate** — compilate e auditabili, non prompt in chiaro.
3. **Multi-motore on-premise** verticalizzato sulla didattica, con pacchetto **compliance EU-native** (GDPR / AI Act).

La correzione human-in-the-loop e l'allenamento studente, da soli, sono terreno affollato: **non** sono il fossato.

---

## I confini (cosa NON è)

- **Non** un decisore automatico di voti ufficiali (vietato: art. 22 GDPR + alto rischio AI Act).
- **Non** un sistema che *inferisce* condizioni dello studente (territorio clinico — la diagnosi resta fuori dall'AI).
- **Non** un motore fisso: il cliente sceglie il proprio modello di AI, con opzione on-premise (installato nei propri server).

---

## I principi invarianti (non negoziabili in nessuna release)

- **Bias è correggibile via offset; bassa affidabilità e bassa validità sono squalificanti.** Asimmetria che struttura tutta la certificazione.
- **Alta affidabilità NON implica alta validità.** Mai derivare l'una dall'altra in una metrica o in un messaggio di prodotto.
- **Nessun miglioramento monotòno tra generazioni di modelli:** ogni versione va ricertificata, mai assunta come migliore a priori.

---

*Idea a paternità non esclusiva: il concetto è condiviso, non rivendicato in esclusiva.*
