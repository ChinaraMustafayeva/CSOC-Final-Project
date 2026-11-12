# 2.3 — MƏRKƏZİ KİMLİK İDARƏETMƏSİ, SSO VƏ MFA

## 1. Məqsəd

Bu mərhələdə korporativ istifadəçi hesablarının mərkəzləşdirilmiş idarə olunması, Active Directory ilə təhlükəsiz sinxronizasiya, administrator hesabları üçün çoxfaktorlu autentifikasiya və dörd fərqli tətbiqin vahid giriş sistemi ilə inteqrasiyası həyata keçirilmişdir.

IAM platforması kimi Keycloak seçilmişdir.

Layihədə aşağıdakı funksiyalar tətbiq edilmişdir:

- Keycloak 26.4 və PostgreSQL 17 infrastrukturu;
- Active Directory ilə LDAPS inteqrasiyası;
- 16 domen istifadəçisinin sinxronizasiyası;
- Administrator hesabları üçün OTP əsaslı MFA;
- Recovery Authentication Codes;
- Daxili CA sertifikatı ilə HTTPS;
- Grafana, Gitea, Wiki.js və Nextcloud üçün SSO.

## 2.3.1 — IAM01 serverinin və Keycloak-un qurulması

### Server infrastrukturu

VMware Workstation üzərində IAM01 adlı Ubuntu Server 24.04 virtual maşını yaradılmışdır.

| Parametr | Dəyər |
|---|---|
| Server adı | IAM01 |
| Əməliyyat sistemi | Ubuntu Server 24.04 |
| Identity IP | 192.168.100.50 |
| Digər interfeys | 10.0.0.50 |
| IAM platforması | Keycloak 26.4 |
| Verilənlər bazası | PostgreSQL 17 |
| Konteyner idarəetməsi | Docker Compose |
| Konfiqurasiya qovluğu | /opt/keycloak |
| Realm | corp |

IAM01 serverində şəbəkə interfeysləri və DNS bağlantısı konfiqurasiya edilmişdir.

### Docker Compose quraşdırılması

Keycloak 26.4 və PostgreSQL 17 Docker Compose vasitəsilə quraşdırılmışdır.

Konfiqurasiya /opt/keycloak qovluğunda hazırlanmış və xidmətlər aşağıdakı əmrlə başladılmışdır:

~~~bash
sudo docker compose up -d
~~~

Konteynerlərin işləməsi yoxlanılmış, Keycloak administrator panelində corp adlı realm yaradılmışdır.

### Realm strukturu

corp realm korporativ autentifikasiya üçün əsas idarəetmə mühiti kimi istifadə edilmişdir.

Bu realm daxilində:
- LDAP Federation;
- İstifadəçi sinxronizasiyası;
- Authentication Flow;
- OTP və recovery codes;
- SSO tətbiq client-ləri konfiqurasiya edilmişdir.

## 2.3.2 — Active Directory ilə LDAPS inteqrasiyası

### Servis hesabı

DC01 üzərində Keycloak-un Active Directory ilə əlaqəsi üçün svc_keycloak_ldap adlı servis hesabı yaradılmışdır.

Bu hesaba Domain Admin səlahiyyəti verilməmişdir.

Beləliklə, IAM inteqrasiyasında yüksək domen səlahiyyətli hesabdan istifadə edilməmişdir.

### LDAP Federation

Keycloak-da CORP-AD adlı LDAP Federation bağlantısı yaradılmışdır.

| Parametr | Dəyər |
|---|---|
| Federation adı | CORP-AD |
| Connection URL | ldaps://dc01.corp.local:636 |
| Users DN | DC=corp,DC=local |
| Edit Mode | READ_ONLY |
| Search Scope | Subtree |
| Username Attribute | sAMAccountName |

LDAPS TCP/636 portu üzərindən şifrələnmiş LDAP bağlantısı təmin edir.

READ_ONLY rejimi Keycloak tərəfindən Active Directory məlumatlarının dəyişdirilməsinin qarşısını almaq üçün seçilmişdir.

### Bağlantı xətasının aradan qaldırılması

İlkin autentifikasiya yoxlamasında servis hesabının istifadəçi adı ilə Distinguished Name (DN) məlumatı qarışdırıldığı üçün bağlantı alınmamışdır.

Servis hesabının düzgün DN məlumatı müəyyən edilmiş və LDAP konfiqurasiyası düzəldilmişdir.

### LDAPS sertifikat etibarlılığı

LDAPS bağlantısının qurulması zamanı daxili sertifikat etibarlılığı xətası yaranmışdır.

Səbəb IAM01 serverinin və Keycloak konteynerinin CORP-ROOT-CA sertifikatına etibar etməməsi olmuşdur.

Problemin həlli:
1. Daxili CA sertifikatı əldə edilmişdir.
2. Sertifikat etibarlı sertifikatlar siyahısına əlavə edilmişdir.
3. Keycloak konteyneri yenidən başladılmışdır.
4. LDAP bağlantısı yenidən yoxlanılmışdır.

Nəticədə Keycloak üzərində Test connection və Test authentication yoxlamaları uğurla tamamlanmışdır.

## 2.3.3 — Active Directory istifadəçilərinin sinxronizasiyası

### İlkin sinxronizasiya

LDAP Federation konfiqurasiyasından sonra Keycloak-da Sync all users əməliyyatı icra edilmişdir.

| Göstərici | Nəticə |
|---|---|
| Sinxronlaşdırılmış istifadəçi | 16 |
| Uğursuz sinxronizasiya | 0 |
| Sinxronizasiya mənbəyi | Active Directory |
| İstifadəçi atributu | sAMAccountName |

Beləliklə, Active Directory-dən 16 istifadəçi hesabı Keycloak-a uğurla əlavə edilmişdir.

### Avtomatik sinxronizasiya

| Sinxronizasiya növü | Interval |
|---|---|
| Full Sync | Hər 24 saatdan bir |
| Changed Users Sync | Hər 5 dəqiqədən bir |

Full Sync bütün istifadəçi məlumatlarının dövri yenilənməsi üçün, Changed Users Sync isə dəyişmiş hesabların daha qısa intervalla sinxronlaşdırılması üçün aktivləşdirilmişdir.

### Autentifikasiya testi

t2-aysel domen hesabı ilə Keycloak-a giriş həyata keçirilmişdir.

Test nəticəsində Active Directory istifadəçi hesabı ilə Keycloak autentifikasiyasının işlədiyi təsdiqlənmişdir.

## 2.3.4 — MFA və ehtiyat giriş kodları

### MFA siyasəti

Administrator hesablarının qorunması üçün Keycloak-da aşağıdakı Required Actions aktivləşdirilmişdir:

- Configure OTP;
- Recovery Authentication Codes.

Tier0, Tier1 və Tier2 administrator hesabları üçün bu addımlar tələb olunan autentifikasiya əməliyyatları kimi təyin edilmişdir.

### Google Authenticator ilə OTP

t2-aysel hesabında Google Authenticator vasitəsilə OTP konfiqurasiyası aparılmışdır.

Test ardıcıllığı:
1. İstifadəçi Keycloak autentifikasiya prosesinə daxil olmuşdur.
2. OTP konfiqurasiyası tamamlanmışdır.
3. Yenidən giriş zamanı 6 rəqəmli OTP kodu tələb edilmişdir.
4. Google Authenticator tətbiqindən alınmış düzgün kod daxil edilmişdir.
5. Autentifikasiya uğurla tamamlanmışdır.

Bu test OTP əsaslı ikinci autentifikasiya faktorunun işlədiyini göstərmişdir.

### Recovery Authentication Codes

Telefon və autentifikator tətbiqi əlçatan olmadıqda istifadə üçün ehtiyat bərpa kodları yaradılmışdır.

Recovery Authentication Codes funksiyası MFA sisteminin ehtiyat giriş mexanizmi kimi konfiqurasiya edilmişdir.

## 2.3.5 — Keycloak üçün HTTPS sertifikatı

### DNS konfiqurasiyası

Keycloak xidmətinə domen adı ilə təhlükəsiz giriş üçün aşağıdakı DNS qeydi yaradılmışdır:

iam01.corp.local

### Sertifikatın alınması

IAM01 serverində Certificate Signing Request (CSR) hazırlanmışdır.

CA01 üzərində CORP-WebServer sertifikat şablonundan istifadə edilərək daxili CA tərəfindən imzalanmış sertifikat əldə edilmişdir.

Əlaqəli PKI komponentləri:
- CA01;
- CORP-ROOT-CA;
- CORP-WebServer sertifikat şablonu.

### Keycloak HTTPS konfiqurasiyası

Sertifikat Keycloak konteynerinə əlavə edilmişdir.

HTTPS üçün 8443 portu konfiqurasiya edilmiş və Keycloak production başlanğıc rejiminə keçirilmişdir.

### HTTPS testi

Aşağıdakı ünvan vasitəsilə təhlükəsiz giriş yoxlanılmışdır:

https://iam01.corp.local:8443

Test nəticəsində Keycloak-un daxili CA sertifikatı ilə HTTPS üzərindən işləməsi təsdiqlənmişdir.

## 2.3.6 — Dörd platformanın SSO ilə inteqrasiyası

### Məqsəd

Mərkəzi IAM sisteminin yalnız istifadəçi sinxronizasiyası üçün deyil, real tətbiqlərdə vahid giriş mexanizmi kimi istifadə olunması məqsədilə dörd fərqli platforma Keycloak ilə inteqrasiya edilmişdir.

### İnteqrasiya edilmiş platformalar

| № | Platforma | Ünvan | Nəticə |
|---|---|---|---|
| 1 | Grafana | http://10.0.0.50:3000 | Keycloak SSO ilə uğurlu giriş |
| 2 | Gitea | http://10.0.0.50:3001 | Keycloak üzərindən uğurlu giriş |
| 3 | Wiki.js | http://10.0.0.50:3002 | SSO və OTP tələbi yoxlanıldı |
| 4 | Nextcloud | http://10.0.0.50:3003 | Keycloak SSO quruldu və test edildi |

Bu dörd tətbiq üçün Keycloak daxilində ayrıca client konfiqurasiyaları yaradılmışdır.

### Grafana inteqrasiyası

Grafana üçün Keycloak-da OAuth client yaradılmışdır.

Redirect URI parametrləri konfiqurasiya edilmiş və tətbiqin Keycloak ilə autentifikasiya inteqrasiyası hazırlanmışdır.

Test:
- Grafana giriş səhifəsi;
- Keycloak SSO autentifikasiyası;
- t2-aysel hesabı ilə giriş.

Nəticə: t2-aysel hesabı ilə Grafana-ya Keycloak SSO üzərindən uğurlu giriş həyata keçirilmişdir.

### Gitea inteqrasiyası

Gitea platforması quraşdırılmış və Keycloak ilə giriş inteqrasiyası konfiqurasiya edilmişdir.

Test zamanı t2-aysel hesabı istifadə edilmişdir.

Nəticə: Gitea-ya Keycloak üzərindən tam giriş təmin edilmişdir.

### Wiki.js inteqrasiyası

Wiki.js platformasına Keycloak SSO əlavə edilmişdir.

İstifadəçi qrupu və OTP tələbi yoxlanılmışdır.

Test zamanı Wiki.js istifadəçini Keycloak autentifikasiya səhifəsinə yönləndirmiş və OTP kodu tələb etmişdir.

Nəticə: Wiki.js üçün mərkəzi autentifikasiya və OTP mərhələsi yoxlanılmışdır.

### Nextcloud inteqrasiyası

Nextcloud platforması quraşdırılmış, Keycloak ilə giriş konfiqurasiyası yaradılmış və inteqrasiya test edilmişdir.

Nəticə: Nextcloud-un Keycloak SSO inteqrasiyası həyata keçirilmişdir.

### SSO arxitekturasının üstünlükləri

Dörd tətbiqin vahid IAM sistemi ilə əlaqələndirilməsi aşağıdakı təhlükəsizlik üstünlüklərini təmin edir:

- İstifadəçi autentifikasiyasının mərkəzləşdirilməsi;
- Active Directory hesablarının tətbiqlərdə istifadəsi;
- Ayrı-ayrı tətbiqlərdə müstəqil parol idarəetməsi ehtiyacının azaldılması;
- MFA siyasətlərinin mərkəzi autentifikasiya səviyyəsində tətbiqi;
- İstifadəçi girişlərinin idarə olunmasının sadələşdirilməsi.

## 3. Təhlükəsizlik arxitekturası

| Təhlükəsizlik qatı | Texnologiya | Tətbiq |
|---|---|---|
| İstifadəçi mənbəyi | Active Directory | corp.local |
| Təhlükəsiz kataloq bağlantısı | LDAPS | TCP 636 |
| Mərkəzi IAM | Keycloak 26.4 | corp realm |
| IAM məlumat bazası | PostgreSQL 17 | Docker Compose |
| MFA | Google Authenticator | 6 rəqəmli OTP |
| Ehtiyat autentifikasiya | Recovery Authentication Codes | Ehtiyat kodlar |
| Sertifikat infrastrukturu | AD CS | CORP-ROOT-CA |
| Şifrəli IAM girişi | HTTPS | TCP 8443 |
| SSO tətbiqləri | Grafana, Gitea, Wiki.js, Nextcloud | 4 platforma |

## 4. Praktiki yoxlama nəticələri

| Yoxlama | Nəticə |
|---|---|
| Keycloak 26.4 quraşdırılması | Tamamlandı |
| PostgreSQL 17 quraşdırılması | Tamamlandı |
| corp realm yaradılması | Tamamlandı |
| CORP-AD LDAP Federation | Konfiqurasiya edildi |
| LDAPS Test connection | Uğurlu |
| LDAPS Test authentication | Uğurlu |
| AD istifadəçi sinxronizasiyası | 16 istifadəçi |
| Sinxronizasiya xətası | 0 |
| Full Sync | 24 saat |
| Changed Users Sync | 5 dəqiqə |
| t2-aysel domen autentifikasiyası | Uğurlu |
| OTP ilə giriş | Uğurlu |
| Recovery Authentication Codes | Yaradıldı |
| Keycloak HTTPS | Uğurlu |
| Grafana SSO | Uğurlu |
| Gitea SSO | Uğurlu |
| Wiki.js SSO / OTP | Yoxlanıldı |
| Nextcloud SSO | Quruldu və test edildi |

## 5. Nəticə

Bölmə 2.3 çərçivəsində IAM01 üzərində Keycloak 26.4 və PostgreSQL 17 əsaslı mərkəzi kimlik idarəetmə infrastrukturu qurulmuşdur.

Active Directory ilə LDAPS bağlantısı yaradılmış, 16 istifadəçi xətasız sinxronlaşdırılmış, avtomatik sinxronizasiya intervalları konfiqurasiya edilmişdir.

Administrator hesabları üçün OTP və Recovery Authentication Codes funksiyaları tətbiq edilmiş, Google Authenticator ilə 6 rəqəmli kod əsasında uğurlu giriş yoxlanılmışdır.

CA01 üzərində verilmiş daxili sertifikatla Keycloak üçün HTTPS konfiqurasiya edilmiş və iam01.corp.local:8443 ünvanında təhlükəsiz giriş təsdiqlənmişdir.

Ən əsası, Grafana, Gitea, Wiki.js və Nextcloud daxil olmaqla dörd fərqli platforma Keycloak SSO ilə inteqrasiya edilmiş, onların autentifikasiya funksiyaları praktiki olaraq yoxlanılmışdır.
