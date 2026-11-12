# 15.1 — SECURITY POLICY LIBRARY
## KONRDERK CYBERSECURITY — İnformasiya Təhlükəsizliyi Siyasətləri

### Ümumi məlumat

Bu sənəd KONRDERK Cybersecurity CSOC layihəsinin Governance, Risk & Compliance (GRC) mərhələsində hazırlanmış altı informasiya təhlükəsizliyi siyasətini birləşdirir.

Siyasətlər korporativ informasiya aktivlərinin qorunması, istifadəçilərin təhlükəsiz davranışı, insidentlərə reaksiya, uzaqdan giriş, məlumatların təsnifatı və parolların idarə edilməsi üçün təşkilati tələbləri müəyyən edir.

Hər siyasət ayrıca sənəd identifikatoruna malikdir və layihənin yekun hesabatındakı 15.1 bölməsinə əsaslanır.

| № | Siyasət | Document ID |
|---|---|---|
| 1 | Information Security Policy | KON-GRC-POL-001 |
| 2 | Acceptable Use Policy | KON-GRC-POL-002 |
| 3 | Incident Response Policy | KON-GRC-POL-003 |
| 4 | Remote Access Policy | KON-GRC-POL-004 |
| 5 | Data Classification Policy | KON-GRC-POL-005 |
| 6 | Password Management Policy | KON-GRC-POL-006 |

Bütün siyasətlər üçün ümumi sənəd parametrləri:

| Parametr | Dəyər |
|---|---|
| Organization | KONRDERK Cybersecurity |
| Version | 1.0 |
| Classification | Internal |
| Owner | Information Security Manager |
| Review Frequency | Annually |
| Approval | Information Security Manager və CEO |

**Qeyd:** Təsdiq cədvəllərindəki imza və tarix sahələri layihə hesabatında boş saxlanılmışdır. Buna görə sənədlər təsdiqlənmiş kimi təqdim edilmir.

---

# 15.1.1 — INFORMATION SECURITY POLICY
## İnformasiya Təhlükəsizliyi Siyasəti

**Document ID:** KON-GRC-POL-001

**Version:** 1.0 | **Classification:** Internal

**Owner:** Information Security Manager | **Review:** Annually

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

Bu siyasət KONRDERK Cybersecurity şirkətinin informasiya aktivlərinin məxfiliyini, bütövlüyünü və əlçatanlığını qorumaq məqsədi daşıyır.

Tələblər bütün əməkdaşlara, korporativ sistemlərə və səlahiyyətli üçüncü tərəflərə şamil edilir.

İnformasiya təhlükəsizliyinin üç əsas prinsipi:

- **Confidentiality:** İnformasiyanın icazəsiz şəxslərə açıqlanmamasının təmin edilməsi.
- **Integrity:** Məlumatların icazəsiz dəyişdirilməsinin qarşısının alınması.
- **Availability:** Kritik informasiya sistemlərinin və xidmətlərin əlçatanlığının qorunması.

## 2. Access Control — Giriş Nəzarəti

### 2.1. Least Privilege və RBAC

Sistemlərə giriş Least Privilege və Role-Based Access Control (RBAC) prinsipləri əsasında verilməlidir.

İstifadəçilərə yalnız iş funksiyalarını yerinə yetirmək üçün tələb olunan hüquqlar ayrılmalıdır.

### 2.2. Hesabların idarə edilməsi

İstifadəçi hesabları Active Directory vasitəsilə, SSO və MFA xidmətləri isə Keycloak vasitəsilə idarə olunur.

Bu nəzarətlər mərkəzləşdirilmiş identifikasiya və autentifikasiyanı dəstəkləyir.

### 2.3. İmtiyazlı girişlər

Administratorların imtiyazlı girişləri JumpServer PAM vasitəsilə nəzarətdə saxlanılmalıdır.

Bu tələb kritik sistemlərə girişlərin məhdudlaşdırılması və auditinin aparılması üçün nəzərdə tutulmuşdur.

### 2.4. İşdən ayrılma

İşdən ayrılan əməkdaşların korporativ sistemlərə giriş hüquqları ləğv edilməlidir.

## 3. Infrastructure Security — İnfrastruktur Təhlükəsizliyi

### 3.1. Şəbəkə segmentasiyası

LAN, DMZ və Server Zone arasında trafik nftables Firewall qaydaları ilə məhdudlaşdırılmalıdır.

### 3.2. Təhlükələrin aşkarlanması

Suricata IDS/IPS və DNS Sinkhole şəbəkə təhlükələrinin aşkarlanması və məhdudlaşdırılması üçün istifadə olunur.

### 3.3. Sistemlərin təhlükəsizliyi

Windows və Linux serverləri müntəzəm yenilənməlidir.

Lazımsız xidmətlər deaktiv edilməli və hücum səthi azaldılmalıdır.

### 3.4. Audit

Kritik sistemlərə girişlər və konfiqurasiya dəyişiklikləri audit məqsədilə qeydiyyata alınmalıdır.

## 4. Data Protection — Məlumatların Qorunması

Korporativ məlumatlar dörd səviyyəyə bölünür:

| Səviyyə | Təsvir |
|---|---|
| Public | İctimai paylaşım üçün nəzərdə tutulan məlumat |
| Internal | Şirkətdaxili məlumat |
| Confidential | Məxfi korporativ və müştəri məlumatları |
| Restricted | Kritik və yüksək həssaslıqlı məlumat |

Məxfi məlumatlara giriş yalnız səlahiyyətli şəxslərə verilməlidir.

Ötürülmə və saxlanma zamanı uyğun şifrələmə tətbiq edilməlidir.

## 5. Monitoring and Incident Response — Monitorinq və İnsidentlər

SOC komandası təhlükəsizlik hadisələrinin monitorinqi, təhlili və eskalasiyasına cavabdehdir.

Şübhəli girişlər, məlumat sızması və digər təhlükəsizlik pozuntuları Incident Response Policy əsasında araşdırılmalıdır.

## 6. Risk, Backup and Compliance — Risk, Backup və Uyğunluq

Kritik məlumatlar üçün təhlükəsiz backup və bərpa prosedurları tətbiq edilməlidir.

Risklər Risk Register-də qiymətləndirilməli və aylıq nəzərdən keçirilməlidir.

Təhlükəsizlik nəzarətləri aşağıdakı çərçivələrin prinsipləri nəzərə alınmaqla idarə edilməlidir:

- ISO/IEC 27001;
- NIST Cybersecurity Framework;
- CIS Controls.

Siyasət ildə ən azı bir dəfə yenilənməlidir.

## 7. Approval — Təsdiq

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

**End of Document — KON-GRC-POL-001**

---

# 15.1.2 — ACCEPTABLE USE POLICY
## Korporativ Resurslardan Məqbul İstifadə Siyasəti

**Document ID:** KON-GRC-POL-002

**Version:** 1.0 | **Classification:** Internal

**Owner:** Information Security Manager | **Review:** Annually

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

Bu siyasət KONRDERK Cybersecurity şirkətinin informasiya sistemlərindən, korporativ şəbəkəsindən və məlumatlarından təhlükəsiz istifadə qaydalarını müəyyən edir.

Tələblər bütün əməkdaşlara və sistemlərə giriş hüququ olan üçüncü tərəflərə şamil edilir.

## 2. Account and Device Usage — Hesab və Cihazlardan İstifadə

### 2.1. Fərdi istifadəçi hesabları

Hər bir istifadəçi yalnız özünə məxsus Active Directory və ya Keycloak hesabından istifadə etməlidir.

Başqa şəxsin hesabından istifadə edilməməlidir.

### 2.2. Autentifikasiya məlumatları

Parolların və MFA kodlarının digər şəxslərlə paylaşılması qadağandır.

### 2.3. Korporativ cihazlar

Korporativ cihazlara icazəsiz proqram təminatı quraşdırılmamalıdır.

Təhlükəsizlik mexanizmləri deaktiv edilməməlidir.

### 2.4. USB cihazları

USB cihazlarının istifadəsi təsdiqlənmiş qaydalara və USBGuard məhdudiyyətlərinə uyğun olmalıdır.

Bu nəzarət icazəsiz çıxarıla bilən daşıyıcıların istifadəsini məhdudlaşdırmaq üçün nəzərdə tutulmuşdur.

## 3. Network and Administrative Access — Şəbəkə və Administrator Girişləri

### 3.1. Şəbəkə qaydalarına riayət

LAN, DMZ, Server Zone və digər şəbəkə zonaları arasında trafik Firewall qaydalarına uyğun olmalıdır.

### 3.2. Administrator girişləri

Administratorların kritik sistemlərə girişləri JumpServer PAM vasitəsilə idarə edilməlidir.

### 3.3. Qadağan edilmiş fəaliyyətlər

Aşağıdakılar icazəsiz həyata keçirilə bilməz:

- Port scanning;
- RDP və SSH bağlantıları;
- Təhlükəsizlik məhdudiyyətlərindən yayınma;
- Korporativ sistemlərdə təsdiqlənməmiş təhlükəsizlik testləri.

Təhlükəsizlik testləri yalnız əvvəlcədən təsdiqlənmiş əhatə dairəsində aparıla bilər.

## 4. Applications and Data Protection — Tətbiqlər və Məlumatların Qorunması

### 4.1. Korporativ tətbiqlər

Aşağıdakı sistemlər yalnız səlahiyyətli iş məqsədləri üçün istifadə edilməlidir:

| Tətbiq | İstifadə sahəsi |
|---|---|
| Gitea | Kod və repository idarəetməsi |
| Wiki.js | Daxili sənədləşdirmə |
| Nextcloud | Fayl paylaşımı |
| Grafana | Monitorinq və vizuallaşdırma |

### 4.2. Məxfi məlumatların qorunması

Repository-lərdə aşağıdakı məlumatların saxlanılması qadağandır:

- Parollar;
- API token-ləri;
- Private key-lər.

### 4.3. Məlumat bazaları və backup

PostgreSQL məlumatlarına və backup nüsxələrinə giriş yalnız səlahiyyətli şəxslərə verilməlidir.

### 4.4. Məlumatların paylaşılması

Confidential və Restricted məlumatların icazəsiz paylaşılması və şəxsi cihazlara köçürülməsi qadağandır.

## 5. Monitoring and Incident Reporting — Monitorinq və İnsidentlər

Korporativ sistemlərdə aşağıdakı fəaliyyətlər audit məqsədilə qeydiyyata alınmalıdır:

- İstifadəçi girişləri;
- Administrator fəaliyyəti;
- Təhlükəsizlik hadisələri.

İstifadəçilərin audit loglarını silməsi və ya dəyişdirməsi qadağandır.

Aşağıdakı hadisələr dərhal SOC komandasına bildirilməlidir:

- Şübhəli giriş;
- Phishing;
- Zərərli proqram;
- Məlumat sızması.

Hadisələr KON-GRC-POL-003 Incident Response Policy əsasında araşdırılmalıdır.

## 6. Compliance and Enforcement — Uyğunluq və Nəzarət

Siyasətin pozulması giriş hüquqlarının məhdudlaşdırılması və daxili araşdırma ilə nəticələnə bilər.

Information Security Manager siyasətin icrasına nəzarət edir.

Sənəd ildə ən azı bir dəfə və ya infrastrukturda əhəmiyyətli dəyişiklik olduqda yenilənməlidir.

## 7. Approval — Təsdiq

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

**End of Document — KON-GRC-POL-002**

---

# 15.1.3 — INCIDENT RESPONSE POLICY
## İnformasiya Təhlükəsizliyi İnsidentlərinə Cavab Siyasəti

**Document ID:** KON-GRC-POL-003

**Version:** 1.0 | **Classification:** Internal

**Owner:** Information Security Manager | **Review:** Annually

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

Bu siyasət KONRDERK Cybersecurity şirkətində təhlükəsizlik insidentlərinin aşkarlanması, araşdırılması və aradan qaldırılması qaydalarını müəyyən edir.

Siyasət bütün əməkdaşlara, SOC komandasına və korporativ infrastruktura şamil edilir.

## 2. Roles and Responsibilities — Məsuliyyətlər

| Rol | Məsuliyyət |
|---|---|
| SOC Analysts | Xəbərdarlıqların təhlili və şübhəli hadisələrin qeydiyyatı |
| SOC Lead | İnsidentlərin prioritetləşdirilməsi və cavab tədbirlərinin koordinasiyası |
| Incident Responders | Təhdidin məhdudlaşdırılması, sübutların toplanması və bərpa |
| Information Security Manager | Kritik insidentlərin rəhbərliyə eskalasiyası və uyğunluq nəzarəti |

### 2.1. SOC Analysts

SOC analitikləri təhlükəsizlik xəbərdarlıqlarını təhlil edir və şübhəli hadisələri qeydiyyata alırlar.

### 2.2. SOC Lead

SOC Lead insidentləri prioritetləşdirir və cavab tədbirlərini koordinasiya edir.

### 2.3. Incident Responders

Incident Responders təhdidin məhdudlaşdırılması, sübutların toplanması və bərpa işlərini həyata keçirirlər.

### 2.4. Information Security Manager

Information Security Manager kritik insidentləri rəhbərliyə eskalasiya edir və uyğunluq tələblərinə nəzarət edir.

## 3. Incident Classification — İnsidentlərin Təsnifatı

| Severity | Description | Priority |
|---|---|---|
| Critical | Domen komprometasiyası, genişmiqyaslı məlumat sızması | Immediate |
| High | Administrator hesabının ələ keçirilməsi, ciddi zərərli proqram fəaliyyəti | Urgent |
| Medium | Məhdud sistemə təsir edən təhlükəsizlik pozuntusu | Standard |
| Low | Az təsirli təhlükəsizlik hadisəsi | Routine |

### Critical

Domen komprometasiyası və genişmiqyaslı məlumat sızması kimi hadisələr Critical olaraq qiymətləndirilir və dərhal cavab tələb edir.

### High

Administrator hesabının ələ keçirilməsi və ciddi zərərli proqram fəaliyyəti High səviyyəsinə aid edilir.

### Medium

Məhdud sistemə təsir edən təhlükəsizlik pozuntuları Medium səviyyəsində qiymətləndirilir.

### Low

Az təsirli təhlükəsizlik hadisələri Low səviyyəsində qiymətləndirilir.

## 4. Incident Response Process — Cavab Prosesi

İnsidentlər altı mərhələdə idarə edilməlidir.

### 4.1. Detection — Aşkarlanma

Hadisə aşağıdakı mənbələr əsasında aşkarlana bilər:

- SOC monitorinqi;
- Sistem logları;
- Firewall xəbərdarlıqları;
- Suricata xəbərdarlıqları.

### 4.2. Analysis — Analiz

Bu mərhələdə:

1. Təsirlənmiş sistemlər müəyyən edilir.
2. Hadisənin səbəbi araşdırılır.
3. Severity səviyyəsi müəyyən edilir.

### 4.3. Containment — Məhdudlaşdırma

Mümkün cavab tədbirləri:

- Komprometasiya olunmuş hesabların bloklanması;
- Şübhəli trafikin dayandırılması;
- Təsirlənmiş sistemlərin izolyasiyası.

### 4.4. Eradication — Təhlükənin aradan qaldırılması

Zərərli komponentlər və istismar edilmiş zəifliklər aradan qaldırılmalıdır.

### 4.5. Recovery — Bərpa

Sistemlər təhlükəsiz vəziyyətə qaytarılmalıdır.

Zərurət yarandıqda backup nüsxələrindən bərpa həyata keçirilməlidir.

### 4.6. Lessons Learned — Nəticələrin təhlili

İnsident sənədləşdirilməli və təkrarlanmanın qarşısını alan tədbirlər müəyyən edilməlidir.

## 5. Evidence and Reporting — Sübutlar və Hesabat

### 5.1. Sübut mənbələri

Sübutlar aşağıdakı sistemlərdən əldə edilə bilər:

- Active Directory;
- Keycloak;
- JumpServer PAM;
- Firewall;
- Digər korporativ sistemlər.

Sübutlar bütövlüyü qorunmaqla saxlanılmalıdır.

### 5.2. İnsident qeydiyyatı

Hər təsdiqlənmiş insident üçün aşağıdakı məlumatlar qeyd edilməlidir:

| Sahə | Təsvir |
|---|---|
| Incident ID | İnsidentin identifikatoru |
| Date | Hadisənin tarixi |
| Affected System | Təsirlənmiş sistem |
| Severity | İnsidentin kritikliyi |
| Actions Taken | Görülmüş tədbirlər |
| Outcome | Nəticə |

### 5.3. Eskalasiya

High və Critical insidentlər SOC Lead və Information Security Manager-ə dərhal eskalasiya olunmalıdır.

Şəxsi məlumatlarla bağlı insidentlərdə tətbiq olunan hüquqi bildiriş tələbləri qiymətləndirilməlidir.

## 6. Review and Compliance — Nəzarət və Uyğunluq

İnsidentlərdən əldə edilən nəticələr Risk Register-də nəzərə alınmalıdır.

Cavab prosedurları periodik yoxlanılmalıdır.

Siyasət ildə ən azı bir dəfə və ya ciddi insidentdən sonra yenilənməlidir.

## 7. Approval — Təsdiq

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

**End of Document — KON-GRC-POL-003**

---

# 15.1.4 — REMOTE ACCESS POLICY
## Uzaqdan Giriş Siyasəti

**Document ID:** KON-GRC-POL-004

**Version:** 1.0 | **Classification:** Internal

**Owner:** Information Security Manager | **Review:** Annually

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

Bu siyasət KONRDERK Cybersecurity şirkətinin serverlərinə və korporativ sistemlərinə uzaqdan girişin təhlükəsiz idarə olunmasını təmin edir.

Tələblər administratorlara, əməkdaşlara və uzaqdan giriş icazəsi verilmiş üçüncü tərəflərə şamil edilir.

## 2. Access Authorization — Giriş İcazələri

### 2.1. İş ehtiyacı və Least Privilege

Uzaqdan giriş yalnız iş ehtiyacına əsasən və Least Privilege prinsipi ilə verilməlidir.

### 2.2. Mərkəzləşdirilmiş hesab idarəetməsi

İstifadəçi hesabları Active Directory, SSO və MFA xidmətləri isə Keycloak vasitəsilə idarə olunur.

### 2.3. Fərdi autentifikasiya

Hər istifadəçi fərdi hesabdan istifadə etməlidir.

Parolların və MFA kodlarının paylaşılması qadağandır.

### 2.4. Giriş hüquqlarının ləğvi

İşdən ayrılan əməkdaşların uzaqdan giriş hüquqları dərhal ləğv edilməlidir.

## 3. Privileged Remote Access — İmtiyazlı Girişlər

### 3.1. JumpServer PAM

Kritik Windows və Linux serverlərinə administrator girişləri JumpServer PAM vasitəsilə idarə edilməlidir.

### 3.2. DC01 RDP nəzarəti

DC01 serverinə RDP bağlantıları PAM üzərindən həyata keçirilir.

Birbaşa RDP girişləri Firewall ilə məhdudlaşdırılır.

### 3.3. Administrator sessiyalarının auditi

Administrator sessiyaları audit məqsədilə qeydiyyata alınmalı və icazəsiz dəyişiklikdən qorunmalıdır.

### 3.4. Windows LAPS

SRV01 serverində lokal administrator parolları Windows LAPS vasitəsilə 30 günlük rotasiya ilə idarə olunur.

## 4. Network and Session Security — Şəbəkə və Sessiya Təhlükəsizliyi

### 4.1. RDP və SSH məhdudiyyətləri

RDP və SSH bağlantıları yalnız təsdiqlənmiş mənbələrdən və portlardan qəbul edilməlidir.

### 4.2. Şəbəkə zonaları

Aşağıdakı zonalara giriş Firewall qaydaları ilə məhdudlaşdırılmalıdır:

- LAN;
- DMZ;
- Server Zone;
- Backup VM şəbəkəsi.

### 4.3. Xarici giriş

Xarici şəbəkədən giriş tələb olunduqda təsdiqlənmiş şifrəli bağlantı və MFA tətbiq edilməlidir.

### 4.4. Sessiya müddəti

Administrator sessiyaları üçün fəaliyyətsizlik müddəti məhdudlaşdırılmalı və istifadəsiz sessiyalar bağlanmalıdır.

Bu siyasət tələbidir; konkret timeout testinin tamamlanma vəziyyəti ayrıca Compliance Assessment-də qiymətləndirilir.

## 5. Monitoring and Incident Reporting — Monitorinq və İnsidentlər

Aşağıdakı hadisələr qeydiyyata alınmalıdır:

- Uzaqdan giriş cəhdləri;
- Administrator əməliyyatları;
- Uğursuz autentifikasiya hadisələri.

Şübhəli RDP/SSH bağlantıları, hesab komprometasiyası və icazəsiz giriş halları SOC komandasına bildirilməlidir.

Hadisələr KON-GRC-POL-003 Incident Response Policy əsasında araşdırılmalıdır.

## 6. Compliance and Review — Uyğunluq və Yenilənmə

Siyasətin pozulması giriş hüquqlarının məhdudlaşdırılması və daxili araşdırma ilə nəticələnə bilər.

Information Security Manager siyasətin icrasına nəzarət edir.

Sənəd ildə ən azı bir dəfə və ya uzaqdan giriş infrastrukturunda əhəmiyyətli dəyişiklik olduqda yenilənməlidir.

## 7. Approval — Təsdiq

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

**End of Document — KON-GRC-POL-004**

---

# 15.1.5 — DATA CLASSIFICATION POLICY
## Məlumatların Təsnifatı Siyasəti

**Document ID:** KON-GRC-POL-005

**Version:** 1.0 | **Classification:** Internal

**Owner:** Information Security Manager | **Review:** Annually

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

Bu siyasət KONRDERK Cybersecurity şirkətində məlumatların həssaslıq səviyyəsinə uyğun təsnif edilməsini, saxlanılmasını və qorunmasını tənzimləyir.

Tələblər bütün əməkdaşlara, korporativ sistemlərə və məlumatlara giriş hüququ olan üçüncü tərəflərə şamil edilir.

## 2. Data Classification Levels — Təsnifat Səviyyələri

| Level | Description | Example |
|---|---|---|
| Public | İctimai paylaşılması təsdiqlənmiş məlumatlar | Şirkət elanları |
| Internal | Yalnız şirkətdaxili məlumatlar | Daxili sənədlər |
| Confidential | Məxfi korporativ və müştəri məlumatları | Təhlükəsizlik hesabatları |
| Restricted | Kritik və yüksək həssaslıqlı məlumatlar | Parollar, private key-lər, backup açarları |

### 2.1. Public

İctimai paylaşılması təsdiqlənmiş məlumatları əhatə edir.

Nümunə: şirkət elanları.

### 2.2. Internal

Yalnız təşkilat daxilində istifadə olunması nəzərdə tutulan məlumatları əhatə edir.

Nümunə: daxili sənədlər.

### 2.3. Confidential

Məxfi korporativ və müştəri məlumatlarını əhatə edir.

Nümunə: təhlükəsizlik hesabatları.

### 2.4. Restricted

Kritik və yüksək həssaslıqlı məlumatları əhatə edir.

Nümunələr:

- Parollar;
- Private key-lər;
- Backup açarları.

## 3. Data Handling and Access — Məlumatların İdarə Edilməsi

### 3.1. Giriş hüquqları

Məlumatlara giriş Least Privilege və RBAC prinsipləri əsasında verilməlidir.

### 3.2. Məxfi məlumatların paylaşılması

Confidential və Restricted məlumatlar yalnız səlahiyyətli şəxslərlə paylaşılmalıdır.

### 3.3. Korporativ sistemlərdə məlumatların qorunması

Aşağıdakı sistemlər müvafiq giriş icazələri ilə qorunmalıdır:

- Nextcloud fayl paylaşımı;
- Gitea repository-ləri;
- PostgreSQL məlumatları.

### 3.4. Açıq mətn məlumatları

Parolların, API token-lərinin və private key-lərin açıq mətn formasında saxlanılması qadağandır.

## 4. Storage, Transfer and Backup — Saxlama və Backup

### 4.1. Şifrəli ötürülmə

Məxfi məlumatların ötürülməsi zamanı HTTPS/TLS kimi şifrəli bağlantılardan istifadə edilməlidir.

### 4.2. İcazəsiz köçürmə

Korporativ məlumatların şəxsi e-poçt və icazəsiz bulud xidmətlərinə köçürülməsi qadağandır.

### 4.3. Backup təhlükəsizliyi

Backup nüsxələri məlumatın təsnifat səviyyəsinə uyğun qorunmalı və şifrələnməlidir.

### 4.4. P2-Backup

P2-Backup serverinin IP ünvanı:

~~~text id="grc1505a"
192.168.40.10
~~~

Bu serverdə saxlanılan ehtiyat nüsxələrinə giriş yalnız səlahiyyətli şəxslərə verilməlidir.

Bu siyasət backup mühafizəsi tələbini müəyyən edir; backup və restore testlərinin faktiki təsdiqi ayrıca qiymətləndirilir.

### 4.5. Təhlükəsiz silinmə

Saxlanma müddəti başa çatan məlumatlar hüquqi tələblərə uyğun təhlükəsiz silinməlidir.

## 5. Data Breach and Responsibilities — Məlumat Sızması və Məsuliyyətlər

| Rol | Məsuliyyət |
|---|---|
| Information Security Manager | Məlumatların qorunması tələblərinə nəzarət |
| System Administrators | Texniki giriş məhdudiyyətlərinin tətbiqi |
| Employees | Məlumatların təsnifatına uyğun istifadəsi |
| SOC Team | Bildirilmiş təhlükəsizlik hadisələrinin araşdırılması |

Məlumatların itirilməsi, icazəsiz paylaşılması və ya dəyişdirilməsi dərhal SOC komandasına bildirilməlidir.

Hadisələr KON-GRC-POL-003 Incident Response Policy əsasında araşdırılmalıdır.

## 6. Compliance and Review — Uyğunluq və Yenilənmə

Məlumatların emalı Azərbaycan Respublikasının tətbiq olunan fərdi məlumatlar qanunvericiliyinə uyğun aparılmalıdır.

Siyasət ildə ən azı bir dəfə və ya məlumatların emalı qaydaları dəyişdikdə nəzərdən keçirilməlidir.

## 7. Approval — Təsdiq

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

**End of Document — KON-GRC-POL-005**

---

# 15.1.6 — PASSWORD MANAGEMENT POLICY
## Parolların İdarə Edilməsi Siyasəti

**Document ID:** KON-GRC-POL-006

**Version:** 1.0 | **Classification:** Internal

**Owner:** Information Security Manager | **Review:** Annually

## 1. Purpose and Scope — Məqsəd və Əhatə Dairəsi

Bu siyasət KONRDERK Cybersecurity şirkətində istifadəçi və administrator parollarının yaradılması, qorunması və idarə olunması qaydalarını müəyyən edir.

Tələblər bütün əməkdaşlara, korporativ hesablara və sistemlərə giriş hüququ olan üçüncü tərəflərə şamil edilir.

## 2. Password Requirements — Parol Tələbləri

| Requirement | Policy |
|---|---|
| User Password | Minimum 12 simvol |
| Administrator Password | Minimum 16 simvol |
| Complexity | Böyük və kiçik hərf, rəqəm və xüsusi simvol |
| Default Password | İlk istifadədən əvvəl dəyişdirilməlidir |
| Compromised Password | Dərhal dəyişdirilməlidir |
| Password Reuse | Əvvəlki parolların təkrar istifadəsi məhdudlaşdırılmalıdır |

### 2.1. İstifadəçi parolları

Adi istifadəçi parollarının minimum uzunluğu 12 simvol olmalıdır.

### 2.2. Administrator parolları

Administrator parollarının minimum uzunluğu 16 simvol olmalıdır.

### 2.3. Mürəkkəblik

Parollarda aşağıdakı simvol qrupları nəzərdə tutulur:

- Böyük hərflər;
- Kiçik hərflər;
- Rəqəmlər;
- Xüsusi simvollar.

### 2.4. Default parollar

İlkin və standart parollar ilk istifadədən əvvəl dəyişdirilməlidir.

### 2.5. Komprometasiya edilmiş parollar

Komprometasiya edildiyi müəyyən edilən parollar dərhal dəyişdirilməlidir.

### 2.6. Təkrar istifadə

Əvvəlki parolların təkrar istifadəsi məhdudlaşdırılmalıdır.

Parollar şəxsi məlumatlardan və asan təxmin edilən kombinasiyalardan ibarət olmamalıdır.

## 3. Authentication and Privileged Accounts — Autentifikasiya və İmtiyazlı Hesablar

### 3.1. Active Directory və Keycloak

İstifadəçi hesabları Active Directory vasitəsilə idarə olunur.

SSO və OTP əsaslı MFA Keycloak vasitəsilə təmin olunur.

### 3.2. Kritik sistemlərə giriş

Kritik sistemlərə giriş zamanı MFA tətbiq edilməlidir.

Administrator hesabları gündəlik istifadəçi hesablarından ayrılmalıdır.

### 3.3. JumpServer PAM

İmtiyazlı girişlər JumpServer PAM vasitəsilə nəzarətdə saxlanılmalıdır.

### 3.4. Windows LAPS

SRV01 serverində Windows LAPS aşağıdakı parametrlərlə tətbiq olunur:

| Parametr | Dəyər |
|---|---|
| Server | SRV01 |
| Həll | Windows LAPS |
| Parol uzunluğu | 16 simvol |
| Parol növü | Kompleks |
| Rotasiya müddəti | 30 gün |

Bu mexanizm lokal administrator parollarının avtomatlaşdırılmış idarə edilməsinə xidmət edir.

## 4. Password Storage and Protection — Parolların Qorunması

### 4.1. Məxfilik

Aşağıdakı məlumatların paylaşılması qadağandır:

- Parollar;
- MFA kodları;
- Recovery code-lar.

### 4.2. Açıq mətn saxlanması

Parollar aşağıdakı yerlərdə saxlanılmamalıdır:

- Gitea repository-ləri;
- E-poçt mesajları;
- Açıq mətn faylları.

### 4.3. Restricted məlumatlar

Aşağıdakılar Restricted məlumat kimi qorunmalıdır:

- API token-ləri;
- Private key-lər;
- Backup şifrələmə açarları.

### 4.4. Şifrəli bağlantılar

Autentifikasiya məlumatlarının ötürülməsi təhlükəsiz HTTPS/TLS bağlantıları üzərindən həyata keçirilməlidir.

## 5. Password Reset and Monitoring — Parolun Sıfırlanması və Monitorinq

### 5.1. Şəxsiyyətin yoxlanılması

Parol sıfırlanmadan əvvəl istifadəçinin şəxsiyyəti yoxlanılmalıdır.

### 5.2. Şübhəli hesab fəaliyyəti

Şübhəli hesab fəaliyyəti zamanı:

1. Parol dəyişdirilməlidir.
2. Aktiv sessiyalar nəzərdən keçirilməlidir.
3. Təhlükəsizlik hadisəsi qiymətləndirilməlidir.

### 5.3. Audit

Uğursuz giriş cəhdləri və administrator hesablarının istifadəsi audit məqsədilə qeydiyyata alınmalıdır.

### 5.4. Brute-force və komprometasiya

Brute-force və hesab komprometasiyası halları SOC komandasına bildirilməlidir.

Bu hadisələr KON-GRC-POL-003 Incident Response Policy əsasında araşdırılmalıdır.

## 6. Compliance and Review — Uyğunluq və Yenilənmə

System Administrators parol siyasətlərinin texniki tətbiqinə cavabdehdir.

Information Security Manager ümumi nəzarəti həyata keçirir.

Siyasət ISO/IEC 27001 və CIS Controls prinsipləri nəzərə alınmaqla ildə ən azı bir dəfə nəzərdən keçirilməlidir.

## 7. Approval — Təsdiq

| Responsibility | Signature | Date |
|---|---|---|
| Information Security Manager | __________ | __________ |
| CEO | __________ | __________ |

**End of Document — KON-GRC-POL-006**

---

# 15.1 — ÜMUMİ YEKUN

KONRDERK Cybersecurity CSOC layihəsi çərçivəsində altı informasiya təhlükəsizliyi siyasəti hazırlanmışdır.

| Document ID | Siyasət | Əsas təhlükəsizlik istiqaməti |
|---|---|---|
| KON-GRC-POL-001 | Information Security Policy | İnformasiya aktivlərinin qorunması və ümumi təhlükəsizlik nəzarətləri |
| KON-GRC-POL-002 | Acceptable Use Policy | Korporativ hesab, cihaz, tətbiq və şəbəkə resurslarından məqbul istifadə |
| KON-GRC-POL-003 | Incident Response Policy | Təhlükəsizlik insidentlərinin aşkarlanması, araşdırılması və bərpası |
| KON-GRC-POL-004 | Remote Access Policy | RDP, SSH, PAM, MFA və uzaqdan giriş təhlükəsizliyi |
| KON-GRC-POL-005 | Data Classification Policy | Məlumatların təsnifatı, saxlanılması və qorunması |
| KON-GRC-POL-006 | Password Management Policy | Parol tələbləri, MFA, LAPS və autentifikasiya məlumatlarının qorunması |

Siyasətlər Active Directory, Keycloak, JumpServer PAM, nftables Firewall, Suricata, DNS Sinkhole, USBGuard, Gitea, Wiki.js, Nextcloud, Grafana, PostgreSQL və backup infrastrukturu ilə əlaqələndirilmişdir.

Sənədlər üçün Version 1.0, Internal təsnifatı, Information Security Manager məsuliyyəti və illik nəzərdən keçirilmə tələbi müəyyən edilmişdir.

Hər siyasət üzrə Information Security Manager və CEO üçün təsdiq bölməsi nəzərdə tutulmuşdur.

Bu siyasətlər Bölmə 15.2 — Risk Register və Bölmə 15.3 — Compliance Assessment sənədləri ilə birlikdə layihənin GRC çərçivəsini təşkil edir.

## Əlaqəli sənədlər

- [Section 15 — README](README.md)
- [Risk Register](risk-register.md)
- [Compliance Assessment](compliance-assessment.md)
- [Verification Checklist](verification-checklist.md)

---

**Section:** 15.1 — Policy Library

**Organization:** KONRDERK Cybersecurity

**Documents:** KON-GRC-POL-001 — KON-GRC-POL-006

**Classification:** Internal

**Version:** 1.0
