# 2.4 — WINDOWS LAPS VƏ SERTİFİKAT İDARƏETMƏSİ (PKI)

## 1. Məqsəd

Bu mərhələdə korporativ infrastrukturda lokal administrator parollarının təhlükəsiz idarə olunması və daxili HTTPS xidmətləri üçün sertifikat infrastrukturunun yaradılması həyata keçirilmişdir.

İki əsas texnologiyadan istifadə edilmişdir:

- Active Directory Certificate Services (AD CS) — daxili sertifikat mərkəzi və PKI;
- Windows LAPS — lokal administrator parollarının avtomatik rotasiyası və Active Directory-də saxlanması.

Tətbiq olunan təhlükəsizlik nəzarətləri:
- Daxili Enterprise Root CA;
- Sertifikat şablonları;
- Sertifikatların avtomatik alınması;
- HTTPS bağlantılarının daxili CA ilə qorunması;
- Lokal administrator parollarının 16 simvol uzunluğunda yaradılması;
- Parolların 30 günlük rotasiya siyasəti;
- Parol məlumatlarının Active Directory üzərindən idarə olunması.

## 2.4.1 — CA01 serverinin hazırlanması

Sertifikat xidmətini Domain Controller-lərdən ayrı saxlamaq üçün CA01 adlı Windows Server 2022 virtual maşını yaradılmışdır.

### Server parametrləri

| Parametr | Dəyər |
|---|---|
| Server adı | CA01 |
| Əməliyyat sistemi | Windows Server 2022 |
| Identity IP | 192.168.100.40/24 |
| Əlavə IP | 10.0.0.40/8 |
| Gateway | 10.0.0.2 |
| Əsas DNS | 192.168.100.10 — DC01 |
| İkinci DNS | 192.168.100.11 — DC02 |
| Domen | corp.local |

CA01 serveri corp.local domeninə qoşulmuş və DC01 ilə şəbəkə bağlantısı yoxlanılmışdır.

### Arxitektura əsaslandırması

Certificate Authority xidmətinin ayrıca serverdə yerləşdirilməsi sertifikat idarəetmə funksiyasını Domain Controller xidmətlərindən ayırır.

Bu yanaşma PKI komponentinin müstəqil idarə olunmasına və sertifikat xidmətləri üçün ayrıca inzibati nəzarət tətbiqinə imkan verir.

## 2.4.2 — Enterprise Root CA-nın qurulması

CA01 serverində Server Manager vasitəsilə Active Directory Certificate Services rolu quraşdırılmışdır.

Quraşdırma yolu:

Server Manager → Add Roles and Features → Active Directory Certificate Services

Role Services mərhələsində Certification Authority seçilmişdir.

### CA konfiqurasiyası

| Parametr | Dəyər |
|---|---|
| Setup Type | Enterprise CA |
| CA Type | Root CA |
| CA adı | CORP-ROOT-CA |
| Açar uzunluğu | RSA 4096 bit |
| Hash alqoritmi | SHA256 |
| CA etibarlılıq müddəti | 10 il |

Konfiqurasiya tamamlandıqdan sonra Configuration succeeded nəticəsi alınmışdır.

certsrv.msc konsolunda CORP-ROOT-CA xidmətinin yaradıldığı və mövcud olduğu yoxlanılmışdır.

### Təhlükəsizlik əhəmiyyəti

Enterprise Root CA daxili sistemlərə verilən sertifikatlar üçün etibar mərkəzi rolunu oynayır.

RSA 4096 bit və SHA256 parametrləri Root CA-nın kriptoqrafik konfiqurasiyasında istifadə edilmişdir.

## 2.4.3 — HTTPS sertifikat şablonunun yaradılması

Daxili serverlərə HTTPS sertifikatları vermək üçün certtmpl.msc konsolunda Web Server şablonu kopyalanmış və CORP-WebServer adlı yeni sertifikat şablonu yaradılmışdır.

### Sertifikat şablonunun parametrləri

| Parametr | Dəyər |
|---|---|
| Şablon adı | CORP-WebServer |
| Sertifikat müddəti | 1 il |
| Renewal Period | 6 həftə |
| Açar uzunluğu | RSA 2048 bit |
| Subject Alternative Name | DNS name |
| Private Key Export | Disabled |

Private Key Export parametrinin söndürülməsi sertifikatın şəxsi açarının ixracını məhdudlaşdırmaq üçün tətbiq edilmişdir.

### Sertifikat icazələri

Domain Computers qrupuna aşağıdakı icazələr verilmişdir:

- Read;
- Enroll;
- Autoenroll.

Bu icazələr domen kompüterlərinin uyğun sertifikat şablonundan istifadə etməsi və sertifikatların avtomatik alınması üçün konfiqurasiya edilmişdir.

### Şablonun CA üzərində yayımlanması

certsrv.msc konsolunda Certificate Template to Issue seçimi vasitəsilə CORP-WebServer şablonu CA üzərində yayımlanmışdır.

### Access is denied xətasının həlli

İlkin mərhələdə sertifikat şablonlarının idarə olunması zamanı Access is denied xətası yaranmışdır.

Səbəb sertifikat şablonlarının lokal CA01\Administrator hesabı ilə idarə edilməsinə cəhd edilməsi olmuşdur.

CORP\Administrator hesabı ilə daxil olduqdan sonra problem aradan qaldırılmış və şablonun idarə olunması tamamlanmışdır.

## 2.4.4 — Sertifikatların avtomatik alınması və HTTPS testi

### Auto-Enrollment siyasəti

Sertifikatların avtomatik alınması üçün Group Policy üzərindən Certificate Auto-Enrollment siyasəti tətbiq edilmişdir.

Bu siyasət uyğun domen kompüterlərinin sertifikat şablonlarına əsasən sertifikat əldə etməsinə xidmət edir.

### SRV01 sertifikat problemi

İlkin yoxlamada SRV01 serverinin sertifikat almadığı müəyyən edilmişdir.

Araşdırma zamanı CORP-WebServer şablonunun CA üzərində yayımlanması ilə bağlı problem aşkar edilmişdir.

Şablon aktivləşdirildikdən sonra sertifikat sorğusu yenidən yoxlanılmışdır.

### Sertifikatın yoxlanılması

SRV01 serverində aşağıdakı xüsusiyyətlərə malik sertifikatın mövcudluğu təsdiqlənmişdir:

| Parametr | Nəticə |
|---|---|
| Server | SRV01 |
| Sertifikat adı | SRV01.corp.local |
| İmzalayan CA | CORP-ROOT-CA |
| Şablon | CORP-WebServer |

### IIS HTTPS konfiqurasiyası

SRV01 üzərində IIS Web Server rolu quraşdırılmışdır.

Alınmış sertifikat IIS xidmətinin HTTPS bağlantısına bağlanmışdır.

| Parametr | Dəyər |
|---|---|
| Xidmət | IIS |
| Protokol | HTTPS |
| Port | TCP 443 |
| URL | https://srv01.corp.local |
| Sertifikat mənbəyi | CORP-ROOT-CA |

### Brauzer testi

Brauzerdə aşağıdakı ünvan açılmışdır:

https://srv01.corp.local

Nəticə: IIS HTTPS xidməti sertifikat xəbərdarlığı olmadan açılmışdır.

Bu test daxili CA tərəfindən verilmiş sertifikatın müştəri sistemində etibarlı qəbul edildiyini göstərmişdir.

## 2.4.5 — Windows LAPS üçün Active Directory-nin hazırlanması

Lokal administrator parollarının mərkəzləşdirilmiş və avtomatik idarə edilməsi üçün Windows LAPS tətbiq edilmişdir.

İlk test serveri olaraq Tier1 səviyyəsində yerləşən SRV01 seçilmişdir.

### Active Directory hazırlığı

DC01 üzərində Windows LAPS modulu yoxlanılmışdır.

İlkin mərhələdə modul görünmədiyi üçün Windows yeniləmələri quraşdırılmışdır.

### SRV01-in OU yerləşməsi

SRV01 serverinin aşağıdakı Organizational Unit daxilində olduğu təsdiqlənmişdir:

OU=Servers,OU=Tier1,DC=corp,DC=local

Bu yerləşmə Windows LAPS siyasətinin Tier1 serverlərinə tətbiq olunması üçün istifadə edilmişdir.

## 2.4.6 — Windows LAPS GPO-nun tətbiqi

### Active Directory icazələri

SRV01 serverinin öz LAPS məlumatlarını Active Directory-yə yaza bilməsi üçün müvafiq OU üzərində kompüter hesablarına icazə verilmişdir.

İstifadə olunan PowerShell əmri:

~~~powershell
Set-LapsADComputerSelfPermission -Identity "OU=Servers,OU=Tier1,DC=corp,DC=local"
~~~

### GPO konfiqurasiyası

Aşağıdakı Group Policy yaradılmışdır:

GPO-Windows-LAPS-Tier1-Servers

Siyasət Tier1 → Servers OU-suna bağlanmışdır.

### LAPS parametrləri

| Parametr | Dəyər |
|---|---|
| Backup Directory | Active Directory |
| Password Length | 16 simvol |
| Password Complexity | Hərflər, rəqəmlər və xüsusi simvollar |
| Password Age | 30 gün |

Bu siyasət lokal administrator parolunun 16 simvol uzunluğunda və mürəkkəb formada yaradılmasını, Active Directory-də saxlanmasını və 30 günlük rotasiya müddətini müəyyən edir.

## 2.4.7 — LAPS xətasının həlli və parol rotasiyasının yoxlanılması

### Problemin müəyyən edilməsi

SRV01 serverində Windows LAPS modulunun mövcud olmadığı müəyyən edilmişdir.

Səbəb Windows Server 2022 sisteminin köhnə yeniləmə səviyyəsində olması idi.

### Şəbəkə bağlantısının düzəldilməsi

Windows yeniləməsinin quraşdırılması üçün internet bağlantısı tələb olunurdu.

SRV01 serverində gateway konfiqurasiyası düzgün olmadığı üçün şəbəkə parametrləri yenilənmişdir.

| Parametr | Dəyər |
|---|---|
| Mövcud domen IP | 192.168.100.20 |
| Əlavə IP | 10.0.0.21 |
| Gateway | 10.0.0.2 |

Mövcud domen IP ünvanı saxlanılmış, əlavə IP və gateway konfiqurasiya edilmişdir.

### Windows yeniləməsi

Şəbəkə bağlantısı düzəldildikdən sonra KB5025230 yeniləməsi quraşdırılmışdır.

Server yenidən başladılmış və Windows LAPS modulunun mövcud olduğu yoxlanılmışdır.

### GPO-nun yenilənməsi

SRV01 serverində Group Policy yenilənmişdir:

~~~powershell
gpupdate /force
~~~

### Parol rotasiyasının başladılması

Lokal administrator parolunun rotasiyası aşağıdakı əmrlə başladılmışdır:

~~~powershell
Reset-LapsPassword
~~~

### Active Directory-də nəticənin yoxlanılması

DC01 üzərində LAPS məlumatları aşağıdakı PowerShell əmri ilə yoxlanılmışdır:

~~~powershell
Get-LapsADPassword -Identity SRV01 |
    Select-Object ComputerName,PasswordUpdateTime,ExpirationTimestamp
~~~

Nəticədə SRV01 üçün:
- Parolun yenilənmə vaxtı;
- Parolun 30 gün sonrakı bitmə tarixi

görünmüşdür.

### GPO tətbiqinin yoxlanılması

SRV01 üzərində aşağıdakı əmr istifadə edilmişdir:

~~~cmd
gpresult /r /scope computer
~~~

Nəticədə Windows LAPS GPO-sunun serverə tətbiq edildiyi təsdiqlənmişdir.

## 3. PKI və LAPS təhlükəsizlik arxitekturası

| Komponent | Server | Funksiya |
|---|---|---|
| Enterprise Root CA | CA01 | CORP-ROOT-CA |
| Sertifikat şablonu | CA01 | CORP-WebServer |
| Auto-Enrollment | Active Directory GPO | Sertifikatların avtomatik alınması |
| IIS HTTPS | SRV01 | TCP 443, daxili CA sertifikatı |
| Windows LAPS | SRV01 | Lokal administrator parolunun rotasiyası |
| LAPS məlumatlarının saxlanması | Active Directory | Parol və bitmə vaxtı məlumatları |
| LAPS GPO | Tier1 → Servers OU | 16 simvol, 30 gün |

## 4. Praktiki test nəticələri

| Test | Nəticə |
|---|---|
| CA01 serverinin domenə qoşulması | Uğurlu |
| AD CS rolunun quraşdırılması | Tamamlandı |
| Enterprise Root CA | CORP-ROOT-CA yaradıldı |
| CA konfiqurasiyası | Configuration succeeded |
| CORP-WebServer şablonu | Yaradıldı və yayımlandı |
| Sertifikat müddəti | 1 il |
| Renewal Period | 6 həftə |
| Auto-Enrollment | GPO ilə tətbiq edildi |
| SRV01 sertifikatı | CORP-ROOT-CA tərəfindən imzalandı |
| IIS HTTPS | TCP 443 |
| Brauzer testi | Sertifikat xəbərdarlığı olmadan açıldı |
| Windows LAPS modulu | KB5025230 sonrası aktiv |
| LAPS GPO | GPO-Windows-LAPS-Tier1-Servers |
| Parol uzunluğu | 16 simvol |
| Parol rotasiya müddəti | 30 gün |
| Reset-LapsPassword | İcra edildi |
| AD-də parol məlumatları | Yoxlanıldı |
| gpresult ilə GPO testi | Təsdiqləndi |

## 5. Nəticə

Bölmə 2.4 çərçivəsində CA01 serveri üzərində CORP-ROOT-CA adlı Enterprise Root CA qurulmuşdur.

CORP-WebServer sertifikat şablonu yaradılmış, 1 illik sertifikat müddəti və 6 həftəlik yenilənmə intervalı konfiqurasiya edilmişdir. Group Policy vasitəsilə Certificate Auto-Enrollment tətbiq olunmuşdur.

SRV01 serverində daxili CA tərəfindən imzalanmış sertifikat alınmış, IIS HTTPS xidməti TCP 443 portunda konfiqurasiya edilmiş və https://srv01.corp.local ünvanına brauzerdən sertifikat xəbərdarlığı olmadan giriş təsdiqlənmişdir.

Windows LAPS Tier1 serverləri üçün konfiqurasiya edilmişdir. SRV01 üzərində 16 simvolluq lokal administrator parolu, Active Directory-də saxlanma və 30 günlük rotasiya siyasəti tətbiq olunmuşdur.

Reset-LapsPassword və Get-LapsADPassword əmrləri vasitəsilə parolun yenilənməsi və bitmə vaxtı yoxlanılmış, gpresult ilə GPO-nun tətbiqi təsdiqlənmişdir.
