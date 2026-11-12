# Risk Assessment and Controls

Source: Final report, Section 1.2.5–1.2.9, pages 20–29.

## Scoring
**Risk = Likelihood × Impact**, with each factor from 1 (very low) to 5 (very high).

| Score | Classification |
|---|---|
| 1–4 | Low |
| 5–9 | Medium |
| 10–16 | High |
| 17–25 | Critical |

## Critical scenarios
| Scenario | Score | Control described in report |
|---|---:|---|
| AD account compromise | 20 | AD policies, Keycloak MFA |
| Unauthorized administrator use | 20 | JumpServer PAM |
| Phishing credential theft | 20 | Proxmox Mail Gateway, awareness, MFA |
| Backup destruction/tampering | 20 | Restic, separated backup zone |

## Other security controls
- Local admin password exposure → Windows LAPS.
- PKI misuse → AD CS and certificate administration.
- Malicious attachments and URLs → mail gateway and sandbox.
- Unauthorized network traffic → nftables; suspicious traffic → Suricata.
- DMZ lateral movement → network segmentation.
- Database exposure → separate database segment.
- Honeypot pivoting → quarantine segment.
- Security monitoring gaps → Wazuh SIEM; threat indicators → MISP.

## Residual risk
The report discusses residual risks qualitatively. Do not interpret the listed controls as verified proof of effectiveness; validation evidence should be attached separately.
