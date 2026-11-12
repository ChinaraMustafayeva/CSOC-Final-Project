# BÖLMƏ 1 — MÜHİT DİZAYNI VƏ TƏHDİD MODELLƏMƏSİ

## 1. Ümumi məlumat

Bu bölmədə müəssisə səviyyəli Cyber Security Operations Center (CSOC) infrastrukturunun arxitekturası hazırlanmış, təhlükəsizlik xidmətləri funksiyalarına görə qruplaşdırılmış, şəbəkə seqmentləri və kommunikasiya qaydaları müəyyən edilmiş, qorunan aktivlər inventarlaşdırılmış və potensial kiberhücum ssenariləri təhlil edilmişdir.

Layihənin əsas məqsədi identifikasiya xidmətləri, imtiyazlı girişlərin idarə olunması, elektron poçt təhlükəsizliyi, şəbəkə müdafiəsi və təhlükəsizlik monitorinqi üçün bir-birini tamamlayan çoxqatlı müdafiə arxitekturası formalaşdırmaqdır.

Arxitekturanın hazırlanması zamanı aşağıdakı prinsiplər əsas götürülmüşdür:

- Təhlükəsizlik funksiyalarının ayrı sistemlərdə yerləşdirilməsi;
- Şəbəkə seqmentasiyası və təhlükəsizlik zonalarının ayrılması;
- İmtiyazlı girişlərə mərkəzləşdirilmiş nəzarət;
- Sistemlərarası kommunikasiya üçün konkret port və protokolların müəyyənləşdirilməsi;
- Təhlükələrin STRIDE metodologiyası əsasında modelləşdirilməsi;
- Texnologiya seçimlərinin funksionallıq, idarəetmə, təhlükəsizlik və resurs tələblərinə əsaslandırılması;
- Aktivlərin və risklərin sənədləşdirilməsi.

## 2. Layihənin arxitekturası

CSOC infrastrukturu üç əsas istiqamətdə təşkil edilmişdir:

| İstiqamət | Funksiya | Platforma | Virtual maşın sayı |
|---|---|---|---|
| P1 — Identity & Mail Security | Active Directory, IAM, PAM, PKI və email təhlükəsizliyi | VMware Workstation | 9 |
| P2 — Network Security | Firewall, IDS/IPS, seqmentasiya, verilənlər bazası, backup və honeypot | VMware Workstation | 6 |
| P4 — SIEM & Monitoring | Təhlükəsizlik monitorinqi və threat intelligence | Microsoft Azure | 2 |
| **Ümumi** | **CSOC infrastrukturu** | **VMware + Azure** | **17** |

P1 və P2 komponentləri lokal virtualizasiya mühitində, P4 komponentləri isə Microsoft Azure platformasının Sweden Central regionunda yerləşdirilmişdir.

Bu arxitektura identifikasiya, şəbəkə müdafiəsi, email təhlükəsizliyi və monitorinq xidmətlərinin funksional ayrılmasını təmin edir.

## 3. P1 — Identity & Mail Security

P1 infrastrukturu doqquz virtual maşından ibarətdir.

| Server | IP ünvanı | Xidmət |
|---|---|---|
| DC01 | 192.168.100.10 | Active Directory Domain Services, DNS |
| DC02 | 192.168.100.11 | Secondary Domain Controller, AD Replication |
| SRV01 | 192.168.100.20 | Windows Member Server, Windows LAPS |
| PAM01 | 192.168.100.30 | JumpServer, Privileged Access Management |
| CA01 | 192.168.100.40 | Active Directory Certificate Services, PKI |
| IAM01 | 192.168.100.50 | Keycloak, SSO, MFA |
| MAIL01 | 10.0.0.102 | Mailcow email server |
| ESG01 | 10.0.0.103 | Proxmox Mail Gateway |
| SANDBOX01 | 10.0.0.104 | Sandbox analizi, GoPhish |

### 3.1. Identifikasiya və girişlərin idarə edilməsi

DC01 və DC02 serverləri corp.local domeninin idarə olunması və Active Directory replikasiyası üçün nəzərdə tutulmuşdur.

PAM01 üzərində JumpServer vasitəsilə imtiyazlı girişlərin mərkəzləşdirilməsi həyata keçirilmişdir.

IAM01 üzərində Keycloak ilə kimlik idarəetməsi, SSO və MFA funksiyaları hazırlanmışdır.

CA01 daxili PKI və sertifikat xidmətlərini təmin edir. SRV01 üzərində Windows LAPS lokal administrator parollarının idarə olunması üçün istifadə edilmişdir.

### 3.2. Email təhlükəsizliyi

MAIL01 korporativ email serveri, ESG01 email təhlükəsizlik şlüzü, SANDBOX01 isə şübhəli məzmunun analizi və phishing simulyasiyası üçün istifadə edilmişdir.

Mailcow, Proxmox Mail Gateway, SpamAssassin, Docker Sandbox və GoPhish komponentləri çoxqatlı email təhlükəsizliyi yanaşmasını təşkil edir.

## 4. P2 — Network Security

P2 infrastrukturu altı virtual maşından ibarətdir.

| Server | IP ünvanı | Xidmət |
|---|---|---|
| FIREWALL | 192.168.232.18 | nftables, Suricata IDS/IPS, NAT |
| CLIENT01 | 192.168.10.10 | İstifadəçi sistemi, USBGuard, DNS filtering |
| DMZ01 | 192.168.20.10 | DMZ serveri |
| DB01 | 192.168.30.10 | PostgreSQL, Restic |
| P2-BACKUP | 192.168.40.10 | Ehtiyat nüsxələrin saxlanması |
| P2-HONEYPOT | 192.168.60.10 | Cowrie Honeypot, Docker |

P2 mühitində istifadəçi sistemləri, DMZ, verilənlər bazası, backup və honeypot xidmətləri ayrı şəbəkə zonalarında təşkil edilmişdir.

FIREWALL serverində nftables paket filtrasiyası və Suricata IDS/IPS texnologiyası istifadə edilmişdir.

P2-HONEYPOT ayrıca Quarantine zonasına yerləşdirilmişdir.

## 5. P4 — SIEM & Monitoring

P4 infrastrukturu Microsoft Azure üzərində iki Ubuntu Server 24.04 virtual maşınından ibarətdir.

| Server | Platforma | Xidmət |
|---|---|---|
| WAZUH-SIEM | Microsoft Azure | Wazuh SIEM, log toplama, alertlər, File Integrity Monitoring |
| MISP-CTI | Microsoft Azure | MISP, Threat Intelligence, IoC məlumatları |

Bu komponentlərin ayrıca virtual maşınlarda yerləşdirilməsi təhlükəsizlik hadisələrinin monitorinqi və threat intelligence funksiyalarının ayrılması məqsədilə seçilmişdir.

## 6. Şəbəkə seqmentasiyası

İnfrastrukturda xidmətlər funksional təyinatına görə ayrı IP diapazonlarında yerləşdirilmişdir.

| Zona | Şəbəkə | Təyinat |
|---|---|---|
| Identity | 192.168.100.0/24 | AD, PAM, IAM, PKI |
| Mail/Lab | 10.0.0.0/24 | Mailcow, ESG, Sandbox |
| P2 WAN | 192.168.232.0/24 | Firewall-un xarici interfeysi |
| LAN | 192.168.10.0/24 | İstifadəçi sistemləri |
| DMZ | 192.168.20.0/24 | DMZ xidmətləri |
| Database | 192.168.30.0/24 | Verilənlər bazası |
| Backup | 192.168.40.0/24 | Ehtiyat nüsxələr |
| Quarantine | 192.168.60.0/24 | Honeypot və izolyasiya |

Şəbəkə seqmentasiyasının əsas məqsədi müxtəlif təhlükəsizlik funksiyalarını ayırmaq, icazəsiz bağlantıları məhdudlaşdırmaq və potensial lateral movement riskini azaltmaqdır.

## 7. Zonalararası kommunikasiya

Layihədə funksional ehtiyaclara əsasən aşağıdakı əsas əlaqələr müəyyən edilmişdir:

| Mənbə | Təyinat | Protokol / Port | Məqsəd |
|---|---|---|---|
| DC01 | DC02 | AD replication protokolları | Domen məlumatlarının replikasiyası |
| PAM01 | DC01 | RDP / TCP 3389 | İmtiyazlı idarəetmə |
| ESG01 | MAIL01 | SMTP / TCP 25 | Filtrlənmiş email trafiki |
| ESG01 | SANDBOX01 | SSH / TCP 22 | Email nümunələrinin manual analiz üçün ötürülməsi |

PAM01 üzərindən DC01-ə idarəetmə girişi təşkil edilmiş, birbaşa RDP bağlantısı məhdudlaşdırılmışdır.

Email mühitində MAIL01-in SMTP portuna giriş ESG01 vasitəsilə təmin edilmişdir.

## 8. Təhdid modelləşdirilməsi

Layihədə təhlükələrin müəyyənləşdirilməsi üçün STRIDE metodologiyası əsas götürülmüşdür.

STRIDE aşağıdakı təhdid kateqoriyalarını əhatə edir:

| Kateqoriya | Təhdid |
|---|---|
| Spoofing | Kimliyin saxtalaşdırılması |
| Tampering | Məlumatların icazəsiz dəyişdirilməsi |
| Repudiation | Əməliyyatın inkar edilməsi |
| Information Disclosure | Məlumatların açıqlanması |
| Denial of Service | Xidmətin əlçatmaz vəziyyətə gətirilməsi |
| Elevation of Privilege | Səlahiyyətlərin artırılması |

Layihə üzrə 18 hücum ssenarisi müəyyən edilmişdir. Təhdidlərin ehtimalı, potensial təsiri, risk səviyyəsi və uyğun müdafiə tədbirləri ayrıca təhlil edilmişdir.

Threat Modeling fəaliyyəti aktiv inventarı, hücum səthləri və təhlükəsizlik nəzarətləri ilə əlaqələndirilmişdir.

## 9. Texnologiya seçimləri

### VMware Workstation
Lokal virtual maşınların yaradılması, fərqli əməliyyat sistemlərinin idarə olunması və izolyasiya edilmiş laboratoriya şəbəkələrinin hazırlanması üçün seçilmişdir.

Alternativ olaraq VirtualBox və Proxmox VE nəzərdən keçirilmişdir.

### Microsoft Azure
Bulud virtual maşınlarının yerləşdirilməsi, public IP ünvanlarının ayrılması və hesablama resurslarının idarə edilməsi üçün istifadə edilmişdir.

Alternativ olaraq AWS və Google Cloud Platform nəzərdən keçirilmişdir.

### Təhlükəsizlik komponentləri
Layihədə funksional ehtiyaclara uyğun olaraq Active Directory, JumpServer, Keycloak, Windows LAPS, AD CS, Mailcow, Proxmox Mail Gateway, nftables, Suricata, Cowrie, Wazuh və MISP texnologiyaları seçilmişdir.

Bu seçimlərin texniki əsaslandırılması ayrıca sənəddə təqdim edilir.

## 10. İnfrastruktur xərcləri

İnfrastruktur xərclərinin qiymətləndirilməsi zamanı aşağıdakı kateqoriyalar nəzərə alınmışdır:

- VMware Workstation üçün fiziki kompüter resursları və elektrik sərfiyyatı;
- Windows Server sistemlərinin lisenziya modeli;
- Ubuntu Server və açıq mənbəli təhlükəsizlik komponentləri;
- Microsoft Azure virtual maşınlarının hesablama resursları;
- Bulud şəbəkə və saxlama resursları.

Xərc modeli lokal virtualizasiya və bulud resurslarının fərqli maliyyələşmə xüsusiyyətlərini nəzərə alır.

## 11. Bölmənin texniki sənədləri

- [Aktiv inventarı](asset-inventory.md)
- [Şəbəkə seqmentasiyası](network-segmentation.md)
- [Təhdid modelləşdirilməsi](threat-modeling.md)
- [Risk qiymətləndirilməsi](risk-assessment.md)
- [Texnologiya seçimlərinin əsaslandırılması](technology-selection.md)

## 12. Nəticə

Bölmə 1 çərçivəsində 17 virtual maşından ibarət CSOC arxitekturası sənədləşdirilmiş, sistemlərin rolları və şəbəkə zonaları müəyyən edilmiş, əsas trafik istiqamətləri və portlar təsvir edilmişdir.

STRIDE metodologiyası ilə 18 hücum ssenarisi üzrə təhdid modelləşdirilməsi aparılmış, aktiv inventarı və risk qiymətləndirilməsi hazırlanmış, istifadə olunan texnologiyaların seçimi texniki baxımdan əsaslandırılmışdır.

Bu arxitektura layihənin sonrakı bölmələrində tətbiq edilən kimlik idarəetməsi, email təhlükəsizliyi, şəbəkə müdafiəsi və monitorinq komponentləri üçün əsas təşkil edir.
