# 1.2.3 — ASSET INVENTORY: QORUNAN AKTİVLƏRİN İNVENTARI

## 1. Məqsəd və əhatə dairəsi

CSOC infrastrukturunun təhlükəsizlik arxitekturası və təhdid modelləşdirilməsi çərçivəsində qorunan informasiya aktivlərinin inventarı hazırlanmışdır.

Aktiv inventarının məqsədi infrastrukturda yerləşən serverləri, onların funksiyalarını, saxladıqları və emal etdikləri məlumatları, şəbəkə zonalarını və təhlükəsizlik baxımından kritikliyini müəyyənləşdirməkdir.

Bu inventar STRIDE əsaslı təhdid modelləşdirilməsi və risklərin qiymətləndirilməsi üçün əsas məlumat mənbələrindən biridir.

İnventar üç əsas istiqaməti əhatə edir:

- P1 — Identity & Mail Security;
- P2 — Network Security;
- P4 — SIEM & Monitoring.

Layihə arxitekturasında ümumilikdə 17 virtual maşın müəyyən edilmişdir.

## 2. Aktivlərin kritiklik səviyyələri

Hesabatda aktivlər funksional əhəmiyyətinə və mümkün təhlükəsizlik təsirlərinə əsasən üç səviyyədə təsnifləşdirilmişdir.

| Kritiklik | İzah |
|---|---|
| Kritik | Komprometasiya və ya dayanma halında əsas təhlükəsizlik, autentifikasiya, şəbəkə və ya məlumat xidmətlərinə ciddi təsir göstərə bilən aktiv |
| Yüksək | Korporativ xidmətlərin təhlükəsizliyinə və əlçatanlığına əhəmiyyətli təsir göstərə bilən aktiv |
| Orta | Laboratoriya, istifadəçi və müşahidə funksiyalarını yerinə yetirən, lakin ayrıca təhlükəsizlik nəzarəti tələb edən aktiv |

Kritiklik səviyyələri risklərin prioritetləşdirilməsi və müdafiə tədbirlərinin seçilməsi üçün istifadə olunur.

## 3. P1 — Identity & Mail Security aktivləri

P1 infrastrukturu VMware Workstation mühitində yerləşən doqquz virtual maşından ibarətdir.

### 3.1. Aktiv inventarı

| Aktiv | IP ünvanı | Əsas funksiya | Kritiklik |
|---|---|---|---|
| DC01 | 192.168.100.10 | Active Directory Domain Services, DNS | Kritik |
| DC02 | 192.168.100.11 | Secondary Domain Controller, AD Replication | Kritik |
| SRV01 | 192.168.100.20 | Windows Member Server, lokal administrator hesabları, Windows LAPS | Yüksək |
| PAM01 | 192.168.100.30 | JumpServer və imtiyazlı girişlərin idarə edilməsi | Kritik |
| CA01 | 192.168.100.40 | Sertifikatların verilməsi, Active Directory Certificate Services, PKI | Kritik |
| IAM01 | 192.168.100.50 | Keycloak, SSO, MFA və mərkəzi kimlik idarəetməsi | Kritik |
| MAIL01 | 10.0.0.102 | Mailcow, email xidmətləri və poçt məlumatları | Yüksək |
| ESG01 | 10.0.0.103 | Proxmox Mail Gateway, spam və phishing filtrasiyası | Yüksək |
| SANDBOX01 | 10.0.0.104 | Sandbox analizi və GoPhish simulyasiyası | Orta |

### 3.2. Active Directory aktivləri — DC01 və DC02

DC01 və DC02 corp.local domeninin əsas identifikasiya komponentləridir.

Bu serverlər aşağıdakı xidmətləri əhatə edir:
- Domen autentifikasiyası;
- Active Directory obyektləri və istifadəçi hesabları;
- DNS xidməti;
- Domain Controller replikasiyası;
- Domen səviyyəli giriş və idarəetmə mexanizmləri.

Hər iki Domain Controller kritik aktiv kimi qiymətləndirilmişdir.

Bu sistemlərin komprometasiyası istifadəçi identifikasiyasına, domen resurslarına girişə və inzibati təhlükəsizlik nəzarətlərinə ciddi təsir göstərə bilər.

### 3.3. SRV01 — Windows Member Server

SRV01 domenə qoşulmuş Windows serveridir və Windows LAPS ilə lokal administrator hesablarının idarə olunmasını əhatə edir.

Kritiklik səviyyəsi: Yüksək.

Bu aktivin qorunması lokal administrator parollarının təhlükəsiz idarə olunması və domenə qoşulmuş serverlərin inzibati girişlərinin məhdudlaşdırılması baxımından əhəmiyyətlidir.

### 3.4. PAM01 — Privileged Access Management

PAM01 üzərində JumpServer yerləşdirilmişdir.

Əsas funksiyalar:
- İmtiyazlı administrator girişlərinin mərkəzləşdirilməsi;
- Serverlərə idarəetmə bağlantılarının nəzarətdə saxlanması;
- Administrator sessiyalarının audit edilməsi;
- Birbaşa inzibati girişlərin məhdudlaşdırılması.

Kritiklik səviyyəsi: Kritik.

PAM platformasının təhlükəsizliyi administrator sessiyalarının və yüksək səlahiyyətli girişlərin qorunması üçün mühüm əhəmiyyət daşıyır.

### 3.5. CA01 — PKI infrastrukturu

CA01 üzərində Active Directory Certificate Services istifadə olunur.

Əsas funksiyalar:
- Daxili sertifikatların verilməsi;
- PKI xidmətlərinin idarə olunması;
- Daxili HTTPS xidmətlərinin sertifikat təminatı.

Kritiklik səviyyəsi: Kritik.

Sertifikat infrastrukturunun qorunması sistemlər arasında etibarlı şifrəli bağlantıların saxlanması üçün vacibdir.

### 3.6. IAM01 — Kimlik və autentifikasiya

IAM01 üzərində Keycloak platforması istifadə olunur.

Əsas funksiyalar:
- Mərkəzi kimlik idarəetməsi;
- Single Sign-On;
- Multi-Factor Authentication;
- Active Directory ilə inteqrasiya.

Kritiklik səviyyəsi: Kritik.

IAM sisteminə qarşı hücumlar istifadəçi autentifikasiyasına və inteqrasiya olunmuş xidmətlərə girişin təhlükəsizliyinə təsir göstərə bilər.

### 3.7. MAIL01, ESG01 və SANDBOX01

Email təhlükəsizliyi üç ayrıca aktiv üzərində təşkil edilmişdir.

MAIL01:
- Mailcow email xidmətləri;
- Korporativ poçt qutuları;
- Email məlumatlarının emalı.

Kritiklik: Yüksək.

ESG01:
- Proxmox Mail Gateway;
- Spam və phishing filtrasiyası;
- Email trafikinin təhlükəsizlik yoxlanması.

Kritiklik: Yüksək.

SANDBOX01:
- Şübhəli məzmunun analizi;
- Docker əsaslı laboratoriya mühiti;
- GoPhish phishing simulyasiyası.

Kritiklik: Orta.

## 4. P2 — Network Security aktivləri

P2 infrastrukturu VMware Workstation üzərində yerləşən altı virtual maşından ibarətdir.

| Aktiv | IP ünvanı | Əsas funksiya | Kritiklik |
|---|---|---|---|
| FIREWALL | 192.168.232.18 | nftables, Suricata IDS/IPS, NAT | Kritik |
| CLIENT01 | 192.168.10.10 | İstifadəçi sistemi, USBGuard, DNS filtering | Orta |
| DMZ01 | 192.168.20.10 | DMZ zonasındakı xidmətlər | Yüksək |
| DB01 | 192.168.30.10 | PostgreSQL verilənlər bazası, Restic | Kritik |
| P2-BACKUP | 192.168.40.10 | Ehtiyat nüsxələrin saxlanması | Kritik |
| P2-HONEYPOT | 192.168.60.10 | Cowrie Honeypot, Docker | Orta |

### 4.1. FIREWALL

FIREWALL serveri şəbəkə trafikinin idarə edilməsi və təhlükəsizlik yoxlamaları üçün istifadə olunur.

Texnologiyalar:
- nftables;
- Suricata IDS/IPS;
- NAT.

Kritiklik səviyyəsi: Kritik.

Bu aktiv şəbəkə seqmentləri arasındakı trafikə nəzarət və müdafiə mexanizmləri baxımından əsas komponentlərdən biridir.

### 4.2. CLIENT01

CLIENT01 istifadəçi iş stansiyası və endpoint təhlükəsizlik sınaqları üçün nəzərdə tutulmuşdur.

Əlaqəli komponentlər:
- USBGuard;
- DNS filtering;
- İstifadəçi mühiti.

Kritiklik səviyyəsi: Orta.

### 4.3. DMZ01

DMZ01 ayrıca DMZ zonasının serveridir.

Kritiklik səviyyəsi: Yüksək.

DMZ-nin daxili şəbəkədən ayrılması internetə və digər zonalara yönələn xidmətlər üçün ayrıca təhlükəsizlik sərhədi formalaşdırır.

### 4.4. DB01

DB01 PostgreSQL verilənlər bazası üçün ayrılmış serverdir.

Əlaqəli texnologiyalar:
- PostgreSQL;
- Restic.

Kritiklik səviyyəsi: Kritik.

Verilənlər bazasının məxfiliyi, bütövlüyü və əlçatanlığı əsas qorunma prioritetlərindəndir.

### 4.5. P2-BACKUP

P2-BACKUP ehtiyat nüsxələrin ayrıca şəbəkə seqmentində saxlanması üçün istifadə olunur.

Kritiklik səviyyəsi: Kritik.

Ehtiyat nüsxələrin əsas sistemlərdən ayrılması məlumat itkisi və xidmətlərin dayanması risklərinin idarə edilməsində əhəmiyyətli rol oynayır.

### 4.6. P2-HONEYPOT

P2-HONEYPOT üzərində Cowrie Honeypot və Docker istifadə olunur.

Sistem Quarantine zonasına ayrılmışdır.

Əsas təyinatı hücum davranışlarının müşahidəsi və şübhəli fəaliyyətin izolyasiya olunmuş mühitdə izlənməsidir.

Kritiklik səviyyəsi: Orta.

## 5. P4 — SIEM & Monitoring aktivləri

P4 infrastrukturu Microsoft Azure platformasının Sweden Central regionunda yerləşən iki Ubuntu Server 24.04 virtual maşınından ibarətdir.

| Aktiv | Platforma | Əsas funksiya | Kritiklik |
|---|---|---|---|
| WAZUH-SIEM | Microsoft Azure | Təhlükəsizlik hadisələrinin toplanması və monitorinqi | Kritik |
| MISP-CTI | Microsoft Azure | Təhdid kəşfiyyatı və IoC məlumatlarının idarə olunması | Yüksək |

### 5.1. WAZUH-SIEM

WAZUH-SIEM təhlükəsizlik hadisələrinin toplanması, təhlili və xəbərdarlıqların yaradılması üçün nəzərdə tutulmuşdur.

Əsas funksiyalar:
- Təhlükəsizlik loglarının toplanması;
- Hadisələrin monitorinqi;
- Alertlərin idarə edilməsi;
- File Integrity Monitoring.

Kritiklik səviyyəsi: Kritik.

### 5.2. MISP-CTI

MISP-CTI təhdid kəşfiyyatı məlumatlarının və komprometasiya indikatorlarının idarə edilməsi üçün istifadə olunur.

Əsas funksiyalar:
- Threat Intelligence məlumatları;
- Indicators of Compromise;
- Təhdid göstəricilərinin sistemləşdirilməsi.

Kritiklik səviyyəsi: Yüksək.

## 6. Şəbəkə zonaları üzrə aktivlərin yerləşdirilməsi

| Zona | IP diapazonu | Əlaqəli aktivlər |
|---|---|---|
| Identity | 192.168.100.0/24 | DC01, DC02, SRV01, PAM01, CA01, IAM01 |
| Mail/Lab | 10.0.0.0/24 | MAIL01, ESG01, SANDBOX01 |
| P2 WAN | 192.168.232.0/24 | FIREWALL-un xarici interfeysi |
| LAN | 192.168.10.0/24 | CLIENT01 |
| DMZ | 192.168.20.0/24 | DMZ01 |
| Database | 192.168.30.0/24 | DB01 |
| Backup | 192.168.40.0/24 | P2-BACKUP |
| Quarantine | 192.168.60.0/24 | P2-HONEYPOT |

P4 komponentləri Microsoft Azure mühitində ayrıca yerləşdirilmişdir.

## 7. Qorunan informasiya və xidmət kateqoriyaları

Aktiv inventarı yalnız virtual maşınları deyil, həmin sistemlərin qoruduğu informasiya və xidmətləri də əhatə edir.

| Kateqoriya | Əlaqəli aktivlər | Qorunan resurs |
|---|---|---|
| Kimlik və autentifikasiya | DC01, DC02, IAM01 | İstifadəçi hesabları və autentifikasiya xidmətləri |
| İmtiyazlı giriş | PAM01, SRV01 | Administrator girişləri və lokal admin hesabları |
| Sertifikat infrastrukturu | CA01 | Daxili sertifikat xidmətləri |
| Elektron poçt | MAIL01, ESG01 | Poçt qutuları, email trafiki və filtrasiya |
| Şübhəli məzmun analizi | SANDBOX01 | Laboratoriya email və phishing nümunələri |
| Şəbəkə təhlükəsizliyi | FIREWALL | Trafik filtrasiyası və IDS/IPS |
| İstifadəçi sistemi | CLIENT01 | Endpoint və istifadəçi mühiti |
| DMZ xidmətləri | DMZ01 | Ayrılmış DMZ resursları |
| Verilənlər bazası | DB01 | PostgreSQL məlumatları |
| Ehtiyat nüsxələr | P2-BACKUP | Backup məlumatları |
| Hücum müşahidəsi | P2-HONEYPOT | Honeypot müşahidə məlumatları |
| Təhlükəsizlik monitorinqi | WAZUH-SIEM | Təhlükəsizlik hadisələri və audit məlumatları |
| Təhdid kəşfiyyatı | MISP-CTI | IoC və CTI məlumatları |

## 8. Aktiv inventarı və təhdid modelləşdirilməsi

Aktiv inventarı STRIDE metodologiyası əsasında aparılmış təhdid modelləşdirilməsinin ilkin mərhələsini təşkil edir.

Aktivlər müəyyən edildikdən sonra aşağıdakı istiqamətlər qiymətləndirilmişdir:
- Kimliyin saxtalaşdırılması;
- Məlumatların icazəsiz dəyişdirilməsi;
- Əməliyyatların inkar edilməsi;
- Məlumatların açıqlanması;
- Xidmətin əlçatmaz vəziyyətə gətirilməsi;
- Səlahiyyətlərin artırılması.

Kritik aktivlərə qarşı hücumların mümkün nəticələri:
- Domen autentifikasiyasının dayanması;
- İmtiyazlı girişlərin ələ keçirilməsi;
- Sertifikat infrastrukturunun təhlükəyə məruz qalması;
- Verilənlər bazası və ehtiyat nüsxələrə təsir;
- Şəbəkə müdafiəsi və təhlükəsizlik monitorinqinin zəifləməsi.

Bu səbəbdən kritik aktivlər risk qiymətləndirilməsində xüsusi diqqət mərkəzində saxlanılmışdır.

## 9. Yekun göstəricilər

| Göstərici | Say |
|---|---|
| Ümumi virtual maşın | 17 |
| P1 aktivləri | 9 |
| P2 aktivləri | 6 |
| P4 aktivləri | 2 |
| Kritik aktivlər | 8 |
| Yüksək kritiklikli aktivlər | 6 |
| Orta kritiklikli aktivlər | 3 |

## 10. Nəticə

CSOC infrastrukturu üzrə 17 virtual maşını əhatə edən aktiv inventarı hazırlanmışdır. Hər aktivin funksiyası, şəbəkə yerləşməsi və təhlükəsizlik kritikliyi müəyyən edilmişdir.

İnventar əsasında əsas identifikasiya, giriş idarəetməsi, sertifikat, email, şəbəkə, verilənlər bazası, backup, monitorinq və threat intelligence xidmətləri sistemləşdirilmişdir.

Hazırlanmış aktiv inventarı STRIDE əsaslı təhdid modelləşdirilməsi, hücum ssenarilərinin qiymətləndirilməsi və risklərin prioritetləşdirilməsi üçün əsas təşkil edir.
