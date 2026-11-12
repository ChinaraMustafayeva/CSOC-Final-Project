# BÖLMƏ 15 — GOVERNANCE, RISK & COMPLIANCE (GRC)

## 1. Ümumi məlumat

Bu bölmədə KONRDERK Cybersecurity CSOC layihəsinin informasiya təhlükəsizliyinin idarə edilməsi, risklərin qiymətləndirilməsi və beynəlxalq standartlara uyğunluğunun təhlili üçün Governance, Risk & Compliance (GRC) çərçivəsi sənədləşdirilmişdir.

GRC yanaşması layihədəki texniki təhlükəsizlik həllərini təşkilati siyasətlər, risk idarəetməsi və uyğunluq qiymətləndirməsi ilə əlaqələndirir.

Layihədə istifadə edilən Active Directory, Keycloak SSO/MFA, JumpServer PAM, Windows LAPS, nftables Firewall, Suricata, DNS Sinkhole, PostgreSQL və backup infrastrukturu bu bölmədə təhlükəsizlik idarəetməsi baxımından nəzərdən keçirilir.

### Əsas məqsədlər

- İnformasiya təhlükəsizliyi siyasətlərini sənədləşdirmək;
- Korporativ aktivlər üçün təhlükəsizlik risklərini müəyyən etmək;
- Riskləri ehtimal və təsir əsasında qiymətləndirmək;
- Risk sahiblərini və azaltma tədbirlərini müəyyənləşdirmək;
- Hədəf residual risk göstəricilərini təqdim etmək;
- ISO/IEC 27001:2022, NIST CSF 2.0 və CIS Controls v8.1 üzrə daxili uyğunluq analizi aparmaq;
- Uyğunluq boşluqlarını və düzəldici tədbirləri müəyyənləşdirmək.

---

## 2. Bölmənin strukturu

| Alt bölmə | Sənəd | Məqsəd |
|---|---|---|
| 15.1 | Security Policy Library | Altı informasiya təhlükəsizliyi siyasəti |
| 15.2 | Risk Register | 20 riskin qiymətləndirilməsi və idarə edilməsi |
| 15.3 | Compliance Assessment | Standartlara uyğunluq və 10 maddəlik Gap Analysis |
| Verification | Verification Checklist | Sənədləşmə və əlavə yoxlama tələbləri |

### GitHub fayl strukturu

~~~text
Section-15-GRC/
├── README.md
├── security-policies.md
├── risk-register.md
├── compliance-assessment.md
└── verification-checklist.md
~~~

Altı təhlükəsizlik siyasəti ayrıca qovluqlarda deyil, vahid security-policies.md faylında saxlanılır.

---

## 3. Bölmə 15.1 — Security Policy Library

KONRDERK Cybersecurity üçün altı əsas informasiya təhlükəsizliyi siyasəti hazırlanmışdır.

| № | Policy | Document ID |
|---|---|---|
| 1 | Information Security Policy | KON-GRC-POL-001 |
| 2 | Acceptable Use Policy | KON-GRC-POL-002 |
| 3 | Incident Response Policy | KON-GRC-POL-003 |
| 4 | Remote Access Policy | KON-GRC-POL-004 |
| 5 | Data Classification Policy | KON-GRC-POL-005 |
| 6 | Password Management Policy | KON-GRC-POL-006 |

Siyasətlər Version 1.0 və Internal təsnifatı ilə hazırlanmışdır.

Sənəd sahibi Information Security Manager olaraq müəyyən edilmişdir. İllik baxış və Information Security Manager ilə CEO tərəfindən təsdiq üçün imza sahələri nəzərdə tutulmuşdur.

### 3.1. Information Security Policy

Bu siyasət informasiya aktivlərinin məxfiliyini, bütövlüyünü və əlçatanlığını qorumaq üçün ümumi tələbləri müəyyən edir.

Əsas istiqamətlər:

- Least Privilege və RBAC;
- Active Directory və Keycloak SSO/MFA;
- JumpServer PAM;
- Şəbəkə segmentasiyası və nftables Firewall;
- Suricata IDS/IPS və DNS Sinkhole;
- Audit logları və monitorinq;
- Backup və bərpa;
- Təhlükəsizlik insidentlərinin bildirilməsi.

### 3.2. Acceptable Use Policy

Korporativ hesabların, cihazların, şəbəkə resurslarının və tətbiqlərin məqbul istifadəsini tənzimləyir.

Əsas istiqamətlər:

- Korporativ hesabların yalnız səlahiyyətli istifadəsi;
- Parol və MFA kodlarının paylaşılmaması;
- İcazəsiz proqram təminatının məhdudlaşdırılması;
- USBGuard nəzarətləri;
- Məxfi məlumatların qorunması;
- Şübhəli hadisələrin SOC komandasına bildirilməsi.

### 3.3. Incident Response Policy

Təhlükəsizlik insidentlərinin aşkarlanması, qeydiyyatı, qiymətləndirilməsi, eskalasiyası, məhdudlaşdırılması, aradan qaldırılması və bərpası proseslərini müəyyən edir.

Əsas mərhələlər:

1. Preparation;
2. Identification;
3. Containment;
4. Eradication;
5. Recovery;
6. Lessons Learned.

### 3.4. Remote Access Policy

Korporativ sistemlərə uzaqdan girişin təhlükəsiz idarə olunmasını tənzimləyir.

Əsas istiqamətlər:

- RDP və SSH girişlərinin məhdudlaşdırılması;
- MFA;
- JumpServer PAM vasitəsilə administrator girişi;
- DC01-ə birbaşa RDP girişinin Firewall ilə məhdudlaşdırılması;
- Sessiya auditi;
- Session timeout nəzarəti.

### 3.5. Data Classification Policy

Korporativ məlumatlar dörd kateqoriyaya bölünür.

| Classification | Description |
|---|---|
| Public | İctimai paylaşılması təsdiqlənmiş məlumat |
| Internal | Şirkətdaxili məlumat |
| Confidential | Məxfi korporativ və müştəri məlumatı |
| Restricted | Kritik və yüksək həssaslıqlı məlumat |

Təsnifat məlumatların saxlanılması, paylaşılması, giriş hüquqları və qorunması üçün əsasdır.

### 3.6. Password Management Policy

İstifadəçi və administrator parollarının yaradılması və qorunması qaydalarını müəyyən edir.

| Account Type | Minimum Password Length |
|---|---|
| Standard User | 12 simvol |
| Administrator | 16 simvol |

Siyasət Active Directory, Keycloak MFA, Fine-Grained Password Policies, Windows LAPS və imtiyazlı hesabların qorunması ilə əlaqələndirilir.

**Ətraflı sənəd:** [Security Policies](security-policies.md)

---

## 4. Bölmə 15.2 — Risk Register

Risk Register korporativ infrastrukturun informasiya təhlükəsizliyi risklərini müəyyən etmək, prioritetləşdirmək və azaltma tədbirlərini planlaşdırmaq üçün hazırlanmışdır.

| Parametr | Dəyər |
|---|---|
| Document ID | KON-GRC-RSK-001 |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review | Monthly |
| Risk sayı | 20 |

### 4.1. Risk qiymətləndirməsi

Risklər iki göstərici əsasında qiymətləndirilir:

- Likelihood (L) — riskin başvermə ehtimalı;
- Impact (I) — risk baş verdikdə təsir səviyyəsi.

Hər iki göstərici 1–5 şkalası üzrə qiymətləndirilir.

~~~text
Risk Score = Likelihood × Impact
~~~

| Risk Score | Risk Level |
|---|---|
| 1–4 | Low |
| 5–9 | Medium |
| 10–16 | High |
| 17–25 | Critical |

### 4.2. Risk Register məlumatları

Hər risk üçün aşağıdakı sahələr göstərilmişdir:

- Risk ID;
- Risk və ya təsirlənən aktiv;
- Likelihood;
- Impact;
- Risk Score;
- Risk Owner;
- Mitigation;
- Residual Risk.

Risklər R-01-dən R-20-yə qədər qeydiyyata alınmışdır.

### 4.3. Risk prioritetləri

Ən yüksək ilkin risk R-03 — Privileged hesabın ələ keçirilməsidir.

Bu riskin ilkin göstəricisi:

~~~text
Likelihood = 4
Impact = 5
Risk Score = 20 — Critical
~~~

Riskin azaldılması üçün JumpServer PAM, MFA və audit nəzarətləri nəzərdə tutulmuşdur.

### 4.4. Residual Risk

Residual Risk nəzərdə tutulan təhlükəsizlik tədbirlərindən sonra qalan riskdir.

Risk Register-də göstərilən residual risklər hədəf göstəricilərdir və bütün tədbirlərin artıq tamamlandığını ifadə etmir.

### 4.5. Risklərin idarə edilməsi

Risklər aşağıdakı yanaşmalarla idarə edilir:

- Mitigate;
- Avoid;
- Transfer;
- Accept.

Risk Register üçün aylıq baxış dövrü müəyyən edilmişdir.

**Ətraflı sənəd:** [Risk Register](risk-register.md)

---

## 5. Bölmə 15.3 — Compliance Assessment

Compliance Assessment layihənin mövcud təhlükəsizlik nəzarətlərini beynəlxalq standartlarla müqayisə edir və təkmilləşdirilməli istiqamətləri müəyyən edir.

| Parametr | Dəyər |
|---|---|
| Document ID | KON-GRC-CMP-001 |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review | Annually |

### 5.1. Qiymətləndirmə çərçivələri

| Framework | Version |
|---|---|
| ISO/IEC 27001 | 2022 |
| NIST Cybersecurity Framework | 2.0 |
| CIS Controls | v8.1 |

### 5.2. ISO/IEC 27001:2022

| Control | Infrastructure Evidence | Assessment |
|---|---|---|
| A.5.15 — Access Control | AD, RBAC, Keycloak | Implemented |
| A.5.17 — Authentication Information | MFA, Windows LAPS | Implemented |
| A.8.2 — Privileged Access Rights | JumpServer PAM | Implemented |
| A.8.13 — Information Backup | Restic, P2-Backup | Partial |
| A.8.15 — Logging | PAM audit, sistem logları | Partial |
| A.8.20 — Network Security | nftables, Suricata, DNS Sinkhole | Implemented |

### 5.3. NIST CSF 2.0

| Function | Assessment |
|---|---|
| Govern | Partial |
| Identify | Partial |
| Protect | Implemented |
| Detect | Partial |
| Respond | Partial |
| Recover | Partial |

### 5.4. CIS Controls v8.1

| Control | Assessment |
|---|---|
| Controls 5–6 — Account and Access Management | Implemented |
| Control 8 — Audit Log Management | Partial |
| Control 11 — Data Recovery | Partial |
| Controls 12–13 — Network Infrastructure and Monitoring | Partial |
| Control 17 — Incident Response Management | Partial |

### 5.5. Gap Analysis

Uyğunluq qiymətləndirməsində 10 boşluq müəyyən edilmişdir.

| ID | Identified Gap | Priority |
|---|---|---|
| G-01 | PAM loglarının SIEM-ə ötürülməsi tamamlanmayıb | High |
| G-02 | Backup restore testləri təsdiqlənməyib | High |
| G-03 | P2-Backup serverində backup saxlanması yoxlanılmalıdır | High |
| G-04 | PAM sessiyalarının avtomatik bağlanması yoxlanılmayıb | Medium |
| G-05 | İnsident cavab prosedurlarının praktiki sınağı tələb olunur | High |
| G-06 | SIEM üzrə tam log əhatəsi təsdiqlənməyib | High |
| G-07 | Zəifliklərin idarə edilməsi üzrə vahid hesabat tələb olunur | Medium |
| G-08 | Backup retention və bərpa müddətləri sənədləşdirilməlidir | Medium |
| G-09 | Fərdi məlumatların emalı reyestri hazırlanmalıdır | Medium |
| G-10 | Siyasətlərin təsdiq və illik baxış qeydləri saxlanmalıdır | Medium |

**Gap Analysis nəticəsi:**

- High: 5;
- Medium: 5;
- Total: 10.

### 5.6. Fərdi məlumatların qorunması

Fərdi məlumatların emalı üzrə Azərbaycan Respublikasının “Fərdi məlumatlar haqqında” Qanunu və tətbiq olunduğu hallarda GDPR tələbləri nəzərə alınmışdır.

Sənədləşdirilmiş prinsiplər:

1. Purpose Limitation;
2. Data Minimization;
3. Lawful Processing;
4. Access Control;
5. Secure Storage;
6. Retention and Deletion;
7. Data Subject Rights;
8. Breach Management.

Data processing register hazırlanması əlavə tədbir olaraq müəyyən edilmişdir.

### 5.7. Ümumi uyğunluq nəticəsi

**OVERALL ASSESSMENT: PARTIALLY COMPLIANT**

Əsas təhlükəsizlik nəzarətləri mövcuddur, lakin bəzi texniki və təşkilati nəzarətlərin effektivliyi əlavə yoxlama tələb edir.

Bu qiymətləndirmə daxili uyğunluq analizidir və ISO/IEC 27001 sertifikatlaşdırılması hesab edilmir.

**Ətraflı sənəd:** [Compliance Assessment](compliance-assessment.md)

---

## 6. GRC və Texniki İnfrastruktur

| Component | GRC Role |
|---|---|
| Active Directory | Hesab və giriş nəzarəti |
| Keycloak | SSO və MFA |
| JumpServer PAM | İmtiyazlı giriş və sessiya auditi |
| Windows LAPS | Lokal administrator parollarının idarə edilməsi |
| nftables Firewall | Şəbəkə girişlərinin məhdudlaşdırılması |
| Suricata | Şəbəkə təhlükələrinin aşkarlanması |
| DNS Sinkhole | Zərərli domenlərin məhdudlaşdırılması |
| PostgreSQL | Məlumatların saxlanılması və giriş nəzarəti |
| Restic / P2-Backup | Backup və bərpa |
| GRC Policies | Təşkilati təhlükəsizlik tələbləri |
| Risk Register | Risklərin qiymətləndirilməsi |
| Compliance Assessment | Standartlarla müqayisə |

Layihənin VMware/Azure hibrid infrastrukturu çərçivəsində qurulmuş texniki komponentlər GRC baxımından sənədləşdirilmişdir.

---

## 7. Verification Checklist

Bölmə 15 üzrə sənədləşmənin və əlavə yoxlama tələb edən məsələlərin izlənilməsi üçün Verification Checklist hazırlanmışdır.

Yoxlama siyahısına aşağıdakılar daxildir:

- Altı təhlükəsizlik siyasətinin mövcudluğu;
- 20 riskin qiymətləndirilməsi;
- ISO, NIST və CIS üzrə uyğunluq analizi;
- 10 uyğunluq boşluğu;
- Fərdi məlumatların emalı prinsipləri;
- Rəsmi təsdiq və texniki yoxlama tələbləri.

**Ətraflı sənəd:** [Verification Checklist](verification-checklist.md)

---

## 8. Əlaqəli GitHub sənədləri

| File | Description |
|---|---|
| [security-policies.md](security-policies.md) | Altı təhlükəsizlik siyasəti |
| [risk-register.md](risk-register.md) | 20 risk və risk idarəetmə planı |
| [compliance-assessment.md](compliance-assessment.md) | ISO, NIST, CIS və Gap Analysis |
| [verification-checklist.md](verification-checklist.md) | Bölmə 15 üzrə yoxlama siyahısı |

---

## 9. Yekun nəticə

Bölmə 15 çərçivəsində KONRDERK Cybersecurity layihəsi üçün Governance, Risk & Compliance çərçivəsi sənədləşdirilmişdir.

Əldə edilmiş əsas nəticələr:

- Altı informasiya təhlükəsizliyi siyasəti hazırlanmışdır.
- Hər siyasət üçün sənəd identifikatoru, versiya, təsnifat, məsul şəxs və baxış dövrü müəyyən edilmişdir.
- 20 riskdən ibarət Risk Register hazırlanmışdır.
- Risklər Likelihood və Impact əsasında qiymətləndirilmişdir.
- Risk sahibləri, azaltma tədbirləri və hədəf residual risklər müəyyən edilmişdir.
- ISO/IEC 27001:2022, NIST CSF 2.0 və CIS Controls v8.1 üzrə daxili uyğunluq qiymətləndirməsi aparılmışdır.
- 10 uyğunluq boşluğu müəyyən edilmişdir.
- Fərdi məlumatların emalı üzrə əsas prosedurlar sənədləşdirilmişdir.
- Verification Checklist hazırlanmışdır.

**Yekun uyğunluq nəticəsi: PARTIALLY COMPLIANT.**

Bu nəticə layihənin əsas təhlükəsizlik komponentlərini və GRC sənədləşməsini əks etdirir, eyni zamanda əlavə təsdiq və düzəldici tədbir tələb edən məsələləri göstərir.

---

**Section:** 15 — Governance, Risk & Compliance

**Organization:** KONRDERK Cybersecurity

**Documentation:** Security Policies, Risk Register, Compliance Assessment, Verification Checklist

**Overall Compliance Result:** PARTIALLY COMPLIANT
