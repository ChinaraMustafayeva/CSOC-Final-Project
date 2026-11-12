# 1.2 — TƏHDİD MODELLƏŞDİRİLMƏSİ (THREAT MODELING)

## Məqsəd

CSOC infrastrukturu üçün qorunan aktivlərin, potensial hücum səthlərinin, etibar sərhədlərinin və mümkün hücum ssenarilərinin müəyyənləşdirilməsi.

Təhdid modelləşdirilməsi P1 — Identity & Mail Security, P2 — Network Security və P4 — SIEM & Monitoring istiqamətlərini əhatə edir.

## STRIDE metodologiyası

Layihədə STRIDE metodologiyası seçilmişdir.

| Kateqoriya | Təhdid | CSOC nümunəsi |
|---|---|---|
| Spoofing | Kimliyin saxtalaşdırılması | AD istifadəçi hesabının ələ keçirilməsi |
| Tampering | Məlumat və konfiqurasiyanın dəyişdirilməsi | Firewall qaydalarının dəyişdirilməsi |
| Repudiation | Əməliyyatın inkar edilməsi | Administrator fəaliyyətinin qeydiyyatsız qalması |
| Information Disclosure | Məxfi məlumatların açıqlanması | PostgreSQL məlumat sızması |
| Denial of Service | Xidmətin əlçatanlığının pozulması | Mail və ya SIEM resurslarının tükənməsi |
| Elevation of Privilege | Səlahiyyətlərin artırılması | Lokal administrator hüquqlarının ələ keçirilməsi |

STRIDE konkret sistem komponentlərinin və qarşılıqlı əlaqələrinin təhlili üçün seçilmişdir. Alternativ PASTA metodologiyası daha geniş biznes və hücum simulyasiyası mərhələlərinə əsaslanır.

## Qorunan aktivlər

Təhlil 17 virtual maşını əhatə edir:

- P1: DC01, DC02, SRV01, PAM01, CA01, IAM01, MAIL01, ESG01, SANDBOX01;
- P2: FIREWALL, CLIENT01, DMZ01, DB01, P2-BACKUP, P2-HONEYPOT;
- P4: WAZUH-SIEM, MISP-CTI.

Ətraflı inventar asset-inventory.md sənədində göstərilmişdir.

## Hücum səthləri

### Identity & Access Management
Active Directory, Keycloak və JumpServer istifadəçi autentifikasiyası və administrator girişlərini idarə edir. Hesabların komprometasiyası, icazəsiz imtiyazlı giriş və giriş siyasətlərinin pozulması əsas təhlükələrdir.

### Mail Security
Mailcow və Proxmox Mail Gateway phishing, saxta göndərici ünvanları, zərərli attachment və spam kampaniyaları baxımından təhlil edilmişdir.

### Network Security
Firewall, LAN, DMZ, Database və Backup zonaları arasındakı bağlantılar lateral movement və icazəsiz trafik baxımından qiymətləndirilmişdir.

### Sandbox və Honeypot
Şübhəli məzmunun analizi üçün istifadə olunan sistemlərdə izolyasiyanın pozulması və digər sistemlərə keçid riski nəzərdən keçirilmişdir.

### SIEM və Threat Intelligence
Wazuh və MISP sistemlərində logların dəyişdirilməsi, icazəsiz giriş və xidmət əlçatanlığı ilə əlaqəli risklər qiymətləndirilmişdir.

## Etibar sərhədləri

Əsas trust boundary istiqamətləri:
1. Identity və Mail/Lab şəbəkələri;
2. LAN və DMZ;
3. LAN və Database;
4. Database və Backup;
5. Quarantine və digər P2 zonaları;
6. Lokal virtualizasiya və Azure mühiti.

## Risk qiymətləndirmə metodologiyası

Risk balı aşağıdakı düsturla hesablanmışdır:

Risk = Likelihood × Impact

Ehtimal və təsir 1–5 intervalında qiymətləndirilir.

| Bal | Ehtimal | Təsir |
|---|---|---|
| 1 | Çox aşağı | Çox zəif |
| 2 | Aşağı | Zəif |
| 3 | Orta | Orta |
| 4 | Yüksək | Ciddi |
| 5 | Çox yüksək | Kritik |

| Risk balı | Risk səviyyəsi |
|---|---|
| 1–4 | Aşağı |
| 5–9 | Orta |
| 10–16 | Yüksək |
| 17–25 | Kritik |

## 18 hücum ssenarisi

| № | Hücum ssenarisi | STRIDE | Ehtimal | Təsir | Risk |
|---|---|---|---:|---:|---|
| 1 | Active Directory istifadəçi hesabının ələ keçirilməsi | Spoofing | 4 | 5 | 20 — Kritik |
| 2 | Administrator hesabının icazəsiz istifadəsi | Spoofing | 4 | 5 | 20 — Kritik |
| 3 | Domen administratoru səlahiyyətlərinin artırılması | Elevation of Privilege | 3 | 5 | 15 — Yüksək |
| 4 | Lokal administrator parolunun ələ keçirilməsi | Elevation of Privilege | 4 | 4 | 16 — Yüksək |
| 5 | Keycloak autentifikasiya mexanizminə hücum | Spoofing | 3 | 5 | 15 — Yüksək |
| 6 | PKI sertifikatlarının icazəsiz istifadəsi | Spoofing | 3 | 5 | 15 — Yüksək |
| 7 | Administrator əməliyyatlarının inkar edilməsi | Repudiation | 3 | 4 | 12 — Yüksək |
| 8 | Phishing vasitəsilə istifadəçi məlumatlarının ələ keçirilməsi | Spoofing | 5 | 4 | 20 — Kritik |
| 9 | Elektron poçt vasitəsilə zərərli faylın ötürülməsi | Tampering | 4 | 4 | 16 — Yüksək |
| 10 | Mail Gateway filtrasiya qaydalarının dəyişdirilməsi | Tampering | 3 | 4 | 12 — Yüksək |
| 11 | Firewall qaydalarının icazəsiz dəyişdirilməsi | Tampering | 3 | 5 | 15 — Yüksək |
| 12 | DMZ sistemindən daxili şəbəkəyə lateral movement | Elevation of Privilege | 3 | 5 | 15 — Yüksək |
| 13 | PostgreSQL verilənlər bazasından məlumat sızması | Information Disclosure | 3 | 5 | 15 — Yüksək |
| 14 | Backup məlumatlarının silinməsi və ya dəyişdirilməsi | Tampering | 4 | 5 | 20 — Kritik |
| 15 | Honeypot mühitindən digər sistemlərə keçid | Elevation of Privilege | 2 | 4 | 8 — Orta |
| 16 | SIEM loglarının silinməsi və ya dəyişdirilməsi | Tampering | 3 | 5 | 15 — Yüksək |
| 17 | SIEM xidmətinin əlçatmaz vəziyyətə gətirilməsi | Denial of Service | 3 | 4 | 12 — Yüksək |
| 18 | MISP təhdid göstəricilərinin dəyişdirilməsi | Tampering | 3 | 4 | 12 — Yüksək |

## Prioritet risklər

Ən yüksək risk balına malik ssenarilər:

- №1 — Active Directory hesabının ələ keçirilməsi: 20;
- №2 — Administrator hesabının icazəsiz istifadəsi: 20;
- №8 — Phishing vasitəsilə hesab məlumatlarının ələ keçirilməsi: 20;
- №14 — Backup məlumatlarının silinməsi və ya dəyişdirilməsi: 20.

Bu dörd ssenari kritik risk səviyyəsinə daxildir.

## Təhlükəsizlik nəzarətləri

| Təhdid | Müdafiə komponenti |
|---|---|
| AD hesablarının ələ keçirilməsi | Active Directory, Keycloak MFA |
| Administrator hesablarına hücum | JumpServer PAM |
| Lokal admin parollarının komprometasiyası | Windows LAPS |
| Sertifikatların saxtalaşdırılması | AD CS, PKI |
| Phishing və saxta məktublar | Proxmox Mail Gateway |
| Zərərli URL və attachment | SANDBOX01 |
| İcazəsiz şəbəkə trafiki | nftables |
| Şəbəkə hücumları | Suricata IDS/IPS |
| DMZ-dən daxili şəbəkəyə keçid | Şəbəkə seqmentasiyası |
| Verilənlər bazasına hücum | Ayrı Database zonası |
| Backup məlumatlarının itirilməsi | Restic, P2-BACKUP |
| Honeypot-dan digər sistemlərə keçid | Quarantine zonası |
| Təhlükəsizlik hadisələrinin monitorinqi | Wazuh |
| Təhdid indikatorlarının idarə olunması | MISP |

## Qalıq risklər

Müdafiə nəzarətlərindən sonra aşağıdakı risk istiqamətləri də qiymətləndirilmişdir:

- İstifadəçinin phishing mesajına aldanması;
- Administrator hesabının komprometasiyası;
- Firewall qaydalarının yanlış konfiqurasiyası;
- Backup məlumatlarının zədələnməsi;
- SIEM xidmətinin dayanması;
- Bulud idarəetmə hesablarının ələ keçirilməsi;
- Sandbox izolyasiyasının pozulması.

## Nəticə

STRIDE metodologiyası əsasında 18 potensial hücum ssenarisi hazırlanmış, hər biri ehtimal və təsir göstəriciləri üzrə qiymətləndirilmişdir. Risklər arxitekturanın konkret serverləri, təhlükəsizlik zonaları və müdafiə komponentləri ilə əlaqələndirilmişdir.
