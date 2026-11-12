# BÖLMƏ 15 — GOVERNANCE, RISK & COMPLIANCE (GRC)

## 1. Ümumi məlumat

Bu bölmədə KONRDERK Cybersecurity layihəsinin informasiya təhlükəsizliyinin idarə edilməsi, risklərin qiymətləndirilməsi və beynəlxalq standartlara uyğunluğunun təhlili üçün Governance, Risk & Compliance (GRC) çərçivəsi hazırlanmışdır.

GRC yanaşması texniki təhlükəsizlik həllərini təşkilati siyasətlər, risk idarəetməsi və uyğunluq qiymətləndirməsi ilə əlaqələndirir.

Layihənin əvvəlki bölmələrində qurulmuş Active Directory, Keycloak SSO/MFA, JumpServer PAM, Firewall, Suricata, DNS Sinkhole və backup infrastrukturu bu bölmədə idarəetmə və uyğunluq baxımından qiymətləndirilmişdir.

Bölmənin əsas məqsədləri:

- İnformasiya təhlükəsizliyi qaydalarını rəsmi siyasətlər şəklində sənədləşdirmək;
- Korporativ sistemlər üçün riskləri müəyyənləşdirmək;
- Riskləri ehtimal və təsir əsasında qiymətləndirmək;
- Risklərin azaldılması tədbirlərini və məsul şəxsləri göstərmək;
- Qalan riskləri (Residual Risk) müəyyən etmək;
- ISO/IEC 27001:2022, NIST CSF 2.0 və CIS Controls v8.1 üzrə uyğunluq qiymətləndirməsi aparmaq;
- Mövcud boşluqları və təkmilləşdirmə tədbirlərini müəyyənləşdirmək.

## 2. Bölmənin strukturu

| Alt bölmə | Sənəd | Məqsəd |
|---|---|---|
| 15.1 | Policy Library | Altı təhlükəsizlik siyasətinin hazırlanması |
| 15.2 | Risk Register | 20 riskin qiymətləndirilməsi və azaldılması |
| 15.3 | Compliance Assessment | Standartlar üzrə uyğunluq və gap analysis |

## 3. Bölmə 15.1 — Təhlükəsizlik siyasətləri

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

Siyasətlərin sahibi Information Security Manager olaraq müəyyən edilmişdir.

Sənədlərdə illik baxış dövrü və təsdiq üçün imza bölmələri nəzərdə tutulmuşdur.

### 3.1. Information Security Policy

Bu siyasət informasiya aktivlərinin məxfiliyini, bütövlüyünü və əlçatanlığını qorumaq üçün ümumi təhlükəsizlik tələblərini müəyyən edir.

Əsas istiqamətlər:

- Least Privilege və RBAC;
- Active Directory və Keycloak SSO/MFA;
- JumpServer PAM;
- Şəbəkə segmentasiyası və nftables Firewall;
- Suricata IDS/IPS və DNS Sinkhole;
- Sistemlərin yenilənməsi;
- Audit logları və monitorinq;
- Backup və bərpa;
- İnsidentlərin bildirilməsi.

### 3.2. Acceptable Use Policy

Bu siyasət əməkdaşların korporativ sistemlərdən və resurslardan istifadəsini tənzimləyir.

Əsas istiqamətlər:

- Korporativ hesabların istifadəsi;
- İş stansiyaları və serverlərdən məqbul istifadə;
- Email və internet resursları;
- İcazəsiz proqram təminatı və təhlükəli fəaliyyətlərin məhdudlaşdırılması;
- Məlumatların qorunması;
- Təhlükəsizlik hadisələrinin bildirilməsi.

### 3.3. Incident Response Policy

Bu siyasət təhlükəsizlik insidentlərinin müəyyənləşdirilməsi, eskalasiyası, araşdırılması və aradan qaldırılması prosesini tənzimləyir.

Əsas istiqamətlər:

- İnsidentin aşkarlanması;
- Qeydiyyat və ilkin qiymətləndirmə;
- Prioritetləşdirmə;
- Eskalasiya;
- Məhdudlaşdırma və aradan qaldırma;
- Bərpa;
- Hadisədən sonra təhlil və hesabat.

### 3.4. Remote Access Policy

Bu siyasət korporativ sistemlərə uzaqdan girişin təhlükəsiz idarə olunmasını müəyyən edir.

Əsas istiqamətlər:

- RDP və SSH girişlərinin məhdudlaşdırılması;
- MFA və təsdiqlənmiş şifrəli bağlantılar;
- JumpServer PAM vasitəsilə administrator girişi;
- DC01-ə birbaşa RDP girişinin Firewall ilə məhdudlaşdırılması;
- Administrator sessiyalarının audit qeydləri;
- Sessiya müddəti və fəaliyyətsizlik nəzarəti;
- Şübhəli uzaqdan giriş hadisələrinin bildirilməsi.

### 3.5. Data Classification Policy

Bu siyasət məlumatların həssaslıq səviyyəsinə görə təsnif edilməsini və müvafiq qaydada qorunmasını tənzimləyir.

Əsas istiqamətlər:

- Public;
- Internal;
- Confidential;
- Restricted;
- Məlumatlara girişin məhdudlaşdırılması;
- Məlumatların saxlanılması və ötürülməsi;
- Məlumatların təhlükəsiz silinməsi.

### 3.6. Password Management Policy

Bu siyasət istifadəçi və administrator parollarının yaradılması, istifadəsi və qorunması qaydalarını müəyyən edir.

Layihədəki texniki nəzarətlərlə əlaqəsi:

- Active Directory;
- Fine-Grained Password Policies;
- Windows LAPS;
- MFA;
- İmtiyazlı hesabların qorunması;
- Parol rotasiyası və hesab kilidlənməsi.

## 4. Bölmə 15.2 — Risk Register

### 4.1. Məqsəd

Risk Register korporativ infrastrukturun informasiya təhlükəsizliyi risklərini müəyyənləşdirmək, prioritetləşdirmək və azaltma tədbirlərini planlaşdırmaq üçün hazırlanmışdır.

Hesabatda 20 riskdən ibarət risk reyestri təqdim edilmişdir.

Sənəd məlumatları:

| Parametr | Dəyər |
|---|---|
| Document ID | KON-GRC-RSK-001 |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review | Monthly |
| Risk sayı | 20 |

### 4.2. Risk qiymətləndirmə metodologiyası

Risklər iki göstərici üzrə qiymətləndirilir:

- Likelihood (L) — riskin başvermə ehtimalı;
- Impact (I) — risk baş verdikdə təsir səviyyəsi.

Hər iki göstərici 1-dən 5-ə qədər qiymətləndirilir.

Risk balının hesablanması:

~~~text id="grc1501"
Risk Score = Likelihood × Impact
~~~

### 4.3. Risk səviyyələri

| Risk Score | Risk Level |
|---|---|
| 1–4 | Low |
| 5–9 | Medium |
| 10–16 | High |
| 17–25 | Critical |

### 4.4. Risk reyestrinin sahələri

Hər risk üçün aşağıdakı məlumatlar göstərilmişdir:

- Risk ID;
- Risk və ya təsirlənən aktiv;
- Likelihood;
- Impact;
- Risk Score;
- Risk Owner;
- Mitigation;
- Residual Risk.

### 4.5. Residual Risk

Residual Risk — nəzərdə tutulan təhlükəsizlik tədbirləri tətbiq edildikdən sonra qalan riskdir.

Hesabatdakı residual göstəricilər nəzarət tədbirlərinin tətbiqindən sonrakı hədəf qiymətlərdir.

Bu göstəricilər bütün azaltma tədbirlərinin artıq tam icra olunduğunu bildirmir.

### 4.6. Risklərin idarə edilməsi

Risk Register üçün aylıq yenilənmə dövrü müəyyən edilmişdir.

Yenilənmə zamanı:

1. Mövcud risklərin vəziyyəti nəzərdən keçirilir.
2. Yeni risklər müəyyənləşdirilir.
3. Likelihood və Impact yenidən qiymətləndirilir.
4. Mitigation tədbirlərinin vəziyyəti yoxlanılır.
5. Residual Risk göstəriciləri yenilənir.
6. Məsul şəxslər və prioritetlər nəzərdən keçirilir.

## 5. Bölmə 15.3 — Compliance Assessment

### 5.1. Məqsəd

Compliance Assessment mövcud təhlükəsizlik nəzarətlərinin beynəlxalq standartlarla uyğunluğunu qiymətləndirmək və təkmilləşdirilməli istiqamətləri müəyyən etmək üçün hazırlanmışdır.

Sənəd məlumatları:

| Parametr | Dəyər |
|---|---|
| Document ID | KON-GRC-CMP-001 |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review | Annually |

### 5.2. Qiymətləndirmə çərçivələri

Uyğunluq qiymətləndirməsi üç çərçivə əsasında aparılmışdır.

| Standart | Əhatə dairəsi |
|---|---|
| ISO/IEC 27001:2022 | İnformasiya təhlükəsizliyinin idarə edilməsi və nəzarətlər |
| NIST CSF 2.0 | Govern, Identify, Protect, Detect, Respond, Recover |
| CIS Controls v8.1 | Praktiki kibertəhlükəsizlik nəzarətləri |

### 5.3. Qiymətləndirilən infrastruktur

- Active Directory;
- Keycloak SSO və MFA;
- JumpServer PAM;
- nftables Firewall;
- Suricata;
- PostgreSQL;
- Backup infrastrukturu.

### 5.4. Uyğunluq statusları

Hesabatda iki əsas qiymətləndirmə statusundan istifadə edilmişdir.

| Status | İzah |
|---|---|
| Implemented | Texniki tətbiqi barədə məlumat mövcuddur |
| Partial | Nəzarət qismən mövcuddur və ya tam effektivliyi təsdiqlənməyib |

Bu qiymətləndirmə daxili uyğunluq analizidir və ISO/IEC 27001 sertifikatlaşdırılması hesab edilmir.

## 6. ISO/IEC 27001:2022 üzrə qiymətləndirmə

| Nəzarət | Sübut və infrastruktur | Status |
|---|---|---|
| A.5.15 — Access Control | AD, RBAC, Keycloak | Implemented |
| A.5.17 — Authentication Information | MFA, Windows LAPS | Implemented |
| A.8.2 — Privileged Access Rights | JumpServer PAM | Implemented |
| A.8.13 — Information Backup | Restic, P2-Backup | Partial |
| A.8.15 — Logging | PAM audit, sistem logları | Partial |
| A.8.20 — Network Security | nftables, Suricata, DNS Sinkhole | Implemented |

## 7. NIST CSF 2.0 üzrə qiymətləndirmə

| Funksiya | Sübut | Status |
|---|---|---|
| Govern | GRC siyasətləri, Risk Register | Partial |
| Identify | Aktivlər və 20 riskin qeydiyyatı | Partial |
| Protect | MFA, PAM, Firewall, segmentasiya | Implemented |
| Detect | Suricata, təhlükəsizlik logları | Partial |
| Respond | Incident Response Policy | Partial |
| Recover | Restic backup, bərpa tələbləri | Partial |

## 8. CIS Controls v8.1 üzrə qiymətləndirmə

| CIS Control | Sahə | Status |
|---|---|---|
| Controls 5–6 | Account və Access Management | Implemented |
| Control 8 | Audit Log Management | Partial |
| Control 11 | Data Recovery | Partial |
| Controls 12–13 | Network Infrastructure və Monitoring | Partial |
| Control 17 | Incident Response Management | Partial |

## 9. Gap Analysis

Uyğunluq qiymətləndirməsində 10 əsas boşluq müəyyən edilmişdir.

| ID | Boşluq | Prioritet | Təkmilləşdirmə tədbiri | Məsul şəxs |
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

### 9.1. Prioritetlərin xülasəsi

| Prioritet | Say |
|---|---|
| High | 5 |
| Medium | 5 |
| Ümumi | 10 |

Gap Analysis mövcud texniki tətbiqlərlə sənədləşdirmə, monitorinq və təsdiq tələbləri arasındakı boşluqları göstərir.

## 10. Fərdi məlumatların qorunması

KONRDERK Cybersecurity üçün fərdi məlumatların emalında Azərbaycan Respublikasının Fərdi məlumatlar haqqında Qanunu və tətbiq olunduğu hallarda GDPR tələbləri nəzərə alınmışdır.

Əsas prinsiplər:

1. Purpose Limitation — məlumatların yalnız müəyyən edilmiş qanuni məqsədlər üçün toplanması.
2. Data Minimization — yalnız zəruri məlumatların toplanması.
3. Lawful Processing — emal üçün müvafiq hüquqi əsasın müəyyən edilməsi.
4. Access Control — məlumatlara girişin RBAC və Least Privilege əsasında məhdudlaşdırılması.

Bu prinsiplər Data Classification Policy və Information Security Policy ilə əlaqələndirilir.

## 11. GRC və texniki təhlükəsizlik infrastrukturu

| Texniki komponent | GRC baxımından rolu |
|---|---|
| Active Directory | Hesab və giriş nəzarəti |
| Keycloak | SSO və MFA |
| JumpServer PAM | İmtiyazlı giriş və sessiya auditi |
| Windows LAPS | Lokal administrator parollarının idarə edilməsi |
| nftables Firewall | Şəbəkə girişlərinin məhdudlaşdırılması |
| Suricata | Şəbəkə təhlükələrinin aşkarlanması |
| DNS Sinkhole | Zərərli domenlərə çıxışın məhdudlaşdırılması |
| Restic / P2-Backup | Məlumatların ehtiyat nüsxələnməsi və bərpa planlaşdırılması |
| GRC Policies | Təhlükəsizlik tələblərinin sənədləşdirilməsi |
| Risk Register | Risklərin prioritetləşdirilməsi |
| Compliance Assessment | Nəzarətlərin standartlarla müqayisəsi |

## 12. GitHub sənəd strukturu

Bu bölmənin sənədləri aşağıdakı strukturda saxlanılır:

~~~text id="grc1502"
Section-15-Governance-Risk-Compliance/
├── README.md
├── policy-library/
│   ├── information-security-policy.md
│   ├── acceptable-use-policy.md
│   ├── incident-response-policy.md
│   ├── remote-access-policy.md
│   ├── data-classification-policy.md
│   └── password-management-policy.md
├── risk-register.md
└── compliance-assessment.md
~~~

## 13. Əlaqəli sənədlər

### Policy Library

- [Information Security Policy](policy-library/information-security-policy.md)
- [Acceptable Use Policy](policy-library/acceptable-use-policy.md)
- [Incident Response Policy](policy-library/incident-response-policy.md)
- [Remote Access Policy](policy-library/remote-access-policy.md)
- [Data Classification Policy](policy-library/data-classification-policy.md)
- [Password Management Policy](policy-library/password-management-policy.md)

### Risk və uyğunluq

- [Risk Register](risk-register.md)
- [Compliance Assessment](compliance-assessment.md)

## 14. Yekun nəticə

Bölmə 15 çərçivəsində KONRDERK Cybersecurity layihəsi üçün Governance, Risk & Compliance çərçivəsi hazırlanmışdır.

Altı əsas informasiya təhlükəsizliyi siyasəti sənədləşdirilmiş, hər biri üçün sənəd identifikatoru, versiya, təsnifat, məsul şəxs, baxış dövrü və təsdiq bölməsi nəzərdə tutulmuşdur.

20 riskdən ibarət Risk Register hazırlanmış, risklər Likelihood və Impact göstəriciləri əsasında qiymətləndirilmiş, azaltma tədbirləri, risk sahibləri və hədəf residual risk göstəriciləri müəyyən edilmişdir.

ISO/IEC 27001:2022, NIST CSF 2.0 və CIS Controls v8.1 çərçivələri əsasında daxili uyğunluq qiymətləndirməsi aparılmışdır.

Qiymətləndirmədə tətbiq edilmiş nəzarətlərlə yanaşı, qismən təmin edilmiş nəzarətlər də müəyyən edilmiş və 10 maddəlik Gap Analysis hazırlanmışdır.

Beləliklə, layihənin texniki təhlükəsizlik infrastrukturu siyasət, risk və uyğunluq idarəetməsi ilə əlaqələndirilmişdir.
