# Vincoli legali e di compliance

### App di correzione assistita da AI per la didattica

> **Natura del documento.** Sintesi di lavoro per orientare il planning di prodotto. Non è una consulenza legale. Prima del rilascio, in particolare su trattamenti che coinvolgono minori o atenei pubblici, è necessario un parere DPO (*Data Protection Officer*, responsabile della protezione dei dati) / legale e una validazione delle scadenze normative, che sono in evoluzione.

---

## 1. I due regimi che si applicano

Il prodotto vive all'incrocio di due corpi normativi distinti, che vanno tenuti separati perché rispondono a logiche diverse:

- **GDPR** — disciplina *come* tratti i dati personali. I suoi vincoli si attivano in funzione del *soggetto* (minore/adulto) e del tipo di dato.
- **AI Act (Reg. UE 2024/1689)** — disciplina *cosa può fare il sistema in sé*. I suoi vincoli si attivano in funzione della *finalità* del sistema, non dell'età degli interessati.

In Italia il quadro è integrato dalla **legge 132/2025**, che recepisce e adatta l'AI Act con disposizioni per il settore pubblico, incluse le istituzioni scolastiche, e dalle **Linee guida MIM** sull'IA a scuola.

---

## 2. Il vincolo invariante (il punto da cui partire)

Correggere un elaborato descrittivo e assegnare un voto rientra nell'**Allegato III, punto 3(b)** dell'AI Act — *valutazione dei risultati di apprendimento* — e quindi è classificato **ad alto rischio**.

Due conseguenze centrali, entrambe **indipendenti dall'età degli studenti**:

1. **Alto rischio AI Act** → obblighi di gestione del rischio, data governance, sorveglianza umana, documentazione tecnica, logging, trasparenza, più valutazione d'impatto sui diritti fondamentali (FRIA) per i deployer pubblici.
2. **Art. 22 GDPR** → un voto è un effetto "significativo" sulla persona, quindi non può essere prodotto da una decisione *unicamente* automatizzata: serve un intervento umano effettivo.

Entrambi convergono sullo stesso requisito di design: **la macchina propone, il docente decide e può sovrascrivere**. Questo non è un dettaglio: è la leva che riduce di più la superficie regolatoria (vedi §6).

L'eccezione dell'art. 6(3) AI Act (compito meramente accessorio, nessuna profilazione) **non copre** l'assegnazione del voto; potrebbe valere solo per usi marginali (es. controllo ex post di scostamento del docente da un modello).

> **Nota di raccordo — il rischio è già in atto (shadow AI).** Non è ipotetico: nella prassi molti docenti già usano chatbot consumer per correggere, eseguendo *questa stessa* funzione ad alto rischio senza base giuridica, tracciabilità né human-in-the-loop. Il prodotto non introduce il rischio: **porta sotto governance un rischio già presente e oggi assorbito dall'istituzione**. È il risvolto di compliance dell'argomento commerciale dello "scudo" ([`modelloBusiness.md`](./modelloBusiness.md) §5-ter).

---

## 3. Matrice: segmento × profilo di rischio

| Segmento | Età tipica | Base giuridica probabile | Strato "minori" GDPR | Alto rischio AI Act | Dimensione amministrativa |
|---|---|---|---|---|---|
| Scuola secondaria (istituzionale) | Minori (e alcuni 18+) | Compito di interesse pubblico | **Sì** | **Sì** | Atto valutativo scolastico |
| CPIA / istruzione adulti | Adulti | Compito di interesse pubblico | No | **Sì** | Atto valutativo |
| Università pubblica | Maggiorenni | Compito di interesse pubblico | No | **Sì** | **Atto amministrativo** (accesso atti, ricorsi) |
| Certificazioni linguistiche / enti privati | Adulti (talvolta minori) | Contratto / consenso | Solo se minori | **Sì** | Regolamento d'esame dell'ente |
| B2C autoapprendimento | Variabile, anche < 14 | Consenso (genitoriale se < 14) | **Sì se < 14** | Dipende dall'uso* | — |

\* Nel B2C formativo senza assegnazione di voto ufficiale la classificazione può essere più lieve; resta alto rischio se il sistema produce una valutazione che orienta il percorso.

**Lettura della matrice.** La colonna "Alto rischio AI Act" è quasi sempre piena: è il baricentro e non si sposta cambiando target. Lo strato "minori" è l'unica colonna che si accende/spegne con l'età. Spostarsi su utenza adulta toglie *quella* colonna — utile ma marginale rispetto al peso complessivo.

---

## 4. Vincoli trasversali (validi per qualunque segmento ed età)

- **Base giuridica** documentata e adeguata al contesto (interesse pubblico per il settore pubblico; contratto/consenso nel B2C).
- **Human-in-the-loop** effettivo (art. 22 GDPR + art. 14 AI Act): voto proposto, mai imposto.
- **Dati particolari incidentali** (art. 9 GDPR): un elaborato personale può rivelare salute, convinzioni religiose, opinioni politiche, orientamento sessuale. Da prevedere nel design del trattamento.
- **Minimizzazione e conservazione**: raccogliere solo il necessario, definire tempi di cancellazione.
- **Trasparenza**: informativa chiara; informare l'interessato che è soggetto a un sistema AI ad alto rischio.
- **Trasferimenti extra-UE e scelta del modello**: se l'inferenza avviene su un LLM (*Large Language Model*) ospitato fuori UE, gli elaborati transitano verso un responsabile in paese terzo. Servono garanzie adeguate, DPA (*Data Processing Agreement*, accordo sul trattamento dei dati) col sub-responsabile, valutazione del trasferimento. È una **scelta architetturale** (modello UE / on-prem / deployment regionale), non un adempimento a valle. Nota di fase: finché lo sviluppo gira su **dati sintetici** (nessun dato personale) il GDPR non si applica e i modelli frontier extra-UE sono liberamente usabili; il punto di decisione è l'ingresso del **primo dato reale**, non il rilascio (vedi il gate di migrazione in [`roadmap.md`](./roadmap.md) §4).
- **AI literacy** (art. 4 AI Act): in vigore dal 2 febbraio 2025.
- **Capacità estese dei modelli self-hosted e ribaltamento di responsabilità.** Un modello ospitato dal fornitore applica *policy di rifiuto* proprie: certi contenuti (es. cybersecurity offensiva) vengono negati a monte. Un modello **self-hosted** opera anche lì — apre ambiti didattici legittimi altrimenti preclusi, ma **sposta sul deployer la responsabilità** di ciò che il modello produce, insieme allo scivolamento verso il ruolo di provider (vedi voce successiva). L'**hosting gestito** (il modello del cliente operato da noi) è la modalità intermedia che conserva tracciabilità e controllo delle modifiche: chi esegue e chi autorizza le variazioni dei pesi va fissato contrattualmente. Dettaglio di governance in [`governanceModelli.md`](./governanceModelli.md) §5 e §8; risvolto commerciale in [`modelloBusiness.md`](./modelloBusiness.md) §5-bis.
- **Ripartizione provider/deployer**: se il cliente personalizza/co-costruisce il sistema, può assumersi responsabilità da provider. Da regolare contrattualmente.
- **DPIA** (*Data Protection Impact Assessment*, valutazione d'impatto sulla protezione dei dati): di fatto dovuta per tecnologia innovativa + valutazione automatizzata su larga scala (oltre che, dove presenti, per i minori).

---

## 5. Vincoli specifici sui minori (lo strato che si spegne con utenza adulta)

Si applicano nei segmenti con studenti minori; **cadono** con utenza interamente maggiorenne:

- **Soglia del consenso digitale**: in Italia **14 anni**; sotto i 14 serve il consenso di chi esercita la responsabilità genitoriale (rilevante soprattutto nel B2C, dove la base è il consenso).
- **Protezione rinforzata** (Considerando 38 GDPR) e lettura più severa contro le decisioni totalmente automatizzate sui minori (Considerando 71).
- **Informativa** con linguaggio adeguato all'età.
- Eventuali **disposizioni nazionali** specifiche sull'accesso dei minori ai servizi AI.

> Nota: con utenza adulta la **DPIA non sparisce** — perde solo il trigger "soggetto vulnerabile", ma resta dovuta su altri presupposti.

---

## 6. Leve di mitigazione

| Leva | Vincoli che attenua | Note |
|---|---|---|
| **Posizionamento come "assistente che propone"** (mai decisore) | Art. 22 GDPR, sorveglianza umana AI Act, decisioni automatizzate su minori | Leva singola che copre più obblighi insieme: è la più efficace |
| **Override del docente tracciato** | Human-in-the-loop + difendibilità del voto | Doppio valore: metrica di prodotto (fiducia) e presidio di compliance |
| **Tracciabilità e motivazione del giudizio** | Difendibilità, diritto di accesso (università pubblica) | Da feature commerciale diventa requisito di diritto amministrativo nel settore pubblico |
| **Scelta del modello e del luogo di inferenza** | Trasferimenti extra-UE, sicurezza dati minori | Decisione architetturale a monte; condiziona quali LLM sono utilizzabili |
| **Target su utenza adulta** | Solo lo strato "minori" del GDPR | Riduce attrito, ma non tocca il baricentro alto rischio |
| **Contrattualizzazione provider/deployer** | Responsabilità AI Act | Definisce chi sostiene gli obblighi da provider |

---

## 7. Proprietà intellettuale e titolarità dei contenuti condivisi

Con il marketplace di compiti e griglie (vedi [`backlogPrioritizzato.md`](./backlogPrioritizzato.md)) si apre un **asse di compliance nuovo, accanto a GDPR e AI Act**, che la sola app di correzione non aveva. Va affrontato **prima** di abilitare la vendita/condivisione, non a valle.

I due nodi:

- **Titolarità dell'opera.** Di chi è un compito che il docente carica — suo o della scuola/ateneo? In ambito lavorativo la titolarità dei materiali prodotti nell'esercizio delle proprie funzioni **non è scontata** e può spettare al datore di lavoro (istituzione). Prima di consentire la condivisione a scopo di credito/vendita serve una **verifica della titolarità**.
- **Materiale di terzi incorporato.** I compiti includono spesso opere altrui (un brano di un romanzo per la comprensione, un'immagine, un grafico): redistribuirli tocca il **diritto d'autore di terzi**, indipendentemente da chi ha scritto la consegna.

Leve di gestione:

| Leva | A cosa serve |
|---|---|
| **Framework di licenza** esplicito al momento del caricamento | Definire cosa l'autore concede alla piattaforma e agli altri utenti |
| **Verifica/dichiarazione di titolarità** prima di abilitare vendita o crediti | Spostare sull'autore la responsabilità dichiarativa e tracciarla |
| **Segnalazione del materiale di terzi** e policy di rimozione | Gestire il diritto d'autore altrui e le richieste di takedown |

> Nota di raccordo: la scelta dei **crediti chiusi** (non convertibili in denaro) descritta nel backlog alleggerisce anche questo asse, perché evita di configurare l'autore come venditore/impresa; ma **non** elimina il nodo della titolarità e del materiale di terzi, che resta da regolare contrattualmente.

---

## 8. Tempistiche AI Act (da riverificare)

Quadro in movimento al momento della stesura:

- **2 febbraio 2025** — in vigore i divieti sui sistemi a rischio inaccettabile e l'obbligo di AI literacy.
- **Obblighi sull'alto rischio (Allegato III)** — originariamente attesi per agosto 2026; risulta in corso uno **slittamento**, con alcune fonti che indicano **2 dicembre 2027** per i sistemi autonomi e **2 agosto 2028** per quelli integrati in prodotti.

La finestra temporale va riconfermata in fase di sviluppo, perché incide sulla roadmap di compliance.

---

## 9. Checklist operativa minima

- [ ] Definire il segmento target e leggere la riga corrispondente della matrice (§3).
- [ ] Stabilire la base giuridica per quel segmento.
- [ ] Progettare il flusso con human-in-the-loop e override tracciato fin dall'inizio.
- [ ] Decidere modello e luogo di inferenza (vincolo trasferimenti).
- [ ] Impostare DPIA (e, se settore pubblico, FRIA).
- [ ] Predisporre informativa e meccanismo di trasparenza.
- [ ] Regolare contrattualmente la ripartizione provider/deployer col cliente.
- [ ] Mappare la gestione dei dati particolari incidentali negli elaborati.
- [ ] Se è previsto il marketplace: verificare titolarità e materiale di terzi, predisporre licenza (§7).
- [ ] Verificare le scadenze AI Act aggiornate.
- [ ] Ottenere parere DPO/legale prima del rilascio.

---

## 10. Sintesi in una frase

Il peso regolatorio non dipende dall'età degli studenti ma dalla funzione "valuto e assegno un voto": l'unica leva che lo riduce davvero è il **posizionamento del sistema come assistente alla correzione, non come decisore automatico**.
