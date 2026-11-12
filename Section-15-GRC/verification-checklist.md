# Section 15 — GRC Verification Checklist
## KONRDERK Cybersecurity — Governance, Risk & Compliance

**Project:** CSOC Final Project  
**Section:** 15 — Governance, Risk & Compliance  
**Organization:** KONRDERK Cybersecurity  
**Verification Scope:** Security Policies, Risk Register, Compliance Assessment  
**Overall Compliance Result:** PARTIALLY COMPLIANT

---

## 1. Məqsəd və yoxlama meyarları

Bu sənəd CSOC Final Project çərçivəsində Bölmə 15 — Governance, Risk & Compliance (GRC) üzrə hazırlanmış materialların yoxlama siyahısıdır.

Layihə hesabatında GRC bölməsi üç əsas tapşırıqdan ibarətdir:

1. **15.1 — Siyasət Kitabxanası:** Altı informasiya təhlükəsizliyi siyasətinin hazırlanması.
2. **15.2 — Risk Register:** Ən azı 20 riskin müəyyənləşdirilməsi, qiymətləndirilməsi və azaltma tədbirlərinin planlaşdırılması.
3. **15.3 — Compliance Assessment:** Standartlara uyğunluğun qiymətləndirilməsi, Gap Analysis, uyğunluq hesabatı və fərdi məlumatların emalı prosedurları.

Yoxlama iki fərqli anlayışı ayırır:

- **Documentation completed:** Sənədin layihə çərçivəsində hazırlanması.
- **Technical compliance verified:** Nəzarətin tətbiqinin və effektivliyinin texniki sübutlarla təsdiqlənməsi.

Sənədin hazırlanması bütün texniki və təşkilati tələblərin tam icra edildiyini göstərmir.

### Status işarələri

- [x] — Layihə hesabatında hazırlanmış və ya qiymətləndirilmişdir.
- [ ] — Əlavə yoxlama, təsdiq və ya düzəldici tədbir tələb edir.

---

## 2. Bölmə 15.1 — Security Policy Library

### 2.1. Altı təhlükəsizlik siyasətinin mövcudluğu

- [x] Information Security Policy hazırlanıb.
- [x] Acceptable Use Policy hazırlanıb.
- [x] Incident Response Policy hazırlanıb.
- [x] Remote Access Policy hazırlanıb.
- [x] Data Classification Policy hazırlanıb.
- [x] Password Management Policy hazırlanıb.

### 2.2. Sənəd identifikatorları

| № | Siyasət | Document ID | Sənədləşmə |
|---|---|---|---|
| 1 | Information Security Policy | KON-GRC-POL-001 | Hazırlanıb |
| 2 | Acceptable Use Policy | KON-GRC-POL-002 | Hazırlanıb |
| 3 | Incident Response Policy | KON-GRC-POL-003 | Hazırlanıb |
| 4 | Remote Access Policy | KON-GRC-POL-004 | Hazırlanıb |
| 5 | Data Classification Policy | KON-GRC-POL-005 | Hazırlanıb |
| 6 | Password Management Policy | KON-GRC-POL-006 | Hazırlanıb |

### 2.3. Siyasət məzmununun yoxlanılması

- [x] İnformasiya aktivlərinin məxfiliyi, bütövlüyü və əlçatanlığı təsvir edilib.
- [x] Least Privilege və RBAC prinsipləri göstərilib.
- [x] Active Directory, Keycloak SSO/MFA və JumpServer PAM nəzarətləri sənədləşdirilib.
- [x] Şəbəkə təhlükəsizliyi üçün Firewall, Suricata və DNS Sinkhole qeyd edilib.
- [x] Korporativ cihaz və hesabların məqbul istifadəsi qaydaları müəyyən edilib.
- [x] USBGuard və icazəsiz proqram istifadəsi üzrə məhdudiyyətlər təsvir edilib.
- [x] Incident Response rolları və reaksiya mərhələləri müəyyən edilib.
- [x] Uzaqdan giriş, RDP/SSH və imtiyazlı sessiya tələbləri göstərilib.
- [x] Məlumatların Public, Internal, Confidential və Restricted təsnifatı hazırlanıb.
- [x] Adi istifadəçilər üçün minimum 12 simvol parol tələbi göstərilib.
- [x] Administratorlar üçün minimum 16 simvol parol tələbi göstərilib.
- [x] SRV01 üzərində Windows LAPS və 30 günlük rotasiya tələbi sənədləşdirilib.

### 2.4. Təsdiq və dövri baxış

- [x] Siyasətlərdə Version 1.0 göstərilib.
- [x] Internal təsnifatı göstərilib.
- [x] Information Security Manager sənəd sahibi kimi müəyyən edilib.
- [x] İllik baxış tələbi müəyyən edilib.
- [x] Information Security Manager və CEO üçün təsdiq sahələri yaradılıb.
- [ ] Siyasətlərin faktiki imzalanması və təsdiq tarixləri ayrıca qeydə alınmalıdır.
- [ ] Policy approval register hazırlanmalı və illik baxış qeydləri saxlanmalıdır.

**Əlaqəli Gap:** G-10 — Medium.

### 2.5. Nəticə

**Sənədləşmə:** Tamamlanıb.

**Rəsmi təsdiq qeydləri:** Əlavə tədbir tələb edir.

**GitHub faylı:** [security-policies.md](security-policies.md)

---

## 3. Bölmə 15.2 — Risk Register

### 3.1. Risk reyestrinin hazırlanması

- [x] Risk Register sənədi hazırlanıb.
- [x] KON-GRC-RSK-001 sənəd identifikatoru müəyyən edilib.
- [x] 20 informasiya təhlükəsizliyi riski qeydiyyata alınıb.
- [x] Risklər R-01-dən R-20-yə qədər identifikatorlarla göstərilib.
- [x] Risk sahibləri müəyyən edilib.
- [x] Azaltma tədbirləri sənədləşdirilib.
- [x] İlkin və hədəf residual risklər göstərilib.

### 3.2. Qiymətləndirmə metodologiyası

- [x] Likelihood 1–5 şkalası ilə qiymətləndirilib.
- [x] Impact 1–5 şkalası ilə qiymətləndirilib.
- [x] Risk Score = Likelihood × Impact düsturu tətbiq edilib.
- [x] Low, Medium, High və Critical səviyyələri müəyyən edilib.
- [x] Residual Risk hesablamaları göstərilib.

### 3.3. Risklərin əhatə dairəsi

- [x] Active Directory və domen komprometasiyası riskləri.
- [x] Privileged account və MFA riskləri.
- [x] Keycloak və PKI riskləri.
- [x] Firewall və şəbəkə segmentasiyası riskləri.
- [x] Suricata və DNS təhlükəsizliyi riskləri.
- [x] PostgreSQL və məlumat sızması riskləri.
- [x] Backup və bərpa riskləri.
- [x] Gitea və Nextcloud riskləri.
- [x] Phishing və istifadəçi hesabları riskləri.
- [x] VMware platforması riskləri.
- [x] USB təhlükəsizliyi riskləri.
- [x] PAM loglarının saxlanılması riskləri.
- [x] Patch management və zəiflik riskləri.
- [x] İnsidentə gec reaksiya riski.

### 3.4. Risk prioritetlərinin yoxlanılması

- [x] R-03 — Privileged hesabın ələ keçirilməsi ən yüksək ilkin risk kimi göstərilib.
- [x] Critical risklər üçün dərhal eskalasiya tələbi müəyyən edilib.
- [x] High risklər üçün prioritet tədbirlər planı nəzərdə tutulub.
- [x] Medium və Low risklər üçün planlı monitorinq müəyyən edilib.

### 3.5. Risklərin idarə edilməsi

- [x] Mitigate yanaşması sənədləşdirilib.
- [x] Avoid yanaşması sənədləşdirilib.
- [x] Transfer yanaşması sənədləşdirilib.
- [x] Accept yanaşması sənədləşdirilib.
- [x] Risk Register üçün aylıq baxış tələbi müəyyən edilib.
- [x] Information Security Manager məsul şəxs kimi göstərilib.
- [ ] Hədəf residual risklər faktiki nəzarət nəticələri ilə yenidən təsdiqlənməlidir.
- [ ] Düzəldici tədbirlərin icrası üzrə aylıq baxış qeydləri saxlanmalıdır.

### 3.6. Nəticə

**Risklərin müəyyənləşdirilməsi və sənədləşdirilməsi:** Tamamlanıb.

**Residual risklərin faktiki təsdiqi və davamlı izlənməsi:** Əlavə yoxlama tələb edir.

**GitHub faylı:** [risk-register.md](risk-register.md)

---

## 4. Bölmə 15.3 — Compliance Assessment

### 4.1. Beynəlxalq standartlar

- [x] ISO/IEC 27001:2022 üzrə qiymətləndirmə hazırlanıb.
- [x] NIST Cybersecurity Framework 2.0 üzrə qiymətləndirmə hazırlanıb.
- [x] CIS Controls v8.1 üzrə qiymətləndirmə hazırlanıb.
- [x] Implemented və Partial statusları müəyyən edilib.
- [x] İnfrastruktur sübutları nəzarətlərlə əlaqələndirilib.
- [x] Qiymətləndirmənin daxili uyğunluq analizi olduğu qeyd edilib.

### 4.2. ISO/IEC 27001:2022 nəzarətləri

| Control | Assessment | Yoxlama |
|---|---|---|
| A.5.15 — Access Control | Implemented | [x] |
| A.5.17 — Authentication Information | Implemented | [x] |
| A.8.2 — Privileged Access Rights | Implemented | [x] |
| A.8.13 — Information Backup | Partial | [x] |
| A.8.15 — Logging | Partial | [x] |
| A.8.20 — Network Security | Implemented | [x] |

Buradakı işarələr nəzarətlərin qiymətləndirmədə əks olunduğunu göstərir; Partial nəzarətlərin tam uyğunluğunu bildirmir.

### 4.3. NIST CSF 2.0 funksiyaları

| Function | Assessment | Yoxlama |
|---|---|---|
| Govern | Partial | [x] |
| Identify | Partial | [x] |
| Protect | Implemented | [x] |
| Detect | Partial | [x] |
| Respond | Partial | [x] |
| Recover | Partial | [x] |

### 4.4. CIS Controls v8.1

| Control | Assessment | Yoxlama |
|---|---|---|
| Controls 5–6 — Account and Access Management | Implemented | [x] |
| Control 8 — Audit Log Management | Partial | [x] |
| Control 11 — Data Recovery | Partial | [x] |
| Controls 12–13 — Network Infrastructure and Monitoring | Partial | [x] |
| Control 17 — Incident Response Management | Partial | [x] |

### 4.5. Gap Analysis

- [x] 10 uyğunluq boşluğu müəyyən edilib.
- [x] Hər boşluğa Gap ID verilib.
- [x] Hər boşluğun prioriteti göstərilib.
- [x] Düzəldici tədbirlər müəyyən edilib.
- [x] Risk sahibləri göstərilib.
- [x] 5 High və 5 Medium prioritetli boşluq qeyd edilib.

### 4.6. High Priority — Düzəldici tədbirlər

- [ ] **G-01:** PAM loglarının SIEM-ə inteqrasiyası tamamlanmalı və təsdiqlənməlidir.
  - Owner: SOC Lead
  - Corrective Action: Mərkəzləşdirilmiş log inteqrasiyası.

- [ ] **G-02:** Backup restore testləri aparılmalı və nəticələri təsdiqlənməlidir.
  - Owner: System Admin
  - Corrective Action: Planlı bərpa sınaqları.

- [ ] **G-03:** P2-Backup serverində backup job və storage vəziyyəti yoxlanılmalıdır.
  - Owner: System Admin
  - Corrective Action: Backup job və storage yoxlaması.

- [ ] **G-05:** Incident Response prosedurları tabletop və IR drill vasitəsilə sınaqdan keçirilməlidir.
  - Owner: SOC Lead
  - Corrective Action: Tabletop və IR drill.

- [ ] **G-06:** SIEM üzrə log source inventory və coverage testi tamamlanmalıdır.
  - Owner: SOC Lead
  - Corrective Action: Log source inventory və coverage testi.

### 4.7. Medium Priority — Düzəldici tədbirlər

- [ ] **G-04:** PAM session timeout mexanizmi test edilməlidir.
  - Owner: Security Engineer
  - Corrective Action: Session timeout testi.

- [ ] **G-07:** Zəifliklərin idarə edilməsi üzrə vahid hesabat hazırlanmalıdır.
  - Owner: Security Engineer
  - Corrective Action: Periodik vulnerability assessment.

- [ ] **G-08:** Backup retention və RPO/RTO tələbləri sənədləşdirilməlidir.
  - Owner: System Admin
  - Corrective Action: Retention, RPO/RTO planı.

- [ ] **G-09:** Fərdi məlumatların emalı reyestri hazırlanmalıdır.
  - Owner: GRC Lead
  - Corrective Action: Data processing register.

- [ ] **G-10:** Siyasətlərin təsdiq və illik baxış qeydləri saxlanmalıdır.
  - Owner: GRC Lead
  - Corrective Action: Policy approval register.

**Qeyd:** Yuxarıdakı boş xanalar hesabatda müəyyən edilmiş açıq uyğunluq məsələlərini göstərir. Bu, əsas texniki komponentlərin ümumiyyətlə qurulmadığı mənasına gəlmir.

---

## 5. Personal Data Protection — Fərdi Məlumatların Qorunması

### 5.1. Hüquqi əsasların sənədləşdirilməsi

- [x] Azərbaycan Respublikasının “Fərdi məlumatlar haqqında” Qanunu nəzərə alınıb.
- [x] Tətbiq olunduğu hallarda GDPR tələbləri qeyd edilib.

### 5.2. Səkkiz məlumat emalı proseduru

- [x] Purpose Limitation — məqsədin məhdudlaşdırılması.
- [x] Data Minimization — minimum zəruri məlumatın toplanması.
- [x] Lawful Processing — qanuni emal.
- [x] Access Control — RBAC və Least Privilege.
- [x] Secure Storage — təhlükəsiz saxlanma və şifrəli ötürülmə.
- [x] Retention and Deletion — saxlanma müddəti və təhlükəsiz silinmə.
- [x] Data Subject Rights — çıxış, düzəliş və silinmə hüquqları.
- [x] Breach Management — məlumat sızmasının idarə edilməsi.

### 5.3. Əlavə təsdiq

- [ ] Data processing register tamamlanmalıdır.
- [ ] Məlumatların saxlanma və silinmə müddətləri müvafiq qeydlərlə təsdiqlənməlidir.

**Əlaqəli Gap:** G-09.

---

## 6. Compliance Report — Ümumi Qiymətləndirmə

Layihə hesabatındakı yekun qiymətləndirmə:

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

### Overall Assessment

**PARTIALLY COMPLIANT**

Bu nəticə aşağıdakı vəziyyəti əks etdirir:

- Əsas təhlükəsizlik komponentlərinin bir hissəsi tətbiq edilib.
- Altı siyasət sənədləşdirilib.
- 20 risk müəyyənləşdirilib və qiymətləndirilib.
- Üç beynəlxalq çərçivə üzrə uyğunluq analizi hazırlanıb.
- 10 uyğunluq boşluğu sənədləşdirilib.
- Bəzi nəzarətlərin effektivliyi və tamamlanması əlavə təsdiq tələb edir.

Bu qiymətləndirmə ISO/IEC 27001 sertifikatlaşdırılması deyil.

---

## 7. GitHub Documentation Verification

### 7.1. Repository strukturu

Section-15-GRC/
- README.md
- security-policies.md
- risk-register.md
- compliance-assessment.md
- verification-checklist.md

### 7.2. Faylların funksiyası

| File | Purpose |
|---|---|
| README.md | GRC bölməsinin ümumi təsviri |
| security-policies.md | Altı təhlükəsizlik siyasəti |
| risk-register.md | 20 risk, qiymətləndirmə və azaltma tədbirləri |
| compliance-assessment.md | ISO, NIST, CIS, Gap Analysis və fərdi məlumat prosedurları |
| verification-checklist.md | Bölmə 15 üzrə yekun yoxlama siyahısı |

### 7.3. Sənədləşmə yoxlaması

- [x] Altı təhlükəsizlik siyasətinin məzmunu hazırlanıb.
- [x] 20 riskin qiymətləndirilməsi sənədləşdirilib.
- [x] Üç standart üzrə uyğunluq qiymətləndirməsi hazırlanıb.
- [x] 10 uyğunluq boşluğu müəyyən edilib.
- [x] Fərdi məlumatların emalı prinsipləri sənədləşdirilib.
- [x] Yekun PARTIALLY COMPLIANT nəticəsi göstərilib.

### 7.4. GitHub üzrə son yoxlama

Aşağıdakı əməliyyatlar repository yenilənərkən yoxlanılmalıdır:

- [ ] Bütün faylların Section-15-GRC qovluğunda yerləşdiyi təsdiqlənməlidir.
- [ ] Markdown cədvəllərinin GitHub-da düzgün göründüyü yoxlanılmalıdır.
- [ ] README.md daxilindəki fayl keçidləri yoxlanılmalıdır.
- [ ] Son dəyişikliklər GitHub-a commit edilməlidir.

Bu dörd bənd GitHub üzərində faktiki yoxlama üçün saxlanılıb.

---

## 8. Yekun Verification Summary

| Requirement | Documentation | Technical / Governance Follow-up |
|---|---|---|
| 15.1 — Security Policy Library | Hazırlanıb | Approval register |
| 15.2 — Risk Register | Hazırlanıb | Residual risk və aylıq baxışın təsdiqi |
| 15.3 — Standards Assessment | Hazırlanıb | Partial nəzarətlər üzrə əlavə yoxlama |
| 15.3 — Gap Analysis | 10 boşluq sənədləşdirilib | Düzəldici tədbirlərin icrası |
| 15.3 — Personal Data Procedures | 8 prinsip sənədləşdirilib | Data processing register |
| 15.3 — Compliance Report | Hazırlanıb | PARTIALLY COMPLIANT |

### Final Verification Result

**GRC Documentation:** Prepared

**Identified Risks:** 20

**Security Policies:** 6

**Compliance Frameworks:** 3

**Identified Compliance Gaps:** 10

**Overall Compliance Status:** PARTIALLY COMPLIANT

Bölmə 15 çərçivəsində təhlükəsizlik siyasətləri, Risk Register və Compliance Assessment sənədləri hazırlanmışdır.

Yoxlama siyahısı sənədləşdirilmiş nəticələri və əlavə tədbir tələb edən məsələləri bir-birindən ayırır.

Tam uyğunluq üçün hesabatdakı 10 boşluq üzrə tədbirlərin icrası və müvafiq sübutlarla təsdiqi tələb olunur.

---

## 9. Əlaqəli sənədlər

- [Section 15 — README](README.md)
- [Security Policies](security-policies.md)
- [Risk Register](risk-register.md)
- [Compliance Assessment](compliance-assessment.md)

---

**Section:** 15 — Governance, Risk & Compliance

**Organization:** KONRDERK Cybersecurity

**Verification:** Documentation and Compliance Review

**Overall Result:** PARTIALLY COMPLIANT
