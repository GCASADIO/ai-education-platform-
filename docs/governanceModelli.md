# Governance dei motori di valutazione

### Architettura multi-motore, deployment on-premise e certificazione della qualità

> **Natura del documento.** Sintesi di lavoro per il planning di prodotto. Si concentra sulla governance della *qualità della valutazione* in un'architettura dove ogni cliente sceglie il proprio motore (LLM), con opzione on-premise. Per i vincoli normativi vedi il documento [`legale.md`](./legale.md), a cui questo rinvia.

---

## 1. La decisione di design

Il prodotto non incorpora un motore fisso: ogni cliente seleziona il proprio **LLM** (*Large Language Model*, il modello linguistico che fa da motore di correzione), con possibilità di **deployment on-premise** (installazione nei server dell'istituto). Sul piano compliance questo ha un doppio effetto, già anticipato in `legale.md`:

- **Risolve** in larga parte il vincolo dei trasferimenti extra-UE: con inferenza nel perimetro dell'istituto (o su modello ospitato in UE), gli elaborati non transitano verso un responsabile in paese terzo.
- **Sposta** il problema sull'allocazione dei ruoli AI Act (provider = chi immette il sistema sul mercato; deployer = chi lo utilizza; fornitore GPAI = *General-Purpose AI*, chi fornisce il modello di IA per finalità generali), che diventa variabile per modalità di deployment (vedi §8).

Quello che la flessibilità di motore **non** tocca è la classificazione ad alto rischio — ancorata alla funzione "valuto e assegno un voto" — e introduce un problema nuovo, oggetto di questo documento: la **governance della qualità della valutazione**.

---

## 2. La tensione centrale

La libertà di motore introduce una tensione strutturale tra protezione del dato e qualità del giudizio.

- I modelli che meglio proteggono la privacy sono quelli **piccoli, locali, self-hosted** su hardware modesto.
- Sono però anche quelli che **valutano peggio**: i modelli chiusi (GPT, Claude) si collocano su auto-consistenza ICC (*Intraclass Correlation Coefficient*, coefficiente di correlazione intraclasse) ~0.94–0.99 con buon allineamento all'umano, mentre gli open-source tendono a restare sotto su *entrambi* gli assi.

Il caso peggiore — un open-source piccolo on-prem — è esattamente quello che un cliente sceglie *per* stare on-prem. La conseguenza: la libertà di motore va **governata**, non lasciata libera, altrimenti il prodotto eredita la responsabilità reputazionale e contrattuale di giudizi prodotti da motori non idonei.

---

## 3. Principio guida

Non si certifica "l'app corregge bene" in astratto. Si certifica **"il motore X, con questa rubrica, corregge con questo profilo di affidabilità e validità"**. La qualità è una proprietà della coppia (motore, configurazione), non dell'applicazione.

Da qui discende un'architettura a livelli (§5): un insieme di **motori certificati** con metriche garantite, e sotto un'opzione **bring-your-own** esplicitamente a rischio del cliente.

---

## 4. Il framework di certificazione

Qui la metodologia psicometrica diventa il processo industriale di certificazione dei motori. Ogni motore candidato viene profilato su **tre assi ortogonali**, perché nessuno dei tre da solo è sufficiente.

| Asse | Metrica | Cosa misura | Cosa NON cattura |
|---|---|---|---|
| **Ripetibilità** (auto-consistenza) | ICC test-retest a temperatura fissa | Stabilità del motore su rivalutazioni dello stesso elaborato | L'accuratezza: un motore può essere stabilmente sbagliato |
| **Allineamento all'umano** (validità) | QWK (*Quadratic Weighted Kappa*) / ICC vs gold standard esperto | Accordo punto-per-punto con il giudizio umano di riferimento | Il livello assoluto: l'accordo di rango non esclude bias sistematici |
| **Bias di severità** | SMD (*Standardized Mean Difference*, adimensionale, analogo a Cohen's *d*) | Scostamento medio di severità rispetto al riferimento | L'accordo punto-per-punto: due rater possono avere SMD ≈ 0 e QWK basso |

**Riferimenti operativi.**

- Ripetibilità umana realistica (rater addestrato con rubrica): ICC ~0.70–0.85. Auto-consistenza AI: ~0.94–0.99. La soglia di ammissione va fissata almeno al livello umano, idealmente sopra.
- Bias di severità: soglia indicativa SMD ≈ 0.15. Essendo adimensionale, si converte in punti grezzi moltiplicando per la deviazione standard della distribuzione dei voti.

**Il punto che orienta tutta la governance: il bias è correggibile, la varianza no.**

Un motore con SMD noto e stabile può essere **ricalibrato** applicando un offset pari a `SMD × SD`: il bias di severità diventa un parametro di calibrazione, non un motivo di esclusione. Al contrario, un motore con bassa ripetibilità o basso allineamento **non si recupera** — non c'è offset che sistemi un giudizio rumoroso o non valido.

Ne segue una gerarchia chiara dei criteri:

- Ripetibilità e validità → **criteri di ammissione** (un motore sotto soglia non entra nel set certificato).
- Severità → **parametro di calibrazione** (un motore ammesso ma severo/indulgente viene corretto, non scartato).

**Il gold standard.** Tutto ciò richiede un corpus di elaborati con doppia correzione esperta, che serve a stimare sia il riferimento umano (ripetibilità e inter-rater) sia l'allineamento del motore. È il collo di bottiglia del progetto, soprattutto per l'italiano dove i dataset pubblici scarseggiano: va messo a budget come asset, non come sottoprodotto.

**Il profilo frontier come tetto pratico.** La strategia di sviluppo parte dai motori frontier (closed-source: Claude, GPT, Gemini) su **dataset sintetico** con voti di riferimento umani: il loro profilo tri-metrico contro quel riferimento diventa il **target di ammissione pratico** per il motore locale/UE destinato alla produzione — il locale è pronto quando avvicina il profilo frontier sullo stesso harness. Attenzione all'errore da non commettere: **l'output del frontier non è ground truth**. Un frontier ha auto-consistenza ~0.94–0.99 senza che questo lo renda accurato (alta affidabilità ⇏ validità): certificare il locale contro i *voti* del frontier ne clonerebbe i bias. Il riferimento resta il giudizio umano; il frontier fissa solo l'asticella. La migrazione frontier → locale è un caso del principio di §6: nuovo motore, ricertificazione completa. Sulla sequenza e sul vincolo legale che impone la migrazione prima dei dati reali, vedi il gate di migrazione in [`roadmap.md`](./roadmap.md).

---

## 5. Architettura a livelli

| Livello | Cosa offre | Garanzia | Per chi |
|---|---|---|---|
| **Motori certificati** | Profilo tri-metrico pubblicato, ricalibrazione severità applicata | Metriche di affidabilità/validità garantite contrattualmente | Default, clienti istituzionali |
| **Bring-your-own** | Il cliente collega qualsiasi motore (tipicamente on-prem) | Nessuna garanzia sulle metriche; segnalazione esplicita del rischio | Clienti con vincoli di sovranità del dato che accettano il trade-off |

La segnalazione esplicita non è solo prudenza commerciale: in regime di alto rischio, sapere *quale* motore ha prodotto un giudizio e con quale profilo di qualità è parte della tracciabilità e della difendibilità del voto.

---

## 6. Ricertificazione e monitoraggio

La certificazione non è un atto una tantum.

- **Nessun miglioramento monotòno tra generazioni.** Una versione più recente di un modello non è necessariamente migliore sulla valutazione: ogni versione va ri-testata contro il gold standard. Non assumere mai "newer = better".
- **Override rate come segnale continuo.** In produzione, la frequenza con cui il docente modifica il voto proposto è il rilevatore precoce di drift — del motore (dopo un aggiornamento) o della popolazione di compiti. È al tempo stesso metrica di prodotto, presidio di compliance (human-in-the-loop) e trigger di ricertificazione.
- **Versioning congelato.** Per riprodurre un voto — anche ai fini della difendibilità amministrativa nel settore pubblico — occorre congelare la terna (versione del motore + prompt + rubrica) associata a ciascuna valutazione.

---

## 7. Allineamento del motore al docente

Portare un motore "a corrispondere al docente" non è un'operazione sola: sotto il termine convivono **due obiettivi psicometricamente distinti**, che vanno su due leve diverse.

- **Allineare la severità media** — il motore è sistematicamente più severo/indulgente del docente. È il **bias di severità (SMD)**, e per §4 è un **parametro di calibrazione**: si corregge con un offset, senza toccare il modello.
- **Allineare l'accordo caso-per-caso** — non basta che le medie coincidano: si vuole che il motore dia voto alto *sugli stessi elaborati* del docente. È l'accordo **QWK/ICC**, e non si sposta con un offset: richiede di cambiare *come* il motore discrimina i casi.

Confondere le due porta all'errore tipico: azzerare l'SMD con un offset e credere di aver "allineato", mentre l'ICC resta ferma. L'offset trasla e riscala la distribuzione, non ne cambia l'ordinamento.

**Lo spettro delle leve, ordinato per quanto tocca il modello.**

| Leva | Dove agisce | Cosa allinea | Genera nuova versione? |
|---|---|---|---|
| Rubrica eseguibile / prompt | Inferenza | Accordo caso-per-caso | No |
| Ancore few-shot / recupero (RAG) di esempi corretti dal docente | Inferenza | Accordo caso-per-caso | No |
| **Offset / calibrazione affine** | Post-processing | **Solo** severità media (SMD) | No |
| Fine-tuning supervisionato (SFT), anche PEFT/LoRA per-istituto | Training | Accordo caso-per-caso | **Sì** |
| Preference learning (RLHF / DPO) | Training | Qualità difficili da specificare (tono, priorità del feedback) | **Sì** |

**Il confine che conta: inferenza ↔ training coincide col confine ricertifichi‑no ↔ ricertifichi‑sì.** Ricalibrare un offset o cambiare le ancore non crea un nuovo motore; **ogni modifica dei pesi sì** — nuovo motore, ricertificazione completa contro il gold standard (§6), senza assumere che l'allineamento raggiunto valga anche altrove.

Ne segue una **tesi operativa a strati**: si sale di strato solo quando quello sotto satura. Prima rubrica + ancore (accordo) e offset (severità) in inferenza — economici, interpretabili, auditabili, senza ricertificazione. Il fine-tuning entra **solo se** l'accordo QWK/ICC col docente resta insufficiente *dopo* aver spremuto l'inferenza, *e* c'è un corpus etichettato sufficiente e pulito; LoRA per-istituto è il taglio più sensato. Il preference learning resta frontiera per il feedback qualitativo, non per il punteggio: è il regime più data-hungry, instabile e opaco all'audit — ultimo, non primo.

> **Nodo aperto — da portare al team (non deciso).** Allineare a *quel singolo docente* o a un **gold standard di consenso** fra più docenti? Sono due prodotti diversi: allinearsi al singolo massimizza la sua percezione di "corregge come me" ma ottimizza l'affidabilità *rispetto a un rater*, potendone clonare i bias (alta affidabilità, validità non garantita — vedi il principio "alta affidabilità ⇏ alta validità"); allinearsi al consenso punta alla validità, ma il singolo può percepire il motore "non allineato a lui" proprio dove *lui* devia dal consenso. Decisione rinviata al confronto di team.
>
> **Sintesi candidata (da validare, non ancora decisa): certificare sul consenso, personalizzare con offset.** Le due esigenze non sono in conflitto se agiscono su leve diverse. Si **certifica** il motore contro un gold standard di **consenso** fra più esperti — è l'unico riferimento che consente di stimare la validità e il suo tetto realistico (l'affidabilità inter-rater umana, §4/§6): nessun offset ripara affidabilità o validità mancanti. Sopra il motore certificato si offre un **offset per-docente** come layer di personalizzazione: sposta la sola severità media (SMD, §4) verso lo standard del singolo, *senza* toccare l'accordo caso-per-caso (QWK/ICC) né i pesi del modello — quindi **non richiede ricertificazione** (§7, confine inferenza↔training). Il singolo ottiene "corregge come me" sul livello di severità; l'istituzione conserva un motore difendibile sulla validità. Restano fuori da questa sintesi le deviazioni del docente dal consenso che sono *di ordinamento* e non di severità (dove lui valuta *casi diversi* in modo diverso): non le copre un offset, e inseguirle richiederebbe fine-tuning per-istituto — da valutare solo se e quando l'override rate lo giustifica. Questa resta una **proposta**: la decisione formale è del team.

---

## 8. Allocazione dei ruoli per modalità di deployment

| Modalità | Ruolo del vendor (tu) | Ruolo del cliente | Fornitore del modello | Nodo critico |
|---|---|---|---|---|
| **Cloud, API motore certificato (UE)** | Provider del sistema ad alto rischio | Deployer | Fornitore GPAI | Documentazione GPAI per comporre il sistema |
| **Open-source on-premise** | Provider del software; il modello lo porta il cliente | Deployer, ma vicino al ruolo di provider se personalizza | — (modello self-hosted) | Documentazione spesso scarna; rischio scivolamento di ruolo |
| **Hybrid (orchestrazione tua, inferenza on-prem)** | Provider | Deployer | Misto | Ripartizione contrattuale fine delle responsabilità |

La regola pratica: più il cliente controlla e personalizza il motore on-prem, più si avvicina al ruolo di provider AI Act — con i relativi obblighi. Va regolato contrattualmente in ciascuna modalità.

---

## 9. Implicazioni tecniche

- **Strato di astrazione sui motori.** API, formati di input/output, limiti di token e comportamenti differiscono per famiglia: serve un'interfaccia comune che normalizzi le differenze.
- **Tuning per motore.** La stessa rubrica/prompt rende diversamente da famiglia a famiglia. La certificazione vale per la coppia (motore, prompt): cambiare prompt invalida il profilo.
- **Determinismo.** Temperatura fissa (idealmente bassa) come precondizione per la ripetibilità; va imposta dall'orchestratore, non lasciata al cliente.
- **On-premise.** Requisiti hardware (GPU), trade-off dimensione modello / qualità, e un processo di manutenzione e aggiornamento — ogni aggiornamento riapre la ricertificazione (§6).

---

## 10. Sintesi

La libertà di motore è un punto di forza commerciale e di compliance, ma trasferisce il rischio dalla *localizzazione del dato* alla *qualità del giudizio*. La leva di controllo non è limitare la scelta, ma **governarla**: set certificato come default con profilo tri-metrico garantito, bring-your-own come opzione esplicita a rischio del cliente, e la metodologia psicometrica (ripetibilità, validità, severità) come cancello di certificazione. È il punto in cui il lavoro di ricerca sull'affidabilità dei rater diventa direttamente il processo industriale del prodotto.
