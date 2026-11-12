# BÖLMƏ 2 — Identity & Access Management, PAM, SSO və PKI

## 1. Məqsəd və əhatə dairəsi

Bu bölmədə CSOC infrastrukturunda istifadəçi və administrator hesablarının təhlükəsiz idarə edilməsi, imtiyazlı girişlərin mərkəzləşdirilməsi, vahid autentifikasiya, çoxfaktorlu doğrulama və daxili sertifikat infrastrukturu sənədləşdirilir.

İstifadə edilən əsas texnologiyalar: Microsoft Active Directory, Group Policy, JumpServer PAM, Keycloak, PostgreSQL, Docker Compose, Windows LAPS və Active Directory Certificate Services (AD CS).

## 2. İnfrastruktur

| Server | IP ünvanı | Təyinat |
|---|---|---|
| DC01 | 192.168.100.10 | Active Directory, DNS |
| DC02 | 192.168.100.11 | Əlavə Domain Controller, replikasiya |
| SRV01 | 192.168.100.20 | Windows Member Server, LAPS |
| PAM01 | 192.168.100.30 | JumpServer PAM |
| CA01 | 192.168.100.40 | AD CS, daxili PKI |
| IAM01 | 192.168.100.50 | Keycloak, SSO, MFA |

## 3. Tapşırıq 2.1 — Active Directory və Tiered Access Model

### Məqsəd
Administrator hüquqlarını təhlükəsizlik səviyyələrinə ayırmaq və icazəsiz lateral movement riskini azaltmaq.

### Tətbiq
- Active Directory domen infrastrukturu DC01 və DC02 üzərində təşkil edildi.
- Administrator və server resursları üçün Tier əsaslı giriş modeli tətbiq edildi.
- OU və Group Policy mexanizmləri ilə giriş məhdudiyyətləri yaradıldı.
- SRV01 serveri Tier1 OU-suna yerləşdirildi.
- Uyğun olmayan Tier hesablarının serverə girişinə məhdudiyyət tətbiq edildi.
- Domain Controller-lər üçün GPO-T0-Audit audit siyasəti hazırlandı.

### Test və nəticə
SRV01 serverinə Tier2 hesabı ilə giriş cəhdi uğursuz oldu. Sistem 'The sign-in method you're trying to use isn't allowed' mesajı göstərdi. Bu test Tier1 serverinə digər Tier hesabları ilə giriş məhdudiyyətini təsdiqlədi.

### Audit
GPO-T0-Audit vasitəsilə aşağıdakı hadisələrin auditi konfiqurasiya edildi:
- Uğurlu və uğursuz login hadisələri;
- İstifadəçi və təhlükəsizlik qruplarının idarə edilməsi;
- Active Directory dəyişiklikləri;
- Audit siyasətində dəyişikliklər.

### Müəllimin tələb etdiyi sübut
Tier1 hesabının Tier0 resursuna daxil ola bilmədiyini göstərən ayrıca test və screenshot təqdim edilməlidir. SRV01 üzərindəki Tier2 → Tier1 testi bu tələbə tam ekvivalent deyil.

## 4. Tapşırıq 2.2 — Privileged Access Management (PAM)

### Məqsəd
Administratorların kritik serverlərə girişini mərkəzi platformadan idarə etmək, sessiyaları qeyd etmək və birbaşa girişləri məhdudlaşdırmaq.

### Tətbiq
- PAM01 serverində JumpServer platforması quruldu.
- DC01 üçün PAM giriş siyasəti yaradıldı.
- DC01 serverinə RDP girişi yalnız PAM01 IP ünvanı ilə məhdudlaşdırıldı.
- JumpServer üzərindən RDP bağlantısı yoxlanıldı.
- Sessiya video qeydi və əmrlərin audit qeydləri yoxlanıldı.
- GPO vasitəsilə 15 dəqiqəlik boşdayanma və 1 saatlıq aktiv sessiya limiti tətbiq edildi.

### Təsdiqlənmiş nəticələr
- PAM üzərindən RDP bağlantısı;
- IP əsaslı giriş məhdudiyyəti;
- Sessiya video qeydi;
- Əmr auditinin işləməsi;
- Sessiya müddəti məhdudiyyətləri.

### Əlavə yoxlama
Müəllimin tələbinə əsasən PAM loglarının SIEM-ə real vaxtda ötürülməsi ayrıca sübutla təsdiqlənməlidir.

## 5. Tapşırıq 2.3 — Mərkəzi IAM, SSO və MFA

### Məqsəd
Active Directory istifadəçilərinin mərkəzi IAM platforması vasitəsilə idarə edilməsi, daxili sistemlər üçün vahid giriş və administrator hesablarının MFA ilə qorunması.

### Keycloak-un qurulması
- IAM01 adlı Ubuntu Server 24.04 virtual maşını hazırlandı.
- Docker Compose vasitəsilə Keycloak 26.4 və PostgreSQL 17 quruldu.
- Keycloak administrator panelində 'corp' realm yaradıldı.
- Active Directory ilə LDAPS inteqrasiyası konfiqurasiya edildi.

### İstifadəçi sinxronizasiyası
Keycloak üzərində 'Sync all users' əməliyyatı aparıldı:
- 16 Active Directory istifadəçisi sinxronizasiya edildi;
- Uğursuz sinxronizasiya qeydə alınmadı;
- Tam sinxronizasiya: 24 saatdan bir;
- Dəyişmiş istifadəçilərin sinxronizasiyası: 5 dəqiqədən bir.

### MFA
- Google Authenticator vasitəsilə OTP konfiqurasiya edildi.
- Yenidən giriş zamanı 6 rəqəmli OTP tələb olundu.
- Düzgün kodla uğurlu giriş yoxlanıldı.
- Ehtiyat bərpa kodları yaradıldı.

### HTTPS
- iam01.corp.local DNS qeydi yaradıldı.
- Daxili CA tərəfindən imzalanmış sertifikat Keycloak-a əlavə edildi.
- HTTPS üçün 8443 portu konfiqurasiya edildi.
- https://iam01.corp.local:8443 ünvanı ilə giriş yoxlanıldı.

### Müəllimin yoxlama meyarları
- Ən azı 4 platformanın SSO inteqrasiyası;
- Bütün administrator hesabları üçün məcburi MFA;
- MFA bypass cəhdinin bloklanması;
- Uğurlu və uğursuz login hadisələrinin SIEM-ə çatması.

Bu meyarların hər biri ayrıca test nəticəsi və screenshotla təsdiqlənməlidir. OTP ilə uğurlu giriş testi özlüyündə MFA bypass bloklanması testi deyil.

## 6. Tapşırıq 2.4 — Windows LAPS və sertifikat idarəetməsi

### Məqsəd
Lokal administrator parollarının avtomatik dəyişdirilməsi və daxili HTTPS xidmətlərinin etibarlı sertifikatlarla qorunması.

### Windows LAPS
- Windows LAPS Tier1 serverləri üçün tətbiq edildi.
- SRV01-də lokal administrator parolunun Active Directory-də saxlanılması yoxlanıldı.
- 16 simvolluq kompleks parol siyasəti tətbiq edildi.
- Parol rotasiyası 30 gün olaraq müəyyənləşdirildi.
- Parolun yenilənmə və bitmə tarixləri yoxlanıldı.
- 'gpresult /r /scope computer' əmri ilə GPO tətbiqi təsdiqləndi.

### Daxili PKI
- CA01 üzərində CORP-ROOT-CA sertifikat mərkəzi quruldu.
- CORP-WebServer adlı HTTPS sertifikat şablonu yaradıldı.
- Group Policy vasitəsilə Certificate Auto-Enrollment tətbiq edildi.
- SRV01 üzərində IIS xidməti daxili CA sertifikatı ilə HTTPS üzərindən işlədildi.
- Brauzerdə sertifikat xəbərdarlığı olmadan açılması yoxlanıldı.

### Qarşılaşılan problemlər
1. Sertifikat şablonunu idarə edərkən 'Access is denied' xətası yarandı. Lokal CA01 Administrator hesabı əvəzinə CORP Administrator hesabından istifadə edilərək problem həll olundu.
2. SRV01 ilkin yoxlamada sertifikat almadı. CORP-WebServer şablonunun CA üzərində yayımlanması düzəldildikdən sonra sertifikat sorğusu yenidən yoxlanıldı.

### Nəticə
LAPS rotasiya siyasəti və daxili CA ilə HTTPS bağlantısı hesabatda testlərlə təsdiqlənmişdir. Bütün daxili xidmətlərin sertifikat əhatəsi isə ayrıca inventar və yoxlama tələb edir.

## 7. Müəllim üçün yekun yoxlama cədvəli

| Tələb | Hesabatdakı vəziyyət |
|---|---|
| AD və Tier əsaslı giriş | SRV01 üzərində giriş məhdudiyyəti test edilib |
| Tier1 → Tier0 bloklanma testi | Ayrıca sübut tələb olunur |
| PAM üzərindən giriş | Yoxlanılıb |
| PAM sessiya video qeydi | Yoxlanılıb |
| PAM əmrlərinin auditi | Yoxlanılıb |
| PAM loglarının SIEM-ə real-time ötürülməsi | Ayrıca sübut tələb olunur |
| Keycloak və AD sinxronizasiyası | 16 istifadəçi sinxronlaşdırılıb |
| 4 platformanın SSO inteqrasiyası | Ayrı-ayrı sübutlarla yoxlanmalıdır |
| OTP əsaslı MFA | Uğurlu giriş yoxlanılıb |
| MFA bypass bloklanması | Ayrıca test tələb olunur |
| Windows LAPS | 30 günlük rotasiya yoxlanılıb |
| Daxili CA və HTTPS | SRV01 üzərində təsdiqlənib |
| Bütün daxili HTTPS xidmətlərinin əhatəsi | Əlavə yoxlama tələb olunur |

## 8. Sübutların saxlanılması

Bu bölmənin screenshotları və test nəticələri sonradan 'evidence/' qovluğunda saxlanılmalıdır. Real screenshot təqdim edilməyən testlər tamamlanmış kimi qeyd edilməməlidir.

## 9. Ümumi nəticə

Bölmə 2 çərçivəsində Active Directory giriş məhdudiyyətləri, JumpServer PAM, Keycloak IAM, OTP MFA, Windows LAPS və daxili PKI mexanizmləri tətbiq və test edilmişdir. Nəticələr imtiyazlı girişlərin idarə edilməsi, hesabların qorunması və HTTPS təhlükəsizliyi istiqamətində əsas nəzarətlərin qurulduğunu göstərir. Müəllimin tələb etdiyi əlavə inteqrasiya və mənfi test ssenariləri ayrıca sübutlarla tamamlanmalıdır.
