# 1.1 — ŞƏBƏKƏ ARXİTEKTURASI VƏ SEQMENTASİYA

## Məqsəd

CSOC infrastrukturu üçün server rollarının, təhlükəsizlik zonalarının, zonalararası kommunikasiya qaydalarının və inbound/outbound portlarının müəyyənləşdirilməsi.

Arxitektura P1 — Identity & Mail Security, P2 — Network Security və P4 — SIEM & Monitoring istiqamətlərinə ayrılmışdır. Ümumilikdə 17 virtual maşın nəzərdə tutulmuşdur.

## İnfrastrukturun bölgüsü

| İstiqamət | Platforma | VM sayı | Əsas xidmətlər |
|---|---|---:|---|
| P1 | VMware Workstation | 9 | AD, PAM, IAM, PKI, Mail Security |
| P2 | VMware Workstation | 6 | Firewall, IDS/IPS, Database, Backup, Honeypot |
| P4 | Microsoft Azure, Sweden Central | 2 | Wazuh, MISP |

Şəbəkə topologiyaları hesabatda hər istiqamət üzrə ayrıca diaqramlarla təsvir edilmişdir.

## Şəbəkə zonaları

| Zona | Şəbəkə | Təyinat |
|---|---|---|
| Identity | 192.168.100.0/24 | Active Directory, PAM, IAM, PKI |
| Mail/Lab | 10.0.0.0/24 | Mailcow, ESG, Sandbox |
| P2 WAN | 192.168.232.0/24 | Firewall xarici interfeysi |
| LAN | 192.168.10.0/24 | İstifadəçi sistemləri |
| DMZ | 192.168.20.0/24 | DMZ xidmətləri |
| Database | 192.168.30.0/24 | PostgreSQL |
| Backup | 192.168.40.0/24 | Ehtiyat nüsxələr |
| Quarantine | 192.168.60.0/24 | Cowrie Honeypot |

### Identity zonası

DC01, DC02, SRV01, PAM01, CA01 və IAM01 sistemləri 192.168.100.0/24 şəbəkəsində yerləşdirilmişdir.

Bu zonada domen autentifikasiyası, replikasiya, administrator girişləri, sertifikat xidmətləri və mərkəzi kimlik idarəetməsi təşkil edilmişdir.

### Mail/Lab zonası

MAIL01, ESG01 və SANDBOX01 sistemləri 10.0.0.0/24 şəbəkəsində yerləşdirilmişdir.

Bu mühit korporativ email, təhlükəsizlik filtrasiyası, phishing aşkarlanması və laboratoriya analizini əhatə edir.

### P2 zonaları

P2 infrastrukturu LAN, DMZ, Database, Backup və Quarantine şəbəkələrinə ayrılmışdır.

Bu bölgü istifadəçi sistemləri, verilənlər bazası, ehtiyat nüsxələr və honeypot arasında təhlükəsizlik sərhədləri yaradır.

FIREWALL serveri nftables, Suricata IDS/IPS və NAT funksiyalarını yerinə yetirir.

## Zonalararası kommunikasiya

| Mənbə | Təyinat | Protokol / Port | Məqsəd |
|---|---|---|---|
| DC01 | DC02 | AD replication protokolları | Domen məlumatlarının replikasiyası |
| PAM01 | DC01 | RDP / TCP 3389 | Administrator girişi |
| ESG01 | MAIL01 | SMTP / TCP 25 | Filtrlənmiş emailin ötürülməsi |
| ESG01 | SANDBOX01 | SSH / TCP 22 | Manual analiz üçün .eml ötürülməsi |

PAM01 vasitəsilə DC01 serverinə inzibati giriş təşkil edilmiş, DC01-ə birbaşa RDP bağlantısı məhdudlaşdırılmışdır.

MAIL01 serverinin SMTP xidmətinə giriş ESG01 üzərindən təşkil edilmişdir.

ESG01 və SANDBOX01 arasında SSH əsaslı manual analiz bağlantısı istifadə edilmişdir.

## Inbound və Outbound port/protokol cədvəli

| Sistem | Port / Protokol | Trafik istiqaməti | Xidmət |
|---|---|---|---|
| DC01 / DC02 | TCP/UDP 53 | Inbound / Outbound | DNS |
| DC01 / DC02 | TCP/UDP 88 | Inbound / Outbound | Kerberos |
| DC01 / DC02 | TCP/UDP 389 | Inbound / Outbound | LDAP |
| DC01 / DC02 | TCP 636 | Inbound / Outbound | LDAPS |
| DC01 / DC02 | TCP 445 | Inbound / Outbound | SMB |
| PAM01 → DC01 | TCP 3389 | Outbound / Inbound | RDP |
| IAM01 | TCP 443 | Inbound | HTTPS, SSO |
| ESG01 | TCP 25 | Inbound | SMTP qəbulu |
| ESG01 → MAIL01 | TCP 25 | Outbound / Inbound | SMTP relay |
| ESG01 | TCP 8006 | Inbound | PMG idarəetməsi |
| ESG01 → SANDBOX01 | TCP 22 | Outbound / Inbound | SSH |
| P2-HONEYPOT | TCP 2222 | Inbound | Cowrie SSH Honeypot |
| WAZUH-SIEM | TCP 22 | Inbound | SSH |
| WAZUH-SIEM | TCP 443 | Inbound | HTTPS |
| WAZUH-SIEM | TCP/UDP 1514 | Inbound | Agent kommunikasiyası |
| WAZUH-SIEM | TCP 1515 | Inbound | Agent qeydiyyatı |
| MISP-CTI | TCP 22 | Inbound | SSH |
| MISP-CTI | TCP 443 | Inbound | HTTPS |

## Praktiki giriş məhdudiyyətləri

### PAM üzərindən RDP

PAM01 üzərindən DC01 serverinə administrator bağlantısı üçün TCP/3389 istifadə edilmişdir. DC01-ə birbaşa RDP girişinin məhdudlaşdırılması imtiyazlı idarəetmə trafikinin mərkəzləşdirilməsinə xidmət edir.

### Email SMTP trafiki

MAIL01 serverinə SMTP girişinin ESG01 vasitəsilə həyata keçirilməsi üçün firewall məhdudiyyətləri tətbiq edilmişdir.

Bağlantı testləri:
- ESG01 → MAIL01:25 — uğurlu;
- DC01 → MAIL01:25 — bloklandı.

Firewall sayğacında 5 paket və 260 bayt bloklanmış trafik qeydə alınmışdır.

### Sandbox bağlantısı

ESG01 və SANDBOX01 arasında TCP/22 üzərindən SSH bağlantısı və email nümunələrinin manual ötürülməsi istifadə edilmişdir.

## Virtualizasiya platformalarının seçimi

VMware Workstation lokal virtual maşınların yaradılması, virtual adapterlərin konfiqurasiyası və izolyasiya edilmiş laboratoriya şəbəkələrinin idarə edilməsi üçün seçilmişdir.

Microsoft Azure isə Wazuh və MISP komponentlərinin ayrıca bulud virtual maşınlarında yerləşdirilməsi üçün istifadə edilmişdir.

## İnfrastruktur xərclərinin qiymətləndirilməsi

Xərc modeli aşağıdakı kateqoriyaları əhatə edir:
- Lokal hostların hesablama resursları və elektrik sərfiyyatı;
- Windows Server lisenziyalaşdırılması;
- Ubuntu Server və açıq mənbəli texnologiyalar;
- Azure virtual maşınları;
- Bulud şəbəkəsi və saxlama resursları.

## Nəticə

CSOC üçün funksional zonalara ayrılmış şəbəkə arxitekturası hazırlanmış, 17 virtual maşının yerləşməsi və xidmət rolları müəyyən edilmişdir. Zonalararası əsas trafik istiqamətləri, portlar və protokollar sənədləşdirilmiş, PAM və email infrastrukturu üzrə giriş məhdudiyyətləri tətbiq edilmişdir.
