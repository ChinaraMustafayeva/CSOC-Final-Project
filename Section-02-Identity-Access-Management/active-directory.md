# 2.1 — ACTIVE DIRECTORY EKOSİSTEMİ VƏ TIERED ACCESS MODEL

## 1. Məqsəd və əhatə dairəsi

CSOC layihəsinin bu mərhələsində Active Directory domen infrastrukturu qurulmuş, iki Domain Controller arasında replikasiya təşkil edilmiş, administrator hesabları Tier 0, Tier 1 və Tier 2 səviyyələrinə ayrılmışdır.

Layihədə aşağıdakı təhlükəsizlik tədbirləri həyata keçirilmişdir:

- DC01 və DC02 üzərində Active Directory Domain Services;
- DNS və Domain Controller replikasiyası;
- Tiered Access Model;
- Administratorlar üçün ayrıca Organizational Unit strukturu;
- Səviyyələrarası giriş məhdudiyyətləri üçün üç GPO;
- Active Directory dəyişikliklərinin auditi;
- Fine-Grained Password Policy;
- Protected Users qrupundan istifadə;
- BloodHound və SharpHound vasitəsilə hücum yollarının analizi.

## 2.1.1 — Domain Controller serverlərinin qurulması

### 2.1.1.1. Server infrastrukturu

VMware Workstation üzərində iki Windows Server virtual maşını yaradılmışdır.

| Parametr | DC01 | DC02 |
|---|---|---|
| IP ünvanı | 192.168.100.10 | 192.168.100.11 |
| Subnet mask | 255.255.255.0 | 255.255.255.0 |
| DNS | 127.0.0.1 | 192.168.100.10 |
| Domen | corp.local | corp.local |
| Rol | Əsas Domain Controller | İkinci Domain Controller |

### 2.1.1.2. DC01 konfiqurasiyası

DC01 serverində statik IP ünvanı və DNS konfiqurasiya edilmişdir.

Server Manager → Add Roles and Features vasitəsilə aşağıdakı rollar quraşdırılmışdır:

- Active Directory Domain Services;
- DNS Server.

Daha sonra Promote this server to a domain controller → Add a new forest seçilmiş və corp.local domeni yaradılmışdır.

Forest Functional Level və Domain Functional Level üçün Windows Server 2016 seçilmişdir.

DNS Server və Global Catalog funksiyaları aktiv saxlanılmışdır.

### 2.1.1.3. DC02 konfiqurasiyası

DC02 serverinə 192.168.100.11/24 statik IP ünvanı verilmişdir.

DNS ünvanı kimi DC01-in 192.168.100.10 IP-si istifadə edilmişdir.

DC02-də AD DS və DNS rolları quraşdırılmışdır.

Add a domain controller to an existing domain seçimi ilə DC02 corp.local domeninə əlavə edilmişdir.

Autentifikasiya üçün CORP\Administrator hesabından istifadə edilmişdir.

DC02 writable Domain Controller kimi konfiqurasiya edilmiş, DNS və Global Catalog funksiyaları aktiv saxlanılmışdır.

### 2.1.1.4. Replikasiya testi

Domain Controller-lər arasında replikasiyanı yoxlamaq üçün aşağıdakı əmr istifadə edilmişdir:

~~~powershell
repadmin /showrepl
~~~

Əmrin nəticəsində DC01 və DC02 arasındakı replikasiya əlaqələri və son uğurlu replikasiya məlumatları yoxlanılmışdır.

## 2.1.2 — Tiered Access Model

### 2.1.2.1. Tier strukturunun yaradılması

DC01 üzərində Active Directory Users and Computers konsolundan istifadə edilərək corp.local domeni daxilində üç əsas OU yaradılmışdır:

- Tier0;
- Tier1;
- Tier2.

Administrator hesabları və təhlükəsizlik qrupları bu səviyyələrə uyğun təşkil edilmişdir.

### 2.1.2.2. OU strukturu

~~~text
corp.local
├── Tier0
│   ├── Admins
│   ├── Groups
│   └── Servers
├── Tier1
│   ├── Admins
│   ├── Groups
│   └── Servers
└── Tier2
    ├── Admins
    ├── Groups
    ├── Users
    └── Workstations
~~~

Bu struktur domen administratorlarının, server administratorlarının və istifadəçi sistemlərini idarə edən administratorların ayrı saxlanmasına xidmət edir.

### 2.1.2.3. Tier 0 — Kritik domen infrastrukturu

Tier 0 domen və kritik identifikasiya infrastrukturunun idarə olunması üçün yaradılmışdır.

Təhlükəsizlik qrupları:

- T0-Admins;
- T0-DomainAdmins;
- T0-PKI-Admins.

Bu qruplar domen və PKI idarəetmə səlahiyyətlərinin ayrılması üçün istifadə edilmişdir.

### 2.1.2.4. Tier 1 — Server və tətbiq idarəetməsi

Tier 1 serverlərin və tətbiqlərin inzibati idarə olunması üçün yaradılmışdır.

Təhlükəsizlik qrupları:

- T1-Admins;
- T1-WebAdmins;
- T1-DBAdmins;
- T1-ServerOps.

Bu bölgü server idarəetməsi, veb xidmətləri, verilənlər bazası və əməliyyat funksiyalarının ayrıca qruplarla idarə edilməsinə imkan verir.

### 2.1.2.5. Tier 2 — İstifadəçi sistemləri

Tier 2 istifadəçi kompüterləri və helpdesk fəaliyyətləri üçün yaradılmışdır.

Təhlükəsizlik qrupları:

- T2-Admins;
- T2-Helpdesk;
- T2-DesktopSupport.

### 2.1.2.6. Administrator hesablarının yerləşdirilməsi

Administrator hesabları uyğun Tier OU-larında yaradılmış və vəzifələrinə əsasən təhlükəsizlik qruplarına əlavə edilmişdir.

| Səviyyə | İdarəetmə istiqaməti | Əsas qrup |
|---|---|---|
| Tier 0 | Domen və PKI | T0-Admins |
| Tier 1 | Server və tətbiqlər | T1-Admins |
| Tier 2 | İstifadəçi sistemləri | T2-Admins |

Bu yanaşma yüksək səlahiyyətli hesabların gündəlik istifadəçi əməliyyatlarından ayrılması üçün tətbiq edilmişdir.

## 2.1.3 — Tier səviyyələri arasında GPO məhdudiyyətləri

### 2.1.3.1. GPO-ların yaradılması

Group Policy Management konsolunda Group Policy Objects → New vasitəsilə üç ayrı təhlükəsizlik siyasəti yaradılmışdır.

| GPO adı | Tətbiq olunduğu OU | Məhdudlaşdırılan hesablar |
|---|---|---|
| GPO-T0-Deny-CrossTier | Domain Controllers OU | T1-Admins, T2-Admins |
| GPO-T1-Deny-CrossTier | Tier1 → Servers | T0-Admins, T2-Admins |
| GPO-T2-Deny-CrossTier | Tier2 → Workstations | T0-Admins, T1-Admins |

### 2.1.3.2. GPO-T0-Deny-CrossTier

Bu GPO Domain Controllers OU-suna bağlanmışdır.

Məqsəd Tier 1 və Tier 2 administratorlarının Domain Controller sistemlərinə girişinin məhdudlaşdırılmasıdır.

Məhdudlaşdırılan qruplar:

- T1-Admins;
- T2-Admins.

### 2.1.3.3. GPO-T1-Deny-CrossTier

Bu GPO Tier1 → Servers OU-suna bağlanmışdır.

Məqsəd Tier 1 serverlərinə digər səviyyələrdən administrator girişlərini məhdudlaşdırmaqdır.

Məhdudlaşdırılan qruplar:

- T0-Admins;
- T2-Admins.

### 2.1.3.4. GPO-T2-Deny-CrossTier

Bu GPO Tier2 → Workstations OU-suna bağlanmışdır.

Məqsəd yüksək səlahiyyətli administrator hesablarının istifadəçi iş stansiyalarında istifadəsini məhdudlaşdırmaqdır.

Məhdudlaşdırılan qruplar:

- T0-Admins;
- T1-Admins.

### 2.1.3.5. User Rights Assignment konfiqurasiyası

Hər üç GPO daxilində aşağıdakı yol istifadə edilmişdir:

Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → User Rights Assignment

İki əsas təhlükəsizlik siyasəti konfiqurasiya edilmişdir:

1. Deny log on locally;
2. Deny log on through Remote Desktop Services.

Bu qaydalar uyğun olmayan Tier administratorlarının lokal və RDP girişlərini məhdudlaşdırmaq üçün istifadə edilmişdir.

### 2.1.3.6. GPO tətbiqinin yoxlanılması

Siyasətlərin tətbiqini yoxlamaq üçün aşağıdakı əmrlər icra edilmişdir:

~~~cmd
gpupdate /force
gpresult /r
~~~

GPO-ların müvafiq OU-lara bağlandığı və tətbiq vəziyyəti yoxlanılmışdır.

### 2.1.3.7. SRV01 üzərində praktiki test

SRV01 serveri corp.local domeninə qoşulmuş və Tier1 → Servers OU-suna yerləşdirilmişdir.

Tier 2 administrator hesabı ilə SRV01 serverinə giriş cəhdi həyata keçirilmişdir.

Windows aşağıdakı xəta mesajını göstərmişdir:

The sign-in method you're trying to use isn't allowed.

Bu nəticə Tier 2 administratorunun Tier 1 serverinə girişinin bloklandığını göstərmişdir.

Digər Tier səviyyələrindən administrator hesabları ilə aparılan uyğun olmayan giriş cəhdləri də uğursuz olmuşdur.

Beləliklə, Tier1 serveri üçün Cross-Tier məhdudiyyətlərinin işlədiyi praktiki testlə yoxlanılmışdır.

## 2.1.4 — Active Directory audit siyasəti

### 2.1.4.1. GPO-T0-Audit

Domen daxilində administrator və istifadəçi obyektləri üzərində aparılan dəyişiklikləri izləmək üçün GPO-T0-Audit yaradılmışdır.

Bu GPO Domain Controllers OU-suna bağlanmışdır.

Audit parametrləri Advanced Audit Policy Configuration vasitəsilə konfiqurasiya edilmişdir.

### 2.1.4.2. Audit parametrləri

| Bölmə | Audit parametri | Seçim |
|---|---|---|
| Logon/Logoff | Audit Logon | Success and Failure |
| Logon/Logoff | Audit Logoff | Success |
| Account Management | Audit User Account Management | Success and Failure |
| Account Management | Audit Security Group Management | Success and Failure |
| DS Access | Audit Directory Service Changes | Success and Failure |
| Policy Change | Audit Audit Policy Change | Success and Failure |

Bu konfiqurasiya giriş hadisələrinin, hesab və qrup dəyişikliklərinin, Directory Service əməliyyatlarının və audit siyasətində dəyişikliklərin qeydə alınması üçün tətbiq edilmişdir.

### 2.1.4.3. Event ID 4738 testi

Audit mexanizmini yoxlamaq üçün t0-yusif istifadəçi hesabının Description sahəsində dəyişiklik edilmişdir.

Windows Event Viewer üzərindən aşağıdakı hadisə yoxlanılmışdır:

Event ID 4738 — A user account was changed.

Bu hadisə istifadəçi hesabı məlumatlarının dəyişdirilməsinin audit edildiyini göstərmişdir.

### 2.1.4.4. Event ID 5136 testi

Tier0 OU üzərində müvafiq audit icazələri — SACL — konfiqurasiya edilmişdir.

Daha sonra istifadəçi obyektində dəyişiklik aparılmışdır.

Windows Event Viewer-də aşağıdakı hadisə yoxlanılmışdır:

Event ID 5136 — A directory service object was modified.

Bu nəticə Active Directory obyektləri üzərində dəyişikliklərin Directory Service audit mexanizmi ilə izlənildiyini göstərmişdir.

## 2.1.5 — Administrator hesabları üçün Fine-Grained Password Policy

### 2.1.5.1. FGPP məqsədi

Administrator hesabları üçün eyni parol siyasətindən istifadə etmək əvəzinə, Tier səviyyəsinə görə fərqli təhlükəsizlik tələbləri tətbiq edilmişdir.

Fine-Grained Password Policy vasitəsilə Tier 0, Tier 1 və Tier 2 administratorları üçün ayrıca parol siyasətləri yaradılmışdır.

### 2.1.5.2. Siyasətlərin yaradılması

DC01 serverində Active Directory Administrative Center açılmışdır.

İstifadə olunan yol:

corp.local → System → Password Settings Container → New → Password Settings

Üç ayrı FGPP siyasəti yaradılmışdır.

| Parametr | Tier 0 | Tier 1 | Tier 2 |
|---|---|---|---|
| Siyasət | FGPP-Tier0-Admins | FGPP-Tier1-Admins | FGPP-Tier2-Admins |
| Minimum parol uzunluğu | 16 simvol | 14 simvol | 12 simvol |
| Precedence | 10 | 20 | 30 |
| Tətbiq olunan qrup | T0-Admins | T1-Admins | T2-Admins |

### 2.1.5.3. Bütün Tier-lər üçün ortaq təhlükəsizlik parametrləri

| Parametr | Tətbiq edilən dəyər |
|---|---|
| Password Complexity | Enabled |
| Password History | Son 24 parol |
| Maximum Password Age | 90 gün |
| Account Lockout Threshold | 5 uğursuz cəhd |
| Account Lockout Duration | 30 dəqiqə |
| Reversible Encryption | Disabled |

Bu parametrlər administrator hesablarında zəif parolların istifadəsini, əvvəlki parolların təkrar seçilməsini və ardıcıl uğursuz giriş cəhdlərini məhdudlaşdırmaq üçün tətbiq edilmişdir.

### 2.1.5.4. FGPP siyasətlərinin yoxlanılması

Siyasətlərin istifadəçilərə düzgün tətbiq olunduğunu yoxlamaq üçün aşağıdakı PowerShell əmri istifadə edilmişdir:

~~~powershell
Get-ADUserResultantPasswordPolicy
~~~

Aşağıdakı administrator hesabları yoxlanılmışdır:

| Hesab | Tier | Tətbiq edilən FGPP |
|---|---|---|
| t0-yusif | Tier 0 | FGPP-Tier0-Admins |
| t1-elcin | Tier 1 | FGPP-Tier1-Admins |
| t2-aysel | Tier 2 | FGPP-Tier2-Admins |

Yoxlama nəticəsində hər üç administrator hesabına uyğun parol siyasətinin tətbiq edildiyi təsdiqlənmişdir.

### 2.1.5.5. Protected Users qrupu

Əlavə təhlükəsizlik tədbiri olaraq t0-yusif hesabı Active Directory-də Protected Users qrupuna əlavə edilmişdir.

Qrup üzvlüyü PowerShell vasitəsilə yoxlanılmışdır.

Bu addım Tier 0 administrator hesabının autentifikasiya təhlükəsizliyini gücləndirmək üçün həyata keçirilmişdir.

## 2.1.6 — BloodHound ilə Active Directory analizi

### 2.1.6.1. Məqsəd

Active Directory mühitində administrator hesabları arasındakı əlaqələri və potensial hücum yollarını araşdırmaq üçün BloodHound platformasından istifadə edilmişdir.

Analiz administrator hesablarının və qrupların domen daxilindəki səlahiyyət əlaqələrini qiymətləndirmək məqsədi daşıyır.

### 2.1.6.2. BloodHound quraşdırılması

BloodHound Kali Linux üzərində quraşdırılmışdır.

Veb interfeysə aşağıdakı ünvan vasitəsilə giriş həyata keçirilmişdir:

http://127.0.0.1:8080

### 2.1.6.3. SharpHound ilə məlumat toplanması

Domen məlumatlarının toplanması üçün SRV01 serverində SharpHound istifadə edilmişdir.

İcra olunan əmr:

~~~powershell
.\SharpHound.exe -c DCOnly --zipfilename corp-bloodhound.zip
~~~

Toplanan məlumatlar ZIP formatında saxlanılmışdır.

### 2.1.6.4. BloodHound-a məlumatların yüklənməsi

corp-bloodhound.zip faylı BloodHound platformasına yüklənmişdir.

Yoxlama nəticələri:

| Göstərici | Nəticə |
|---|---|
| Toplanmış obyektlər | 339 |
| Uğurla qəbul edilmiş fayllar | 9 |
| Analiz platforması | BloodHound |
| Məlumat toplama aləti | SharpHound |

### 2.1.6.5. Pathfinding analizi

BloodHound interfeysində Explore → Pathfinding bölməsindən istifadə edilmişdir.

Müxtəlif Tier administrator hesablarından aşağıdakı qrupa mümkün hücum yolları araşdırılmışdır:

DOMAIN ADMINS@CORP.LOCAL

Bu analiz Active Directory-də inzibati səlahiyyət əlaqələrinin və potensial hücum yollarının vizual qiymətləndirilməsini təmin etmişdir.

## 3. Təhlükəsizlik nəzarətlərinin yekun cədvəli

| Təhlükəsizlik istiqaməti | Tətbiq edilmiş həll | Praktiki yoxlama |
|---|---|---|
| Domen infrastrukturu | DC01 və DC02 | Replikasiya yoxlanıldı |
| DNS | AD DNS | Domen xidmətləri konfiqurasiya edildi |
| Tiered Access | Tier0, Tier1, Tier2 OU | Struktur yaradıldı |
| Tier 0 qrupları | T0-Admins, T0-DomainAdmins, T0-PKI-Admins | Qruplar yaradıldı |
| Tier 1 qrupları | T1-Admins, T1-WebAdmins, T1-DBAdmins, T1-ServerOps | Qruplar yaradıldı |
| Tier 2 qrupları | T2-Admins, T2-Helpdesk, T2-DesktopSupport | Qruplar yaradıldı |
| Cross-Tier GPO | GPO-T0-Deny-CrossTier | Domain Controllers OU |
| Cross-Tier GPO | GPO-T1-Deny-CrossTier | Tier1 Servers OU |
| Cross-Tier GPO | GPO-T2-Deny-CrossTier | Tier2 Workstations OU |
| Giriş məhdudiyyəti | Deny log on locally / RDP | SRV01 testi uğurlu |
| Audit | GPO-T0-Audit | Event ID 4738 və 5136 |
| Tier 0 parol siyasəti | FGPP-Tier0-Admins | 16 simvol |
| Tier 1 parol siyasəti | FGPP-Tier1-Admins | 14 simvol |
| Tier 2 parol siyasəti | FGPP-Tier2-Admins | 12 simvol |
| Parol siyasəti testi | Get-ADUserResultantPasswordPolicy | 3 hesab yoxlanıldı |
| Əlavə hesab qorunması | Protected Users | t0-yusif |
| AD hücum yolu analizi | BloodHound və SharpHound | 339 obyekt, 9 fayl |

## 4. Nəticə

Bölmə 2.1 çərçivəsində corp.local domeni DC01 və DC02 üzərində qurulmuş, DNS xidmətləri və Active Directory replikasiyası konfiqurasiya edilmişdir.

Administrator hesabları Tier 0, Tier 1 və Tier 2 səviyyələrinə ayrılmış, hər səviyyə üçün ayrıca OU və təhlükəsizlik qrupları yaradılmışdır.

Üç Cross-Tier GPO vasitəsilə lokal və RDP giriş məhdudiyyətləri tətbiq edilmişdir. SRV01 üzərində Tier 2 hesabının girişinin bloklanması praktiki testlə təsdiqlənmişdir.

GPO-T0-Audit vasitəsilə Active Directory dəyişikliklərinin auditi təşkil edilmiş, Event ID 4738 və 5136 hadisələri yoxlanılmışdır.

Administrator hesabları üçün üç ayrı FGPP siyasəti yaradılmış, 16, 14 və 12 simvolluq minimum parol uzunluqları tətbiq edilmişdir. Parol siyasətləri üç administrator hesabı üzərində yoxlanılmış və Tier 0 hesabı Protected Users qrupuna əlavə edilmişdir.

BloodHound və SharpHound vasitəsilə Active Directory mühiti analiz edilmiş, 339 obyekt və 9 fayl emal olunmuş, DOMAIN ADMINS@CORP.LOCAL qrupuna mümkün hücum yolları araşdırılmışdır.

Bu mərhələdə domen infrastrukturu, administrator səlahiyyətlərinin ayrılması, giriş məhdudiyyətləri, audit, parol siyasətləri və hücum yolu analizi birlikdə həyata keçirilmişdir.
