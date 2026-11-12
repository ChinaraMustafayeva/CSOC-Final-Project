# BÖLMƏ 2 — ENTERPRISE IDENTITY & ACCESS MANAGEMENT

## 1. Ümumi məlumat

Bu bölmədə CSOC layihəsi üçün korporativ kimlik və giriş idarəetməsi infrastrukturu qurulmuşdur. Əsas məqsəd istifadəçi və administrator hesablarını mərkəzləşdirilmiş qaydada idarə etmək, yüksək səlahiyyətli girişləri qorumaq, autentifikasiyanı gücləndirmək və daxili xidmətlər arasında təhlükəsiz inteqrasiya yaratmaqdır.

Bölmə dörd əsas istiqaməti əhatə edir:

- **2.1 — Active Directory və Tiered Access Model**
- **2.2 — Privileged Access Management (PAM)**
- **2.3 — Mərkəzi Kimlik İdarəetməsi, SSO və MFA**
- **2.4 — Windows LAPS və Public Key Infrastructure (PKI)**

Layihədə Active Directory, Group Policy, JumpServer, Keycloak, PostgreSQL, Docker Compose, Windows LAPS və Active Directory Certificate Services texnologiyaları istifadə edilmişdir.

## 2. İnfrastruktur və server rolları

| Server | IP ünvanı | Əsas funksiya |
|---|---|---|
| DC01 | 192.168.100.10 | Active Directory Domain Services, DNS |
| DC02 | 192.168.100.11 | İkinci Domain Controller, AD replikasiyası |
| SRV01 | 192.168.100.20 | Tier1 Member Server, Windows LAPS, IIS |
| PAM01 | 192.168.100.30 | JumpServer, imtiyazlı girişlərin idarə edilməsi |
| CA01 | 192.168.100.40 | AD CS, Enterprise Root CA, PKI |
| IAM01 | 192.168.100.50 | Keycloak 26.4, PostgreSQL 17, SSO və MFA |

**Active Directory domeni:** corp.local

IAM01 serverində əlavə olaraq 10.0.0.50 IP ünvanı istifadə edilmişdir. Bu interfeys üzərindən SSO tətbiqlərinə giriş təşkil olunmuşdur.

## 3. Bölmə 2.1 — Active Directory və Tiered Access Model

### 3.1. Active Directory infrastrukturu

DC01 və DC02 üzərində Active Directory infrastrukturu hazırlanmışdır.

DC01 əsas Domain Controller, DC02 isə ikinci Domain Controller kimi istifadə edilmişdir. Domen məlumatlarının replikasiyası və istifadəçilərin mərkəzləşdirilmiş idarə edilməsi üçün iki serverli arxitektura təşkil olunmuşdur.

### 3.2. Organizational Units və Group Policy

İstifadəçi, administrator və server obyektlərinin funksional ayrılması üçün OU strukturu yaradılmışdır.

Group Policy mexanizmi vasitəsilə təhlükəsizlik siyasətləri müvafiq təşkilati vahidlərə tətbiq edilmişdir.

### 3.3. Tiered Access Model

Administrator hesabları üç təhlükəsizlik səviyyəsinə ayrılmışdır.

| Səviyyə | Təyinat |
|---|---|
| Tier 0 | Domen və kritik identifikasiya infrastrukturu |
| Tier 1 | Serverlərin idarə olunması |
| Tier 2 | İstifadəçi sistemlərinin idarə olunması |

Bu model yüksək səlahiyyətli hesabların daha aşağı etibar səviyyəli sistemlərdə istifadəsini məhdudlaşdırmaq üçün tətbiq edilmişdir.

### 3.4. Giriş məhdudiyyətinin yoxlanılması

Tier2 administrator hesabı ilə SRV01 serverinə giriş sınağı aparılmışdır.

Giriş bloklanmış və Windows aşağıdakı mesajı göstərmişdir:

The sign-in method you're trying to use isn't allowed.

Bu test Group Policy vasitəsilə tətbiq edilmiş giriş məhdudiyyətinin işlədiyini göstərmişdir.

### 3.5. Audit siyasəti

Yüksək səlahiyyətli əməliyyatların izlənilməsi üçün GPO-T0-Audit adlı Group Policy yaradılmışdır.

**Ətraflı sənəd:** [Active Directory və Tiered Access](active-directory.md)

## 4. Bölmə 2.2 — Privileged Access Management

### 4.1. JumpServer PAM

PAM01 üzərində JumpServer platforması quraşdırılmışdır.

Platforma kritik sistemlərə administrator girişlərinin mərkəzləşdirilməsi və imtiyazlı sessiyaların audit edilməsi üçün istifadə edilmişdir.

### 4.2. DC01-ə RDP bağlantısı

DC01 serverinə inzibati giriş JumpServer üzərindən təşkil edilmişdir.

| Mənbə | Təyinat | Port | Funksiya |
|---|---|---|---|
| PAM01 — 192.168.100.30 | DC01 — 192.168.100.10 | TCP 3389 | RDP |

DC01-ə RDP bağlantısı PAM01 IP ünvanı ilə məhdudlaşdırılmışdır.

JumpServer üzərindən DC01-ə uğurlu RDP bağlantısı yoxlanılmışdır.

### 4.3. Sessiya qeydiyyatı və audit

Administrator sessiyalarının video qeydləri yoxlanılmışdır.

JumpServer replay qovluğu:

/data/jumpserver/core/data/media/replay

Sessiya zamanı icra edilmiş əmrlərin audit qeydləri də yoxlanılmışdır.

### 4.4. Sessiya müddətlərinin idarə edilməsi

GPO-PAM-RDP-Session-Limits adlı Group Policy yaradılmışdır.

| Parametr | Müddət |
|---|---|
| İstifadəsiz RDP sessiyası | 15 dəqiqə |
| Aktiv RDP sessiyasının maksimum müddəti | 1 saat |

Bu siyasət administrator sessiyalarının uzun müddət açıq qalmasının qarşısını almaq üçün tətbiq edilmişdir.

**Ətraflı sənəd:** [Privileged Access Management](privileged-access-management.md)

## 5. Bölmə 2.3 — Mərkəzi IAM, SSO və MFA

### 5.1. Keycloak infrastrukturu

IAM01 adlı Ubuntu Server 24.04 virtual maşınında Docker Compose vasitəsilə aşağıdakı xidmətlər quraşdırılmışdır:

- Keycloak 26.4;
- PostgreSQL 17.

Keycloak daxilində corp adlı realm yaradılmışdır.

Əsas konfiqurasiya qovluğu:

/opt/keycloak

### 5.2. Active Directory ilə LDAPS

Keycloak və Active Directory arasında CORP-AD adlı LDAP Federation bağlantısı yaradılmışdır.

Əsas parametrlər:

| Parametr | Dəyər |
|---|---|
| LDAP bağlantısı | LDAPS |
| Port | TCP 636 |
| Federation | CORP-AD |
| Servis hesabı | svc_keycloak_ldap |
| İstifadəçi atributu | sAMAccountName |

svc_keycloak_ldap servis hesabına Domain Admin səlahiyyəti verilməmişdir.

### 5.3. İstifadəçi sinxronizasiyası

Active Directory-dən Keycloak-a 16 istifadəçi uğurla sinxronlaşdırılmışdır.

| Göstərici | Nəticə |
|---|---|
| Sinxronlaşdırılan istifadəçi | 16 |
| Xəta | 0 |
| Full Sync | 24 saat |
| Changed Users Sync | 5 dəqiqə |

t2-aysel domen hesabı ilə Keycloak autentifikasiyası yoxlanılmışdır.

### 5.4. MFA və ehtiyat giriş kodları

Administrator hesabları üçün aşağıdakı Required Actions konfiqurasiya edilmişdir:

- Configure OTP;
- Recovery Authentication Codes.

Tier0, Tier1 və Tier2 administrator hesabları üçün MFA tələbləri tətbiq edilmişdir.

Google Authenticator ilə 6 rəqəmli OTP kodu əsasında giriş yoxlanılmış və uğurlu nəticə alınmışdır.

Telefon əlçatan olmadıqda istifadə üçün recovery codes yaradılmışdır.

### 5.5. HTTPS və daxili sertifikat

Keycloak üçün iam01.corp.local DNS qeydi yaradılmışdır.

CA01 üzərində CORP-WebServer şablonundan istifadə edilərək sertifikat alınmış və Keycloak konteynerinə əlavə edilmişdir.

HTTPS üçün 8443 portu konfiqurasiya edilmişdir.

**Yoxlanılmış HTTPS ünvanı:**

https://iam01.corp.local:8443

### 5.6. Dörd platformanın SSO inteqrasiyası

Keycloak mərkəzi IAM platforması dörd fərqli tətbiqlə inteqrasiya edilmişdir.

| Platforma | Ünvan | Nəticə |
|---|---|---|
| Grafana | http://10.0.0.50:3000 | Keycloak SSO ilə uğurlu giriş |
| Gitea | http://10.0.0.50:3001 | Keycloak üzərindən uğurlu giriş |
| Wiki.js | http://10.0.0.50:3002 | SSO və OTP yoxlanıldı |
| Nextcloud | http://10.0.0.50:3003 | SSO quruldu və test edildi |

Grafana üçün OAuth client və redirect URI parametrləri konfiqurasiya edilmişdir.

Gitea və Nextcloud platformaları Keycloak ilə inteqrasiya olunmuş, Wiki.js üçün SSO və OTP mərhələsi yoxlanılmışdır.

Bu mərhələdə dörd tətbiqin mərkəzi kimlik idarəetməsi ilə inteqrasiyası həyata keçirilmişdir.

**Ətraflı sənəd:** [SSO və MFA](sso-mfa.md)

## 6. Bölmə 2.4 — Windows LAPS və PKI

### 6.1. Enterprise Root CA

CA01 üzərində Active Directory Certificate Services quraşdırılmışdır.

| Parametr | Dəyər |
|---|---|
| CA adı | CORP-ROOT-CA |
| CA növü | Enterprise Root CA |
| Açar | RSA 4096 bit |
| Hash | SHA256 |
| Etibarlılıq müddəti | 10 il |

### 6.2. Sertifikat şablonu

Daxili HTTPS xidmətləri üçün CORP-WebServer adlı sertifikat şablonu yaradılmışdır.

| Parametr | Dəyər |
|---|---|
| Sertifikat müddəti | 1 il |
| Renewal Period | 6 həftə |
| Açar | RSA 2048 bit |
| Subject Alternative Name | DNS name |
| Private Key Export | Disabled |

Domain Computers qrupuna Read, Enroll və Autoenroll icazələri verilmişdir.

### 6.3. Auto-Enrollment və IIS HTTPS

Certificate Auto-Enrollment siyasəti Group Policy vasitəsilə tətbiq edilmişdir.

SRV01 serveri üçün CORP-ROOT-CA tərəfindən imzalanmış sertifikat əldə edilmişdir.

Sertifikat IIS xidmətinin HTTPS bağlantısına əlavə edilmişdir.

Test ünvanı:

https://srv01.corp.local

Brauzer testi zamanı HTTPS xidməti sertifikat xəbərdarlığı olmadan açılmışdır.

### 6.4. Windows LAPS

SRV01 üzərində lokal administrator parollarının idarə edilməsi üçün Windows LAPS tətbiq edilmişdir.

GPO adı:

GPO-Windows-LAPS-Tier1-Servers

GPO aşağıdakı OU-ya bağlanmışdır:

OU=Servers,OU=Tier1,DC=corp,DC=local

| Parametr | Dəyər |
|---|---|
| Backup Directory | Active Directory |
| Parol uzunluğu | 16 simvol |
| Parol mürəkkəbliyi | Hərflər, rəqəmlər və xüsusi simvollar |
| Parolun yenilənmə müddəti | 30 gün |

### 6.5. LAPS rotasiyasının yoxlanılması

Windows LAPS üçün tələb olunan KB5025230 yeniləməsi quraşdırılmışdır.

Parol rotasiyası Reset-LapsPassword əmri ilə başladılmışdır.

Get-LapsADPassword vasitəsilə SRV01 üçün parolun yenilənmə vaxtı və bitmə tarixi yoxlanılmışdır.

gpresult ilə GPO-nun tətbiq edildiyi təsdiqlənmişdir.

**Ətraflı sənəd:** [Windows LAPS və PKI](laps-pki.md)

## 7. İnteqrasiya olunmuş təhlükəsizlik modeli

Bölmə 2-dəki texnologiyalar müxtəlif təhlükəsizlik qatlarını tamamlayır.

| Təhlükəsizlik qatı | Komponent | Funksiya |
|---|---|---|
| Identity Directory | Active Directory | Domen hesabları və autentifikasiya |
| Access Segmentation | Tiered Access Model | Administrator səlahiyyətlərinin ayrılması |
| Privileged Access | JumpServer | İmtiyazlı giriş və sessiya auditi |
| Identity Federation | Keycloak | Mərkəzi IAM və SSO |
| Multi-Factor Authentication | Google Authenticator | OTP |
| Recovery Authentication | Keycloak | Ehtiyat giriş kodları |
| Local Password Management | Windows LAPS | Lokal admin parollarının rotasiyası |
| Certificate Authority | AD CS | Daxili PKI |
| Encrypted Communication | HTTPS və LDAPS | Şifrəli autentifikasiya və xidmət bağlantıları |

## 8. Praktiki nəticələrin xülasəsi

| № | Həyata keçirilmiş iş | Nəticə |
|---|---|---|
| 1 | Active Directory infrastrukturu | DC01 və DC02 |
| 2 | Tiered Access Model | Tier 0 / Tier 1 / Tier 2 |
| 3 | Tier2 → SRV01 giriş testi | Bloklandı |
| 4 | Administrator auditi | GPO-T0-Audit |
| 5 | JumpServer PAM | Quraşdırıldı |
| 6 | DC01 RDP girişi | PAM üzərindən uğurlu |
| 7 | RDP IP məhdudiyyəti | PAM01 mənbə IP-si |
| 8 | Sessiya video replay | Yoxlanıldı |
| 9 | Command Audit | Yoxlanıldı |
| 10 | RDP idle timeout | 15 dəqiqə |
| 11 | RDP maksimum sessiya müddəti | 1 saat |
| 12 | Keycloak və PostgreSQL | 26.4 / 17 |
| 13 | AD ilə LDAPS | Uğurlu |
| 14 | AD istifadəçi sinxronizasiyası | 16 istifadəçi, 0 xəta |
| 15 | MFA | OTP ilə uğurlu giriş |
| 16 | Recovery Authentication Codes | Yaradıldı |
| 17 | Grafana SSO | Uğurlu |
| 18 | Gitea SSO | Uğurlu |
| 19 | Wiki.js SSO | OTP mərhələsi yoxlanıldı |
| 20 | Nextcloud SSO | Quruldu və test edildi |
| 21 | Keycloak HTTPS | TCP 8443 |
| 22 | Enterprise Root CA | CORP-ROOT-CA |
| 23 | Sertifikat şablonu | CORP-WebServer |
| 24 | IIS HTTPS | Sertifikat xəbərdarlığı olmadan açıldı |
| 25 | Windows LAPS | 16 simvol, 30 gün |
| 26 | LAPS parol rotasiyası | AD üzərindən yoxlanıldı |

## 9. Bölmənin sənədləri

Bu qovluqda hər alt bölmənin ayrıca texniki sənədi yerləşir:

- [2.1 — Active Directory və Tiered Access](active-directory.md)
- [2.2 — Privileged Access Management](privileged-access-management.md)
- [2.3 — Keycloak, SSO və MFA](sso-mfa.md)
- [2.4 — Windows LAPS və PKI](laps-pki.md)
- [Texniki yoxlama siyahısı](verification-checklist.md)

## 10. Nəticə

Bölmə 2 çərçivəsində korporativ kimlik və giriş idarəetməsi infrastrukturu qurulmuşdur.

Active Directory domeni iki Domain Controller ilə təşkil edilmiş, administrator səlahiyyətləri Tier 0, Tier 1 və Tier 2 səviyyələrinə ayrılmış və giriş məhdudiyyətləri Group Policy ilə tətbiq edilmişdir.

JumpServer PAM vasitəsilə DC01 serverinə mərkəzləşdirilmiş RDP girişi təmin edilmiş, sessiyaların video qeydi və command audit funksiyaları yoxlanılmışdır. Administrator sessiyaları üçün 15 dəqiqəlik idle timeout və 1 saatlıq maksimum aktiv sessiya limiti tətbiq edilmişdir.

Keycloak 26.4 Active Directory ilə LDAPS üzərindən inteqrasiya edilmiş, 16 istifadəçi xətasız sinxronlaşdırılmış, administratorlar üçün MFA və recovery codes konfiqurasiya edilmişdir.

Grafana, Gitea, Wiki.js və Nextcloud olmaqla dörd platforma Keycloak SSO ilə inteqrasiya edilmişdir.

CA01 üzərində CORP-ROOT-CA yaradılmış, daxili sertifikat infrastrukturu qurulmuş, SRV01 üzərində IIS HTTPS uğurla yoxlanılmışdır.

Windows LAPS vasitəsilə SRV01-in lokal administrator parolu üçün 16 simvolluq parol və 30 günlük rotasiya siyasəti tətbiq edilmiş, Active Directory üzərindən parol məlumatlarının yenilənməsi yoxlanılmışdır.

Beləliklə, identifikasiya, imtiyazlı giriş, vahid autentifikasiya, MFA, lokal parol idarəetməsi və daxili sertifikat xidmətləri bir-birini tamamlayan təhlükəsizlik arxitekturasında birləşdirilmişdir.
