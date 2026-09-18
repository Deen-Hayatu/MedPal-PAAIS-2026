# Safety and evaluation

MedPal is designed on the principle that **patient safety must not depend on model behaviour**.

## Controls enforced in code

| Risk | Control |
|---|---|
| Missed emergency | Deterministic rules force "Emergency: refer now" for emergency presentations (for example meningism with altered consciousness), whatever the LLM says |
| Invented sources | Only citations drawn from retrieved guideline text are displayed |
| Unsafe drug advice | Contraindication, pregnancy and paediatric-dosing checks on every answer |
| Overconfidence | Low-confidence answers are marked "Advisory: use judgement" |
| Patient data exposure | Identifiers removed on our own server before the LLM; guideline-only fallback if that fails; facilities can opt out of the LLM entirely |
| AI outage | Rules-based STG matcher keeps answering |

## How we test

- **Clinical vignettes in CI** - named cases (malaria, pre-eclampsia, cholera, meningitis, typhoid, tuberculosis, paediatric pneumonia, low-information notes) with expected top condition and safety status, run on every push.
- **50-case Ghana evaluation** - 50 Ghanaian clinical vignettes run against the live system whenever retrieval, reranking or prompts change, checking that the expected condition appears in the top three differentials.
- **API contract tests** - protect the GhEHR integration.
- **De-identification and LLM-hardening tests** - verify identifiers never reach the model.

## A real example

During a latency optimisation we reduced the number of retrieved passages from 15 to 8. Unit tests passed. The 50-case evaluation against production showed a repeatable regression: for an onchocerciasis (river blindness) case, the red-flag detection still worked but the treatment recommendation was wrong for an endemic condition. We reverted to 15 the same day and confirmed the fix in production, choosing treatment accuracy over about 1-1.5 seconds of speed.

## Next

Clinician ratings on each answer (1-5, with override notes) to measure real-world accuracy, and a fixed retrieval evaluation set before adding clinical entity recognition.
