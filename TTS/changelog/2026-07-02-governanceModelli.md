# Rigenerazione copione — governanceModelli

Data: 2026-07-02

## Cosa è cambiato nel sorgente

Rispetto alla versione precedentemente allineata, `docs/governanceModelli.md` ha aggiunto:

- l'**ambito** come terza coordinata di certificazione (non solo motore + configurazione, ma motore + configurazione + ambito), con badge di validità per-ambito;
- il **profilo frontier come tetto pratico** (§4): i motori frontier su dataset sintetico fissano l'asticella per il motore locale/UE, col caveat che il frontier non è ground truth;
- l'**hosting gestito** come terzo livello dell'architettura a livelli (§5), intermedio tra motori certificati e bring-your-own;
- il dettaglio esteso delle **leve di allineamento del motore al docente** (§7: rubrica/prompt, ancore few-shot, offset, fine-tuning, RLHF/DPO) e la sintesi candidata "certificare sul consenso, personalizzare con offset".

## Come si riflette nel copione

Il copione riscritto aggiunge tre passaggi narrati corrispondenti: l'ambito come coordinata che si affianca a motore e configurazione; il profilo frontier come bersaglio pratico con l'avvertenza che non è verità di riferimento; l'architettura ora a **tre** gradini (era a due) con l'hosting gestito descritto come compromesso tra controllo e libertà del cliente; e un passaggio nuovo sulle leve di allineamento e sulla proposta di certificare sul consenso e personalizzare con offset per-docente.
