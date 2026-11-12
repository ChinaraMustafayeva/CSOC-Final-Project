# 15.3 — COMPLIANCE ASSESSMENT
## KONRDERK CYBERSECURITY — İnformasiya Təhlükəsizliyi üzrə Uyğunluq Qiymətləndirilməsi

| Document Information | Details |
|---|---|
| Document ID | KON-GRC-CMP-001 |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review Frequency | Annually |
| Organization | KONRDERK Cybersecurity |
| Overall Assessment | PARTIALLY COMPLIANT |

---

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

### 1.1. Məqsəd

Bu sənəd KONRDERK Cybersecurity şirkətinin informasiya təhlükəsizliyi infrastrukturunun beynəlxalq standartlara uyğunluğunu qiymətləndirir, mövcud nəzarət mexanizmlərini və təkmilləşdirmə istiqamətlərini müəyyən edir.

Qiymətləndirmənin əsas məqsədləri:

- İnfrastrukturda mövcud təhlükəsizlik nəzarətlərini müəyyən etmək;
- Nəzarətləri beynəlxalq kibertəhlükəsizlik çərçivələri ilə müqayisə etmək;
- Tam və qismən tətbiq edilmiş nəzarətləri fərqləndirmək;
- Uyğunluq boşluqlarını müəyyənləşdirmək;
- Boşluqların aradan qaldırılması üçün düzəldici tədbirlər təyin etmək;
- Hər tədbir üzrə məsul şəxsi göstərmək;
- Fərdi məlumatların emalı və qorunması prosedurlarını sənədləşdirmək;
- Ümumi uyğunluq nəticəsini təqdim etmək.

### 1.2. İstifadə olunan standartlar

Qiymətləndirmə üç çərçivə əsasında aparılmışdır:

| Framework | Version | Əsas istiqamət |
|---|---|---|
| ISO/IEC 27001 | 2022 | İnformasiya təhlükəsizliyinin idarə edilməsi və nəzarətlər |
| NIST Cybersecurity Framework | 2.0 | Kibertəhlükəsizlik risklərinin idarə edilməsi |
| CIS Controls | v8.1 | Praktiki təhlükəsizlik nəzarətləri |

### 1.3. İnfrastrukturun əhatə dairəsi

Hesabatdakı uyğunluq qiymətləndirməsinin əsas əhatə dairəsinə aşağıdakı sistemlər daxildir:

- Active Directory;
- Keycloak;
- JumpServer PAM;
- Firewall;
- Suricata;
- PostgreSQL;
- Backup infrastrukturu.

Bu komponentlər identifikasiya və giriş nəzarəti, imtiyazlı girişlərin idarə edilməsi, şəbəkə təhlükəsizliyi, monitorinq, məlumatların qorunması və bərpa imkanları baxımından qiymətləndirilmişdir.

### 1.4. Qiymətləndirmə statusları

Hesabatda iki nəzarət statusundan istifadə edilmişdir:

| Status | İzah |
|---|---|
| Implemented | Texniki tətbiqi barədə məlumat mövcuddur |
| Partial | Nəzarət qismən mövcuddur və ya tam effektivliyi təsdiqlənməyib |

**Vacib qeyd:** Bu qiymətləndirmə daxili uyğunluq analizidir və ISO/IEC 27001 sertifikatlaşdırılması hesab edilmir.

---

## 2. Standards Compliance — Standartlara Uyğunluq

### 2.1. ISO/IEC 27001:2022 üzrə qiymətləndirmə

| ISO Control | Infrastructure Evidence | Assessment |
|---|---|---|
| A.5.15 — Access Control | AD, RBAC, Keycloak | Implemented |
| A.5.17 — Authentication Information | MFA, Windows LAPS | Implemented |
| A.8.2 — Privileged Access Rights | JumpServer PAM | Implemented |
| A.8.13 — Information Backup | Restic, P2-Backup infrastrukturu | Partial |
| A.8.15 — Logging | PAM audit, sistem logları | Partial |
| A.8.20 — Network Security | nftables, Suricata, DNS Sinkhole | Implemented |

#### A.5.15 — Access Control

**Assessment: Implemented**

Layihədə giriş nəzarəti üçün aşağıdakı komponentlər mövcuddur:

- Active Directory;
- Role-Based Access Control (RBAC);
- Keycloak.

Bu komponentlər istifadəçi hesablarının və giriş hüquqlarının idarə edilməsini dəstəkləyir.

#### A.5.17 — Authentication Information

**Assessment: Implemented**

Autentifikasiya məlumatlarının qorunması üçün aşağıdakı nəzarətlər göstərilmişdir:

- MFA;
- Windows LAPS.

MFA istifadəçi autentifikasiyasına əlavə nəzarət təmin edir.

Windows LAPS lokal administrator parollarının idarə edilməsini dəstəkləyir.

#### A.8.2 — Privileged Access Rights

**Assessment: Implemented**

İmtiyazlı girişlərin idarə edilməsi üçün JumpServer PAM istifadə olunur.

PAM administrator girişlərinin mərkəzləşdirilməsi və sessiya fəaliyyətinin auditini dəstəkləyir.

Bu nəzarətin Implemented statusu PAM loglarının SIEM-ə tam inteqrasiyasının təsdiqləndiyini göstərmir. Həmin məsələ ayrıca G-01 boşluğunda qeyd edilmişdir.

#### A.8.13 — Information Backup

**Assessment: Partial**

Sübut kimi aşağıdakı infrastruktur göstərilmişdir:

- Restic;
- P2-Backup.

Backup nəzarətinin qismən uyğun qiymətləndirilməsinin səbəbi bərpa sınaqlarının və backup saxlanmasının əlavə təsdiq tələb etməsidir.

Əlaqəli boşluqlar:

- G-02 — Backup restore testləri;
- G-03 — P2-Backup saxlanma yoxlaması;
- G-08 — Retention və RPO/RTO sənədləşməsi.

#### A.8.15 — Logging

**Assessment: Partial**

Mövcud sübutlar:

- PAM audit;
- Sistem logları.

Mərkəzləşdirilmiş log inteqrasiyası və SIEM üzrə tam log əhatəsi əlavə yoxlama tələb edir.

Əlaqəli boşluqlar:

- G-01 — PAM loglarının SIEM-ə ötürülməsi;
- G-06 — SIEM log coverage.

#### A.8.20 — Network Security

**Assessment: Implemented**

Şəbəkə təhlükəsizliyi üçün aşağıdakı komponentlər göstərilmişdir:

- nftables;
- Suricata;
- DNS Sinkhole.

Bu komponentlər şəbəkə trafikinə giriş nəzarəti, təhlükə aşkarlanması və zərərli domenlərin məhdudlaşdırılmasını dəstəkləyir.

### 2.2. ISO qiymətləndirməsinin xülasəsi

| Assessment | Control Count |
|---|---:|
| Implemented | 4 |
| Partial | 2 |
| **Total** | **6** |

Bu göstəricilər yalnız hesabatda qiymətləndirilmiş altı ISO nəzarətinə aiddir; ISO/IEC 27001-in bütün tələbləri üzrə ümumi sertifikatlaşdırma nəticəsi deyil.

---

### 2.3. NIST CSF 2.0 üzrə qiymətləndirmə

| NIST CSF Function | Infrastructure Evidence | Assessment |
|---|---|---|
| Govern | GRC siyasətləri, Risk Register | Partial |
| Identify | Aktivlər və 20 riskin qeydiyyatı | Partial |
| Protect | MFA, PAM, Firewall, segmentasiya | Implemented |
| Detect | Suricata, təhlükəsizlik logları | Partial |
| Respond | Incident Response Policy | Partial |
| Recover | Restic backup, bərpa tələbləri | Partial |

#### Govern — İdarəetmə

**Assessment: Partial**

Layihədə aşağıdakı GRC sənədləri hazırlanmışdır:

- Security Policies;
- Risk Register;
- Compliance Assessment.

Bu sənədlər təşkilati təhlükəsizlik idarəetməsinin əsasını təşkil edir.

Bununla yanaşı, siyasətlərin təsdiq və illik baxış qeydləri üzrə boşluq müəyyən edilmişdir.

Əlaqəli boşluq: G-10.

#### Identify — Müəyyənləşdirmə

**Assessment: Partial**

Layihədə aktivlər və 20 informasiya təhlükəsizliyi riski qeydiyyata alınmışdır.

Risk Register hər risk üzrə aşağıdakı məlumatları ehtiva edir:

- Risk ID;
- Likelihood;
- Impact;
- Risk Score;
- Risk Owner;
- Mitigation;
- Residual Risk.

Bu funksiya hesabatda Partial olaraq qiymətləndirilmişdir.

#### Protect — Qoruma

**Assessment: Implemented**

Sübutlar:

- MFA;
- PAM;
- Firewall;
- Şəbəkə segmentasiyası.

Bu nəzarətlər autentifikasiya, imtiyazlı giriş və şəbəkə qorunmasını dəstəkləyir.

#### Detect — Aşkarlama

**Assessment: Partial**

Sübutlar:

- Suricata;
- Təhlükəsizlik logları.

Mərkəzləşdirilmiş monitorinq və log əhatəsinin tamlığı ayrıca yoxlanılmalıdır.

Əlaqəli boşluqlar: G-01 və G-06.

#### Respond — Cavab

**Assessment: Partial**

Incident Response Policy hazırlanmışdır.

Lakin insident cavab prosedurlarının praktiki sınağı əlavə tədbir kimi müəyyən edilmişdir.

Əlaqəli boşluq: G-05.

#### Recover — Bərpa

**Assessment: Partial**

Sübutlar:

- Restic backup;
- Bərpa tələbləri.

Backup restore testləri, backup saxlanması və bərpa müddətlərinin sənədləşdirilməsi əlavə təsdiq tələb edir.

Əlaqəli boşluqlar: G-02, G-03 və G-08.

### 2.4. NIST CSF qiymətləndirməsinin xülasəsi

| Assessment | Function Count |
|---|---:|
| Implemented | 1 |
| Partial | 5 |
| **Total** | **6** |

---

### 2.5. CIS Controls v8.1 üzrə qiymətləndirmə

| CIS Control | Infrastructure Evidence | Assessment |
|---|---|---|
| Controls 5–6 | Account və Access Management | Implemented |
| Control 8 | Audit Log Management | Partial |
| Control 11 | Data Recovery | Partial |
| Controls 12–13 | Network Infrastructure və Monitoring | Partial |
| Control 17 | Incident Response Management | Partial |

#### CIS Controls 5–6 — Account və Access Management

**Assessment: Implemented**

Hesabların və giriş hüquqlarının idarə edilməsi üzrə nəzarətlər tətbiq edilmiş kimi qiymətləndirilmişdir.

#### CIS Control 8 — Audit Log Management

**Assessment: Partial**

Audit logları mövcuddur, lakin mərkəzləşdirilmiş log inteqrasiyası və tam əhatənin təsdiqi tələb olunur.

Əlaqəli boşluqlar: G-01 və G-06.

#### CIS Control 11 — Data Recovery

**Assessment: Partial**

Backup infrastrukturu mövcuddur.

Bərpa testlərinin təsdiqi, backup saxlanmasının yoxlanılması və bərpa planlaşdırılması əlavə tədbirlərdir.

Əlaqəli boşluqlar: G-02, G-03 və G-08.

#### CIS Controls 12–13 — Network Infrastructure və Monitoring

**Assessment: Partial**

Şəbəkə infrastrukturu və monitorinq üzrə nəzarətlər mövcuddur.

Hesabat bu nəzarət qrupunu Partial olaraq qiymətləndirmişdir.

#### CIS Control 17 — Incident Response Management

**Assessment: Partial**

Incident Response Policy hazırlanmışdır.

Praktiki tabletop və incident response drill tədbirləri tələb olunur.

Əlaqəli boşluq: G-05.

### 2.6. CIS Controls qiymətləndirməsinin xülasəsi

| Assessment | Assessed Groups |
|---|---:|
| Implemented | 1 |
| Partial | 4 |
| **Total** | **5** |

CIS Controls 5–6 və 12–13 hesabatda qruplaşdırılmış şəkildə təqdim edildiyindən bu xülasədə də eyni qruplaşdırma saxlanılmışdır.

---

## 3. Gap Analysis — Uyğunluq Boşluqlarının Təhlili

### 3.1. Məqsəd

Gap Analysis mövcud təhlükəsizlik nəzarətləri ilə tam uyğunluq üçün tələb olunan əlavə tədbirlər arasındakı fərqləri müəyyən edir.

Hesabatda 10 uyğunluq boşluğu müəyyən edilmişdir.

Hər boşluq üçün:

- Gap ID;
- Identified Gap;
- Priority;
- Corrective Action;
- Owner

göstərilmişdir.

### 3.2. Tam Gap Analysis cədvəli

| ID | Identified Gap | Priority | Corrective Action | Owner |
|---|---|---|---|---|
| G-01 | PAM loglarının SIEM-ə ötürülməsi tamamlanmayıb | High | Mərkəzləşdirilmiş log inteqrasiyası | SOC Lead |
| G-02 | Backup restore testləri təsdiqlənməyib | High | Planlı bərpa sınaqları | System Admin |
| G-03 | P2-Backup serverində backup saxlanması yoxlanılmalıdır | High | Backup job və storage yoxlaması | System Admin |
| G-04 | PAM sessiyalarının avtomatik bağlanması yoxlanılmayıb | Medium | Session timeout testi | Security Engineer |
| G-05 | İnsident cavab prosedurlarının praktiki sınağı tələb olunur | High | Tabletop və IR drill | SOC Lead |
| G-06 | SIEM üzrə tam log əhatəsi təsdiqlənməyib | High | Log source inventory və coverage testi | SOC Lead |
| G-07 | Zəifliklərin idarə edilməsi üzrə vahid hesabat tələb olunur | Medium | Periodik vulnerability assessment | Security Engineer |
| G-08 | Backup retention və bərpa müddətləri sənədləşdirilməlidir | Medium | Retention, RPO/RTO planı | System Admin |
| G-09 | Fərdi məlumatların emalı reyestri hazırlanmalıdır | Medium | Data processing register | GRC Lead |
| G-10 | Siyasətlərin təsdiq və illik baxış qeydləri saxlanmalıdır | Medium | Policy approval register | GRC Lead |

### 3.3. G-01 — PAM loglarının SIEM-ə inteqrasiyası

**Priority:** High

**Owner:** SOC Lead

**Identified Gap:** PAM loglarının SIEM-ə ötürülməsi tamamlanmayıb.

**Corrective Action:** Mərkəzləşdirilmiş log inteqrasiyası.

JumpServer PAM üzərində audit imkanlarının olması logların SIEM-ə tam ötürüldüyünü avtomatik təsdiqləmir.

Bu boşluq PAM loglarının mərkəzləşdirilmiş təhlükəsizlik monitorinqinə inteqrasiyasının tamamlanmasını tələb edir.

### 3.4. G-02 — Backup restore testləri

**Priority:** High

**Owner:** System Admin

**Identified Gap:** Backup restore testləri təsdiqlənməyib.

**Corrective Action:** Planlı bərpa sınaqları.

Backup nüsxəsinin mövcud olması onun uğurla bərpa edilə biləcəyini təsdiqləmir.

Buna görə planlı restore testlərinin aparılması və nəticələrinin yoxlanılması tələb olunur.

### 3.5. G-03 — P2-Backup saxlanma yoxlaması

**Priority:** High

**Owner:** System Admin

**Identified Gap:** P2-Backup serverində backup saxlanması yoxlanılmalıdır.

**Corrective Action:** Backup job və storage yoxlaması.

Bu tədbir backup prosesinin və saxlama infrastrukturunun faktiki vəziyyətinin yoxlanılmasına yönəlmişdir.

### 3.6. G-04 — PAM session timeout

**Priority:** Medium

**Owner:** Security Engineer

**Identified Gap:** PAM sessiyalarının avtomatik bağlanması yoxlanılmayıb.

**Corrective Action:** Session timeout testi.

İstifadəsiz qalan imtiyazlı sessiyaların avtomatik bağlanmasının işləməsi test edilməlidir.

### 3.7. G-05 — Incident Response praktiki sınağı

**Priority:** High

**Owner:** SOC Lead

**Identified Gap:** İnsident cavab prosedurlarının praktiki sınağı tələb olunur.

**Corrective Action:** Tabletop və IR drill.

Incident Response Policy sənədinin hazırlanması prosedurların praktiki sınaqdan keçirildiyi mənasına gəlmir.

Bu boşluğun aradan qaldırılması üçün tabletop və incident response drill tədbirləri nəzərdə tutulmuşdur.

### 3.8. G-06 — SIEM log coverage

**Priority:** High

**Owner:** SOC Lead

**Identified Gap:** SIEM üzrə tam log əhatəsi təsdiqlənməyib.

**Corrective Action:** Log source inventory və coverage testi.

Log mənbələrinin siyahısı hazırlanmalı və nəzərdə tutulan mənbələrdən hadisələrin SIEM-ə çatması yoxlanılmalıdır.

### 3.9. G-07 — Vulnerability Management hesabatı

**Priority:** Medium

**Owner:** Security Engineer

**Identified Gap:** Zəifliklərin idarə edilməsi üzrə vahid hesabat tələb olunur.

**Corrective Action:** Periodik vulnerability assessment.

Bu tədbir zəifliklərin periodik qiymətləndirilməsinə və nəticələrin vahid hesabatda sənədləşdirilməsinə yönəlmişdir.

### 3.10. G-08 — Backup retention və RPO/RTO

**Priority:** Medium

**Owner:** System Admin

**Identified Gap:** Backup retention və bərpa müddətləri sənədləşdirilməlidir.

**Corrective Action:** Retention, RPO/RTO planı.

Bu plan aşağıdakı anlayışları əhatə etməlidir:

- Retention — backup nüsxələrinin saxlanma müddəti;
- RPO — bərpa nöqtəsi məqsədi;
- RTO — bərpa müddəti məqsədi.

Hesabat konkret RPO/RTO müddətlərini təqdim etmədiyi üçün bu sənəddə rəqəm uydurulmur.

### 3.11. G-09 — Data Processing Register

**Priority:** Medium

**Owner:** GRC Lead

**Identified Gap:** Fərdi məlumatların emalı reyestri hazırlanmalıdır.

**Corrective Action:** Data processing register.

Bu tədbir fərdi məlumatların emalı üzrə qeydiyyat və sənədləşdirmə boşluğunu aradan qaldırmağa yönəlmişdir.

### 3.12. G-10 — Policy Approval Register

**Priority:** Medium

**Owner:** GRC Lead

**Identified Gap:** Siyasətlərin təsdiq və illik baxış qeydləri saxlanmalıdır.

**Corrective Action:** Policy approval register.

Layihədə təhlükəsizlik siyasətlərinin hazırlanması onların rəhbərlik tərəfindən rəsmi təsdiqinin artıq tamamlandığını göstərmir.

Buna görə təsdiq və baxış qeydləri ayrıca saxlanılmalıdır.

### 3.13. Gap Analysis xülasəsi

| Priority | Number of Gaps |
|---|---:|
| High | 5 |
| Medium | 5 |
| **Total** | **10** |

High prioritetli boşluqlar:

- G-01 — PAM loglarının SIEM-ə inteqrasiyası;
- G-02 — Backup restore testləri;
- G-03 — P2-Backup saxlanma yoxlaması;
- G-05 — Incident Response praktiki sınağı;
- G-06 — SIEM log coverage.

Medium prioritetli boşluqlar:

- G-04 — PAM session timeout;
- G-07 — Vulnerability Management hesabatı;
- G-08 — Backup retention və RPO/RTO;
- G-09 — Data Processing Register;
- G-10 — Policy Approval Register.

---

## 4. Personal Data Protection — Fərdi Məlumatların Qorunması

### 4.1. Hüquqi çərçivə

KONRDERK Cybersecurity fərdi məlumatların toplanması və emalında aşağıdakı hüquqi tələbləri nəzərə alır:

- Azərbaycan Respublikasının “Fərdi məlumatlar haqqında” Qanunu;
- Tətbiq olunduğu hallarda GDPR.

Bu bölmə məlumatların emalı üçün müəyyən edilmiş təşkilati prosedurları təsvir edir.

### 4.2. Data Collection and Processing Procedure

#### 1. Purpose Limitation — Məqsədin məhdudlaşdırılması

Fərdi məlumatlar yalnız əvvəlcədən müəyyən edilmiş qanuni məqsədlər üçün toplanmalıdır.

Məlumatların emal məqsədi müəyyən edilməli və məlumatlar həmin məqsədə uyğun istifadə olunmalıdır.

#### 2. Data Minimization — Məlumatların minimuma endirilməsi

İş məqsədi üçün zəruri olmayan məlumatlar toplanmamalıdır.

Bu prinsip artıq və ehtiyac olmayan fərdi məlumatların emalını məhdudlaşdırır.

#### 3. Lawful Processing — Qanuni emal

Emal üçün müvafiq hüquqi əsas müəyyən edilməli və tələb olunan məlumatlandırma aparılmalıdır.

#### 4. Access Control — Giriş nəzarəti

Məlumatlara giriş aşağıdakı prinsiplər əsasında məhdudlaşdırılmalıdır:

- Role-Based Access Control (RBAC);
- Least Privilege.

Yalnız səlahiyyətli şəxslərin müvafiq məlumatlara girişinə icazə verilməlidir.

#### 5. Secure Storage — Təhlükəsiz saxlanma

Məlumatlar təhlükəsiz sistemlərdə saxlanılmalıdır.

Məlumatlar ötürülərkən şifrələmə tətbiq edilməlidir.

#### 6. Retention and Deletion — Saxlanma və silinmə

Məlumatların saxlanma müddətləri müəyyən edilməlidir.

Saxlanma müddəti bitmiş məlumatlar təhlükəsiz silinməlidir.

Bu prinsip G-08 və G-09 kimi sənədləşdirmə tələbləri ilə də əlaqələndirilir.

#### 7. Data Subject Rights — Məlumat subyektinin hüquqları

Tətbiq olunan qanunvericiliyə uyğun olaraq aşağıdakı müraciətlər idarə edilməlidir:

- Məlumatlara çıxış;
- Məlumatların düzəldilməsi;
- Məlumatların silinməsi.

#### 8. Breach Management — Məlumat sızmasının idarə edilməsi

Fərdi məlumatların sızması Incident Response Policy əsasında araşdırılmalıdır.

Qanunla tələb edilən bildirişlər həyata keçirilməlidir.

### 4.3. Prosedurların xülasəsi

| № | Principle | Requirement |
|---|---|---|
| 1 | Purpose Limitation | Əvvəlcədən müəyyən edilmiş qanuni məqsəd |
| 2 | Data Minimization | Yalnız zəruri məlumatların toplanması |
| 3 | Lawful Processing | Hüquqi əsas və tələb olunan məlumatlandırma |
| 4 | Access Control | RBAC və Least Privilege |
| 5 | Secure Storage | Təhlükəsiz saxlanma və şifrəli ötürülmə |
| 6 | Retention and Deletion | Saxlanma müddətləri və təhlükəsiz silinmə |
| 7 | Data Subject Rights | Çıxış, düzəliş və silinmə müraciətləri |
| 8 | Breach Management | Incident Response və hüquqi bildirişlər |

Bu tələblərin sənədləşdirilməsi fərdi məlumatların idarə edilməsində təşkilati nəzarəti dəstəkləyir.

Hesabatda ayrıca G-09 boşluğu müəyyən edildiyindən məlumatların emalı reyestrinin tamamlanması əlavə tədbir olaraq qalır.

---

## 5. Compliance Report — Uyğunluq Hesabatı

### 5.1. Ümumi qiymətləndirmə cədvəli

| Assessment Area | Result |
|---|---|
| Identity and Access Management | Implemented |
| Privileged Access Management | Partially Compliant |
| Network Security | Implemented |
| Security Monitoring and Logging | Partially Compliant |
| Backup and Recovery | Partially Compliant |
| Incident Response | Partially Compliant |
| Risk Management | Partially Compliant |
| Personal Data Governance | Partially Compliant |

### 5.2. Identity and Access Management

**Result: Implemented**

Active Directory, Keycloak və autentifikasiya nəzarətləri bu sahədə texniki tətbiqin əsasını təşkil edir.

### 5.3. Privileged Access Management

**Result: Partially Compliant**

JumpServer PAM mövcuddur.

Lakin PAM loglarının SIEM-ə ötürülməsi və sessiyaların avtomatik bağlanmasının yoxlanılması əlavə tədbir kimi müəyyən edilmişdir.

Əlaqəli boşluqlar: G-01 və G-04.

### 5.4. Network Security

**Result: Implemented**

Şəbəkə təhlükəsizliyi üzrə aşağıdakı nəzarətlər mövcuddur:

- nftables;
- Suricata;
- DNS Sinkhole.

### 5.5. Security Monitoring and Logging

**Result: Partially Compliant**

Təhlükəsizlik logları və monitorinq komponentləri mövcuddur.

SIEM üzrə tam log əhatəsi və PAM log inteqrasiyası əlavə təsdiq tələb edir.

Əlaqəli boşluqlar: G-01 və G-06.

### 5.6. Backup and Recovery

**Result: Partially Compliant**

Restic və P2-Backup infrastrukturu mövcuddur.

Bərpa sınaqları, backup saxlanmasının yoxlanılması və retention/RPO/RTO sənədləşməsi tamamlanmalı və ya təsdiqlənməlidir.

Əlaqəli boşluqlar: G-02, G-03 və G-08.

### 5.7. Incident Response

**Result: Partially Compliant**

Incident Response Policy hazırlanmışdır.

Praktiki tabletop və incident response drill sınaqları əlavə tədbir kimi müəyyən edilmişdir.

Əlaqəli boşluq: G-05.

### 5.8. Risk Management

**Result: Partially Compliant**

20 riskdən ibarət Risk Register hazırlanmışdır.

Risklərin idarə edilməsində davamlı monitorinq və düzəldici tədbirlərin izlənilməsi tələb olunur.

### 5.9. Personal Data Governance

**Result: Partially Compliant**

Fərdi məlumatların emalı prinsipləri sənədləşdirilmişdir.

Data processing register hazırlanması əlavə tədbir olaraq qalır.

Əlaqəli boşluq: G-09.

### 5.10. Overall Assessment

**PARTIALLY COMPLIANT**

KONRDERK Cybersecurity infrastrukturunda MFA, PAM, şəbəkə segmentasiyası, Firewall və IDS/IPS kimi əsas təhlükəsizlik nəzarətləri mövcuddur.

Tam uyğunluq səviyyəsinin artırılması üçün aşağıdakı istiqamətlər prioritet hesab edilir:

1. Mərkəzləşdirilmiş loglama;
2. Backup bərpa sınaqları;
3. İnsident cavab testləri;
4. Fərdi məlumatların idarə edilməsi üzrə sənədləşmə.

Müəyyən edilmiş boşluqlar 15.2 Risk Register ilə əlaqələndirilməli, düzəldici tədbirlərin icrası Information Security Manager tərəfindən izlənilməlidir.

### 5.11. Qiymətləndirmənin sərhədləri

Bu hesabatın nəticəsi daxili uyğunluq qiymətləndirməsidir.

PARTIALLY COMPLIANT statusu layihənin seçilmiş nəzarətlər üzrə ümumi nəticəsini göstərir.

Bu status:

- ISO/IEC 27001 sertifikatı deyil;
- Xarici akkreditə edilmiş auditin nəticəsi deyil;
- Bütün beynəlxalq standart tələblərinin yoxlanıldığı iddiası deyil.

---

## 6. Review and Approval — Yenilənmə və Təsdiq

### 6.1. Yenilənmə dövrü

Uyğunluq qiymətləndirilməsi ildə ən azı bir dəfə yenilənməlidir.

Bundan əlavə, aşağıdakı hallarda növbədənkənar yenilənmə aparılmalıdır:

- Mühüm infrastruktur dəyişiklikləri;
- Qanunvericilik dəyişiklikləri.

### 6.2. Məsuliyyət

Information Security Manager uyğunluq qiymətləndirməsinin yenilənməsinə və düzəldici tədbirlərin izlənilməsinə cavabdehdir.

### 6.3. Təsdiq cədvəli

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

İmza və tarix sahələri rəsmi təsdiq zamanı doldurulmalıdır.

---

## 7. Layihənin GRC Sənədləri ilə Əlaqə

| Document | Əlaqə |
|---|---|
| Security Policies | Təhlükəsizlik tələblərinin müəyyən edilməsi |
| Risk Register | Risklərin qiymətləndirilməsi və prioritetləşdirilməsi |
| Compliance Assessment | Mövcud nəzarətlərin standartlarla müqayisəsi |
| Verification Checklist | Layihə nəticələrinin yoxlanılması |

Uyğunluq qiymətləndirməsində aşkar edilmiş boşluqlar Risk Register-dəki risklər və müvafiq təhlükəsizlik siyasətləri ilə birlikdə nəzərdən keçirilməlidir.

### Əlaqəli fayllar

- [Bölmə 15 — README](README.md)
- [15.1 — Security Policies](security-policies.md)
- [15.2 — Risk Register](risk-register.md)
- [Verification Checklist](verification-checklist.md)

---

## 8. Yekun Nəticə

KONRDERK Cybersecurity CSOC layihəsinin 15.3 mərhələsində informasiya təhlükəsizliyi infrastrukturunun beynəlxalq standartlara uyğunluğu qiymətləndirilmişdir.

Qiymətləndirmə aşağıdakı çərçivələr əsasında aparılmışdır:

- ISO/IEC 27001:2022;
- NIST CSF 2.0;
- CIS Controls v8.1.

Əsas əhatə dairəsinə Active Directory, Keycloak, JumpServer PAM, Firewall, Suricata, PostgreSQL və backup infrastrukturu daxil edilmişdir.

Nəzarətlər Implemented və Partial statusları ilə qiymətləndirilmişdir.

ISO/IEC 27001:2022 üzrə altı nəzarət, NIST CSF 2.0 üzrə altı funksiya və CIS Controls v8.1 üzrə beş nəzarət qrupu qiymətləndirmədə əks olunmuşdur.

Gap Analysis nəticəsində 10 uyğunluq boşluğu müəyyən edilmişdir:

- 5 High;
- 5 Medium.

Əsas boşluqlar PAM və SIEM log inteqrasiyası, backup restore testləri, P2-Backup yoxlaması, insident cavab sınaqları, session timeout, zəifliklərin idarə edilməsi hesabatı, retention/RPO/RTO, fərdi məlumatların emalı reyestri və siyasətlərin təsdiq qeydləridir.

Fərdi məlumatların qorunması üçün Azərbaycan Respublikasının “Fərdi məlumatlar haqqında” Qanunu və tətbiq olunduğu hallarda GDPR tələbləri nəzərə alınmış, səkkiz məlumat emalı prinsipi sənədləşdirilmişdir.

Ümumi qiymətləndirmə nəticəsi:

**OVERALL ASSESSMENT: PARTIALLY COMPLIANT**

Düzəldici tədbirlər Risk Register ilə əlaqələndirilməli və Information Security Manager tərəfindən izlənilməlidir.

Uyğunluq qiymətləndirməsi ildə ən azı bir dəfə, həmçinin mühüm infrastruktur və qanunvericilik dəyişikliklərindən sonra yenilənməlidir.

---

**Document ID:** KON-GRC-CMP-001

**Version:** 1.0

**Classification:** Internal

**Owner:** Information Security Manager

**Review:** Annually

**End of Document — KON-GRC-CMP-001**
