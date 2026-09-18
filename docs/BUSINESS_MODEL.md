# Business model

## Customers

1. **Health facilities** (clinics, hospitals) - reached through GhEHR, where MedPal is bundled into facility plans.
2. **Individual clinicians** - nurses, physician assistants and doctors using the standalone app.

## Pricing (GHS per month)

| Plan | Price | AI analyses | For |
|---|---|---|---|
| Free | 0 | 3, then guideline-only | Trying it out |
| Solo | 99 | 300 | Individual clinicians |
| Practice | 399 | 1,500 pooled | Clinics, multiple users |
| Enterprise | 1,499 | 6,000 | Hospitals, with SLA |

Top-ups: GHS 50 for 100 extra analyses, prepaid like airtime. Yearly billing gives 2 months free. Payment by Mobile Money (MTN, Telecel, AirtelTigo via Paystack), recurring card, or Stripe for international customers.

MedPal is priced to sit beside GhEHR's GHS 499/month Professional plan, not above it: no clinic buys an AI add-on that costs more than its patient-records system.

## Unit economics

- AI cost per analysis: about GHS 0.11 (about 3,500 input and 1,200 output tokens on Claude Haiku 4.5)
- Measured in production: 420 analyses in 30 days cost about USD 4 of model usage
- Hosting: about USD 20/month for the MedPal server
- Worst-case gross margin (every quota unit used): Solo 67%, Practice 59%, Enterprise 56%; a 50% floor is enforced by an automated test
- Break-even on hosting: about one Practice or three Solo subscribers

## Traction

- In production since June 2026
- In clinical use at a clinic in Ghana's Northern Region through GhEHR
- Standalone app and Mobile Money billing live; standalone clinician acquisition is the next channel

## Next

Enable MedPal for each new GhEHR facility, grow the free clinician tier and convert to Solo, collect clinician ratings, and add WhatsApp access in English, Twi and Ga.
