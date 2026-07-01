# Backlog prioritizzato

### Piattaforma di correzione AI, marketplace didattico e apprendimento adattivo

> **Natura del documento.** Inventario delle funzioni ordinate per priorità. Non è una roadmap temporale: la priorità segue la logica di riduzione del rischio (prima il loop e la validità, poi i differenzianti costosi). Si appoggia a [`legale.md`](./legale.md) (vincoli) e [`governanceModelli.md`](./governanceModelli.md) (qualità dei motori).

---

## 1. Visione in breve

Piattaforma **multi-sided** in cui la correzione AI è il motore, non il prodotto:

- **Correzione** — il docente carica elaborati, un motore certificato propone voto e feedback, il docente rivede e sovrascrive, esporta. Human-in-the-loop sempre.
- **Marketplace** — store di compiti e griglie; i docenti che condividono guadagnano **crediti chiusi** (non denaro). Modello a **due monete**: chi compra paga in denaro, il creatore è premiato in crediti riscattabili in valore di piattaforma.
- **Lato studente** — allenamento in affiancamento alle ripetizioni; la correzione multi-tratto produce una **diagnosi per dimensione** che guida la raccomandazione di materiale su misura.
- **Motori** — multi-motore scelto dal cliente, deployment on-premise, certificazione psicometrica della qualità.

Il fossato non è lo store in sé (ne esistono già), ma l'integrazione tra correzione certificata e loop diagnostico: si vendono "compiti che si autocorreggono", non compiti.

---

## 2. Criterio di priorità

L'ordine non riflette il gusto ma il rischio. Le incognite maggiori — *il motore valuta abbastanza bene?* (validità) e *il docente adotta?* (override rate, workflow) — vanno aggredite per prime. Le funzioni differenzianti (multi-motore, on-prem, adattività, marketplace ricco) sono a basso rischio una volta dimostrati loop e validità, quindi stanno più in là.

---

## 3. Backlog per priorità (MoSCoW)

> **MoSCoW** è un metodo di prioritizzazione: **M**ust have (indispensabile), **S**hould have (importante), **C**ould have (utile), **W**on't have (fuori ambito per ora).

### Must have — il loop minimo che dimostra tutto

- Gold standard per **un** segmento e **una** rubrica (prerequisito; collo di bottiglia).
- Correzione con griglia configurabile e voto **proposto** (mai imposto).
- Human-in-the-loop: **override del docente, tracciato**.
- Un **motore certificato** con profilo tri-metrico (ripetibilità, allineamento, severità).
- **Versioning del voto**: congelamento della terna compito + griglia + motore/versione.
- Base di compliance essenziale (informativa, base giuridica, DPIA minima).
- **Modalità demo** su **dati sintetici**, con role-switching docente → studente → restituzione: lo stesso loop senza dati reali, quindi a compliance quasi nulla. Onboarding e fiducia; di fatto il walking skeleton con dati seminati. Include la vista di allineamento a **compito singolo** (illustrativa — vedi §5).

### Should have — rende il prodotto adottabile, difendibile e innesca il marketplace

- Feedback formativo **multi-tratto** per studente.
- **Design universale del feedback** (linguaggio piano, struttura a blocchi, text-to-speech, leggibilità) — accessibile a tutti, nessun dato sanitario trattato.
- Integrazione LMS (*Learning Management System*, la piattaforma didattica: Registro Elettronico, Google Classroom, Moodle) minima.
- Condivisione compiti + **crediti chiusi** (innesco del marketplace sull'utilità mono-utente).
- Store base: catalogo, ricerca, riscatto crediti.
- **Punteggio di qualità delle griglie** derivato dalle metriche (segnale oggettivo che nessuno store generico ha).
- **Validazione di allineamento per set** (cruscotto): elaborati di riferimento col voto atteso, usati come *regression test* al variare della versione del motore. Faccia in-prodotto della certificazione e canale di raccolta del gold standard — vedi §5.

### Could have / Nice to have — differenzianti, costosi, posticipabili

- **Multi-motore + bring-your-own + on-premise** con governance completa (ruoli provider/deployer, ricertificazione).
- **Loop diagnostico → raccomandazione di materiale su misura** (lato studente adattivo). ⚠ Riapre la profilazione (GDPR, minori).
- Modello a due monete completo e monetizzazione della vendita.
- **Specializzazione del feedback per DSA (Disturbi Specifici dell'Apprendimento) e studenti certificati** → vedi §4.

### Won't have (per ora) — fuori ambito

- Valutazione di esiti ufficiali completamente automatizzata (vietata: art. 22 GDPR + alto rischio AI Act).
- Inferenza/diagnosi di condizioni dello studente da parte del modello (territorio clinico).

---

## 4. Nota — Specializzazione del feedback DSA/certificati (Nice to have)

Obiettivo di **lungo termine**: "bello da scrivere, difficile da fare". Classificato nice-to-have perché è l'angolo a massimo carico di tutto il progetto — dati scarsi, **dati sanitari** (art. 9 GDPR) su minori, profilazione, linea clinica da non superare — e perché richiede un gold standard dedicato di giudizi di esperti di sostegno.

Va scomposto in tre strati a priorità diversa, così il valore non aspetta la parte impossibile:

1. **Design universale** — già collocato in *Should have*: feedback accessibile per tutti, senza trattare dati sanitari. È la quota di valore recuperabile presto.
2. **Accomodamento configurato dal docente** — *Could have*: il docente, che detiene il PDP (Piano Didattico Personalizzato), attiva un profilo di correzione (es. escludi l'ortografia dal punteggio) e l'AI esegue. Il dato sanitario resta alla scuola; il modello non lo memorizza né lo inferisce.
3. **Feedback specializzato sul profilo** — *Nice to have / ricerca*: personalizzazione validata contro il giudizio degli esperti, con gold standard proprio. La vera frontiera.

Principio trasversale: **tenere la diagnosi fuori dall'AI finché possibile** — far *configurare* l'accomodamento dal docente è più sicuro e più realizzabile che farlo *inferire* al modello.

---

## 5. Nota — Modalità demo e validazione di allineamento

Sono **due funzioni distinte, a due risoluzioni**, da non confondere.

- **Demo (walkthrough)** — una persona entra come docente (crea compito e griglia), poi come studente (svolge e riceve la restituzione). Gira su **dati sintetici**, con role-switching su un solo utente che *simula* il flusso multi-ruolo (in produzione sono persone diverse). Scopo: capire e fidarsi. Compliance quasi nulla → tra le prime da costruire.
- **Validazione di allineamento** — il docente carica elaborati di riferimento col voto atteso e vede lo scarto rispetto al voto del motore; serve a rivalidare **al variare della versione** del motore, perché non c'è miglioramento monotòno tra generazioni. È la faccia in-prodotto del framework di `governanceModelli.md`.

**La distinzione che conta — compito singolo vs set:**

- Un **compito singolo** col voto atteso è *illustrativo*, non una misura: con n = 1 non distingui rumore, bias e disallineamento, e l'ancora stessa (il voto atteso del docente) è un giudizio umano rumoroso (ICC ~0.70–0.85). Va benissimo **nella demo**, per convincere.
- Un **set di riferimento** che copre l'arco dei voti, di cui si osserva la *distribuzione degli scarti*, è ciò che **valida il processo**: separa il bias sistematico (severità, correggibile con offset `SMD × SD`) dal disaccordo di rango (QWK/ICC, non correggibile).

Effetto collaterale: ogni elaborato di riferimento caricato è, con consenso, **un punto di gold standard**. La funzione che serve al singolo docente costruisce in aggregato il corpus della piattaforma — attacca il collo di bottiglia dei dati.

---

## 6. Nota — Economia dei crediti (razionale della scelta)

La scelta di **crediti chiusi** (non convertibili in denaro) + **modello a due monete** è documentata in §1; qui il perché, perché regge su argomenti solidi e non sull'aneddoto.

- **L'argomento debole da evitare.** "Il cashback non funziona" è falso: chi lo cita (es. Satispay) in realtà lo mantiene come leva centrale e ci ha *aggiunto* sopra un livello a punti. La lezione trasferibile non è "cashback sì/no" ma la **flessibilità di riscatto** (accumulo piacevole, spesa libera).
- **L'argomento solido** è specifico al prodotto: una valuta chiusa evita di trasformare "il docente guadagna" in un **pagamento monetario tassabile**, alleggerendo l'asse **IP/fiscale** (vedi `legale.md` §7) — i crediti restano valore di piattaforma, non reddito.
- **Breakage.** Il valore resta interno (reinvestito in correzioni, contenuti, accesso) e i crediti non riscattati non escono come cassa.
- **Attenzione allo spam.** Premiare la condivisione a volume rischia di generare spam; l'antidoto proprietario è il **punteggio di qualità delle griglie** derivato dalle metriche (§Should have): una griglia che produce alta affidabilità vale più di una che genera giudizi rumorosi. È un segnale di qualità oggettivo che nessuno store generico ha.

> In sintesi: crediti chiusi non perché "il cashback non funziona", ma perché alleggeriscono IP/fisco, abilitano il modello a due monete e trattengono valore (breakage) — con la qualità metrica come freno allo spam.

---

## 7. Sintesi

La priorità mappa la sequenza di de-risking: prima il loop con un motore certificato e la sua validità, poi workflow e marketplace base, infine i differenzianti costosi (multi-motore, on-prem, adattività). La **modalità demo**, a dati sintetici e basso rischio, è un vincitore precoce: dimostra il loop e raccoglie i primi punti di gold standard. La specializzazione DSA è invece un orizzonte di ricerca, non una feature di release — ma il suo strato accessibile (design universale) è già nel breve termine.
