# 2.1 — Active Directory və Tiered Access Model

## Məqsəd
Active Directory infrastrukturunda administrator səlahiyyətlərinin ayrılması, giriş hüquqlarının Group Policy vasitəsilə idarə edilməsi və təhlükəsizlik hadisələrinin auditinin təşkili.

## İnfrastruktur

| Server | IP ünvanı | Təyinat |
|---|---|---|
| DC01 | 192.168.100.10 | Active Directory və DNS |
| DC02 | 192.168.100.11 | Əlavə Domain Controller və replikasiya |
| SRV01 | 192.168.100.20 | Windows Member Server |

## Active Directory konfiqurasiyası

DC01 və DC02 serverləri üzərində domen infrastrukturu quruldu. İstifadəçi və administrator hesablarının idarə edilməsi üçün Active Directory istifadə edildi.

Administrator girişlərinin ayrılması məqsədilə Tiered Access Model tətbiq edildi:

- Tier0 — Domain Controller və kritik identifikasiya sistemləri.
- Tier1 — Serverlərin idarə edilməsi.
- Tier2 — İstifadəçi iş stansiyaları.

## OU və Group Policy

Active Directory üzərində təşkilati vahidlər və giriş siyasətləri konfiqurasiya edildi.

SRV01 serveri Tier1 OU-suna yerləşdirildi. Group Policy vasitəsilə uyğun olmayan Tier hesablarının bu serverə girişinin qarşısı alındı.

## Girişin yoxlanılması

SRV01 serverinə Tier2 hesabı ilə giriş cəhdi aparıldı.

Windows aşağıdakı xəta mesajını göstərdi:

The sign-in method you're trying to use isn't allowed.

Bu nəticə tətbiq edilmiş giriş məhdudiyyətinin işlədiyini göstərdi.

## Audit siyasəti

Domain Controller-lərdə GPO-T0-Audit adlı siyasət konfiqurasiya edildi.

Audit siyasəti aşağıdakı hadisələrin qeydiyyatını əhatə etdi:

- Uğurlu və uğursuz giriş hadisələri;
- İstifadəçi hesablarının idarə edilməsi;
- Təhlükəsizlik qruplarında dəyişikliklər;
- Active Directory obyektlərində dəyişikliklər;
- Audit siyasətində dəyişikliklər.

## Nəticə

Active Directory üzərində Tier əsaslı idarəetmə modeli, OU strukturu və Group Policy giriş məhdudiyyətləri tətbiq edildi. SRV01 serverinə Tier2 hesabı ilə girişin bloklanması praktik sınaqla təsdiqləndi. Domain Controller-lər üçün audit siyasəti konfiqurasiya edildi.
