# Technology Selection and Justification

Source: Final report, Section 1.1.7 and 1.3, pages 14–15 and 30–34.

| Technology | Reported role | Selection rationale |
|---|---|---|
| VMware Workstation | Local virtual lab | Flexible VM creation and isolated virtual networking on existing workstations |
| Microsoft Azure | Wazuh and MISP VMs | Separates monitoring/CTI from local lab and provides cloud VM/network management |
| Windows Server / AD DS | Domain identity | Centralized users, computers, DNS and policies |
| JumpServer | PAM | Centralized privileged access |
| Keycloak | IAM/SSO/MFA | Central identity and authentication capabilities |
| Windows LAPS | Local admin accounts | Password rotation |
| AD CS | PKI | Internal certificate services |
| Mailcow | Mail server | Integrated mail services |
| Proxmox Mail Gateway | ESG | Mail filtering and quarantine |
| GoPhish | Training simulations | Phishing simulation and results tracking |
| nftables / Suricata | Network defense | Firewall filtering and IDS/IPS |
| Wazuh | SIEM | Security event collection and alerts |
| MISP | CTI | Indicator and threat intelligence management |

## Alternatives and limitations
The report compares VMware Workstation with VirtualBox and Proxmox VE, and Azure with AWS and Google Cloud. It notes that VMware fits the team's workstation-based lab, while Azure hosts separate SIEM/CTI services.

**Compliance gap:** The assignment requests a fully cloud-based environment; the documented deployment is hybrid. The report discusses monthly cost categories but does not provide a numerical monthly total. Additional evidence is needed for a complete technical verification.
