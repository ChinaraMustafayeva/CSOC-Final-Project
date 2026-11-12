# 15.3 — Compliance Assessment və Gap Analysis

## Məqsəd

Layihənin informasiya təhlükəsizliyi arxitekturasını beynəlxalq təhlükəsizlik çərçivələri ilə müqayisə etmək, tətbiq edilmiş nəzarətləri qiymətləndirmək və inkişaf istiqamətlərini müəyyənləşdirmək.

## Qiymətləndirmə çərçivələri

Layihədə üç əsas təhlükəsizlik çərçivəsi nəzərdən keçirilmişdir:

1. ISO/IEC 27001:2022;
2. NIST Cybersecurity Framework 2.0;
3. CIS Controls v8.1.

## ISO/IEC 27001:2022

ISO/IEC 27001 informasiya təhlükəsizliyinin idarəetmə sistemi üçün tələbləri müəyyən edir.

Layihənin uyğunluq təhlilində aşağıdakı istiqamətlər nəzərdən keçirilmişdir:
- İnformasiya təhlükəsizliyi siyasətləri;
- Risklərin qiymətləndirilməsi;
- Giriş hüquqlarının idarə edilməsi;
- İmtiyazlı hesabların qorunması;
- Təhlükəsizlik hadisələrinin idarə edilməsi;
- Ehtiyat nüsxələmə və bərpa;
- Texniki təhlükəsizlik nəzarətləri.

Layihədə hazırlanmış altı siyasət və 20 risklik Risk Register idarəetmə və risk qiymətləndirməsi istiqamətlərini dəstəkləyir.

## NIST Cybersecurity Framework 2.0

NIST CSF 2.0 çərçivəsi altı əsas funksiyanı əhatə edir.

| Funksiya | Layihədə əlaqəli fəaliyyət |
|---|---|
| Govern | Təhlükəsizlik siyasətləri və risk reyestri |
| Identify | Aktiv inventarı və risklərin müəyyənləşdirilməsi |
| Protect | AD, IAM, PAM, MFA, şəbəkə və email təhlükəsizliyi |
| Detect | Təhlükəsizlik monitorinqi və aşkarlama nəzarətləri |
| Respond | Incident Response Policy və insident prosesləri |
| Recover | Bərpa və davamlılıq istiqamətləri üzrə qiymətləndirmə |

## CIS Controls v8.1

CIS Controls çərçivəsi praktik təhlükəsizlik tədbirlərinin qiymətləndirilməsi üçün istifadə edilmişdir.

Əlaqəli istiqamətlər:
- Enterprise Assets Inventory;
- Account Management;
- Access Control Management;
- Audit Log Management;
- Email and Web Browser Protections;
- Data Recovery;
- Incident Response Management.

Mailcow serveri üçün ayrıca CIS Ubuntu Server Level 1 auditi aparılmış və 110 uyğunsuzluq müəyyən edilmişdir. Bu audit əməliyyat sistemi konfiqurasiyasının qiymətləndirilməsinə aid olmuşdur.

## Gap Analysis

Uyğunluq təhlili zamanı aşağıdakı istiqamətlər üzrə boşluqlar və inkişaf ehtiyacları müəyyən edilmişdir:

| İstiqamət | Təhlil mövzusu |
|---|---|
| Backup və Recovery | Bərpa testləri və ehtiyat nüsxələrin saxlanması |
| Privileged Access | PAM sessiya müddəti və giriş nəzarətləri |
| Incident Response | Tabletop təlimləri və reaksiya prosesləri |
| Security Monitoring | SIEM log əhatəsinin genişləndirilməsi |
| Vulnerability Management | Zəifliklərin qiymətləndirilməsi və izlənməsi |

## Texniki nəzarətlərlə əlaqə

Uyğunluq təhlilində layihənin digər bölmələrində həyata keçirilmiş texniki işlər də nəzərə alınmışdır:

- Bölmə 1 — təhlükəsizlik arxitekturası, aktiv inventarı və risklərin müəyyənləşdirilməsi;
- Bölmə 2 — Active Directory, Tiered Access, PAM, SSO, MFA, LAPS və PKI;
- Bölmə 8 — Mailcow, Proxmox Mail Gateway, phishing aşkarlanması və simulyasiya.

Bu yanaşma texniki nəzarətlərin idarəetmə və uyğunluq çərçivələri ilə əlaqələndirilməsinə imkan verir.

## Nəticə

ISO/IEC 27001:2022, NIST CSF 2.0 və CIS Controls v8.1 əsasında uyğunluq təhlili aparılmışdır. Mövcud texniki və təşkilati təhlükəsizlik tədbirləri qiymətləndirilmiş, risklərin idarə olunması və təhlükəsizlik nəzarətlərinin inkişafı üçün əsas istiqamətlər müəyyən edilmişdir.
