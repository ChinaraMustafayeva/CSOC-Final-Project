# 2.4 — Windows LAPS və Public Key Infrastructure (PKI)

## Məqsəd

Lokal administrator parollarının təhlükəsiz idarə edilməsi, avtomatik rotasiyası və daxili veb xidmətlərin etibarlı HTTPS sertifikatları ilə qorunması.

## İstifadə olunan texnologiyalar

- Windows LAPS
- Microsoft Active Directory
- Group Policy
- Active Directory Certificate Services
- Microsoft IIS
- HTTPS / TLS

## İnfrastruktur

| Server | IP ünvanı | Funksiya |
|---|---|---|
| DC01 | 192.168.100.10 | Active Directory və Group Policy |
| CA01 | 192.168.100.40 | Daxili sertifikat mərkəzi |
| SRV01 | 192.168.100.20 | LAPS və HTTPS test serveri |

## Windows LAPS tətbiqi

1. Tier1 serverləri üçün Windows LAPS siyasəti hazırlandı.
2. SRV01 üzərində lokal administrator hesabı LAPS idarəetməsinə daxil edildi.
3. Lokal administrator parolunun Active Directory-də saxlanılması yoxlanıldı.
4. Parol uzunluğu 16 simvol olaraq konfiqurasiya edildi.
5. Parolun rotasiya müddəti 30 gün təyin edildi.
6. Parolun yenilənmə və bitmə tarixləri yoxlanıldı.
7. Group Policy tətbiqi gpresult /r /scope computer əmri ilə təsdiqləndi.

## LAPS parametrləri

| Parametr | Dəyər |
|---|---|
| Parol uzunluğu | 16 simvol |
| Rotasiya müddəti | 30 gün |
| Parolun saxlanılması | Active Directory |
| Test serveri | SRV01 |

## Daxili sertifikat infrastrukturu

CA01 serverində Active Directory Certificate Services quraşdırıldı və CORP-ROOT-CA adlı daxili sertifikat mərkəzi yaradıldı.

HTTPS xidmətləri üçün CORP-WebServer adlı sertifikat şablonu hazırlandı.

Group Policy vasitəsilə Certificate Auto-Enrollment konfiqurasiya edildi.

## IIS və HTTPS testi

SRV01 üzərində IIS xidməti quraşdırıldı. Daxili CA tərəfindən imzalanmış sertifikat IIS veb xidmətinə bağlandı.

HTTPS bağlantısı brauzerdə yoxlanıldı və sertifikat xəbərdarlığı olmadan açıldı.

## Qarşılaşılan problemlər və həllər

### Sertifikat şablonunda icazə xətası

Sertifikat şablonunun idarə edilməsi zamanı Access is denied xətası yarandı.

Problem CORP Administrator hesabı ilə əməliyyat aparılaraq həll edildi.

### Sertifikatın avtomatik alınmaması

SRV01 ilkin mərhələdə sertifikat əldə etmədi.

CORP-WebServer şablonunun CA üzərində yayımlanması düzəldildi və sertifikat sorğusu yenidən yoxlanıldı.

## Nəticə

Windows LAPS ilə lokal administrator parollarının 30 günlük rotasiyası tətbiq edildi. CORP-ROOT-CA sertifikat mərkəzi və CORP-WebServer şablonu hazırlandı. SRV01 üzərində IIS xidmətinin daxili CA sertifikatı ilə HTTPS bağlantısı uğurla yoxlanıldı.
