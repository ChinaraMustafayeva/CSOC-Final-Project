# STRIDE Threat Modeling

Source: Final report, Section 1.2, pages 16–30.

## Methodology
STRIDE: **S**poofing, **T**ampering, **R**epudiation, **I**nformation Disclosure, **D**enial of Service, **E**levation of Privilege.

## 18 identified threat scenarios
| # | Threat | STRIDE | Likelihood | Impact | Score |
|---|---|---|---:|---:|---:|
| 1 | Active Directory account compromise | Spoofing | 4 | 5 | 20 |
| 2 | Unauthorized administrator account use | Spoofing | 4 | 5 | 20 |
| 3 | Domain administrator privilege escalation | Elevation of Privilege | 3 | 5 | 15 |
| 4 | Local administrator password compromise | Elevation of Privilege | 4 | 4 | 16 |
| 5 | Keycloak authentication attack | Spoofing | 3 | 5 | 15 |
| 6 | Unauthorized PKI certificate use | Spoofing | 3 | 5 | 15 |
| 7 | Administrator action repudiation | Repudiation | 3 | 4 | 12 |
| 8 | Phishing-based credential theft | Spoofing | 5 | 4 | 20 |
| 9 | Malicious email attachment delivery | Tampering | 4 | 4 | 16 |
| 10 | Mail gateway filtering rule modification | Tampering | 3 | 4 | 12 |
| 11 | Unauthorized firewall rule modification | Tampering | 3 | 5 | 15 |
| 12 | Lateral movement from DMZ to internal network | Elevation of Privilege | 3 | 5 | 15 |
| 13 | PostgreSQL data leakage | Information Disclosure | 3 | 5 | 15 |
| 14 | Backup deletion or tampering | Tampering | 4 | 5 | 20 |
| 15 | Pivoting from honeypot to other systems | Elevation of Privilege | 2 | 4 | 8 |
| 16 | SIEM log deletion or modification | Tampering | 3 | 5 | 15 |
| 17 | SIEM service disruption | Denial of Service | 3 | 4 | 12 |
| 18 | MISP threat indicator modification | Tampering | 3 | 4 | 12 |

These are analytical risk estimates from the report, not measured incident probabilities.
