# Visione di prodotto

### La stella polare — una pagina, stabile nel tempo

> **Natura del documento.** È il primo dei tre artefatti citati in [`roadmap.md`](./roadmap.md) §2: una pagina che dice *cosa fa l'app a regime, per quale segmento, qual è il loop fondamentale*. Non è uno spec e non elenca funzioni (quello è il [`backlogPrioritizzato.md`](./backlogPrioritizzato.md)). Serve a impedire alle singole release di divergere. Si aggiorna raramente e di proposito.
>
> È volutamente **scheletrica**: la narrazione completa di ogni voce è in [`presentazione.md`](./presentazione.md), qui c'è solo l'ancora.

---

## Scopo

Ridurre il carico della **correzione descrittiva** (temi, saggi, risposte aperte) senza delegare il giudizio alla macchina e senza confondere ripetibilità con giustezza del voto. Il valore venduto è la **certificabilità metrologica** del motore di correzione, non la velocità di correggere.

---

## Per chi

Dove coincidono **alto volume di correzione descrittiva + rubriche mature + bisogno di coerenza**: prima la scrittura in lingua straniera (certificazioni linguistiche), poi discipline umanistiche/giuridiche a risposta aperta. La scelta del segmento si fa sul **dolore**, non sul volume ([`analisiBisogniEMercato.md`](./analisiBisogniEMercato.md)).

---

## Il loop fondamentale

> Il docente carica gli elaborati → un **motore certificato** propone voto e feedback → il docente **rivede e sovrascrive** → esporta.

Human-in-the-loop **sempre**: la macchina propone, il docente decide — che è anche la leva che regge la conformità (art. 22 GDPR, sorveglianza umana AI Act; [`legale.md`](./legale.md)).

---

## Il differenziatore

**Certificazione psicometrica per motore** (con ricertificazione a ogni cambio versione) **+ rubriche eseguibili versionate + multi-motore on-premise + compliance EU-native**. Nessun prodotto oggi li unifica ([`statoDellArte.md`](./statoDellArte.md) Parte B); correzione human-in-the-loop e allenamento studente, da soli, sono terreno affollato e **non** sono il fossato.

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
