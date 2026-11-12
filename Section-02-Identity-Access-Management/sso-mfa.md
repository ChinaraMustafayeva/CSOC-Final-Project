# 2.3 — Identity Management, SSO və MFA

## Məqsəd

Active Directory istifadəçilərinin vahid IAM platformasında idarə edilməsi, təhlükəsiz autentifikasiya və çoxfaktorlu doğrulama mexanizminin tətbiqi.

## İstifadə olunan texnologiyalar

- Keycloak 26.4
- PostgreSQL 17
- Docker Compose
- Microsoft Active Directory
- LDAPS
- Google Authenticator
- Active Directory Certificate Services

## İnfrastruktur

| Komponent | Təyinat |
|---|---|
| IAM01 | Keycloak serveri |
| Ubuntu Server 24.04 | Əməliyyat sistemi |
| PostgreSQL 17 | Verilənlər bazası |
| Docker Compose | Konteynerlərin idarə edilməsi |
| corp | Keycloak realm |

## Keycloak-un qurulması

IAM01 virtual maşını hazırlandı. Docker Compose vasitəsilə Keycloak və PostgreSQL xidmətləri quraşdırıldı.

Keycloak administrator panelində corp adlı realm yaradıldı. İstifadəçilərin mərkəzləşdirilmiş idarə edilməsi üçün Active Directory ilə LDAPS inteqrasiyası konfiqurasiya edildi.

## Active Directory sinxronizasiyası

Keycloak üzərində Sync all users əməliyyatı həyata keçirildi.

| Göstərici | Nəticə |
|---|---|
| Sinxronlaşdırılmış istifadəçilər | 16 |
| Uğursuz sinxronizasiya | 0 |
| Tam sinxronizasiya intervalı | 24 saat |
| Dəyişmiş istifadəçilərin sinxronizasiyası | 5 dəqiqə |

## MFA konfiqurasiyası

Google Authenticator vasitəsilə OTP əsaslı çoxfaktorlu autentifikasiya konfiqurasiya edildi.

İstifadəçi giriş zamanı paroldan əlavə 6 rəqəmli OTP kodu daxil etdi. Düzgün kodla autentifikasiya uğurla tamamlandı.

Hesabların bərpası üçün recovery code mexanizmi də konfiqurasiya edildi.

## HTTPS konfiqurasiyası

- iam01.corp.local DNS qeydi yaradıldı.
- Daxili CA tərəfindən imzalanmış sertifikat Keycloak-a əlavə edildi.
- HTTPS 8443 portunda aktivləşdirildi.
- https://iam01.corp.local:8443 ünvanı ilə bağlantı yoxlanıldı.

## Nəticə

Keycloak IAM platforması quruldu, Active Directory ilə LDAPS inteqrasiyası yaradıldı və 16 istifadəçi sinxronlaşdırıldı. OTP əsaslı MFA və daxili CA sertifikatı ilə HTTPS bağlantısı praktik olaraq yoxlanıldı.
