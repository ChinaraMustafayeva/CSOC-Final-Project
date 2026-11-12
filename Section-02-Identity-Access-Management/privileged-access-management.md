# 2.2 — Privileged Access Management (PAM)

## Məqsəd

Kritik serverlərə administrator girişlərinin mərkəzləşdirilməsi, imtiyazlı sessiyaların izlənməsi və icazəsiz birbaşa girişlərin məhdudlaşdırılması.

## İstifadə olunan texnologiyalar

- JumpServer PAM
- Microsoft Active Directory
- Remote Desktop Protocol (RDP)
- Windows Firewall
- Group Policy

## İnfrastruktur

| Server | IP ünvanı | Funksiya |
|---|---|---|
| PAM01 | 192.168.100.30 | JumpServer PAM platforması |
| DC01 | 192.168.100.10 | Qorunan Domain Controller |

## Görülən işlər

1. PAM01 serveri hazırlandı və JumpServer platforması quraşdırıldı.
2. JumpServer idarəetmə interfeysi konfiqurasiya edildi.
3. DC01 serveri PAM vasitəsilə idarə edilən resurs kimi əlavə edildi.
4. DC01 üçün RDP giriş siyasəti yaradıldı.
5. Windows Firewall vasitəsilə DC01-ə RDP bağlantısı PAM01 IP ünvanı ilə məhdudlaşdırıldı.
6. JumpServer üzərindən DC01 serverinə RDP bağlantısı həyata keçirildi.
7. İmtiyazlı sessiyaların video qeydiyyatı yoxlanıldı.
8. Sessiya daxilində əmrlərin audit qeydləri yoxlanıldı.

## Sessiya təhlükəsizliyi

| Parametr | Tətbiq edilmiş dəyər |
|---|---|
| Boşdayanma limiti | 15 dəqiqə |
| Aktiv sessiyanın maksimum müddəti | 1 saat |
| İdarəetmə platforması | JumpServer |
| Bağlantı protokolu | RDP |

Sessiya müddətləri Group Policy vasitəsilə idarə edildi.

## Test nəticələri

JumpServer üzərindən DC01-ə RDP bağlantısı uğurla həyata keçirildi. Birbaşa girişin IP əsaslı məhdudlaşdırılması yoxlanıldı. Sessiya video qeydi və əmr auditinin işləməsi təsdiqləndi.

## Nəticə

JumpServer PAM vasitəsilə kritik serverə administrator girişləri mərkəzləşdirildi. RDP bağlantısına nəzarət, sessiya qeydiyyatı və vaxt məhdudiyyətləri tətbiq edildi.
