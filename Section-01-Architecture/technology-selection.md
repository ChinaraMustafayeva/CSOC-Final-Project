# 1.3 — TEXNİKİ SEÇİMLƏRİN MÜDAFİƏSİ

## Məqsəd

CSOC arxitekturasında istifadə olunan texnologiyaların seçilmə səbəblərinin, alternativ həllərlə fərqlərinin, infrastruktur tələblərinə uyğunluğunun və təhlükəsizlik risklərinin əsaslandırılması.

Seçim meyarları:
- Funksional uyğunluq;
- Təhlükəsizlik imkanları;
- Quraşdırma və idarəetmə rahatlığı;
- Mövcud hesablama resurslarına uyğunluq;
- Açıq mənbəli və kommersiya həllərinin fərqləri;
- Komponentlər arasında inteqrasiya imkanları.

## 1. Virtualizasiya və bulud platformaları

### VMware Workstation

VMware Workstation P1 və P2 infrastrukturlarının lokal virtual maşınlarda yerləşdirilməsi üçün seçilmişdir.

Əsas üstünlüklər:
- Bir fiziki host üzərində müxtəlif əməliyyat sistemlərinin işlədilməsi;
- Virtual şəbəkə adapterlərinin konfiqurasiyası;
- Ayrı laboratoriya seqmentlərinin yaradılması;
- Virtual maşınların idarə olunması;
- Active Directory, PAM, IAM və şəbəkə təhlükəsizliyi sınaqları üçün uyğun mühit.

Alternativlər: VirtualBox və Proxmox VE.

VirtualBox oxşar virtualizasiya imkanları təqdim edir. VMware Workstation mövcud laboratoriya üçün virtual şəbəkələrin idarə olunması baxımından uyğun seçim olmuşdur.

Proxmox VE daha çox ayrıca virtualizasiya hostu üzərində server infrastrukturu üçün nəzərdə tutulur.

### Microsoft Azure

Microsoft Azure Wazuh və MISP xidmətlərinin bulud mühitində yerləşdirilməsi üçün seçilmişdir.

İstifadə olunan region: Sweden Central.

Azure virtual maşınları hesablama resurslarının idarə edilməsi, public IP ayrılması və bulud şəbəkə imkanlarından istifadə üçün seçilmişdir.

Alternativlər: AWS və Google Cloud Platform.

### Resurs planlaşdırılması

Layihənin texniki seçim mərhələsində Azure vCPU kvotası və virtual maşın resurslarının bölüşdürülməsi qiymətləndirilmişdir. Çoxsaylı serverlər üçün VMware Workstation, ayrıca bulud xidmətləri üçün isə Azure istifadə edilmişdir.

## 2. Identity & Access Management

### Windows Server və Active Directory

Seçilmə səbəbləri:
- Domen istifadəçilərinin mərkəzləşdirilmiş idarə olunması;
- Group Policy dəstəyi;
- Windows sistemləri ilə inteqrasiya;
- Domen autentifikasiyası;
- Domain Controller replikasiyası.

Alternativ LDAP həlləri ilə müqayisədə Active Directory Windows domen xidmətlərini və Group Policy idarəetməsini vahid mühitdə təmin edir.

### JumpServer PAM

JumpServer administrator girişlərinin mərkəzləşdirilməsi üçün seçilmişdir.

Əsas imkanlar:
- İmtiyazlı girişlərin idarə olunması;
- RDP bağlantılarının mərkəzləşdirilməsi;
- Sessiya qeydiyyatı;
- Administrator fəaliyyətinin auditi.

Daha mürəkkəb kommersiya PAM platformaları ilə müqayisədə JumpServer Community laboratoriya üçün quraşdırma və idarəetmə rahatlığı təqdim etmişdir.

### Keycloak

Keycloak SSO, MFA və mərkəzi autentifikasiya üçün seçilmişdir.

Əsas imkanlar:
- LDAP və Active Directory inteqrasiyası;
- OpenID Connect;
- Vahid giriş;
- MFA;
- Hazır idarəetmə interfeysi.

Keycloak-un seçilməsi ayrıca autentifikasiya proqramının hazırlanması ehtiyacını azaltmışdır.

### Windows LAPS

Windows LAPS lokal administrator parollarının avtomatik rotasiyası üçün seçilmişdir.

Əsas üstünlüyü Windows və Active Directory infrastrukturu ilə inteqrasiyadır.

### Active Directory Certificate Services

AD CS daxili PKI və sertifikatların mərkəzləşdirilmiş idarə edilməsi üçün seçilmişdir.

Bu texnologiya daxili HTTPS xidmətlərinin sertifikat təminatında istifadə edilmişdir.

## 3. Mail Security və Sandbox

### Mailcow

Mailcow korporativ email serverinin qurulması üçün seçilmişdir.

Seçilmə səbəbləri:
- Docker əsaslı arxitektura;
- Vahid idarəetmə interfeysi;
- Email xidmətlərinin mərkəzləşdirilmiş idarə olunması;
- SOGo veb poçt interfeysi.

### Proxmox Mail Gateway

PMG spam, phishing və zərərli email məzmununun filtrasiyası üçün seçilmişdir.

Mailcow-dan ayrıca yerləşdirilməsi email mesajlarının əsas poçt serverinə çatmazdan əvvəl yoxlanması üçün əlavə təhlükəsizlik qatı yaradır.

### Docker Sandbox

Docker Sandbox şübhəli məzmunun izolyasiya olunmuş mühitdə analizi üçün seçilmişdir.

Tam virtual maşın əsaslı analiz mühitləri ilə müqayisədə konteynerlər daha az resurs tələb edir və laboratoriya mühitinin daha sürətli hazırlanmasına imkan verir.

### GoPhish

GoPhish phishing simulyasiyası və istifadəçi davranışlarının qiymətləndirilməsi üçün seçilmişdir.

Əsas üstünlüklər:
- Kampaniya idarəetməsi;
- Email şablonları;
- Landing page;
- İstifadəçi qarşılıqlı əlaqələrinin izlənilməsi;
- CSV formatında nəticələrin ixracı.

## 4. Network Security

### nftables

nftables Linux əsaslı paket filtrasiyası və firewall qaydalarının idarə olunması üçün seçilmişdir.

Linux nüvəsi ilə inteqrasiyası və çevik qayda strukturu şəbəkə seqmentasiyası üçün uyğun olmuşdur.

### Suricata

Suricata IDS/IPS funksiyalarını təmin etmək üçün seçilmişdir.

Alternativ: Snort.

Suricata-nın çoxaxınlı trafik emalı və geniş protokol analizi imkanları seçimdə əsas üstünlüklərdən olmuşdur.

### PostgreSQL

PostgreSQL verilənlər bazası xidməti üçün seçilmişdir.

Seçilmə səbəbləri:
- Açıq mənbəli platforma;
- Verilənlər bazasının idarə olunması;
- Etibarlı məlumat saxlama imkanları.

### Restic

Restic ehtiyat nüsxələrin yaradılması üçün seçilmişdir.

Əsas imkanlar:
- Şifrələnmiş backup;
- İnkremental ehtiyat nüsxələmə;
- Məlumatların qorunması.

### Cowrie Honeypot

Cowrie SSH əsaslı hücum cəhdlərinin müşahidəsi üçün seçilmişdir.

Hazır emulyasiya və hadisə qeydiyyatı imkanları ayrıca honeypot proqramının hazırlanması ehtiyacını azaltmışdır.

## 5. Monitorinq və Threat Intelligence

### Wazuh

Wazuh təhlükəsizlik hadisələrinin toplanması, alertlərin yaradılması və File Integrity Monitoring üçün seçilmişdir.

Kommersiya SIEM həlləri ilə müqayisədə açıq mənbəli olması və agent əsaslı monitorinq imkanları əsas seçim səbəbləridir.

### MISP

MISP komprometasiya indikatorlarının və threat intelligence məlumatlarının idarə olunması üçün seçilmişdir.

Əsas imkanlar:
- IoC məlumatlarının saxlanması;
- Təhdid göstəricilərinin idarə olunması;
- Müxtəlif threat intelligence mənbələri ilə işləmə;
- Təhdid məlumatlarının sistemləşdirilməsi.

## 6. Təhlükəsizlik riskləri və müdafiə yanaşmaları

| Texnologiya | Əsas təhlükəsizlik riski | Müdafiə yanaşması |
|---|---|---|
| Active Directory | Hesabların ələ keçirilməsi və səlahiyyət artırılması | Giriş siyasətləri, PAM, LAPS |
| JumpServer | İmtiyazlı sessiyalara icazəsiz giriş | Mərkəzləşdirilmiş giriş, sessiya qeydiyyatı |
| Keycloak | Autentifikasiya məlumatlarının komprometasiyası | MFA, təhlükəsiz autentifikasiya |
| Mailcow | Phishing və zərərli email | Proxmox Mail Gateway |
| Docker Sandbox | Konteynerdən kənara çıxış | Şəbəkə izolyasiyası, konteyner məhdudiyyətləri |
| nftables / Suricata | Yanlış qaydalar və aşkarlanmayan trafik | Firewall siyasətləri, IDS/IPS |
| PostgreSQL / Restic | Məlumat itkisi və icazəsiz giriş | Ayrı zona, şifrələnmiş backup |
| Wazuh / MISP | İdarəetmə interfeyslərinə icazəsiz giriş | Giriş məhdudiyyətləri, HTTPS |

## 7. Arxitektura ilə uyğunluq

Seçilmiş texnologiyalar funksiyalarına görə müxtəlif müdafiə qatlarında yerləşdirilmişdir:

- Identity Security — Active Directory, JumpServer, Keycloak, LAPS, AD CS;
- Mail Security — Mailcow, Proxmox Mail Gateway, Docker Sandbox, GoPhish;
- Network Security — nftables, Suricata, PostgreSQL, Restic, Cowrie;
- Monitoring və Threat Intelligence — Wazuh, MISP.

Bu yanaşma təhlükəsizlik funksiyalarının ayrıca komponentlər üzərində təşkil edilməsinə və müxtəlif hücum səthlərinin fərqli nəzarətlərlə qorunmasına imkan verir.

## Nəticə

Layihədə texnologiya seçimləri funksional tələblər, resurslardan səmərəli istifadə, idarəetmə rahatlığı, təhlükəsizlik imkanları və inteqrasiya uyğunluğu əsasında əsaslandırılmışdır.

VMware Workstation və Microsoft Azure, Active Directory və Keycloak, JumpServer, Mailcow, Proxmox Mail Gateway, nftables, Suricata, Wazuh və MISP kimi komponentlərin seçilməsi çoxqatlı CSOC arxitekturasının formalaşdırılmasına xidmət etmişdir.
