# Modello di business e go-to-market

### Come si genera valore, chi paga, come si entra nel mercato

> **Natura del documento.** Consolida in un unico punto scelte che finora vivevano sparse: l'economia dei crediti (era in [`backlogPrioritizzato.md`](./backlogPrioritizzato.md) §6), il motion di vendita (era in [`analisiBisogniEMercato.md`](./analisiBisogniEMercato.md) §3) e il quality score come freno allo spam. Si aggancia a [`legale.md`](./legale.md) (IP/fisco) e a [`visione.md`](./visione.md) (cosa si vende davvero).

---

## 1. Cosa si vende

Non velocità di correzione (commoditizzata), ma **certificabilità metrologica del motore**: fiducia difendibile nel voto. La piattaforma è **multi-sided**, con la correzione AI come motore e non come prodotto finale:

- **Correzione** — il cuore: motore certificato, human-in-the-loop, voto proposto e tracciato.
- **Marketplace** — store di compiti e griglie; si vendono "compiti che si autocorreggono", non compiti.
- **Lato studente** — la diagnosi multi-tratto guida la raccomandazione di materiale su misura.

---

## 2. Economia dei crediti — la scelta e il perché

**Crediti chiusi** (non convertibili in denaro) + **modello a due monete**: chi compra paga in denaro, il creatore è premiato in **crediti** riscattabili in valore di piattaforma.

Il razionale regge su argomenti solidi, non sull'aneddoto:

- **L'argomento debole da evitare.** "Il cashback non funziona" è falso (chi lo cita, es. Satispay, in realtà lo mantiene come leva centrale). La lezione trasferibile non è "cashback sì/no" ma la **flessibilità di riscatto**: accumulo piacevole, spesa libera.
- **L'argomento solido, specifico al prodotto.** Una valuta chiusa evita di trasformare "il docente guadagna" in un **pagamento monetario tassabile**, alleggerendo l'asse IP (proprietà intellettuale) / fiscale ([`legale.md`](./legale.md) §7): i crediti restano valore di piattaforma, non reddito.
- **Breakage.** Il valore resta interno (reinvestito in correzioni, contenuti, accesso); i crediti non riscattati non escono come cassa.

> ⚠️ I crediti chiusi alleggeriscono l'asse IP/fiscale ma **non** eliminano il nodo della titolarità dell'opera e del materiale di terzi, che resta da regolare contrattualmente ([`legale.md`](./legale.md) §7).

---

## 3. Il freno allo spam: quality score metrico

Premiare la condivisione a volume rischia spam. L'antidoto è proprietario: il **punteggio di qualità delle griglie** derivato dalle metriche psicometriche. Una griglia che produce alta affidabilità vale più di una che genera giudizi rumorosi. È un segnale di qualità oggettivo che **nessuno store generico ha** — e collega direttamente il marketplace al framework di certificazione ([`governanceModelli.md`](./governanceModelli.md)).

---

## 4. Motion di vendita

Distinguere presto tra due movimenti con economie opposte:

| Movimento | Adozione | Stickiness / ricorrenza | Note |
|---|---|---|---|
| **Vendita al singolo docente** | Facile, veloce | Bassa | Innesco: l'utilità è già mono-utente prima del network effect |
| **Vendita istituzionale** (scuola/ateneo) | Procurement lento | Alta, ricorrente, difendibile | Qui la compliance EU-native e la difendibilità del voto diventano argomenti di acquisto |

Il marketplace si innesca sull'utilità mono-utente (il docente trae valore anche da solo), poi il network effect segue.

---

## 5. Segmento e leva EU-native come vantaggio commerciale

La compliance non è solo un costo: in vendita istituzionale la **difendibilità del voto** (tracciabilità, motivazione, human-in-the-loop) passa da feature a requisito di diritto amministrativo, e l'essere **EU-native by design** (GDPR + AI Act) è un vantaggio reale contro i prodotti USA non nativi (dettaglio in [`statoDellArte.md`](./statoDellArte.md) Parte B e [`legale.md`](./legale.md)).

---

## 5-bis. Il motore locale come leva commerciale — ambiti preclusi e hosting gestito

Due argomenti di vendita che nascono dalla scelta multi-motore + on-prem, non dalla correzione in sé:

- **Ambiti preclusi al frontier ospitato.** I modelli frontier via API applicano policy di rifiuto: alcuni domini didattici legittimi — cybersecurity offensiva, red-team, scrittura di exploit a scopo formativo — vi sbattono contro. Un motore **locale** li copre, e apre un mercato che i prodotti costruiti solo su frontier ospitato **non possono** servire. Attenzione a *come* si vende: *"apre ambiti che il frontier nega"* è vero e difendibile; *"corregge bene quegli ambiti"* è un'altra affermazione, che richiede comunque la **certificazione per-ambito** ([`governanceModelli.md`](./governanceModelli.md) §3) — capacità ≠ validità. E l'apertura di quegli ambiti **sposta la responsabilità sul cliente** ([`legale.md`](./legale.md) §4): va prezzata e contrattualizzata, non regalata.
- **Hosting gestito come tier intermedio.** Tra il cloud a motore certificato e il bring-your-own puro c'è un terzo prodotto: **ospitiamo e operiamo noi il modello del cliente**. Il cliente ottiene motore specializzato e/o sovranità del dato; noi conserviamo il controllo delle modifiche (le eseguiamo noi, o sappiamo cosa è cambiato) e quindi la **garanzia di qualità** che il bring-your-own non può dare ([`governanceModelli.md`](./governanceModelli.md) §5). È monetizzabile come **servizio gestito ricorrente**, coerente con la stickiness della vendita istituzionale (§4).

---

## 6. Sintesi

Si monetizza la certificabilità del motore, non la correzione. I crediti chiusi + due monete alleggeriscono IP/fisco e trattengono valore, con il quality score metrico come freno allo spam. Il go-to-market corre su due binari — docente singolo per l'innesco, istituzione per la ricorrenza — e la compliance EU-native è un argomento di vendita, non solo un adempimento.
