# GradeAgentOps — A Verification-First Framework for Evidence-Anchored LLM Exam Grading

- **DOI**: [10.3390/ai7060198](https://doi.org/10.3390/ai7060198) — MDPI *AI* journal, vol. 7(6), art. 198, maggio 2026
- **PDF**: non scaricabile automaticamente (MDPI blocca il fetch, HTTP 403). Scaricare a mano da [mdpi.com/2673-2688/7/6/198](https://www.mdpi.com/2673-2688/7/6/198) → "Download PDF".
- **Ruolo nel progetto**: è il lavoro più vicino al nostro impianto di **certificazione psicometrica per motore** (ICC+QWK+SMD), citato in `docs/statoDellArte.md` come punto di riferimento metodologico.

## Riassunto

GradeAgentOps è un framework "verification-first" per la correzione d'esame con LLM basata su evidenza ancorata. Non tratta la correzione come singolo passo prompt→risposta, ma come pipeline con:

- **contratti di grading stringenti** (grading contracts);
- **verifica deterministica e canonicalizzazione** delle risposte;
- **riparazione semantica limitata (bounded semantic repair)**;
- **moduli di memoria opzionali**;
- **logging provenance-aware** (tracciabilità delle decisioni).

**Valutazione**: dataset universitario di 1000 risposte aperte brevi (100 studenti × 10 domande), annotato da due grader umani esperti indipendenti; protocollo di ablazione controllata su sei configurazioni, da baseline rubric-only a varianti progressive con repair e memoria. Il riferimento umano–umano dà **ICC(2,1) = 0,678** e **QWK = 0,678** tra i due grader — il tetto contro cui misurare l'accordo del sistema.

## Keypoint per il progetto

- **Prova di esistenza della certificazione psicometrica applicata**: usa esattamente il nostro linguaggio (ICC(2,1), QWK) come metrica di accordo. Conferma la scelta metodologica del progetto.
- **Il tetto è l'accordo umano–umano, non 1.0**: ICC/QWK umano–umano ≈ 0,68 fissa il "soffitto" realistico. Un motore che eguaglia l'accordo inter-umano ha raggiunto il massimo utile — da riflettere nelle soglie di certificazione (non pretendere ICC ~0,9+ contro rater umani).
- **Verification-first ≠ modello migliore**: il guadagno viene dall'architettura (contratti, verifica, repair, provenance), non da un LLM più potente. Coerente col principio "nessun miglioramento monotono tra generazioni": l'affidabilità si costruisce attorno al motore.
- **Provenance-aware logging** = requisito riusabile per audit trail (AI Act, `docs/legale.md`) e per la ricertificazione.
- **Ablazione a sei configurazioni** = template per il nostro protocollo di certificazione comparativa (baseline vs varianti, isolando il contributo di ciascun componente).
- **Attenzione**: ICC e QWK qui coincidono (0,678) per caso sul loro dataset; restano metriche distinte (QWK = accordo ordinale pesato, ICC = affidabilità inter-rater). Non trattarle come intercambiabili nel prodotto.
