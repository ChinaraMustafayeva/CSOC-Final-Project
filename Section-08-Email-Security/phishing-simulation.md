# 8.4 — Phishing Simulyasiyası

## Məqsəd
Nəzarətli phishing kampaniyası vasitəsilə laboratoriya istifadəçilərinin şübhəli məktublara reaksiyasını qiymətləndirmək və nəticələri qeydə almaq.

## İnfrastruktur
| Parametr | Dəyər |
|---|---|
| Server | SANDBOX01 |
| IP ünvanı | 10.0.0.104 |
| Platforma | GoPhish v0.12.1 |
| Quraşdırma qovluğu | /opt/gophish |
| Admin interfeysi | 127.0.0.1:3333 |
| Simulyasiya veb xidməti | TCP/80 |

## Quraşdırma
GoPhish v0.12.1 SANDBOX01 üzərində quraşdırıldı.

gophish.service adlı systemd xidməti yaradıldı. Xidmətin enabled və active (running) vəziyyətləri yoxlanıldı.

## Qarşılaşılan problem
İdarəetmə interfeysinə ilkin bağlantı zamanı ERR_CONNECTION_REFUSED xətası yarandı.

Bağlantı ss -lntp və Test-NetConnection vasitəsilə yoxlanıldı. 3333 portuna giriş problemi araşdırıldı.

## Kampaniya konfiqurasiyası
SOC_Phishing_Awareness_2026 adlı kampaniya yaradıldı.

Konfiqurasiya edilən komponentlər:
- Email şablonu;
- Landing page;
- SMTP profili;
- SOC_phishing istifadəçi qrupu;
- Laboratoriya phishing keçidi.

Simulyasiya veb ünvanı:

http://10.0.0.104

## Kampaniyanın icrası
GoPhish üzərində Launch Campaign əməliyyatı həyata keçirildi.

Sistemdə Campaign Scheduled! bildirişi göründü.

İlkin statistikada Email Sent = 2 qeydə alındı.

## Nəticələr
| Göstərici | Nəticə |
|---|---|
| Laboratoriya istifadəçiləri | 2 |
| Göndərilmiş məktublar | 2 |
| Şübhəli keçidlə qarşılıqlı əlaqə | 1 istifadəçi |
| Kampaniya statusu | Completed |
| İxrac edilmiş məlumatlar | Results CSV və Raw Events CSV |

## Qiymətləndirmə
Kampaniya nəticəsində iki laboratoriya istifadəçisindən birinin şübhəli keçidlə qarşılıqlı əlaqəyə girdiyi müəyyən edildi.

Bu nəticə email göndəricisinin yoxlanması, keçidlərin diqqətlə qiymətləndirilməsi və şübhəli məktubların bildirilməsi üzrə maarifləndirmənin əhəmiyyətini göstərdi.

## Nəticə
GoPhish ilə nəzarətli phishing kampaniyası həyata keçirildi. İstifadəçi reaksiyaları qeydə alındı, kampaniya tamamlandı və nəticələr CSV formatında ixrac edildi.
