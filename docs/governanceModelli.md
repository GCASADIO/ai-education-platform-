# Governance dei motori di valutazione

### Architettura multi-motore, deployment on-premise e certificazione della qualità

> **Natura del documento.** Sintesi di lavoro per il planning di prodotto. Si concentra sulla governance della *qualità della valutazione* in un'architettura dove ogni cliente sceglie il proprio motore (LLM), con opzione on-premise. Per i vincoli normativi vedi il documento [`legale.md`](./legale.md), a cui questo rinvia.

---

## 1. La decisione di design

Il prodotto non incorpora un motore fisso: ogni cliente seleziona il proprio LLM, con possibilità di **deployment on-premise**. Sul piano compliance questo ha un doppio effetto, già anticipato in `legale.md`:

- **Risolve** in larga parte il vincolo dei trasferimenti extra-UE: con inferenza nel perimetro dell'istituto (o su modello ospitato in UE), gli elaborati non transitano verso un responsabile in paese terzo.
- **Sposta** il problema sull'allocazione dei ruoli AI Act (provider / deployer / fornitore GPAI), che diventa variabile per modalità di deployment (vedi §7).

Quello che la flessibilità di motore **non** tocca è la classificazione ad alto rischio — ancorata alla funzione "valuto e assegno un voto" — e introduce un problema nuovo, oggetto di questo documento: la **governance della qualità della valutazione**.

---

## 2. La tensione centrale

La libertà di motore introduce una tensione strutturale tra protezione del dato e qualità del giudizio.

- I modelli che meglio proteggono la privacy sono quelli **piccoli, locali, self-hosted** su hardware modesto.
- Sono però anche quelli che **valutano peggio**: i modelli chiusi (GPT, Claude) si collocano su auto-consistenza ICC ~0.94–0.99 con buon allineamento all'umano, mentre gli open-source tendono a restare sotto su *entrambi* gli assi.

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
| **Allineamento all'umano** (validità) | QWK / ICC vs gold standard esperto | Accordo punto-per-punto con il giudizio umano di riferimento | Il livello assoluto: l'accordo di rango non esclude bias sistematici |
| **Bias di severità** | SMD (adimensionale, analogo a Cohen's *d*) | Scostamento medio di severità rispetto al riferimento | L'accordo punto-per-punto: due rater possono avere SMD ≈ 0 e QWK basso |

**Riferimenti operativi.**

- Ripetibilità umana realistica (rater addestrato con rubrica): ICC ~0.70–0.85. Auto-consistenza AI: ~0.94–0.99. La soglia di ammissione va fissata almeno al livello umano, idealmente sopra.
- Bias di severità: soglia indicativa SMD ≈ 0.15. Essendo adimensionale, si converte in punti grezzi moltiplicando per la deviazione standard della distribuzione dei voti.

**Il punto che orienta tutta la governance: il bias è correggibile, la varianza no.**

Un motore con SMD noto e stabile può essere **ricalibrato** applicando un offset pari a `SMD × SD`: il bias di severità diventa un parametro di calibrazione, non un motivo di esclusione. Al contrario, un motore con bassa ripetibilità o basso allineamento **non si recupera** — non c'è offset che sistemi un giudizio rumoroso o non valido.

Ne segue una gerarchia chiara dei criteri:

- Ripetibilità e validità → **criteri di ammissione** (un motore sotto soglia non entra nel set certificato).
- Severità → **parametro di calibrazione** (un motore ammesso ma severo/indulgente viene corretto, non scartato).

**Il gold standard.** Tutto ciò richiede un corpus di elaborati con doppia correzione esperta, che serve a stimare sia il riferimento umano (ripetibilità e inter-rater) sia l'allineamento del motore. È il collo di bottiglia del progetto, soprattutto per l'italiano dove i dataset pubblici scarseggiano: va messo a budget come asset, non come sottoprodotto.

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

## 7. Allocazione dei ruoli per modalità di deployment

| Modalità | Ruolo del vendor (tu) | Ruolo del cliente | Fornitore del modello | Nodo critico |
|---|---|---|---|---|
| **Cloud, API motore certificato (UE)** | Provider del sistema ad alto rischio | Deployer | Fornitore GPAI | Documentazione GPAI per comporre il sistema |
| **Open-source on-premise** | Provider del software; il modello lo porta il cliente | Deployer, ma vicino al ruolo di provider se personalizza | — (modello self-hosted) | Documentazione spesso scarna; rischio scivolamento di ruolo |
| **Hybrid (orchestrazione tua, inferenza on-prem)** | Provider | Deployer | Misto | Ripartizione contrattuale fine delle responsabilità |

La regola pratica: più il cliente controlla e personalizza il motore on-prem, più si avvicina al ruolo di provider AI Act — con i relativi obblighi. Va regolato contrattualmente in ciascuna modalità.

---

## 8. Implicazioni tecniche

- **Strato di astrazione sui motori.** API, formati di input/output, limiti di token e comportamenti differiscono per famiglia: serve un'interfaccia comune che normalizzi le differenze.
- **Tuning per motore.** La stessa rubrica/prompt rende diversamente da famiglia a famiglia. La certificazione vale per la coppia (motore, prompt): cambiare prompt invalida il profilo.
- **Determinismo.** Temperatura fissa (idealmente bassa) come precondizione per la ripetibilità; va imposta dall'orchestratore, non lasciata al cliente.
- **On-premise.** Requisiti hardware (GPU), trade-off dimensione modello / qualità, e un processo di manutenzione e aggiornamento — ogni aggiornamento riapre la ricertificazione (§6).

---

## 9. Sintesi

La libertà di motore è un punto di forza commerciale e di compliance, ma trasferisce il rischio dalla *localizzazione del dato* alla *qualità del giudizio*. La leva di controllo non è limitare la scelta, ma **governarla**: set certificato come default con profilo tri-metrico garantito, bring-your-own come opzione esplicita a rischio del cliente, e la metodologia psicometrica (ripetibilità, validità, severità) come cancello di certificazione. È il punto in cui il lavoro di ricerca sull'affidabilità dei rater diventa direttamente il processo industriale del prodotto.
