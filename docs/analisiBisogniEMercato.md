# Analisi dei bisogni e del mercato

### Chi ha il problema, dove si concentra la domanda, come raccogliere i dati per deciderlo

> **Natura del documento.** Sintesi di lavoro per la scelta del segmento. Il valore non sta nell'"automatizzare il voto" ma nel risolvere asimmetrie precise tra ciò che il docente deve fare e ciò che riesce a fare nel tempo disponibile. Si lega a [`roadmap.md`](./roadmap.md) (la Fase 0 usa questi dati) e a [`legale.md`](./legale.md) (i segmenti hanno profili di rischio diversi).

---

## 1. Esigenze dei docenti (in ordine di rilevanza)

- **Tempo sulla correzione descrittiva** (temi, saggi brevi, risposte aperte): è la parte meno comprimibile della loro attività, e dove lo strumento offre il guadagno più tangibile.
- **Coerenza.** L'intra-rater reliability umana realistica (ICC ~0.70–0.85) è soggetta a drift, affaticamento, effetti di ordine e alone. Un modello a temperatura fissa offre repeatability molto più alta (~0.94–0.99). È probabilmente il vero argomento di vendita — ma va comunicato con **onestà**: alta affidabilità **non** implica alta validità (un modello può essere consistentemente severo o miope su una dimensione). Due claim distinti: "voto più ripetibile" ≠ "voto più giusto"; il secondo richiede allineamento a un gold standard umano.
- **Codificare la propria rubrica** invece di subirne una generica.
- **Feedback formativo personalizzato** per studente (che il docente raramente ha tempo di scrivere bene).
- **Controllo finale**: una bozza/proposta sovrascrivibile, non una delega.
- **Giustificazione e tracciabilità** del giudizio, cruciale in caso di contestazioni.
- **Integrazione col workflow esistente** (Registro Elettronico, Google Classroom, Moodle).
- **Conformità GDPR**, particolarmente sensibile con minori.

---

## 2. Esigenze degli studenti

- Tempi di ritorno rapidi (feedback in ore, non settimane).
- Feedback **azionabile**, non solo un numero.
- Percezione di **equità** (qui la coerenza aiuta davvero) e **trasparenza** sui criteri.
- Un **ciclo formativo prima della consegna**: invio bozza → ricevo feedback → miglioro.
- Va gestita l'**ansia da "valutazione algoritmica"**, che è una vera barriera all'adozione.

---

## 3. Dove si concentra la domanda

Il prodotto rende massimo dove coincidono **tre condizioni**: alto volume di correzione descrittiva, rubriche ben definite, coerenza che conta.

- Il segmento che le soddisfa meglio tutte e tre è la **valutazione della scrittura in lingua (L2 — *lingua seconda*, cioè straniera — e certificazioni)**: rubriche mature e standardizzate (QCER — *Quadro Comune Europeo di Riferimento per le lingue* —, con descrittori per banda), e caso in cui la ripetibilità è più facilmente difendibile.
- Subito dopo: **discipline umanistiche/giuridiche** con esami a risposta aperta in corsi ad alto numero di iscritti.

> Attenzione: **il volume non è il dolore.** Un segmento grande con poca correzione descrittiva vale meno di uno piccolo che vive di temi. Il dato di volume va ponderato per "quanta valutazione aperta" produce quel segmento.

**Motion di vendita.** Distinguere presto tra **vendita al singolo docente** (adozione facile, bassa stickiness) e **vendita istituzionale** (procurement lento ma molto più difendibile e ricorrente).

---

## 4. Come raccogliere i dati

Servono **tre tipi di dato per tre decisioni diverse**. Il rischio è sovra-investire sul dato che già si sa trattare (l'affidabilità psicometrica) e sotto-investire su quello che decide l'adozione (il bisogno).

### 4.1 Dati per scegliere il segmento (mercato + bisogni)

Dimensionamento quantitativo (facile da reperire in Italia):

- **ISTAT** (Istituto Nazionale di Statistica, sezione istruzione) e **portale dati aperti del MIM** (Ministero dell'Istruzione e del Merito) — studenti, docenti, scuole per ordine e indirizzo;
- **MUR** (Ministero dell'Università e della Ricerca) **/ ANVUR** (Agenzia Nazionale di Valutazione del sistema Universitario e della Ricerca) — iscritti universitari per area disciplinare;
- **report annuali degli enti di certificazione linguistica** (Cambridge, IELTS/British Council, Goethe, Instituto Cervantes, e CILS/CLIQ per l'italiano come lingua straniera) — volumi di candidati;
- **Eurostat** — confronto europeo.

Dato qualitativo sul bisogno (quello che quasi nessuno raccoglie, e che conta di più):

- **15–20 interviste semi-strutturate** con docenti bastano di solito a raggiungere saturazione tematica.
- Trappola metodologica: chiedere *"useresti uno strumento AI?"* → risposta inutile. Meglio l'approccio **Jobs-to-be-Done**: indagare il comportamento *attuale* (quanto tempo, su cosa, con quale rubrica, dove ci si blocca), non l'intenzione ipotetica.
- Poi una **survey più ampia** per quantificare i temi emersi. Se possibile, **osservazione diretta** di una sessione di correzione reale: è lì che emergono i tempi veri.

### 4.2 Dati per validare la fattibilità tecnica

È il **gold standard**: corpus di prove reali corrette da esperti, idealmente in doppia correzione. Metodologia e fonti (ASAP/ASAP++, ecc.) sono dettagliate in [`roadmap.md`](./roadmap.md) §5, perché costituiscono la Fase 0.

### 4.3 Dati operativi dal pilot

Turnaround reale, soddisfazione e **override rate**. Anche questi vivono nel pilot della roadmap (§5): A/B tra correzione solo-umana, solo-AI e ibrida.

> Nota trasversale: raccogliere compiti di studenti (spesso minori) richiede base giuridica GDPR, consenso e anonimizzazione. Va deciso a monte (vedi `legale.md`).

---

## 5. Sintesi

Il baricentro della domanda è dove alto volume descrittivo, rubriche mature e bisogno di coerenza coincidono: L2/certificazioni in testa, umanistiche/giuridiche a seguire. Ma la scelta del segmento non va fatta sul volume: va fatta sul **dolore** (quanta valutazione aperta) e validata con interviste Jobs-to-be-Done prima che con le survey. I tre tipi di dato — mercato, gold standard, pilot — servono tre decisioni distinte e non vanno confusi.
