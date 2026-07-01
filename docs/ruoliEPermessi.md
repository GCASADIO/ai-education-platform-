# Ruoli e permessi

### Modello di autorizzazione dell'app di correzione

> **Ambito.** Riguarda la sola app di correzione (non il marketplace né il lato studente adattivo). È la base del controllo accessi. Si aggancia a [`legale.md`](./legale.md) (obblighi GDPR/AI Act) e a [`governanceModelli.md`](./governanceModelli.md) (chi governa i motori e le griglie).

---

## 1. Principio di base: ruolo ≠ scope

Due assi separati, da non confondere:

- **Ruolo** — *cosa* puoi fare (l'insieme dei permessi): studente, docente, coordinatore, admin…
- **Scope** — *entro quale confine* lo fai: una consegna, una classe, una materia, l'organizzazione, il sistema.

La stessa persona può avere ruoli diversi in scope diversi (es. un docente che è anche coordinatore della propria materia). Il modello deve permettere questa composizione, con i limiti della separazione dei compiti (§5).

---

## 2. Gerarchia degli scope

```
Sistema / tenant
  └─ Organizzazione (scuola / ateneo)
       └─ Materia / dipartimento
            └─ Classe / corso
                 └─ Consegna / elaborato
```

I permessi di un ruolo valgono solo entro il proprio scope e in quelli annidati sotto di esso.

---

## 3. Ruoli principali

| Ruolo | Scope tipico | Può | Confine chiave (non può) |
|---|---|---|---|
| **Studente** | proprie consegne | Consegnare; vedere il proprio voto e feedback; esercitare i propri diritti | Vedere altri studenti o altre classi |
| **Docente** | proprie classi | Caricare/assegnare compiti; lanciare la correzione; vedere il voto proposto; **override** e validazione; configurare la griglia di classe; dare il feedback finale | Operare fuori dalle proprie classi |
| **Coordinatore didattico** | materia / dipartimento | Gestire le **griglie condivise** di materia; vedere le **metriche di coerenza** e i pattern di override in forma aggregata | Modificare i singoli voti |
| **Gestione classi** (segreteria) | organizzazione | Creare classi; iscrivere studenti; assegnare docenti alle classi | Vedere o correggere elaborati |
| **Admin configurazione** | organizzazione | Gestire i template di griglia; definire la **policy sul motore** certificato; gestire utenti e ruoli | Modificare i voti validati |
| **Admin tecnico / IT** | sistema / tenant | Deployment; connessione e aggiornamento del motore; SSO; integrazioni (LMS) | Vedere il **contenuto** degli elaborati |
| **Audit / Compliance (DPO)** | organizzazione | Leggere l'audit trail e i registri di trattamento; gestire le richieste degli interessati (accesso, cancellazione) | Modificare voti, griglie o configurazioni |

---

## 4. Ruoli dipendenti dal segmento

| Ruolo | Quando serve | Scope | Note |
|---|---|---|---|
| **Genitore / tutore** | Segmenti con minori | proprio figlio | Vede dati e feedback del figlio ed esercita i diritti GDPR per suo conto |
| **Esaminatore / 2° correttore** | Certificazioni, esami | sessione assegnata | Corregge come rater indipendente; il **doppio rating** sullo stesso elaborato alimenta la stima dell'inter-rater e il gold standard |

---

## 5. Separazione dei compiti (separation of duties)

Regola guida: **chi corregge non è chi audita; l'auditor non modifica; l'admin non vede né altera silenziosamente gli elaborati.** Non è solo igiene di sicurezza — è ciò che garantisce l'integrità dell'audit trail e quindi la difendibilità del voto (art. 22 GDPR, logging AI Act).

| Capacità sensibile | Chi la ha | Chi NON deve averla |
|---|---|---|
| **Override / decisione finale sul voto** | Docente, Esaminatore | Admin (config e IT), DPO |
| **Vedere il contenuto degli elaborati** | Studente (il proprio), Docente, Coordinatore (propria materia) | Admin IT, DPO\* |
| **Leggere l'audit trail completo** | DPO / Audit | Docente (oltre i propri), Admin IT |
| **Configurare motore e deployment** | Admin IT | Docente, Studente |
| **Modificare una correzione già validata** | nessuno — solo nuova versione tracciata | tutti |

\* Il DPO accede ai metadati e ai log del trattamento, non al contenuto pedagogico; l'accesso al contenuto è ammesso solo se necessario per evadere una specifica richiesta dell'interessato.

---

## 6. Agganci di compliance

- **Human-in-the-loop**: l'override è un permesso esclusivo dei ruoli che valutano (docente/esaminatore). Nessun ruolo amministrativo può chiudere una correzione al posto loro. Soddisfa art. 22 GDPR e sorveglianza umana AI Act.
- **Audit trail**: ogni correzione registra la terna *compito + griglia + motore/versione*, il voto proposto e l'override umano. Il ruolo DPO/Audit lo legge in sola lettura.
- **Minimizzazione per ruolo**: l'admin tecnico non vede contenuti; la segreteria non vede elaborati; il coordinatore vede metriche aggregate, non singoli voti. Ogni ruolo vede il minimo necessario (least privilege).
- **Dati dei minori**: dove presenti, il ruolo genitore/tutore e i percorsi di esercizio dei diritti vanno previsti by design.

---

## 7. Composizione dei ruoli

Un utente può cumulare ruoli (es. docente + coordinatore; oppure, in una piccola scuola, admin configurazione + gestione classi). È ammesso, **tranne** quando la combinazione rompe la separazione dei compiti nello stesso scope — in particolare *correggere* e *auditare* non vanno assegnati alla stessa persona sullo stesso perimetro. Il sistema dovrebbe segnalare queste combinazioni a rischio anziché impedirle in modo rigido, lasciando la decisione all'organizzazione con tracciamento.

---

## 8. Sintesi

Tre ruoli operativi (studente, docente, segreteria) bastano a far girare il loop; ma il modello non è completo senza i due assi di governo — **coordinatore didattico** (casa delle metriche di qualità) e **DPO/Audit** (integrità e difendibilità) — e senza lo sdoppiamento dell'amministrazione in *configurazione* e *IT*. La separazione dei compiti non è un vincolo aggiunto: è la forma che la compliance assume dentro il modello dei permessi.
