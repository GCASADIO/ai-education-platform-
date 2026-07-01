# Architettura dei motori

### Strategy + Factory, motore demo e identità nell'audit

> **Ambito.** Pattern di progettazione dello strato che astrae i motori di correzione. Si aggancia a [`governanceModelli.md`](./governanceModelli.md) (certificazione e qualità dei motori) e a [`ruoliEPermessi.md`](./ruoliEPermessi.md) (audit trail e versioning del voto).

---

## 1. Il pattern portante è lo Strategy, non la Factory

Sono due pattern che lavorano insieme con ruoli diversi, e il primo è quello che regge l'intera idea "demo = motore finto":

- **Strategy** — un'unica interfaccia `GradingEngine.grade(elaborato, griglia) → Risultato` e tante implementazioni intercambiabili usate in modo polimorfico (OpenAI, Claude, open-source on-prem, e il `FakeEngine` della demo). Il resto del sistema non sa né gli importa quale strategia stia girando.
- **Factory** — il complemento che *istanzia/seleziona* la strategia giusta a partire dalla configurazione (il motore scelto dal tenant, o il flag demo). Basta una Factory Method / Factory parametrica: `EngineFactory.create(config) → GradingEngine`.

La demo non richiede infrastruttura nuova: il `FakeEngine` è semplicemente un'implementazione in più dietro la stessa interfaccia che già serve per il multi-motore.

---

## 2. Il disegno

![Pattern Strategy e Factory per i motori di correzione](./architetturaMotori.svg)

*Tratteggio = realizza l'interfaccia (Strategy). `FakeEngine` = motore demo.*

---

## 3. Abstract Factory? Non adesso

L'Abstract Factory serve a creare *famiglie di oggetti correlati che variano insieme* e devono restare coerenti (il classico esempio è il toolkit UI che produce Button + Checkbox + Scrollbar abbinati a un tema). Qui c'è **un solo tipo di prodotto** — il motore — con più varianti: è il caso della Factory semplice.

Diventa giustificata **solo se** ogni motore si porta dietro una famiglia di collaboratori che devono combaciare — per esempio un `PromptAdapter` + un `ResponseParser` + un tokenizer specifici per famiglia. Dato che in `governanceModelli.md` è annotato il *tuning di prompt e formato per motore*, è uno scenario che potrebbe emergere. La regola: partire da **Strategy + Factory semplice**, promuovere ad Abstract Factory se e quando quei collaboratori diventano una famiglia coerente. Non prima (YAGNI — *You Aren't Gonna Need It*: non costruire in anticipo ciò che non serve ancora).

---

## 4. Il FakeEngine è anche un test double

Il motore finto non serve solo alla demo:

- È un **test double** deterministico e a costo zero (nessuna chiamata API): rende l'intera pipeline di correzione testabile in automatico.
- È una **cartina di tornasole dell'astrazione**: se riesci a sostituirlo senza che il resto del sistema se ne accorga, il *seam* dell'interfaccia è pulito.
- Lo stesso oggetto serve quindi demo, test e verifica del design.

---

## 5. Regola di identità del motore nell'audit

Il `FakeEngine` deve dichiarare un `engine id/version` riconoscibile (es. `demo-fake`) nell'audit trail, così un voto prodotto in demo non può **mai** essere scambiato per un voto di un motore certificato. Il versioning che già congela la terna *compito + griglia + motore/versione* (vedi `ruoliEPermessi.md`) lo gestisce in automatico — basta che il motore finto non menta sulla propria identità.

---

## 6. Disciplina del contratto di output

Pretendere che fake e reale siano davvero intercambiabili costringe a definire bene il **contratto di output** — punteggi per tratto + feedback + metadati (motore, versione). È la stessa disciplina che serve poi ai motori veri, quindi il `FakeEngine` la impone gratis fin dal primo giorno.

---

## 7. Sintesi

Strategy regge l'intercambiabilità dei motori (compreso quello demo); la Factory ne sceglie l'istanza; l'Abstract Factory resta in riserva per quando i collaboratori per-motore diventeranno una famiglia. Il `FakeEngine` è insieme motore demo, test double e verifica dell'astrazione — a patto che dichiari onestamente la propria identità nell'audit.
