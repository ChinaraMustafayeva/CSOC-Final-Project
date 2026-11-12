# Cyber Security Operations Center (CSOC)

**Div Academy – Final Cybersecurity Project**

## Project Overview
This repository documents the design, implementation, security controls, monitoring, threat modeling, and governance activities of an enterprise-style Cyber Security Operations Center (CSOC).

The lab uses a hybrid architecture combining VMware Workstation virtual machines and Microsoft Azure infrastructure.

## Infrastructure Overview
- **17 virtual machines** across three project environments
- **P1 – Identity & Mail Security:** 9 VMs
- **P2 – Network Security:** 6 VMs
- **P4 – SIEM & Monitoring:** 2 Azure VMs

## Core Technologies
Active Directory, Windows LAPS, JumpServer PAM, Keycloak, Active Directory Certificate Services, Mailcow, Proxmox Mail Gateway, GoPhish, nftables, Suricata, PostgreSQL, Restic, Cowrie, Wazuh, MISP, VMware Workstation and Microsoft Azure.

## Project Documentation

| Section | Description | Documentation |
|---|---|---|
| 01 | Environment Design & Threat Modeling | [Section 01](Section-01-Architecture/README.md) |
| 02 | Identity & Access Security | To be uploaded |
| 08 | Security Operations | To be uploaded |
| 15 | Governance, Risk & Compliance | To be uploaded |

## Section 01 Deliverables
- [Architecture and threat modeling overview](Section-01-Architecture/README.md)
- [Asset inventory](Section-01-Architecture/asset-inventory.md)
- [Network segmentation](Section-01-Architecture/network-segmentation.md)
- [STRIDE threat modeling](Section-01-Architecture/threat-modeling.md)
- [Risk assessment](Section-01-Architecture/risk-assessment.md)
- [Technology selection](Section-01-Architecture/technology-selection.md)

## Security and Repository Practices
- No passwords, API keys, access tokens, or other secrets are intentionally published.
- Configuration files and scripts should be reviewed and sanitized before upload.
- Architecture decisions, implementation evidence, test results, and limitations are documented in their respective sections.

## Architecture Note
The implemented lab uses VMware Workstation for P1 and P2 and Microsoft Azure for P4. It is a hybrid deployment rather than a fully cloud-hosted environment.

## Project Status
Documentation and technical evidence are being organized by section. Items not yet uploaded should not be considered complete.

