# Analyze response fields

| Field | Type | Meaning |
|---|---|---|
| `query_id` | string | ID for feedback and audit |
| `differentials` | list | `condition`, `rank`, `confidence` (0-1, not a probability), `reasoning`, `evidence` (citations) |
| `red_flags` | list of strings | Danger signs detected |
| `investigations` | list of strings | Suggested tests |
| `treatment_guidance` | list | `priority` (high/medium/low), `recommendation`, `evidence_level`, `stg_ref` |
| `patient_education` | list of strings | Points to explain to the patient |
| `citations` | list | `source`, `title`, `section`, `year`, `jurisdiction`, `priority` (1 = Ghana STG) |
| `confidence` | number | Overall confidence 0-1 |
| `safety_status` | `safe` / `advisory` / `blocked` | `blocked` = "Emergency: refer now", set by rules, not the AI |
| `fallback_used` | boolean | `true` when the rules-based guideline matcher answered instead of the AI |
| `timestamp` | string | UTC time |
