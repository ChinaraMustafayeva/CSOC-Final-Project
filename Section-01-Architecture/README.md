# Section 01 — Environment Design & Threat Modeling

**Div Academy | CSOC Final Project**

## Scope
This section documents the CSOC environment architecture, network topology, asset inventory, segmentation, inbound/outbound service ports, STRIDE threat modeling, risk assessment, and technical decisions. The content is based on the team's submitted final report (Section 1, pages 3–34).

## Architecture overview
The reported environment comprises **17 virtual machines** across three functional groups:

| Group | VMs | Platform | Main functions |
|---|---:|---|---|
| P1 — Identity & Mail Security | 9 | VMware Workstation | AD, DNS, LAPS, PAM, PKI, SSO/MFA, Mailcow, ESG, sandbox |
| P2 — Network Security | 6 | VMware Workstation | nftables, Suricata, client, DMZ, PostgreSQL, Restic, Cowrie |
| P4 — SIEM & Monitoring | 2 | Microsoft Azure (Sweden Central) | Wazuh SIEM and MISP CTI |

**Important limitation:** This is a **hybrid lab**, not a fully cloud-hosted environment. The original project brief requires all infrastructure in cloud. This difference should be declared during assessment.

## Network diagrams
- [P1 — Identity & Mail Security](network-topology/p1-identity-mail.png)
- [P2 — Network Security](network-topology/p2-network-security.png)
- [P4 — SIEM & Monitoring](network-topology/p4-siem-monitoring.png)

## Supporting documentation
- [Asset inventory](asset-inventory.md) — all 17 virtual machines, IP addresses and functions
- [Network segmentation](network-segmentation.md) — zones and documented communications
- [Threat modeling](threat-modeling.md) — STRIDE and 18 identified threat scenarios
- [Risk assessment](risk-assessment.md) — scoring and security controls
- [Technology selection](technology-selection.md) — platform rationale and limitations

## Risk methodology
Risk score = **Likelihood (1–5) × Impact (1–5)**. Severity bands: Low 1–4, Medium 5–9, High 10–16, Critical 17–25.

## Key findings
The highest scored risks include AD account compromise, unauthorized privileged account use, phishing credential theft, and backup deletion/tampering. Proposed defenses span Keycloak MFA, JumpServer, Windows LAPS, AD CS, Proxmox Mail Gateway, nftables/Suricata, network segmentation, Restic, Wazuh and MISP.

## Evidence and caveats
Architecture figures are extracted from the submitted report. The report's descriptions are **not a substitute for independently verified live configurations**. Monthly cost categories are discussed in the report, but a numeric monthly budget is not supplied. Do not commit credentials, tokens, private keys or unredacted sensitive logs.
