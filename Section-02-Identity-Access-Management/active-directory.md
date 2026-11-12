# 2.1 — ACTIVE DIRECTORY VƏ TIERED ACCESS MODEL

## 1. Məqsəd

Bu mərhələdə korporativ istifadəçilərin və kompüterlərin mərkəzləşdirilmiş idarə edilməsi üçün Active Directory infrastrukturu qurulmuş, administrator səlahiyyətləri təhlükəsizlik səviyyələrinə ayrılmış və Group Policy vasitəsilə giriş məhdudiyyətləri tətbiq edilmişdir.

Əsas məqsəd yüksək səlahiyyətli hesabların gündəlik istifadəçi və server mühitlərindən ayrılması, administrator hesablarının komprometasiyası zamanı lateral movement riskinin azaldılması və inzibati fəaliyyətlərin audit edilməsidir.

## 2. İnfrastruktur

| Server | IP ünvanı | Funksiya |
|---|---|---|
| DC01 | 192.168.100.10 | Əsas Domain Controller, Active Directory, DNS |
| DC02 | 192.168.100.11 | İkinci Domain Controller, replikasiya |
| SRV01 | 192.168.100.20 | Domain Member Server, Tier1 |
| PAM01 | 192.168.100.30 | İmtiyazlı girişlər üçün JumpServer |
| CA01 | 192.168.100.40 | AD CS və daxili sertifikat infrastrukturu |
| IAM01 | 192.168.100.50 | Keycloak və mərkəzi IAM |

Active Directory domeni: corp.local

## 3. Active Directory arxitekturası

DC01 və DC02 serverləri korporativ domenin identifikasiya xidmətlərini təmin etmək üçün hazırlanmışdır.

İki Domain Controller istifadəsinin əsas səbəbləri:
- Domen autentifikasiyasının tək serverdən asılılığının azaldılması;
- Active Directory məlumatlarının replikasiyası;
- Domen istifadəçilərinin və kompüterlərinin mərkəzləşdirilmiş idarə edilməsi;
- DNS və domen xidmətlərinin davamlılığının dəstəklənməsi.

SRV01 domenə qoşulmuş üzv server kimi istifadə edilmişdir.

## 4. Organizational Units və idarəetmə strukturu

Active Directory obyektlərinin idarə olunması üçün Organizational Unit (OU) strukturu hazırlanmışdır.

OU yanaşması istifadəçi və administrator hesablarının, kompüterlərin və serverlərin funksiyalarına görə ayrılmasına imkan verir.

Bu struktur Group Policy qaydalarının uyğun obyektlərə tətbiq edilməsi üçün istifadə edilmişdir.

## 5. Tiered Administration Model

Administrator səlahiyyətləri üç təhlükəsizlik səviyyəsinə ayrılmışdır.

### Tier 0 — Domen və identifikasiya infrastrukturu

Tier 0 ən yüksək səlahiyyətli inzibati mühiti əhatə edir.

Əlaqəli aktivlər:
- Domain Controller sistemləri;
- Active Directory;
- Domen səviyyəli administrator hesabları;
- Kritik identifikasiya xidmətləri.

Tier 0 hesabları domen infrastrukturunun idarə olunması üçün nəzərdə tutulmuşdur.

### Tier 1 — Server idarəetməsi

Tier 1 üzv serverlərin və server xidmətlərinin idarə olunmasını əhatə edir.

SRV01 bu səviyyə üzrə test serveri kimi istifadə edilmişdir.

### Tier 2 — İstifadəçi sistemləri

Tier 2 istifadəçi iş stansiyalarının və gündəlik endpoint idarəetməsinin təhlükəsizlik səviyyəsidir.

Bu səviyyədəki hesabların yüksək səlahiyyətli serverlərdə istifadə edilməsi məhdudlaşdırılmışdır.

## 6. Group Policy ilə giriş məhdudiyyətləri

Tiered Access Model-in tətbiqi üçün Group Policy qaydaları hazırlanmışdır.

GPO-lar vasitəsilə administrator hesablarının uyğun olmayan sistemlərə girişinin qarşısını alan məhdudiyyətlər tətbiq edilmişdir.

### Tier 2 hesabının SRV01-ə giriş testi

Tier 2 administrator hesabı ilə SRV01 serverinə giriş cəhdi həyata keçirilmişdir.

Giriş cəhdi rədd edilmiş və Windows aşağıdakı mesajı göstərmişdir:

The sign-in method you're trying to use isn't allowed.

Bu nəticə Tier 2 hesabı üçün nəzərdə tutulmuş giriş məhdudiyyətinin işlədiyini göstərmişdir.

## 7. Audit siyasəti

Domen mühitində administrator fəaliyyətinin izlənilməsi üçün GPO-T0-Audit adlı Group Policy hazırlanmışdır.

Audit siyasətinin məqsədi yüksək səlahiyyətli əməliyyatların təhlükəsizlik hadisələri kimi qeydə alınmasını təmin etməkdir.

Bu yanaşma administrator fəaliyyətinin izlənilməsi, şübhəli girişlərin araşdırılması və təhlükəsizlik hadisələrinin təhlili üçün əsas yaradır.

## 8. Təhlükəsizlik prinsipləri

### Least Privilege

İstifadəçilərə və administratorlara yalnız öz vəzifələrinə uyğun səlahiyyətlərin verilməsi əsas götürülmüşdür.

### Separation of Duties

Domen idarəetməsi, server idarəetməsi və istifadəçi sistemi idarəetməsi ayrı inzibati səviyyələrə bölünmüşdür.

### Lateral Movement Riskinin Azaldılması

Tier 2 hesabının Tier 1 serverinə girişinin bloklanması administrator hesablarının müxtəlif təhlükəsizlik səviyyələrində istifadəsinin məhdudlaşdırılmasına xidmət edir.

### Auditability

GPO-T0-Audit vasitəsilə yüksək səlahiyyətli fəaliyyətlərin izlənilməsi üçün audit infrastrukturu hazırlanmışdır.

## 9. Praktiki test nəticələri

| Test | Nəticə |
|---|---|
| Active Directory domen infrastrukturu | DC01 və DC02 üzərində təşkil edildi |
| Domenə üzv server | SRV01 |
| Tiered Access Model | Tier 0, Tier 1 və Tier 2 səviyyələri yaradıldı |
| Tier 2 → SRV01 giriş cəhdi | Bloklandı |
| Windows giriş xətası | The sign-in method you're trying to use isn't allowed |
| Administrator auditi | GPO-T0-Audit yaradıldı |

## 10. Digər təhlükəsizlik komponentləri ilə əlaqə

Active Directory infrastrukturu Bölmə 2-nin digər texnologiyaları ilə inteqrasiya olunmuşdur:

- JumpServer — administratorların PAM üzərindən idarəetməsi;
- Keycloak — Active Directory istifadəçilərinin LDAPS vasitəsilə sinxronlaşdırılması;
- Windows LAPS — lokal administrator parollarının idarə olunması;
- AD CS — daxili PKI və sertifikat xidmətləri.

## 11. Nəticə

DC01 və DC02 üzərində Active Directory infrastrukturu hazırlanmış, OU və GPO strukturları qurulmuş, administrator hesabları Tier 0, Tier 1 və Tier 2 səviyyələrinə ayrılmışdır.

Tier 2 hesabının SRV01 serverinə girişinin bloklanması praktik testlə təsdiqlənmişdir. GPO-T0-Audit siyasəti administrator fəaliyyətlərinin izlənilməsi üçün hazırlanmışdır.

Bu arxitektura korporativ identifikasiya sistemində imtiyazların ayrılması və inzibati girişlərin təhlükəsiz idarə olunması üçün əsas təşkil edir.
