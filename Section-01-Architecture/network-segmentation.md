# Network Segmentation and Traffic

Source: Final report, Section 1.1.4–1.1.6, pages 10–14.

| Zone | CIDR | Purpose |
|---|---|---|
| Identity | 192.168.100.0/24 | AD, PAM, IAM, PKI |
| Mail/Lab | 10.0.0.0/24 | Mailcow, ESG, sandbox |
| P2 WAN | 192.168.232.0/24 | Firewall external interface |
| LAN | 192.168.10.0/24 | Clients |
| DMZ | 192.168.20.0/24 | DMZ services |
| Database | 192.168.30.0/24 | Database |
| Backup | 192.168.40.0/24 | Backups |
| Quarantine | 192.168.60.0/24 | Honeypot/isolation |

## Documented communication paths
| Source | Destination | Port / protocol | Purpose |
|---|---|---|---|
| DC01 | DC02 | AD replication protocols | Domain replication |
| PAM01 | DC01 | TCP 3389 | RDP administration |
| ESG01 | MAIL01 | TCP 25 | SMTP relay |
| ESG01 | SANDBOX01 | TCP 22 | Manual analysis transfer |

## Other service ports documented in the report
- DC01/DC02: DNS 53 TCP/UDP; Kerberos 88 TCP/UDP; LDAP 389 TCP/UDP; LDAPS 636 TCP; SMB 445 TCP.
- IAM01: HTTPS 443 TCP.
- ESG01: SMTP 25 TCP; management 8006 TCP.
- P2-HONEYPOT: Cowrie SSH 2222 TCP.
- WAZUH-SIEM: SSH 22 TCP, HTTPS 443 TCP, agent 1514 TCP/UDP, enrollment 1515 TCP.
- MISP-CTI: SSH 22 TCP, HTTPS 443 TCP.

**Note:** These are documented service requirements, not proof that every firewall rule is enabled or that a complete default-deny policy was validated.
