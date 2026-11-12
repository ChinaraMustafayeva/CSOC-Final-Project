# 15.2 — RISK REGISTER
## KONRDERK CYBERSECURITY — İnformasiya Təhlükəsizliyi Risklərinin Reyestri

| Document Information | Details |
|---|---|
| Document ID | KON-GRC-RSK-001 |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review Frequency | Monthly |
| Organization | KONRDERK Cybersecurity |
| Number of Risks | 20 |

---

## 1. Purpose and Methodology — Məqsəd və Metodologiya

### 1.1. Məqsəd

Risk Register KONRDERK Cybersecurity infrastrukturunda informasiya təhlükəsizliyi risklərinin müəyyənləşdirilməsi, qiymətləndirilməsi və idarə edilməsi üçün hazırlanmışdır.

Risk reyestrinin məqsədləri:

- Kritik informasiya aktivlərinə təsir edə biləcək riskləri müəyyən etmək;
- Risklərin başvermə ehtimalını qiymətləndirmək;
- Risklərin biznes və texniki sistemlərə təsirini qiymətləndirmək;
- Risk sahiblərini müəyyənləşdirmək;
- Risklərin azaldılması tədbirlərini sənədləşdirmək;
- Tədbirlərdən sonra gözlənilən qalıq riski hesablamaq;
- Risklərin prioritetləşdirilməsini və aylıq yenilənməsini təmin etmək.

Risklər layihədə qurulmuş və ya nəzərdə tutulmuş təhlükəsizlik infrastrukturuna əsasən müəyyən edilmişdir.

### 1.2. Risk qiymətləndirmə metodologiyası

Hər risk iki göstərici əsasında qiymətləndirilir:

- **Likelihood (L):** Riskin başvermə ehtimalı;
- **Impact (I):** Risk baş verdikdə yarana biləcək təsir.

Hər iki göstərici 1–5 şkalası üzrə qiymətləndirilir.

Risk balı aşağıdakı düsturla hesablanır:

~~~text id="rs1501"
Risk Score = Likelihood × Impact
~~~

Məsələn:

~~~text id="rs1502"
Likelihood = 4
Impact = 5

Risk Score = 4 × 5 = 20
~~~

### 1.3. Risk səviyyələri

| Risk Score | Risk Level | İdarəetmə yanaşması |
|---|---|---|
| 1–4 | Low | Planlı monitorinq |
| 5–9 | Medium | Planlı monitorinq və tədbirlər |
| 10–16 | High | Prioritet tədbirlər planı |
| 17–25 | Critical | Dərhal eskalasiya |

### 1.4. Residual Risk

Residual Risk təhlükəsizlik tədbirləri tətbiq edildikdən sonra qalan riskdir.

Qalıq risk eyni qaydada hesablanır:

~~~text id="rs1503"
Residual Risk = Residual Likelihood × Residual Impact
~~~

**Vacib:** Bu reyestrdə göstərilən residual göstəricilər nəzərdə tutulan təhlükəsizlik tədbirlərinin tətbiqindən sonrakı **hədəf risk qiymətləridir**. Onlar bütün tədbirlərin artıq tamamlandığını və effektivliyinin təsdiqləndiyini göstərmir.

---

## 2. Risk Register — 20 Riskin Reyestri

Aşağıdakı cədvəl layihə hesabatında göstərilmiş 20 riskin ilkin qiymətləndirməsini, risk sahiblərini, azaltma tədbirlərini və hədəf residual risk ballarını əhatə edir.

| ID | Risk / Asset | L | I | Score | Owner | Mitigation | Target Residual |
|---|---|---:|---:|---:|---|---|---|
| R-01 | DC01 komprometasiyası | 3 | 5 | 15 | System Admin | AD hardening, MFA, PAM | 2×5=10 |
| R-02 | DC02 replikasiya nasazlığı | 3 | 4 | 12 | System Admin | Replikasiya monitorinqi | 2×3=6 |
| R-03 | Privileged hesabın ələ keçirilməsi | 4 | 5 | 20 | Security Manager | JumpServer PAM, MFA, audit | 2×5=10 |
| R-04 | Keycloak SSO xidmətinin dayanması | 3 | 4 | 12 | System Admin | Xidmət monitorinqi, bərpa planı | 2×3=6 |
| R-05 | MFA bypass və ya zəif autentifikasiya | 3 | 5 | 15 | Security Engineer | OTP MFA, giriş nəzarəti | 2×3=6 |
| R-06 | CA01 sertifikat açarının komprometasiyası | 2 | 5 | 10 | System Admin | CA giriş məhdudiyyəti, açar mühafizəsi | 1×4=4 |
| R-07 | Firewall qaydalarının səhv konfiqurasiyası | 4 | 4 | 16 | Security Engineer | nftables audit, rule review | 2×3=6 |
| R-08 | DMZ-dən daxili şəbəkəyə keçid | 3 | 5 | 15 | Security Engineer | VLAN/VMnet segmentasiyası, ACL | 2×3=6 |
| R-09 | Suricata xəbərdarlıqlarının qaçırılması | 4 | 4 | 16 | SOC Lead | IDS qaydalarının yenilənməsi, log review | 2×3=6 |
| R-10 | DNS əsaslı zərərli trafik | 4 | 3 | 12 | Security Engineer | DNS Sinkhole, DNS monitorinqi | 2×3=6 |
| R-11 | PostgreSQL məlumat sızması | 3 | 5 | 15 | System Admin | RBAC, şifrələmə, şəbəkə məhdudiyyəti | 2×4=8 |
| R-12 | Backup nüsxələrinin itirilməsi | 3 | 5 | 15 | System Admin | Restic, P2-Backup, restore testləri | 2×4=8 |
| R-13 | Gitea repository-də secret sızması | 4 | 4 | 16 | DevSecOps | Secret scanning, giriş nəzarəti | 2×3=6 |
| R-14 | Nextcloud-da icazəsiz fayl paylaşımı | 4 | 3 | 12 | System Admin | RBAC, paylaşım məhdudiyyətləri | 2×3=6 |
| R-15 | Phishing və hesab komprometasiyası | 4 | 4 | 16 | SOC Lead | MFA, maarifləndirmə, alert review | 2×3=6 |
| R-16 | VMware host/VM nasazlığı | 3 | 5 | 15 | System Admin | VM backup, resurs monitorinqi | 2×4=8 |
| R-17 | USB vasitəsilə zərərli proqram | 4 | 3 | 12 | Security Engineer | USBGuard, endpoint nəzarəti | 2×3=6 |
| R-18 | PAM sessiya loglarının itirilməsi | 3 | 4 | 12 | SOC Lead | Log retention, SIEM inteqrasiyası | 2×3=6 |
| R-19 | Gecikmiş patch və zəiflik istismarı | 4 | 4 | 16 | System Admin | Patch management, vulnerability scan | 2×3=6 |
| R-20 | İnsidentə gec reaksiya | 4 | 4 | 16 | Incident Response Lead | IR proseduru, eskalasiya, təlim | 2×3=6 |

---

## 2.1. Identity and Access Management Riskləri

### R-01 — DC01 komprometasiyası

| Parametr | Dəyər |
|---|---|
| Risk ID | R-01 |
| Asset | DC01 |
| Likelihood | 3 |
| Impact | 5 |
| Initial Risk | 15 — High |
| Owner | System Admin |
| Mitigation | AD hardening, MFA, PAM |
| Target Residual Risk | 2×5=10 — High |

DC01 Active Directory infrastrukturunun kritik komponentidir.

Bu sistemin komprometasiyası domen səviyyəsində idarəetmə hüquqlarının itirilməsi və korporativ autentifikasiya infrastrukturuna ciddi təsir riski yaradır.

Riskin azaldılması üçün:

- Active Directory hardening;
- MFA;
- PAM vasitəsilə imtiyazlı giriş nəzarəti nəzərdə tutulmuşdur.

İlkin risk 15 bal, hədəf residual risk isə 10 baldır.

### R-02 — DC02 replikasiya nasazlığı

| Parametr | Dəyər |
|---|---|
| Risk ID | R-02 |
| Asset | DC02 |
| Likelihood | 3 |
| Impact | 4 |
| Initial Risk | 12 — High |
| Owner | System Admin |
| Mitigation | Replikasiya monitorinqi |
| Target Residual Risk | 2×3=6 — Medium |

DC02 replikasiya nasazlığı domen məlumatlarının sinxronizasiyasına və xidmətlərin davamlılığına təsir edə bilər.

Azaltma tədbiri olaraq replikasiya monitorinqi müəyyən edilmişdir.

### R-03 — Privileged hesabın ələ keçirilməsi

| Parametr | Dəyər |
|---|---|
| Risk ID | R-03 |
| Asset | Privileged Accounts |
| Likelihood | 4 |
| Impact | 5 |
| Initial Risk | 20 — Critical |
| Owner | Security Manager |
| Mitigation | JumpServer PAM, MFA, audit |
| Target Residual Risk | 2×5=10 — High |

Administrator hesabının ələ keçirilməsi kritik sistemlərə icazəsiz giriş və genişmiqyaslı təhlükəsizlik pozuntuları ilə nəticələnə bilər.

Azaltma tədbirləri:

- JumpServer PAM;
- MFA;
- İmtiyazlı fəaliyyətlərin auditi.

Bu risk reyestrdəki yeganə ilkin Critical riskdir.

### R-04 — Keycloak SSO xidmətinin dayanması

| Parametr | Dəyər |
|---|---|
| Risk ID | R-04 |
| Asset | Keycloak SSO |
| Likelihood | 3 |
| Impact | 4 |
| Initial Risk | 12 — High |
| Owner | System Admin |
| Mitigation | Xidmət monitorinqi, bərpa planı |
| Target Residual Risk | 2×3=6 — Medium |

Keycloak SSO xidmətinin dayanması mərkəzləşdirilmiş autentifikasiya imkanlarına təsir edə bilər.

Azaltma tədbirləri kimi xidmət monitorinqi və bərpa planı nəzərdə tutulmuşdur.

### R-05 — MFA bypass və ya zəif autentifikasiya

| Parametr | Dəyər |
|---|---|
| Risk ID | R-05 |
| Asset | MFA / Authentication |
| Likelihood | 3 |
| Impact | 5 |
| Initial Risk | 15 — High |
| Owner | Security Engineer |
| Mitigation | OTP MFA, giriş nəzarəti |
| Target Residual Risk | 2×3=6 — Medium |

Zəif autentifikasiya və MFA nəzarətlərindən yayınma hesab komprometasiyası riskini artırır.

Azaltma tədbirləri:

- OTP MFA;
- Giriş nəzarəti.

### R-06 — CA01 sertifikat açarının komprometasiyası

| Parametr | Dəyər |
|---|---|
| Risk ID | R-06 |
| Asset | CA01 |
| Likelihood | 2 |
| Impact | 5 |
| Initial Risk | 10 — High |
| Owner | System Admin |
| Mitigation | CA giriş məhdudiyyəti, açar mühafizəsi |
| Target Residual Risk | 1×4=4 — Low |

CA01 sertifikat açarının komprometasiyası PKI infrastrukturuna etimadı poza bilər.

Azaltma tədbirləri:

- CA serverinə girişin məhdudlaşdırılması;
- Sertifikat açarlarının mühafizəsi.

---

## 2.2. Network Security və Threat Detection Riskləri

### R-07 — Firewall qaydalarının səhv konfiqurasiyası

| Parametr | Dəyər |
|---|---|
| Risk ID | R-07 |
| Asset | Firewall |
| Likelihood | 4 |
| Impact | 4 |
| Initial Risk | 16 — High |
| Owner | Security Engineer |
| Mitigation | nftables audit, rule review |
| Target Residual Risk | 2×3=6 — Medium |

Firewall qaydalarının səhv konfiqurasiyası icazəsiz şəbəkə bağlantılarına və ya xidmətlərin əlçatanlıq problemlərinə səbəb ola bilər.

Azaltma tədbirləri:

- nftables audit;
- Firewall qaydalarının nəzərdən keçirilməsi.

### R-08 — DMZ-dən daxili şəbəkəyə keçid

| Parametr | Dəyər |
|---|---|
| Risk ID | R-08 |
| Asset | DMZ / Internal Network |
| Likelihood | 3 |
| Impact | 5 |
| Initial Risk | 15 — High |
| Owner | Security Engineer |
| Mitigation | VLAN/VMnet segmentasiyası, ACL |
| Target Residual Risk | 2×3=6 — Medium |

DMZ zonasından daxili şəbəkəyə icazəsiz keçid kritik sistemlərə giriş riskini yaradır.

Azaltma tədbirləri:

- VLAN/VMnet segmentasiyası;
- Access Control List (ACL).

### R-09 — Suricata xəbərdarlıqlarının qaçırılması

| Parametr | Dəyər |
|---|---|
| Risk ID | R-09 |
| Asset | Suricata |
| Likelihood | 4 |
| Impact | 4 |
| Initial Risk | 16 — High |
| Owner | SOC Lead |
| Mitigation | IDS qaydalarının yenilənməsi, log review |
| Target Residual Risk | 2×3=6 — Medium |

Suricata xəbərdarlıqlarının vaxtında aşkarlanmaması təhlükəsizlik hadisələrinin gec müəyyən edilməsinə səbəb ola bilər.

Azaltma tədbirləri:

- IDS qaydalarının yenilənməsi;
- Logların nəzərdən keçirilməsi.

### R-10 — DNS əsaslı zərərli trafik

| Parametr | Dəyər |
|---|---|
| Risk ID | R-10 |
| Asset | DNS Infrastructure |
| Likelihood | 4 |
| Impact | 3 |
| Initial Risk | 12 — High |
| Owner | Security Engineer |
| Mitigation | DNS Sinkhole, DNS monitorinqi |
| Target Residual Risk | 2×3=6 — Medium |

DNS əsaslı zərərli trafik təhlükəli domenlərlə əlaqəyə və hücum infrastrukturuna müraciətlərə səbəb ola bilər.

Azaltma tədbirləri:

- DNS Sinkhole;
- DNS monitorinqi.

---

## 2.3. Data Protection və Backup Riskləri

### R-11 — PostgreSQL məlumat sızması

| Parametr | Dəyər |
|---|---|
| Risk ID | R-11 |
| Asset | PostgreSQL |
| Likelihood | 3 |
| Impact | 5 |
| Initial Risk | 15 — High |
| Owner | System Admin |
| Mitigation | RBAC, şifrələmə, şəbəkə məhdudiyyəti |
| Target Residual Risk | 2×4=8 — Medium |

PostgreSQL məlumat sızması korporativ məlumatların məxfiliyinə ciddi təsir edə bilər.

Azaltma tədbirləri:

- RBAC;
- Şifrələmə;
- Şəbəkə məhdudiyyəti.

### R-12 — Backup nüsxələrinin itirilməsi

| Parametr | Dəyər |
|---|---|
| Risk ID | R-12 |
| Asset | Backup Infrastructure |
| Likelihood | 3 |
| Impact | 5 |
| Initial Risk | 15 — High |
| Owner | System Admin |
| Mitigation | Restic, P2-Backup, restore testləri |
| Target Residual Risk | 2×4=8 — Medium |

Backup nüsxələrinin itirilməsi məlumatların bərpa imkanlarına təsir edir.

Azaltma tədbirləri:

- Restic;
- P2-Backup;
- Restore testləri.

Restore testlərinin tamamlanması və nəticələrinin təsdiqi ayrıca Compliance Assessment çərçivəsində yoxlanılmalıdır.

### R-13 — Gitea repository-də secret sızması

| Parametr | Dəyər |
|---|---|
| Risk ID | R-13 |
| Asset | Gitea |
| Likelihood | 4 |
| Impact | 4 |
| Initial Risk | 16 — High |
| Owner | DevSecOps |
| Mitigation | Secret scanning, giriş nəzarəti |
| Target Residual Risk | 2×3=6 — Medium |

Gitea repository-lərində secret məlumatlarının sızması autentifikasiya məlumatlarının və açarların ifşasına səbəb ola bilər.

Azaltma tədbirləri:

- Secret scanning;
- Giriş nəzarəti.

### R-14 — Nextcloud-da icazəsiz fayl paylaşımı

| Parametr | Dəyər |
|---|---|
| Risk ID | R-14 |
| Asset | Nextcloud |
| Likelihood | 4 |
| Impact | 3 |
| Initial Risk | 12 — High |
| Owner | System Admin |
| Mitigation | RBAC, paylaşım məhdudiyyətləri |
| Target Residual Risk | 2×3=6 — Medium |

Nextcloud üzərindən icazəsiz fayl paylaşımı korporativ məlumatların sızmasına səbəb ola bilər.

Azaltma tədbirləri:

- RBAC;
- Fayl paylaşımı məhdudiyyətləri.

---

## 2.4. Human, Platform və Operational Risklər

### R-15 — Phishing və hesab komprometasiyası

| Parametr | Dəyər |
|---|---|
| Risk ID | R-15 |
| Asset | User Accounts |
| Likelihood | 4 |
| Impact | 4 |
| Initial Risk | 16 — High |
| Owner | SOC Lead |
| Mitigation | MFA, maarifləndirmə, alert review |
| Target Residual Risk | 2×3=6 — Medium |

Phishing hücumları istifadəçi hesablarının komprometasiyasına səbəb ola bilər.

Azaltma tədbirləri:

- MFA;
- İstifadəçi maarifləndirilməsi;
- Alert review.

Layihənin email təhlükəsizliyi mərhələsində GoPhish vasitəsilə phishing simulyasiyası aparılmışdır.

### R-16 — VMware host/VM nasazlığı

| Parametr | Dəyər |
|---|---|
| Risk ID | R-16 |
| Asset | VMware Host / VM |
| Likelihood | 3 |
| Impact | 5 |
| Initial Risk | 15 — High |
| Owner | System Admin |
| Mitigation | VM backup, resurs monitorinqi |
| Target Residual Risk | 2×4=8 — Medium |

VMware host və ya virtual maşın nasazlığı xidmətlərin əlçatanlığına təsir edə bilər.

Azaltma tədbirləri:

- VM backup;
- Resurs monitorinqi.

### R-17 — USB vasitəsilə zərərli proqram

| Parametr | Dəyər |
|---|---|
| Risk ID | R-17 |
| Asset | Endpoint / USB |
| Likelihood | 4 |
| Impact | 3 |
| Initial Risk | 12 — High |
| Owner | Security Engineer |
| Mitigation | USBGuard, endpoint nəzarəti |
| Target Residual Risk | 2×3=6 — Medium |

USB cihazları vasitəsilə zərərli proqramların sistemlərə daxil olması riski mövcuddur.

Azaltma tədbirləri:

- USBGuard;
- Endpoint nəzarəti.

### R-18 — PAM sessiya loglarının itirilməsi

| Parametr | Dəyər |
|---|---|
| Risk ID | R-18 |
| Asset | PAM Audit Logs |
| Likelihood | 3 |
| Impact | 4 |
| Initial Risk | 12 — High |
| Owner | SOC Lead |
| Mitigation | Log retention, SIEM inteqrasiyası |
| Target Residual Risk | 2×3=6 — Medium |

PAM sessiya loglarının itirilməsi administrator fəaliyyətlərinin araşdırılmasını çətinləşdirə bilər.

Azaltma tədbirləri:

- Log retention;
- SIEM inteqrasiyası.

SIEM inteqrasiyasının tamamlanma vəziyyəti Compliance Assessment çərçivəsində ayrıca qiymətləndirilir.

### R-19 — Gecikmiş patch və zəiflik istismarı

| Parametr | Dəyər |
|---|---|
| Risk ID | R-19 |
| Asset | Windows / Linux Systems |
| Likelihood | 4 |
| Impact | 4 |
| Initial Risk | 16 — High |
| Owner | System Admin |
| Mitigation | Patch management, vulnerability scan |
| Target Residual Risk | 2×3=6 — Medium |

Sistem yenilənmələrinin gecikməsi məlum zəifliklərin istismar olunması riskini artırır.

Azaltma tədbirləri:

- Patch management;
- Vulnerability scan.

### R-20 — İnsidentə gec reaksiya

| Parametr | Dəyər |
|---|---|
| Risk ID | R-20 |
| Asset | Incident Response Process |
| Likelihood | 4 |
| Impact | 4 |
| Initial Risk | 16 — High |
| Owner | Incident Response Lead |
| Mitigation | IR proseduru, eskalasiya, təlim |
| Target Residual Risk | 2×3=6 — Medium |

Təhlükəsizlik insidentlərinə gec reaksiya verilməsi hadisənin təsirini artıra bilər.

Azaltma tədbirləri:

- Incident Response proseduru;
- Eskalasiya;
- Təlim.

---

## 3. Risk Treatment — Risklərin İdarə Edilməsi

Risklərin idarə olunmasında dörd əsas yanaşma tətbiq edilir.

### 3.1. Mitigate — Riskin azaldılması

Riskin ehtimalını və ya təsirini azaltmaq üçün təhlükəsizlik nəzarətlərinin tətbiqi.

Layihədə nəzərdə tutulan nəzarətlər:

- MFA;
- PAM;
- Firewall;
- IDS/IPS;
- Backup;
- Monitorinq.

### 3.2. Avoid — Riskdən yayınma

Qəbuledilməz təhlükəli fəaliyyətlərin dayandırılması.

Bu yanaşma müəyyən fəaliyyətin davam etdirilməsinin yaratdığı riskin aradan qaldırılmasını nəzərdə tutur.

### 3.3. Transfer — Riskin ötürülməsi

Müqavilə və xidmət şərtləri vasitəsilə riskin bir hissəsinin ötürülməsi.

### 3.4. Accept — Riskin qəbul edilməsi

Qalıq riskin məsul rəhbər tərəfindən qiymətləndirilməsi və qəbul edilməsi.

### 3.5. Risk prioritetləri

| Risk Level | İdarəetmə |
|---|---|
| Critical | Dərhal eskalasiya |
| High | Prioritet tədbirlər planı |
| Medium | Planlı monitorinq |
| Low | Planlı monitorinq |

---

## 4. Monthly Risk Review — Aylıq Yenilənmə

Risk Register hər ay Information Security Manager tərəfindən nəzərdən keçirilir.

### 4.1. Yenilənmə cədvəli

| Activity | Responsible | Frequency |
|---|---|---|
| Yeni risklərin müəyyənləşdirilməsi | SOC Lead / Security Engineers | Monthly |
| Likelihood və Impact qiymətləndirilməsi | Risk Owner | Monthly |
| Mitigation statusunun yoxlanılması | Risk Owner | Monthly |
| Residual Risk-in yenidən hesablanması | Information Security Manager | Monthly |
| High/Critical risklərin rəhbərliyə təqdimatı | Information Security Manager | Monthly |

### 4.2. Aylıq baxış prosesi

1. Yeni risklər müəyyən edilir.
2. Mövcud risklərin ehtimal və təsir göstəriciləri yenilənir.
3. Risk sahibləri tərəfindən azaltma tədbirlərinin vəziyyəti yoxlanılır.
4. Residual Risk yenidən hesablanır.
5. High və Critical risklər rəhbərliyə təqdim edilir.

### 4.3. Növbədənkənar risk qiymətləndirməsi

Aşağıdakı hallarda növbəti aylıq baxışı gözləmədən risk qiymətləndirilməsi yenilənir:

- Təhlükəsizlik insidenti;
- Ciddi zəiflik;
- İnfrastruktur dəyişikliyi.

---

## 5. Risk Summary — Risklərin Xülasəsi

### 5.1. İlkin və hədəf qalıq risklər

| Risk Level | Initial Risks | Target Residual Risks |
|---|---:|---:|
| Critical | 1 | 0 |
| High | 15 | 2 |
| Medium | 4 | 17 |
| Low | 0 | 1 |
| **Total** | **20** | **20** |

### 5.2. İlkin risklərin qiymətləndirilməsi

Risk Register-də 20 risk müəyyən edilmişdir.

Onlardan:

- 1 risk Critical;
- 15 risk High;
- 4 risk Medium;
- 0 risk Low səviyyəsindədir.

Ən yüksək ilkin risk R-03 — Privileged hesabın ələ keçirilməsidir.

~~~text id="rs1504"
R-03 Initial Risk = 4 × 5 = 20
Risk Level = Critical
~~~

### 5.3. Hədəf residual risklərin qiymətləndirilməsi

Nəzərdə tutulan tədbirlərdən sonra hədəf risk bölgüsü:

- 0 Critical;
- 2 High;
- 17 Medium;
- 1 Low.

High səviyyəsində qalması nəzərdə tutulan risklər:

| Risk ID | Risk | Target Residual |
|---|---|---|
| R-01 | DC01 komprometasiyası | 10 — High |
| R-03 | Privileged hesabın ələ keçirilməsi | 10 — High |

Low səviyyəsinə endirilməsi hədəflənən risk:

| Risk ID | Risk | Target Residual |
|---|---|---|
| R-06 | CA01 sertifikat açarının komprometasiyası | 4 — Low |

### 5.4. Ümumi müqayisə

| Göstərici | İlkin | Hədəf |
|---|---:|---:|
| Critical risk sayı | 1 | 0 |
| High risk sayı | 15 | 2 |
| Medium risk sayı | 4 | 17 |
| Low risk sayı | 0 | 1 |

Bu dəyişikliklər risk azaltma tədbirlərinin nəzərdə tutulan nəticəsini göstərir.

**Qeyd:** Hədəf risk bölgüsü faktiki tətbiq və effektivlik testləri ilə təsdiqləndikcə yenilənməlidir.

---

## 6. Priority Areas — Prioritet İstiqamətlər

Risk Register üzrə əsas prioritet istiqamətlər:

### 6.1. Privileged Access

- Administrator hesablarının qorunması;
- MFA;
- JumpServer PAM;
- Audit.

Əlaqəli risklər: R-01, R-03, R-05.

### 6.2. Network Segmentation

- Firewall qaydaları;
- VLAN/VMnet segmentasiyası;
- ACL;
- IDS qaydaları;
- DNS monitorinqi.

Əlaqəli risklər: R-07, R-08, R-09, R-10.

### 6.3. Data Protection

- PostgreSQL RBAC və şifrələmə;
- Gitea secret scanning;
- Nextcloud paylaşım məhdudiyyətləri;
- CA açarlarının qorunması.

Əlaqəli risklər: R-06, R-11, R-13, R-14.

### 6.4. Backup and Availability

- Replikasiya monitorinqi;
- Xidmət monitorinqi;
- Restic və P2-Backup;
- Restore testləri;
- VM backup.

Əlaqəli risklər: R-02, R-04, R-12, R-16.

### 6.5. Incident Response and Monitoring

- SOC xəbərdarlıqları;
- Phishing maarifləndirməsi;
- PAM log retention;
- SIEM inteqrasiyası;
- Patch management;
- IR prosedurları.

Əlaqəli risklər: R-09, R-15, R-18, R-19, R-20.

---

## 7. GRC Sənədləri ilə Əlaqə

Risk Register aşağıdakı GRC sənədləri ilə əlaqələndirilir:

| Sənəd | Əlaqə |
|---|---|
| Information Security Policy | Ümumi təhlükəsizlik və risk idarəetmə tələbləri |
| Acceptable Use Policy | İstifadəçi davranışı və korporativ resursların qorunması |
| Incident Response Policy | Təhlükəsizlik insidentlərinin idarə edilməsi |
| Remote Access Policy | Administrator və uzaqdan giriş riskləri |
| Data Classification Policy | Məlumatların qorunması və sızma riskləri |
| Password Management Policy | Autentifikasiya və hesab komprometasiyası riskləri |
| Compliance Assessment | Risk nəzarətlərinin standartlarla müqayisəsi |

---

## 8. Əlaqəli GitHub Sənədləri

- [Bölmə 15 — Ümumi README](README.md)
- [15.1 — Security Policies](security-policies.md)
- [15.3 — Compliance Assessment](compliance-assessment.md)
- [Verification Checklist](verification-checklist.md)

---

## 9. Yekun Nəticə

KONRDERK Cybersecurity CSOC layihəsinin 15.2 mərhələsində 20 informasiya təhlükəsizliyi riskindən ibarət Risk Register hazırlanmışdır.

Risklər Likelihood və Impact göstəriciləri əsasında 1–5 şkalası ilə qiymətləndirilmiş və Risk Score = L × I metodologiyası tətbiq edilmişdir.

İlkin risk qiymətləndirməsində:

- 1 Critical;
- 15 High;
- 4 Medium risk müəyyən edilmişdir.

Hər risk üçün məsul şəxs, azaltma tədbiri və hədəf residual risk göstərilmişdir.

Təhlükəsizlik tədbirlərindən sonra hədəf bölgü 0 Critical, 2 High, 17 Medium və 1 Low risk olaraq müəyyən edilmişdir.

Risklərin idarə edilməsi üçün Mitigate, Avoid, Transfer və Accept yanaşmaları təsvir edilmişdir.

Risk Register-in hər ay Information Security Manager tərəfindən nəzərdən keçirilməsi və ciddi insident, zəiflik və ya infrastruktur dəyişikliyi zamanı növbədənkənar yenilənməsi nəzərdə tutulmuşdur.

Prioritet istiqamətlər privileged access, şəbəkə segmentasiyası, məlumatların qorunması, backup və insidentlərə cavab prosesləridir.

Qalıq risk göstəriciləri nəzarət tədbirlərinin effektivliyi yoxlanıldıqca yenilənməlidir.

---

**Document ID:** KON-GRC-RSK-001

**Version:** 1.0

**Classification:** Internal

**Owner:** Information Security Manager

**Review:** Monthly

**End of Document — KON-GRC-RSK-001**
