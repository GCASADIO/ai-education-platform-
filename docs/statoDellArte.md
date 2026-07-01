# Stato dell'arte ed evidenze

### Base empirica sull'affidabilità della correzione AI e panorama competitivo

> **Natura del documento.** Raccoglie (a) le evidenze quantitative sull'affidabilità/validità della correzione AI vs umana e (b) la ricognizione di prodotti e progetti esistenti. Fa da base empirica ai principi fissati in [`governanceModelli.md`](./governanceModelli.md) e al posizionamento del [`README.md`](../README.md).
>
> ⚠️ **Attendibilità delle fonti.** Numeri, citazioni e identificativi arXiv provengono dalle conversazioni di ricerca originali (esportate) e **non sono stati riverificati** contro le fonti primarie. Vanno controllati prima di usarli in materiale pubblico o accademico. Dove due fonti interne divergono, è segnalato.

---

## Parte A — Evidenze sull'affidabilità della correzione

### A.1 Distinzione metrologica di partenza

- **Ripetibilità** (intra-rater): stesso correttore che ri-corregge lo stesso elaborato.
- **Riproducibilità** (inter-rater): correttori diversi.

La letteratura educativa documenta soprattutto la seconda; l'intra-rater "puro" (ri-valutazione in cieco in altra occasione) è la forma **meno riportata**, perché operativamente si fa doppia correzione con correttori diversi, e viene spesso stimato indirettamente.

### A.2 Numeri-ancora

| Dimensione | Valore | Fonte (da verificare) | Confidenza |
|---|---|---|---|
| Umano intra-rater (correttori addestrati con rubrica) | ICC ~0.70–0.85, con drift nella sessione | ricerca psicometrica / generalizability theory | media |
| Umano inter-rater, soglia di bias accettabile | SMD ≤ 0.15 (differenza media standardizzata) | Williamson, Xi & Breyer 2012 | solida |
| AI, stesso modello ripetuto (temp. fissa) | ICC ~0.94–0.99 | Hackl 2023 | solida |
| AI vs umano (accordo) | QWK moderati: gpt-4 ~0.46, gpt-3.5 ~0.43 | — | solida, ma sensibile a prompt/rubrica |
| Miglior caso GPT-4 vs umano | QWK 0.5677 (GPT-4) vs 0.6573 (rater umano 2) | — | solida |
| Auto-consistenza modelli chiusi vs aperti | o1: Spearman r=0.74, ICC=0.80; chiusi > aperti su consistenza e allineamento | studio con 37 insegnanti di riferimento | solida |
| Stabilità alla temperatura | GPT stabili; Mistral Large e Claude calano di più ad alta temperatura | — | solida |
| Open-source con few-shot | Llama 3 e Qwen2.5 raggiungono GPT-4 sull'accuratezza (Llama 3 fino a ~37× più economico), ma meno auto-consistenti | — | media |

### A.3 Le due asimmetrie che orientano il prodotto

1. **Ripetibilità ≠ accuratezza.** A versione e temperatura fissate un singolo LLM è più ripetibile di un umano (ICC 0.94–0.99 vs 0.70–0.85), ma può essere coerentemente clemente o severo: consistente con sé stesso, non necessariamente con il vero.
2. **Nessun miglioramento monotòno tra generazioni.** Cambiando famiglia (o versione) cambiano sia il livello sia i bias. L'umano ha una *riproducibilità tra strumenti* che il parco-modelli AI non ha: GPT vs Claude vs open è come cambiare strumento di misura, ciascuno con offset e derive proprie. → Da qui la **ricertificazione per versione** di `governanceModelli.md`.

### A.4 Nota sulla SMD (differenza media standardizzata)

La soglia 0.15 è **adimensionale** — una *d* di Cohen: `SMD = (M_A − M_B) / SD`, cioè la differenza tra i voti medi dei due correttori divisa per la deviazione standard dei voti (per convenzione AES, la SD dei voti umani; alcuni usano la SD pooled). Si converte in punti grezzi moltiplicando per la SD (es. SD=2 → 0.15×2 = 0.3 punti). Dipende dalla **dispersione dei voti**, non dall'ampiezza nominale della scala (su 10, su 30, su 6…).

Punto concettuale: la SMD misura **solo il bias sistematico di severità/clemenza** tra i due correttori, non l'accordo sul singolo elaborato. Due correttori possono avere SMD ≈ 0 (stessa media) e forte disaccordo caso per caso. Per l'accordo servono **QWK / ICC** — coerente con la separazione degli assi in `governanceModelli.md`.

> Cautela sul "gold standard" umano: l'idea che l'automatico eguagli l'umano (studio Hewlett/ASAP) è stata contestata (anche da Randy Bennett, ETS). Anche la baseline umana va presa con le pinze.

---

## Parte B — Panorama competitivo (ricognizione prodotti/progetti)

**Verdetto sintetico.** Non risulta un prodotto, open o closed, che combini **tutti** gli strati in un'unica piattaforma. Esistono prodotti maturi su due strati (correzione human-in-the-loop e allenamento studente); tre strati — **certificazione psicometrica per motore, griglie eseguibili/versionate, multi-motore con on-premise** — vivono quasi solo nella letteratura di ricerca o in framework generici non verticalizzati. **La cerniera tra questi è lo spazio non occupato.**

### B.1 Strato per strato

| Strato | Attori esistenti | Cosa manca per coincidere |
|---|---|---|
| **Correzione HITL + feedback** (commoditizzato) | *Closed:* CoGrader, Class Companion, Writable (Houghton Mifflin), Brisk Teaching, EssayGrader.ai, TimelyGrader, Gradescope (Turnitin), MagicSchool. *Ricerca:* GradeHITL, CHiL(L)Grader, EssayCBM | Nessuna novità da rivendicare qui |
| **Griglie "eseguibili"** (quasi solo ricerca) | RULERS (compiler–executor di rubriche in bundle versionati e immutabili); affini GUIDE, CARO | I prodotti applicano rubriche come *prompt*, non come artefatto compilato, versionato e auditabile |
| **Multi-motore + on-premise** (libero come prodotto) | Swap-modello solo in framework agentici generici (OpenRouter, ecc.); on-prem/open in codice di ricerca (LLM-AES su LLaMA3) | Nessun prodotto di grading offre la scelta del motore come funzione al cliente |
| **Certificazione psicometrica per motore** (il più distintivo) | Solo metodologia in singoli studi; il più vicino all'impianto ICC+QWK+SMD è **GradeAgentOps** | Nessun prodotto la impacchetta; la **ri-certificazione automatica a ogni cambio versione** non risulta come funzione di piattaforma da nessuna parte |
| **Marketplace compiti/griglie** | Teachers Pay Teachers, Classful, CYPHER, librerie Class Companion, import/export Google Classroom | Nessuno con **crediti chiusi** né con **quality score derivato da metriche** psicometriche |
| **Lato studente diagnostico → raccomandazione** (maturo ma scollegato) | NoRedInk, Quill.org (diagnostico → set personalizzato) | Non accoppiati a un grading multi-motore certificato lato docente |
| **Specializzazione DSA / certificati** | Sostanzialmente vuoto; al più marketing sull'accessibilità (NoRedInk) | Nessun motore di feedback dedicato e certificabile |
| **GDPR + AI Act alto rischio (EU-native)** | Checklist di governance per la valutazione ad alto rischio negli atenei italiani (Annex III); strumenti di compliance generici; i prodotti USA (CoGrader: FERPA/COPPA/SOC2) non sono GDPR/AI-Act-native | Vantaggio reale a una piattaforma **EU-native by design** |

### B.2 Dove sta il fossato

La correzione HITL e l'allenamento studente sono terreno affollato: **non** sono differenzianti. Il moat è la combinazione di: certificazione psicometrica per motore con ri-certificazione automatica **+** griglie compilate/versionate (modello RULERS) **+** multi-motore/on-prem verticalizzato sulla didattica **+** pacchetto GDPR/AI-Act-native — più economia a crediti con quality score metrico e specializzazione DSA (oggi vuote). Nessun concorrente unisce questi: i prodotti scelgono la *velocità di correzione* come messaggio, non la *certificabilità metrologica del motore*.

---

## Parte C — Riferimenti accademici citati

Elenco degli identificativi emersi nelle ricerche. **Da verificare** (alcuni sono futuri rispetto al momento della ricognizione).

- **RULERS** — arXiv 2601.08654 *(⚠️ valore allineato tra i documenti a partire dalla chat sorgente; l'identificativo resta da verificare contro arXiv — in una precedente stesura di CLAUDE.md figurava 2601.08154)*
- **GradeAgentOps** — doi.org/10.3390/ai7060198
- arXiv 2509.19329 — test–retest ICC tra modelli/temperature/prompt (ICC inter-modello 0.77–0.91 large vs 0.60–0.81 small)
- arXiv 2510.19032 — ICC + bias come differenza media segnata normalizzata
- arXiv 2601.03444 — impatto della scala di voto sull'allineamento
- arXiv 2604.03257 — certificazione statistica delle performance LLM via CMLE
- arXiv 2503.05737 — analisi classificazione alto rischio (valutazione studenti)
- GUIDE — arXiv 2603.00465
- CARO — arXiv 2603.00451
- LLM-AES (dual-process, LLaMA3) — github.com/Xiaochr/LLM-AES (LAK25)
- Dataset AES: **ASAP / ASAP++** (Hewlett, Kaggle)
