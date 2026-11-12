# BÖLMƏ 2 — TEXNİKİ YOXLAMA SİYAHISI

## Məqsəd

Bu sənəd CSOC layihəsinin Bölmə 2 — Enterprise Identity & Access Management hissəsində həyata keçirilmiş texniki işlərin və praktiki testlərin yekun yoxlama siyahısıdır.

Yoxlamalar layihənin yekun hesabatında sənədləşdirilmiş nəticələr əsasında hazırlanmışdır.

## 2.1 — Active Directory və Tiered Access

- [x] DC01 serverində Active Directory Domain Services infrastrukturu quruldu.
- [x] DC02 ikinci Domain Controller kimi konfiqurasiya edildi.
- [x] DC01 və DC02 arasında Active Directory replikasiyası təşkil edildi.
- [x] corp.local domeni üçün istifadəçi və administrator hesabları idarə edildi.
- [x] Organizational Unit strukturu yaradıldı.
- [x] Tier 0, Tier 1 və Tier 2 inzibati səviyyələri tətbiq edildi.
- [x] SRV01 Tier 1 üzv serveri kimi istifadə edildi.
- [x] Group Policy vasitəsilə səviyyələrarası giriş məhdudiyyətləri tətbiq edildi.
- [x] Tier 2 hesabının SRV01-ə giriş cəhdi bloklandı.
- [x] Windows giriş xətası yoxlanıldı: The sign-in method you're trying to use isn't allowed.
- [x] GPO-T0-Audit siyasəti yaradıldı.

## 2.2 — Privileged Access Management

- [x] PAM01 serveri hazırlandı.
- [x] JumpServer platforması quraşdırıldı.
- [x] DC01 serveri PAM idarəetməsinə əlavə edildi.
- [x] Administrator giriş icazələri konfiqurasiya edildi.
- [x] DC01-ə RDP bağlantısı PAM01 üzərindən təşkil edildi.
- [x] RDP TCP/3389 trafiki PAM01 mənbə IP ünvanı ilə məhdudlaşdırıldı.
- [x] JumpServer üzərindən DC01-ə RDP bağlantısı uğurla yoxlanıldı.
- [x] Administrator sessiyalarının video replay qeydləri yoxlanıldı.
- [x] Sessiya əmrlərinin audit qeydləri yoxlanıldı.
- [x] GPO-PAM-RDP-Session-Limits siyasəti yaradıldı.
- [x] RDP idle timeout 15 dəqiqə təyin edildi.
- [x] Aktiv RDP sessiyasının maksimum müddəti 1 saat təyin edildi.

### PAM test parametrləri

| Parametr | Dəyər |
|---|---|
| PAM serveri | PAM01 |
| PAM IP | 192.168.100.30 |
| İdarə olunan server | DC01 |
| DC01 IP | 192.168.100.10 |
| İdarəetmə protokolu | RDP / TCP 3389 |
| Idle timeout | 15 dəqiqə |
| Aktiv sessiya limiti | 1 saat |

## 2.3 — Keycloak, SSO və MFA

### IAM platforması

- [x] IAM01 Ubuntu Server 24.04 hazırlandı.
- [x] Keycloak 26.4 Docker Compose ilə quraşdırıldı.
- [x] PostgreSQL 17 verilənlər bazası quraşdırıldı.
- [x] corp realm yaradıldı.
- [x] CORP-AD LDAP Federation konfiqurasiya edildi.
- [x] DC01 ilə LDAPS TCP/636 bağlantısı yaradıldı.
- [x] svc_keycloak_ldap servis hesabı istifadə edildi.
- [x] Servis hesabına Domain Admin səlahiyyəti verilmədi.
- [x] LDAP Test connection uğurla yoxlanıldı.
- [x] LDAP Test authentication uğurla yoxlanıldı.

### İstifadəçi sinxronizasiyası

- [x] Active Directory-dən 16 istifadəçi Keycloak-a sinxronlaşdırıldı.
- [x] Sinxronizasiya nəticəsində 0 xəta qeydə alındı.
- [x] Full Sync intervalı 24 saat konfiqurasiya edildi.
- [x] Changed Users Sync intervalı 5 dəqiqə konfiqurasiya edildi.
- [x] t2-aysel domen hesabı ilə autentifikasiya yoxlanıldı.

### MFA

- [x] Configure OTP Required Action aktivləşdirildi.
- [x] Recovery Authentication Codes aktivləşdirildi.
- [x] Tier 0, Tier 1 və Tier 2 administrator hesabları üçün MFA konfiqurasiya edildi.
- [x] Google Authenticator vasitəsilə OTP quruldu.
- [x] Altırəqəmli OTP ilə uğurlu giriş yoxlanıldı.
- [x] Ehtiyat bərpa kodları yaradıldı.

### HTTPS

- [x] iam01.corp.local DNS qeydi yaradıldı.
- [x] CA01 üzərində daxili sertifikat alındı.
- [x] Sertifikat Keycloak konteynerinə əlavə edildi.
- [x] HTTPS TCP/8443 konfiqurasiya edildi.
- [x] https://iam01.corp.local:8443 ünvanına giriş yoxlanıldı.

### Dörd platformanın SSO inteqrasiyası

- [x] Grafana Keycloak SSO ilə inteqrasiya edildi.
- [x] Grafana üçün OAuth client və redirect URI parametrləri konfiqurasiya edildi.
- [x] t2-aysel hesabı ilə Grafana SSO girişi uğurla yoxlanıldı.
- [x] Gitea Keycloak ilə inteqrasiya edildi.
- [x] t2-aysel hesabı ilə Gitea-ya uğurlu giriş edildi.
- [x] Wiki.js Keycloak SSO ilə inteqrasiya edildi.
- [x] Wiki.js üçün istifadəçi qrupu və OTP tələbi yoxlanıldı.
- [x] Nextcloud Keycloak SSO ilə inteqrasiya edildi və test edildi.

| Platforma | Ünvan |
|---|---|
| Grafana | http://10.0.0.50:3000 |
| Gitea | http://10.0.0.50:3001 |
| Wiki.js | http://10.0.0.50:3002 |
| Nextcloud | http://10.0.0.50:3003 |

**Yekun:** Dörd fərqli platformanın mərkəzi IAM sistemi ilə SSO inteqrasiyası həyata keçirildi.

## 2.4 — Windows LAPS və PKI

### Certificate Authority

- [x] CA01 Windows Server 2022 hazırlandı.
- [x] CA01 corp.local domeninə qoşuldu.
- [x] Active Directory Certificate Services quraşdırıldı.
- [x] Enterprise Root CA konfiqurasiya edildi.
- [x] CORP-ROOT-CA yaradıldı.
- [x] Root CA üçün RSA 4096 bit və SHA256 istifadə edildi.
- [x] CA etibarlılıq müddəti 10 il təyin edildi.

### Sertifikat şablonları və HTTPS

- [x] CORP-WebServer sertifikat şablonu yaradıldı.
- [x] Sertifikat müddəti 1 il təyin edildi.
- [x] Renewal Period 6 həftə təyin edildi.
- [x] RSA 2048 bit açar parametri seçildi.
- [x] Private Key Export deaktiv edildi.
- [x] Domain Computers üçün Read, Enroll və Autoenroll icazələri verildi.
- [x] Şablon CA üzərində yayımlandı.
- [x] Certificate Auto-Enrollment Group Policy vasitəsilə konfiqurasiya edildi.
- [x] SRV01 üçün daxili CA tərəfindən imzalanmış sertifikat alındı.
- [x] SRV01 üzərində IIS HTTPS TCP/443 konfiqurasiya edildi.
- [x] https://srv01.corp.local ünvanı sertifikat xəbərdarlığı olmadan açıldı.

### Windows LAPS

- [x] SRV01 Tier1 Servers OU daxilində yerləşdirildi.
- [x] Windows LAPS üçün Active Directory icazələri konfiqurasiya edildi.
- [x] GPO-Windows-LAPS-Tier1-Servers siyasəti yaradıldı.
- [x] Backup Directory olaraq Active Directory seçildi.
- [x] Parol uzunluğu 16 simvol təyin edildi.
- [x] Parol mürəkkəbliyi konfiqurasiya edildi.
- [x] Password Age 30 gün təyin edildi.
- [x] SRV01 üzərində KB5025230 yeniləməsi quraşdırıldı.
- [x] Windows LAPS modulunun mövcudluğu yoxlanıldı.
- [x] gpupdate /force icra edildi.
- [x] Reset-LapsPassword vasitəsilə parol rotasiyası başladıldı.
- [x] Get-LapsADPassword vasitəsilə AD-də parolun yenilənmə vaxtı yoxlanıldı.
- [x] Parolun 30 gün sonrakı bitmə tarixi yoxlanıldı.
- [x] gpresult /r /scope computer ilə GPO tətbiqi təsdiqləndi.

## Yekun nəticələr

| Alt bölmə | Əsas texnologiyalar | Praktiki nəticə |
|---|---|---|
| 2.1 | AD DS, GPO, Tiered Access | Domen infrastrukturu və giriş məhdudiyyətləri |
| 2.2 | JumpServer, RDP, Session Audit | Mərkəzləşdirilmiş administrator girişi və sessiya nəzarəti |
| 2.3 | Keycloak, PostgreSQL, LDAPS, MFA | 16 istifadəçi, 4 SSO platforması, OTP və HTTPS |
| 2.4 | AD CS, IIS, Windows LAPS | Daxili CA, etibarlı HTTPS, 16 simvolluq parol və 30 günlük rotasiya |

## Əlaqəli sənədlər

- [Bölmə 2 — Ümumi README](README.md)
- [Active Directory və Tiered Access](active-directory.md)
- [Privileged Access Management](privileged-access-management.md)
- [Keycloak, SSO və MFA](sso-mfa.md)
- [Windows LAPS və PKI](laps-pki.md)

## Nəticə

Bölmə 2 üzrə korporativ kimlik və giriş idarəetməsi, imtiyazlı administrator sessiyaları, çoxfaktorlu autentifikasiya, dörd tətbiqin SSO inteqrasiyası, daxili sertifikat infrastrukturu və lokal administrator parollarının rotasiyası həyata keçirilmişdir.

Bu yoxlama siyahısı yekun layihə hesabatında sənədləşdirilmiş konfiqurasiyaları və praktiki nəticələri bir yerdə təqdim edir.
