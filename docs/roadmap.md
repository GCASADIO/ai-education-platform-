# Roadmap di sviluppo

### Come si fasa il prodotto e in che ordine

> **Natura del documento.** Metodo e sequenza dello sviluppo per fasi. Complementare al [`backlogPrioritizzato.md`](./backlogPrioritizzato.md): il backlog dice *cosa* (le funzioni, per priorità MoSCoW), questa roadmap dice *in che ordine e con quale logica di rischio* si costruiscono. Si aggancia a [`governanceModelli.md`](./governanceModelli.md) (certificazione) e [`legale.md`](./legale.md) (vincoli).

---

## 1. La falsa alternativa: "app completa" vs "release per release"

Non è un aut-aut: si scrivono **entrambe, a risoluzione diversa**. Una visione dell'app completa a **bassa** risoluzione (l'end-state: chi serve, qual è il ciclo centrale, dove sono i confini) e un piano ad **alta** risoluzione solo per la release che hai davanti. Più una fase è lontana, meno dettaglio le si dedica.

Scrivere subito lo spec dettagliato dell'app completa è la trappola a cascata: "non si arriva mai alla fine" perché quando ci arrivi metà delle specifiche è già sbagliata.

---

## 2. I tre artefatti

| Artefatto | Cos'è | Quando si scrive |
|---|---|---|
| **Visione di prodotto** | Una pagina: cosa fa l'app a regime, per quale segmento, qual è il loop fondamentale. La stella polare che impedisce alle release di divergere. Non è uno spec. | Una volta |
| **Roadmap di release** | La sequenza di traguardi, ciascuno con obiettivo, ambito e criterio di successo. Il prossimo dettagliato, i successivi grossolani. | Aggiornata a ogni fase |
| **Scheda di release** | Cosa l'utente potrà fare dopo *questa* release, cosa è esplicitamente fuori ambito, la metrica di successo, le dipendenze. | Solo per la release corrente |

Il **loop fondamentale** della visione: *il docente carica elaborati → un motore certificato propone voto e feedback → il docente rivede e sovrascrive → esporta*.

---

## 3. Le tre regole per ordinare le fasi

1. **Ogni release è una fetta verticale end-to-end**, non uno strato orizzontale. Non "prima tutto il backend, poi tutto il frontend": la prima release fa girare l'intero loop su un caso minimo, ed è già usabile.
2. **Si ordina per rischio decrescente**: la prima fase aggredisce l'incognita più grande. Qui le incognite maggiori sono due — *il motore valuta abbastanza bene?* (validità, che dipende dal gold standard) e *il docente adotta?* (override rate, workflow). Vanno affrontate per prime, non dopo aver rifinito l'interfaccia.
3. **Ogni release è un'ipotesi falsificabile**, non un elenco di funzioni: *"se diamo ai docenti un voto proposto sovrascrivibile, l'override rate sarà sotto X e risparmieranno Y tempo"*. Ti dice quando una fase è **fallita**, non solo quando è finita.

Corollario: le funzioni differenzianti (multi-motore, on-prem, adattività, marketplace ricco) arrivano **tardi di proposito** — sono a basso rischio una volta dimostrati loop e validità. Metterle all'inizio è il modo classico per non finire mai.

---

## 4. La sequenza delle fasi

| Fase | Nome | Contenuto | Metrica / criterio |
|---|---|---|---|
| **0** | De-risking / gold standard | Corpus a doppia correzione per **un** segmento e **una** rubrica; benchmark cross-family; profilo tri-metrico di base. Nessun prodotto ancora, solo l'harness. | Profilo (ICC, QWK, SMD — definizioni in [`statoDellArte.md`](./statoDellArte.md) §A.2) stabile su un motore |
| **1** | Walking skeleton | Loop minimo end-to-end con **un** motore certificato, **un** segmento; niente on-prem né multi-motore. Pilot ristretto. | Override rate e tempo risparmiato |
| **2** | Workflow e difendibilità | Rubrica configurabile, feedback formativo per studente, tracciabilità/informativa, integrazione LMS (piattaforma didattica) minima. Ancora monomotore. | Adozione nel pilot; difendibilità del voto |
| **3** | Multi-motore | Strato di astrazione, set di motori certificati, profilo pubblicato. Qui arriva la value prop della scelta del motore. | ≥2 motori certificati intercambiabili |
| **4** | On-prem / bring-your-own | Deployment locale, ricertificazione, ripartizione contrattuale dei ruoli. | Deployment on-prem funzionante + ruoli AI Act mappati |
| **5** | Scala | Altri segmenti, altre lingue/rubriche, ciclo formativo studente (bozza → feedback → revisione). | Espansione a nuovi segmenti |

La **Fase 0 è il collo di bottiglia** e va davanti a tutto: sblocca il resto.

---

## 5. Dettaglio Fase 0 — costruzione del gold standard

Il gold standard è l'asset più costoso e il prerequisito di ogni claim di validità (vedi `governanceModelli.md` §4). Va messo a budget come asset, non come sottoprodotto — soprattutto per l'italiano, dove i dataset pubblici scarseggiano.

**Cosa serve.** Un corpus di prove reali corrette da valutatori esperti, idealmente in **doppia correzione**, così sullo stesso materiale si stimano *sia* la ripetibilità umana di riferimento *sia* l'allineamento dell'AI. Su questo corpus si gira il confronto cross-family (QWK e ICC per l'accordo, SMD per il bias di severità).

**Punto di partenza sui dati.** Dataset pubblici esistono soprattutto per l'inglese — **ASAP/ASAP++** (Hewlett, su Kaggle) è il riferimento per l'Automated Essay Scoring con punteggi per tratto. Per l'italiano la disponibilità è scarsa: con ogni probabilità va costruito il corpus, ed è il collo di bottiglia da mettere in conto subito.

**Dati operativi dal pilot (Fase 1+).** Quando c'è un prototipo minimo, un pilot controllato su poche classi dà ciò che nessuna letteratura offre: turnaround reale, soddisfazione e soprattutto l'**override rate** — quante volte il docente modifica il voto proposto. Misura la fiducia effettiva, non quella dichiarata. Disegno utile: **A/B tra correzione solo-umana, solo-AI e ibrida**.

> Compliance a monte: raccogliere compiti di studenti (spesso minori) richiede base giuridica GDPR, consenso e anonimizzazione (vedi `legale.md`). Va deciso *prima* di raccogliere, non dopo. La funzione di **validazione di allineamento per set** del backlog (§5) è anche il canale con cui, con consenso, ogni elaborato di riferimento diventa un punto di gold standard.

---

## 6. Sintesi

La roadmap traduce il backlog in una sequenza di de-risking: prima il loop con un motore certificato e la sua validità (Fasi 0–1), poi workflow e difendibilità (Fase 2), infine i differenzianti costosi (Fasi 3–5). Il metodo — tre artefatti, fette verticali, ipotesi falsificabili — serve a non ricadere nella cascata. Il vincolo che regge tutto è la Fase 0: senza gold standard non c'è validità da dimostrare, e senza validità le fasi successive costruiscono su sabbia.
