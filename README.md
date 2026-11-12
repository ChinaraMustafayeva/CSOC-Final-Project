# CSOC Final Project — KONRDERK Cybersecurity

## Enterprise Cybersecurity Operations Center

KONRDERK Cybersecurity layihəsi korporativ mühit üçün Cybersecurity Operations Center (CSOC) infrastrukturunun layihələndirilməsi, qurulması, təhlükəsizlik nəzarətlərinin tətbiqi və sənədləşdirilməsini əhatə edir.

Layihədə **VMware və Microsoft Azure əsaslı hibrid infrastruktur** yanaşmasından istifadə edilmişdir.

İşin əsas məqsədi korporativ informasiya sistemlərini mərkəzləşdirilmiş identifikasiya, giriş nəzarəti, şəbəkə segmentasiyası, təhlükəsizlik monitorinqi, məlumatların qorunması və risk idarəetməsi prinsipləri ilə əlaqələndirməkdir.

---

## 1. Project Objectives — Layihənin Məqsədləri

Layihənin əsas məqsədləri:

- Korporativ təhlükəsizlik arxitekturasının hazırlanması;
- İnformasiya aktivlərinin inventarlaşdırılması;
- Şəbəkənin təhlükəsizlik zonalarına bölünməsi;
- Active Directory infrastrukturunun qurulması;
- Mərkəzləşdirilmiş autentifikasiya və giriş nəzarətinin tətbiqi;
- İmtiyazlı hesabların təhlükəsiz idarə edilməsi;
- Firewall, IDS/IPS və DNS təhlükəsizliyi nəzarətlərinin tətbiqi;
- Korporativ email təhlükəsizliyinin təmin edilməsi;
- Backup və bərpa mexanizmlərinin nəzərdə tutulması;
- Təhlükəsizlik siyasətlərinin və risklərin sənədləşdirilməsi;
- Beynəlxalq kibertəhlükəsizlik standartlarına uyğunluğun qiymətləndirilməsi.

---

## 2. Infrastructure Architecture — İnfrastruktur Arxitekturası

Layihə VMware və Microsoft Azure əsaslı hibrid mühit çərçivəsində hazırlanmışdır.

Arxitektura təhlükəsizlik zonalarının ayrılması və sistemlər arasında girişlərin məhdudlaşdırılması prinsiplərinə əsaslanır.

Əsas istiqamətlər:

- Korporativ LAN;
- DMZ;
- Server Zone;
- İdentifikasiya və giriş idarəetməsi;
- Şəbəkə təhlükəsizliyi;
- Təhlükəsizlik monitorinqi;
- Məlumatların qorunması və backup.

Şəbəkə segmentasiyası və trafik nəzarəti üçün nftables Firewall qaydaları, təhlükələrin aşkarlanması üçün isə Suricata IDS/IPS və DNS Sinkhole yanaşmaları nəzərdə tutulmuşdur.

**Ətraflı:** [Section 01 — Architecture](Section-01-Architecture/README.md)

---

## 3. Identity and Access Management

Korporativ identifikasiya və giriş nəzarəti üçün aşağıdakı texnologiyalardan istifadə edilmişdir.

| Technology | Purpose |
|---|---|
| Active Directory | İstifadəçi, qrup və domen idarəetməsi |
| Keycloak | Single Sign-On və Multi-Factor Authentication |
| JumpServer PAM | İmtiyazlı girişlərin idarə edilməsi |
| Windows LAPS | Lokal administrator parollarının idarə edilməsi |
| PKI | Sertifikat əsaslı etimad infrastrukturu |

Əsas təhlükəsizlik prinsipləri:

- Least Privilege;
- Role-Based Access Control;
- MFA;
- İmtiyazlı girişlərin auditi;
- Parol siyasətləri və rotasiya;
- Mərkəzləşdirilmiş hesab idarəetməsi.

**Ətraflı:** [Section 02 — Identity & Access Management](Section-02-Identity-Access-Management/README.md)

---

## 4. Email Security

Korporativ email təhlükəsizliyi layihənin ayrıca istiqaməti kimi sənədləşdirilmişdir.

Bu istiqamət aşağıdakı mövzuları əhatə edir:

- Mail Server;
- Email Security Gateway;
- Anti-Phishing və Sandboxing;
- Phishing Simulation;
- SMTP Relay.

Email təhlükəsizliyi yalnız mesajların ötürülməsini deyil, həmçinin phishing risklərinin azaldılmasını, təhlükəli məzmunun aşkarlanmasını və istifadəçilərin təhlükəsizlik maarifləndirilməsini də əhatə edir.

Phishing simulyasiyası üçün GoPhish istifadə edilmişdir.

**Ətraflı:** [Section 08 — Email Security](Section-08-Email-Security/README.md)

---

## 5. Governance, Risk & Compliance

Layihənin Governance, Risk & Compliance (GRC) bölməsi texniki təhlükəsizlik tədbirlərini təşkilati idarəetmə, risk qiymətləndirməsi və uyğunluq analizi ilə əlaqələndirir.

GRC üzrə üç əsas istiqamət sənədləşdirilmişdir.

### 5.1. Security Policy Library

Altı informasiya təhlükəsizliyi siyasəti hazırlanmışdır:

1. Information Security Policy;
2. Acceptable Use Policy;
3. Incident Response Policy;
4. Remote Access Policy;
5. Data Classification Policy;
6. Password Management Policy.

### 5.2. Risk Register

20 riskdən ibarət reyestr hazırlanmışdır.

Risklər Likelihood və Impact əsasında qiymətləndirilmiş, risk sahibləri, azaltma tədbirləri və hədəf residual risklər müəyyən edilmişdir.

### 5.3. Compliance Assessment

Uyğunluq analizi aşağıdakı çərçivələr əsasında aparılmışdır:

- ISO/IEC 27001:2022;
- NIST Cybersecurity Framework 2.0;
- CIS Controls v8.1.

Qiymətləndirmədə 10 uyğunluq boşluğu müəyyən edilmişdir.

**Overall Compliance Assessment: PARTIALLY COMPLIANT**

Bu nəticə daxili uyğunluq qiymətləndirməsidir və ISO/IEC 27001 sertifikatlaşdırılması demək deyil.

**Ətraflı:** [Section 15 — Governance, Risk & Compliance](Section-15-GRC/README.md)

---

## 6. Technologies and Security Components

| Component | Security Function |
|---|---|
| VMware | Virtual infrastruktur |
| Microsoft Azure | Hibrid infrastruktur komponentləri |
| Active Directory | Identity Management |
| Keycloak | SSO və MFA |
| JumpServer PAM | Privileged Access Management |
| Windows LAPS | Local Administrator Password Management |
| PKI | Sertifikat infrastrukturu |
| nftables | Firewall və trafik məhdudiyyətləri |
| Suricata | IDS/IPS |
| DNS Sinkhole | Zərərli domenlərə çıxışın məhdudlaşdırılması |
| PostgreSQL | Məlumat bazası |
| Restic | Backup |
| Gitea | Git repository idarəetməsi |
| Wiki.js | Daxili sənədləşdirmə |
| Nextcloud | Fayl paylaşımı |
| Grafana | Monitorinq və vizuallaşdırma |
| GoPhish | Phishing simulyasiyası |

Bu komponentlər layihənin müxtəlif təhlükəsizlik istiqamətləri ilə əlaqələndirilmişdir.

---

## 7. Repository Structure

~~~text
CSOC-Final-Project/
├── Section-01-Architecture/
│   ├── README.md
│   └── ...
├── Section-02-Identity-Access-Management/
│   ├── README.md
│   └── ...
├── Section-08-Email-Security/
│   ├── README.md
│   └── ...
├── Section-15-GRC/
│   ├── README.md
│   ├── security-policies.md
│   ├── risk-register.md
│   ├── compliance-assessment.md
│   └── verification-checklist.md
└── README.md
~~~

Bu struktur hazırda GitHub-da sənədləşdirilən bölmələri göstərir.

Digər layihə bölmələrinin sənədləri hazırlandıqca repository genişləndirilə bilər.

---

## 8. Project Documentation

| Section | Description | Documentation |
|---|---|---|
| 01 | Architecture, Asset Inventory, Network Segmentation, Threat Modeling | [Open](Section-01-Architecture/README.md) |
| 02 | Active Directory, PAM, SSO/MFA, LAPS və PKI | [Open](Section-02-Identity-Access-Management/README.md) |
| 08 | Mail Server, Email Gateway, Anti-Phishing və SMTP Relay | [Open](Section-08-Email-Security/README.md) |
| 15 | Security Policies, Risk Register və Compliance Assessment | [Open](Section-15-GRC/README.md) |

### Section 15 — GRC Documentation

- [Security Policies](Section-15-GRC/security-policies.md)
- [Risk Register](Section-15-GRC/risk-register.md)
- [Compliance Assessment](Section-15-GRC/compliance-assessment.md)
- [Verification Checklist](Section-15-GRC/verification-checklist.md)

---

## 9. Security Principles

Layihə aşağıdakı əsas təhlükəsizlik prinsiplərinə əsaslanır:

- **Defense in Depth:** Çoxqatlı təhlükəsizlik nəzarətləri;
- **Least Privilege:** Minimum zəruri giriş hüquqları;
- **RBAC:** Rol əsaslı giriş idarəetməsi;
- **Network Segmentation:** Şəbəkə zonalarının ayrılması;
- **Monitoring and Detection:** Təhlükəsizlik hadisələrinin izlənilməsi;
- **Incident Response:** Hadisələrin araşdırılması və cavab tədbirləri;
- **Backup and Recovery:** Məlumatların bərpa imkanlarının qorunması;
- **Risk-Based Security:** Təhlükəsizlik tədbirlərinin risklərə əsasən prioritetləşdirilməsi.

---

## 10. Project Conclusion — Yekun

CSOC Final Project çərçivəsində KONRDERK Cybersecurity üçün hibrid korporativ kibertəhlükəsizlik infrastrukturu və onu dəstəkləyən təhlükəsizlik sənədləşməsi hazırlanmışdır.

Layihə arxitektura, identifikasiya və giriş nəzarəti, email təhlükəsizliyi, monitorinq, məlumatların qorunması və GRC istiqamətlərini vahid korporativ təhlükəsizlik yanaşması çərçivəsində birləşdirir.

GRC mərhələsində altı informasiya təhlükəsizliyi siyasəti, 20 riskdən ibarət Risk Register və ISO/IEC 27001:2022, NIST CSF 2.0, CIS Controls v8.1 üzrə daxili uyğunluq qiymətləndirməsi hazırlanmışdır.

Uyğunluq qiymətləndirməsində müəyyən edilmiş boşluqlar gələcək düzəldici tədbirlər və əlavə yoxlamalar üçün sənədləşdirilmişdir.

---

**Project:** CSOC Final Project

**Organization:** KONRDERK Cybersecurity

**Infrastructure:** VMware / Microsoft Azure Hybrid Environment

**Repository:** [ChinaraMustafayeva/CSOC-Final-Project](https://github.com/ChinaraMustafayeva/CSOC-Final-Project)
