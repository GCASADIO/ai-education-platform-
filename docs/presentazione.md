# AI in Education — Il racconto

### Livello 1: la presentazione organica, da leggere dall'inizio alla fine

> **Come usare questo documento.** È il *livello di presentazione*: nove sezioni brevi che si leggono in sequenza in ~10 minuti e raccontano il progetto per intero. Ogni sezione chiude con un link **→ Approfondisci** verso il dossier di *livello 2* (in [`docs/`](.)) che ne contiene il dettaglio. Chi presenta resta qui; chi vuole scavare segue i link.
>
> La stella polare stabile è in [`visione.md`](./visione.md); questo documento la espande in narrazione.

---

## 1. Scopo

La correzione descrittiva — temi, saggi, risposte aperte — è la parte del lavoro del docente meno comprimibile e più costosa in tempo. La si vuole alleggerire **senza** delegare il giudizio alla macchina e **senza** barare sulla qualità della misura.

Il punto di onestà che regge tutto: un voto AI più *ripetibile* non è automaticamente più *giusto*. Il prodotto tiene separate le due cose invece di confonderle. Non è "un correttore automatico": è una piattaforma in cui la correzione AI è il **motore**, e il valore vero è la capacità di **dimostrare con metodo quanto ci si può fidare** di quel motore (vedi §5).

**Il loop fondamentale:** il docente carica gli elaborati → un motore certificato propone voto e feedback → il docente rivede e sovrascrive → esporta. Human-in-the-loop sempre.

**→ Approfondisci:** [`visione.md`](./visione.md)

---

## 2. Il problema

Il dolore non è "automatizzare il voto": è un insieme di asimmetrie precise tra ciò che il docente deve fare e ciò che riesce a fare nel tempo disponibile — tempo sulla correzione descrittiva, **coerenza** del giudizio (soggetta a stanchezza, drift, effetto alone), voglia di codificare la *propria* rubrica invece di subirne una generica, feedback formativo che raramente c'è tempo di scrivere bene.

La domanda è massima dove coincidono tre condizioni: **alto volume descrittivo + rubriche mature + coerenza che conta**. Il segmento che le soddisfa meglio è la scrittura in lingua straniera (certificazioni linguistiche); a seguire umanistiche e giuridiche. La scelta si fa sul dolore, non sul volume.

**→ Approfondisci:** [`analisiBisogniEMercato.md`](./analisiBisogniEMercato.md)

---

## 3. Perché può funzionare — le evidenze

Un modello a temperatura fissa ripete lo stesso voto in modo molto più costante di un correttore umano (che è soggetto a stanchezza, fretta ed effetto alone). Ma qui scatta la prima asimmetria: **essere costanti non vuol dire essere accurati**. Un motore può essere stabilmente severo o miope su una dimensione — coerente con sé stesso, non necessariamente con il vero.

Seconda asimmetria: **nessun miglioramento garantito tra una generazione di modelli e la successiva**. Cambiare famiglia o versione cambia sia il livello sia gli errori sistematici: modelli diversi sono come strumenti di misura diversi, ognuno con la propria deriva. Da qui la ricertificazione a ogni cambio versione.

**→ Approfondisci:** [`statoDellArte.md`](./statoDellArte.md) (Parte A), dove trovi i valori numerici e le metriche precise. *Nota: i numeri-ancora provengono da conversazioni di ricerca e sono ancora da riverificare contro le fonti primarie.*

---

## 4. Il fossato — cosa manca ai competitor

La ricognizione non trova un prodotto, open o closed, che combini **tutti** gli strati. Correzione human-in-the-loop e allenamento studente sono terreno affollato (CoGrader, Class Companion, Gradescope…): **non** sono un differenziatore.

Il moat è la cerniera tra strati oggi non occupata:

- **certificazione psicometrica per motore** con ricertificazione automatica (il più distintivo — oggi solo in letteratura);
- **rubriche eseguibili/versionate** (modello RULERS: compilate e auditabili, non prompt in chiaro);
- **multi-motore + on-premise** verticalizzato sulla didattica;
- **pacchetto GDPR / AI-Act EU-native** (i prodotti USA non lo sono by design).

**→ Approfondisci:** [`statoDellArte.md`](./statoDellArte.md) (Parte B)

---

## 5. Il cuore tecnico — certificazione dei motori

> **Cosa vuol dire "certificazione psicometrica" di un motore.** La psicometria è la disciplina che misura *quanto è affidabile e valido un giudizio* — nasce per tarare test ed esami umani. Applicarla a un motore AI significa trattarlo come uno strumento di misura da collaudare: prima di fidarsi del voto che produce, se ne misura la qualità con metodo, invece di darla per scontata.

Non si certifica "l'app corregge bene" in astratto. Si certifica **"il motore X, con questa rubrica, corregge con questo profilo"**. La qualità è proprietà della coppia (motore, configurazione).

Ogni motore è profilato su **tre assi indipendenti**, perché nessuno da solo basta:

| Asse | Cosa misura | Ruolo |
|---|---|---|
| **Ripetibilità** | quanto il motore ripete lo stesso voto sullo stesso elaborato | Criterio di **ammissione** |
| **Allineamento all'umano** (validità) | quanto il voto concorda col giudizio umano di riferimento | Criterio di **ammissione** |
| **Bias di severità** | quanto il motore è mediamente più severo o più indulgente | **Parametro di calibrazione**, non di esclusione |

Il principio che orienta tutto: **il bias è correggibile, la varianza no.** Un motore mediamente severo si ricalibra applicando una correzione fissa; un motore poco ripetibile o poco valido non si recupera. E poiché non c'è miglioramento garantito tra versioni, la certificazione **non è un atto una tantum**: ogni aggiornamento la riapre, e la frequenza con cui il docente corregge a mano il voto proposto è il rilevatore precoce di deriva.

*Le metriche psicometriche precise che misurano i tre assi sono definite nel dossier collegato.*

Il prerequisito costoso di tutto questo è il **gold standard** (corpus a doppia correzione esperta): il collo di bottiglia del progetto, soprattutto per l'italiano.

**→ Approfondisci:** [`governanceModelli.md`](./governanceModelli.md)

---

## 6. Compliance EU-native

Il peso regolatorio **non dipende dall'età degli studenti** ma dalla funzione "valuto e assegno un voto", che ricade nell'Allegato III dell'AI Act (alto rischio) e nell'art. 22 GDPR (no a decisioni unicamente automatizzate). Entrambi convergono sullo stesso requisito di design: **la macchina propone, il docente decide e può sovrascrivere**.

È la leva singola più efficace: lo stesso posizionamento "assistente che propone" copre insieme più obblighi. La scelta del modello e del luogo di inferenza (UE / on-prem) è una decisione architetturale a monte, non un adempimento a valle. Con il marketplace si apre un asse nuovo — IP e titolarità dei contenuti — da affrontare prima di abilitare la condivisione.

**→ Approfondisci:** [`legale.md`](./legale.md)

---

## 7. Architettura e ruoli

**Motori.** Lo strato che li astrae usa **Strategy + Factory**: un'unica interfaccia `grade(elaborato, griglia) → risultato` con implementazioni intercambiabili (OpenAI, Claude, open-source on-prem, e il `FakeEngine` della demo). La demo non richiede infrastruttura nuova: il motore finto è un'implementazione in più dietro la stessa interfaccia — ed è insieme test double e verifica della pulizia dell'astrazione, purché dichiari onestamente la propria identità nell'audit.

**Ruoli.** Due assi separati: **ruolo** (cosa puoi fare) e **scope** (entro quale confine). La regola che regge la difendibilità del voto è la **separazione dei compiti**: chi corregge non audita, l'auditor non modifica, l'admin non vede né altera silenziosamente gli elaborati.

**→ Approfondisci:** [`architetturaMotori.md`](./architetturaMotori.md) · [`ruoliEPermessi.md`](./ruoliEPermessi.md)

---

## 8. Cosa costruiamo e in che ordine

Il metodo evita la trappola a cascata con **tre artefatti** (visione a una pagina, roadmap di release, scheda della release corrente), **fette verticali** end-to-end e **ipotesi falsificabili** invece di elenchi di funzioni. Si ordina per **rischio decrescente**: prima le incognite maggiori — *il motore valuta abbastanza bene?* (validità) e *il docente adotta?* (override rate).

| Fase | Contenuto | Criterio |
|---|---|---|
| **0** | Gold standard + harness (collo di bottiglia) | Profilo tri-metrico stabile su un motore |
| **1** | Walking skeleton: loop minimo, un motore, un segmento | Override rate e tempo risparmiato |
| **2** | Workflow e difendibilità (rubrica, feedback, tracciabilità) | Adozione nel pilot |
| **3** | Multi-motore | ≥2 motori certificati intercambiabili |
| **4** | On-prem / bring-your-own | Deployment locale + ruoli AI Act mappati |
| **5** | Scala (segmenti, lingue, ciclo studente) | Espansione |

I differenzianti costosi (multi-motore, on-prem, adattività, marketplace ricco) arrivano **tardi di proposito**: sono a basso rischio una volta dimostrati loop e validità.

**→ Approfondisci:** [`roadmap.md`](./roadmap.md) · [`backlogPrioritizzato.md`](./backlogPrioritizzato.md)

---

## 9. Modello di business

Si monetizza la **certificabilità del motore**, non la correzione. Il marketplace usa **crediti chiusi** (non convertibili in denaro) + **modello a due monete**: chi compra paga in denaro, il creatore è premiato in crediti — scelta che alleggerisce l'asse proprietà intellettuale/fiscale e trattiene valore dentro la piattaforma, con il **punteggio di qualità** delle griglie (derivato dalle metriche) come freno allo spam.

Go-to-market su due binari: **docente singolo** (adozione facile, innesco mono-utente) e **istituzione** (procurement lento ma ricorrente e difendibile, dove la compliance EU-native diventa argomento di acquisto).

**→ Approfondisci:** [`modelloBusiness.md`](./modelloBusiness.md)

---

## Stato

🚧 Fase di sviluppo iniziale. Idea a paternità **non esclusiva**: il concetto è condiviso, non rivendicato in esclusiva.
