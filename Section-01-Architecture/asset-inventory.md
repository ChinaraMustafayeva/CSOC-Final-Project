# Asset Inventory

Source: Final report, Section 1.1.3, pages 7–10.

| Group | Host | IP address | Function |
|---|---|---|---|
| P1 | DC01 | 192.168.100.10 | AD DS, DNS |
| P1 | DC02 | 192.168.100.11 | Secondary DC, replication |
| P1 | SRV01 | 192.168.100.20 | Windows member server, LAPS |
| P1 | PAM01 | 192.168.100.30 | JumpServer PAM |
| P1 | CA01 | 192.168.100.40 | AD Certificate Services / PKI |
| P1 | IAM01 | 192.168.100.50 | Keycloak SSO and MFA |
| P1 | MAIL01 | 10.0.0.102 | Mailcow |
| P1 | ESG01 | 10.0.0.103 | Proxmox Mail Gateway |
| P1 | SANDBOX01 | 10.0.0.104 | Sandbox analysis, GoPhish |
| P2 | FIREWALL | 192.168.232.18 | nftables, Suricata, NAT |
| P2 | CLIENT01 | 192.168.10.10 | Client, USBGuard, DNS filtering |
| P2 | DMZ01 | 192.168.20.10 | DMZ server |
| P2 | DB01 | 192.168.30.10 | PostgreSQL, Restic |
| P2 | P2-BACKUP | 192.168.40.10 | Backup storage |
| P2 | P2-HONEYPOT | 192.168.60.10 | Cowrie, Docker |
| P4 | WAZUH-SIEM | Azure public IP omitted | SIEM, logs, FIM |
| P4 | MISP-CTI | Azure public IP omitted | CTI and IoCs |

The original report contains the P4 public IP addresses; these are omitted here to avoid unnecessary exposure.
