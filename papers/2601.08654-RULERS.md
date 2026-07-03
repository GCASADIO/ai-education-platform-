# RULERS — From Rubrics to Reliable Scores: Evidence-Grounded Text Evaluation with LLM Judges

- **arXiv**: 2601.08654 — [abs](https://arxiv.org/abs/2601.08654) · [pdf locale](./2601.08654.pdf)
- **Autori**: Yihan Hong, Huaiyuan Yao, Bolin Shen, Wanpeng Xu, Hua Wei, Yushun Dong
- **Codice**: github.com/LabRAI/Rulers
- **Ruolo nel progetto**: paper di riferimento per le *rubriche eseguibili/versionate* (citato in `docs/presentazione.md`, `docs/statoDellArte.md`).

## Riassunto

RULERS è un framework per usare gli LLM come giudici di valutazione testuale in modo affidabile, articolato in tre stadi:

1. **Rubriche → specifiche "bloccate" (locked)**: la rubrica viene compilata in un artefatto fisso e immutabile, non lasciata come prompt in linguaggio naturale interpretabile a runtime.
2. **Esecuzione con evidenza ancorata e verifica delle citazioni**: ogni decisione di punteggio è accompagnata da evidenza strutturata (quote verificate dal testo), rendendo l'attribuzione del voto tracciabile.
3. **Calibrazione**: i punteggi vengono allineati ai confini decisionali umani.

Il framework attacca tre problemi ricorrenti del LLM-as-a-judge: **execution drift** (deriva nell'applicazione dei criteri), **attribuzione di punteggio non verificabile**, **disallineamento con gli standard umani**. Su quattro benchmark (essay scoring, summarization, writing assessment, text generation) RULERS ottiene un accordo con i punteggi umani superiore nella maggior parte dei setting e **maggiore stabilità sotto perturbazioni semanticamente equivalenti della rubrica**. Tesi centrale: la qualità del giudizio LLM dipende da criteri fissi, evidenza tracciabile e interpretazione calibrata — **non dal prompt engineering**.

## Keypoint per il progetto

- **Fondamento diretto delle "rubriche eseguibili versionate"**: RULERS dimostra empiricamente che compilare la rubrica in un artefatto bloccato (vs prompt in chiaro) riduce la variabilità e aumenta l'accordo umano. È la base tecnica del nostro differenziatore "rubriche compilate e auditabili".
- **Stabilità sotto perturbazione = affidabilità, non validità**: il guadagno di stabilità sotto riformulazioni equivalenti è una proprietà di *reliability*. Coerente col principio di progetto: non spacciarla per validità (l'accordo umano è la validità, ed è misurato separatamente).
- **Evidenza ancorata + quote verificate**: schema riusabile per l'auditabilità e per il requisito di *human-in-the-loop* e tracciabilità (AI Act / `docs/legale.md`).
- **La calibrazione ai confini umani è un offset**: coerente col principio "il bias è correggibile via offset"; la calibrazione va tenuta distinta dalla certificazione di affidabilità/validità del motore.
- **Immutabilità + versioning del bundle** si sposa con la ricertificazione automatica a ogni cambio versione del motore (`docs/governanceModelli.md`).
