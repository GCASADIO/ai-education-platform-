# Papers — riferimenti accademici del progetto

Raccolta dei paper citati in `CLAUDE.md` e `docs/statoDellArte.md` (letteratura 2025–2026 su AI grading reliability, certificazione psicometrica, governance). Per ogni paper: PDF scaricato (dove possibile) + scheda `.md` con riassunto e **keypoint per il progetto**.

> **Verifica identificativi (2026-07-02).** Come segnalato in `docs/statoDellArte.md`, gli ID arXiv non erano stati riverificati. Verificati tutti in questa sessione. Due citazioni risultavano **errate** e sono state rimosse (paper, schede e citazioni nei docs):
> - ~~2510.19032~~ — l'ID risolveva a un paper sul dominio *salute mentale*, non coerente con l'uso previsto.
> - ~~2503.05737~~ — l'ID risolveva a un paper di *AI governance*, non a "classificazione alto rischio / valutazione studenti".
>
> Restano i **7 paper le cui citazioni combaciano**.

## Indice

| # | Paper | ID / DOI | PDF | Scheda | Rilevanza |
|---|---|---|---|---|---|
| 1 | **RULERS** — From Rubrics to Reliable Scores | [2601.08654](https://arxiv.org/abs/2601.08654) | [pdf](./2601.08654.pdf) | [scheda](./RULERS-2601.08654.md) | Rubriche eseguibili/versionate |
| 2 | **GradeAgentOps** — Verification-First LLM Exam Grading | [10.3390/ai7060198](https://doi.org/10.3390/ai7060198) | ⚠️ manuale | [scheda](./GradeAgentOps-ai7060198.md) | Certificazione psicometrica per motore (ICC/QWK) |
| 3 | Model Size, Temperature, Prompt Style vs allineamento | [2509.19329](https://arxiv.org/abs/2509.19329) | [pdf](./2509.19329.pdf) | [scheda](./2509.19329-model-size-temp-prompt.md) | ICC multi-livello; reliability ≠ validità |
| 4 | Grading Scale Impact (0–5 è la migliore) | [2601.03444](https://arxiv.org/abs/2601.03444) | [pdf](./2601.03444.pdf) | [scheda](./2601.03444-grading-scale.md) | Scala di voto come fattore di certificazione |
| 5 | LLM Performance Certification via CMLE | [2604.03257](https://arxiv.org/abs/2604.03257) | [pdf](./2604.03257.pdf) | [scheda](./2604.03257-cmle-certification.md) | Certificazione failure-rate con poche etichette umane |
| 6 | **GUIDE** — In-Context Demonstrations for Grading | [2603.00465](https://arxiv.org/abs/2603.00465) | [pdf](./2603.00465.pdf) | [scheda](./2603.00465-GUIDE.md) | Ottimizzazione esempi; casi borderline |
| 7 | **CARO** — Confusion-Aware Rubric Optimization | [2603.00451](https://arxiv.org/abs/2603.00451) | [pdf](./2603.00451.pdf) | [scheda](./2603.00451-CARO.md) | Ottimizzazione rubrica via matrice di confusione |

## Note di download

- PDF arXiv scaricati via `arxiv.org/pdf/<id>` (2026-07-02), tutti header `%PDF` validi.
- **GradeAgentOps**: MDPI blocca il fetch automatico (HTTP 403). Scaricare manualmente da [mdpi.com/2673-2688/7/6/198](https://www.mdpi.com/2673-2688/7/6/198) → "Download PDF" e salvare come `papers/GradeAgentOps-ai7060198.pdf`.

## Mappa tematica (per il progetto)

- **Rubriche eseguibili/versionate** → RULERS (1), GUIDE (6), CARO (7)
- **Certificazione psicometrica del motore** → GradeAgentOps (2), CMLE (5), Model-Size/Temp (3)
- **Affidabilità ≠ validità** (principio cardine) → Model-Size/Temp (3)
- **Bias correggibile via offset** → Grading Scale (4)
- **Configurazione come coordinata di certificazione** (scala, temperatura, esempi, rubrica) → Grading Scale (4), Model-Size/Temp (3), GUIDE (6), CARO (7)
