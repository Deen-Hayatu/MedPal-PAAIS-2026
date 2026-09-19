# Architecture

## Request flow for `POST /v1/analyze`

1. **Auth and quota.** API key or session token identifies the tenant; per-tier rate limits and a monthly AI quota are enforced server side. A client's request to use the AI is a preference, never an entitlement: the tenant's plan decides.
2. **De-identification.** Patient identifiers such as names and NHIS numbers are replaced with surrogates by a local OpenMed model before any text reaches a cloud LLM, and restored in the response. If scrubbing fails, the request is answered guideline-only rather than sending raw patient data.
3. **Retrieval.** The note is embedded and searched against a ChromaDB index of the Ghana STG (259 conditions, about 1,000 chunks), blended with keyword search, then 15 candidates are reranked by a cross-encoder so the most relevant guideline passages go to the model.
4. **Synthesis.** The LLM receives the de-identified note and the retrieved guideline text and returns structured suggestions for the clinician: differentials with confidence, treatment lines with STG references, investigations, patient education.
5. **Safety.** `apply_overrides()` and `enrich()` run on every response path, AI or fallback: emergency patterns force `safety_status = "blocked"` ("Emergency: refer now"); contraindication, pregnancy, paediatric dosing, missing-vitals and low-confidence checks add warnings.
6. **Citation integrity.** Only sources that came from retrieved chunks are shown; any section or page number the model invents is dropped.
7. **Fallback.** If the LLM is disabled, unreachable or returns unparseable output, a deterministic STG keyword matcher answers (`fallback_used: true`), still cited and still passed through the safety layer.

## Deployment

- Single AWS EC2 host, Docker Compose, Caddy with automatic TLS; LLM on Amazon Bedrock in `eu-central-1`
- Pluggable LLM provider: Bedrock (production), OpenAI, or a local Ollama model for fully offline use
- Streaming: server-sent events show progress during analysis and stream copilot answers token by token
- Latency: about 11-12 seconds per full analysis; p95 budget 12 seconds, tracked per stage

## Delivery pipeline

GitLab CI on every push: lint and complexity gates, layer-dependency checks, about 95 automated tests, frontend type check and build. The Docker image is booted and smoke-tested before deploy. Production deploys pass a health check or roll back automatically.

## GhEHR integration

GhEHR's backend is a first-class API client. Per-facility settings in GhEHR control whether MedPal is on and which mode (`enhanced` = full AI; `basic` = guideline-only, no external LLM). A circuit breaker in GhEHR falls back to local NLP if MedPal is unreachable.
