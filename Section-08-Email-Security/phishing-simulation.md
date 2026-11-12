# 8.4 — PHISHING SİMULYASİYASI VƏ İSTİFADƏÇİ MAARİFLƏNDİRMƏSİ

## 1. Məqsəd

Bu mərhələdə korporativ laboratoriya istifadəçilərinin şübhəli email-lərə reaksiyasını ölçmək üçün GoPhish platforması ilə nəzarətli phishing simulyasiyası həyata keçirilmişdir.

Simulyasiyanın məqsədi real hesab parollarını toplamaq deyil, istifadəçilərin şübhəli məktubu açmaq, keçidə klik etmək və test formasını göndərmək kimi davranışlarını qiymətləndirmək olmuşdur.

Testlər yalnız layihənin laboratoriya hesabları üzərində aparılmışdır.

Əsas işlər:

- GoPhish v0.12.1 platformasının quraşdırılması;
- GoPhish idarəetmə panelinin təhlükəsiz açılması;
- İki laboratoriya istifadəçisindən ibarət hədəf qrupunun yaradılması;
- Phishing email şablonunun hazırlanması;
- Təlim məqsədli landing page yaradılması;
- Mailcow SMTP profilinin inteqrasiyası;
- Phishing kampaniyasının başladılması;
- Klik və forma göndərmə hadisələrinin izlənməsi;
- Maarifləndirmə nəticələrinin qiymətləndirilməsi;
- CSV hesabatlarının ixracı.

## 8.4.1 — GoPhish serverinin qurulması

### Server infrastrukturu

GoPhish platforması SANDBOX01 üzərində quraşdırılmışdır.

| Parametr | Dəyər |
|---|---|
| Server | SANDBOX01 |
| Əməliyyat sistemi | Ubuntu Server 24.04 |
| IP ünvanı | 10.0.0.104 |
| Platforma | GoPhish v0.12.1 |
| Quraşdırma qovluğu | /opt/gophish |
| Admin interfeysi | 127.0.0.1:3333 |
| Phishing web server | TCP 80 |
| Systemd xidməti | gophish.service |

### Xidmətin başladılması

GoPhish quraşdırıldıqdan sonra idarəetmə interfeysinin və phishing web serverinin işlədiyi yoxlanılmışdır.

Daha sonra GoPhish üçün ayrıca systemd xidməti yaradılmışdır.

Xidmətin vəziyyəti aşağıdakı əmr vasitəsilə yoxlanıla bilər:

~~~bash id="gp841"
sudo systemctl status gophish.service
~~~

Hesabatda xidmət üçün aşağıdakı nəticələr təsdiqlənmişdir:

~~~text id="gp842"
enabled
active (running)
~~~

Bu nəticə GoPhish-in sistem xidməti kimi işlədiyini göstərmişdir.

## 8.4.2 — Admin panelinə giriş və bağlantı xətasının həlli

### İlkin problem

İdarəetmə panelinə ilk bağlantı cəhdində brauzer aşağıdakı xətanı göstərmişdir:

~~~text id="gp843"
ERR_CONNECTION_REFUSED
~~~

Problemin səbəbini araşdırmaq üçün port və şəbəkə bağlantısı yoxlamaları aparılmışdır.

İstifadə olunan vasitələr:

- ss -lntp;
- Test-NetConnection;
- SSH tuneli.

Yoxlama zamanı 3333 portuna birbaşa bağlantının alınmadığı müəyyən edilmişdir.

### SSH tuneli ilə həll

GoPhish prosesi yenidən başladılmış və Windows kompüterindən SANDBOX01 serverinə SSH tuneli yaradılmışdır.

~~~bash id="gp844"
ssh -N -L 3333:127.0.0.1:3333 sandbox01@10.0.0.104
~~~

Bu komanda lokal kompüterdəki 3333 portunu SANDBOX01 üzərindəki 127.0.0.1:3333 ünvanına yönləndirmişdir.

Daha sonra idarəetmə panelinə aşağıdakı ünvandan giriş edilmişdir:

~~~text id="gp845"
https://127.0.0.1:3333
~~~

### Administrator hesabının qorunması

İdarəetmə panelinə girişdən sonra ilkin administrator parolu dəyişdirilmişdir.

GoPhish-in self-signed sertifikatından istifadə etməsi səbəbindən brauzerdə sertifikat xəbərdarlığı müşahidə edilmişdir.

**Nəticə:** SSH tuneli vasitəsilə GoPhish idarəetmə panelinə giriş təmin edilmişdir.

## 8.4.3 — Hədəf qrupu və phishing email şablonu

### Hədəf qrupunun yaradılması

GoPhish platformasında aşağıdakı hədəf qrupu yaradılmışdır:

~~~text id="gp846"
SOC_phishing
~~~

Qrupa iki laboratoriya istifadəçisi əlavə edilmişdir.

| İstifadəçi | Email |
|---|---|
| Aysel | aysel@konrderk.test |
| Yusif | yusif@konrderk.test |

Bu istifadəçilər layihənin Mailcow email infrastrukturu üzərində yaradılmış test hesablarıdır.

### Email şablonu

GoPhish-də aşağıdakı email şablonu hazırlanmışdır:

~~~text id="gp847"
SOC_Awareness_Phishing_Test
~~~

Məktubun mövzusu hesab təhlükəsizliyinin yoxlanılması olmuşdur.

Email şablonunda GoPhish dəyişənlərindən istifadə edilmişdir.

Bu dəyişənlər vasitəsilə:

- İstifadəçinin adı fərdiləşdirilmişdir;
- Hər istifadəçi üçün fərdi izləmə keçidi yaradılmışdır.

### Tracking Image

Email şablonunda Tracking Image funksiyası aktivləşdirilmişdir.

Bu funksiya məktubun açılması hadisəsinin kampaniya statistikasında izlənilməsi üçün istifadə edilmişdir.

## 8.4.4 — Landing Page və SMTP profilinin qurulması

### Landing Page

GoPhish-də aşağıdakı laboratoriya səhifəsi yaradılmışdır:

~~~text id="gp848"
SOC_Phishing_Test_Login
~~~

Səhifədə hesab təhlükəsizliyinin yoxlanılması mövzusu, simulyasiya haqqında məlumat və saxta test kodunun daxil edilməsi üçün forma yerləşdirilmişdir.

### Məlumat toplama parametrləri

| Parametr | Vəziyyət |
|---|---|
| Capture Submitted Data | Enabled |
| Capture Passwords | Disabled |

Capture Submitted Data funksiyası forma göndərilməsi hadisəsinin izlənilməsi üçün aktivləşdirilmişdir.

Capture Passwords deaktiv saxlanılmışdır.

Beləliklə, simulyasiya real istifadəçi parollarını toplamadan forma göndərmə davranışını ölçmək üçün qurulmuşdur.

### SMTP profilinin yaradılması

Email göndərilməsi üçün aşağıdakı profil yaradılmışdır:

~~~text id="gp849"
SOC_Mailcow_SMTP
~~~

SMTP parametrləri:

| Parametr | Dəyər |
|---|---|
| SMTP server | MAIL01 |
| IP ünvanı | 10.0.0.102 |
| Port | TCP 587 |
| Xidmət | Mailcow SMTP Submission |

### SMTP bağlantı testi

SMTP xidmətinin əlçatanlığı nc vasitəsilə yoxlanılmışdır.

GoPhish-də Send Test Email funksiyası ilə test məktubu göndərilmişdir.

Loglarda aşağıdakı nəticələr müşahidə edilmişdir:

~~~text id="gp84a"
Email sent
HTTP 200
~~~

Test məktubunun Yusifin SOGo Inbox qovluğuna çatması da təsdiqlənmişdir.

**Nəticə:** GoPhish və Mailcow SMTP inteqrasiyası işlək vəziyyətdə olmuşdur.

## 8.4.5 — Phishing kampaniyasının başladılması

### Kampaniyanın yaradılması

GoPhish platformasında aşağıdakı kampaniya yaradılmışdır:

~~~text id="gp84b"
SOC_Phishing_Awareness_2026
~~~

Kampaniyada əvvəl hazırlanmış komponentlər seçilmişdir.

| Komponent | Dəyər |
|---|---|
| Campaign Name | SOC_Phishing_Awareness_2026 |
| Email Template | SOC_Awareness_Phishing_Test |
| Landing Page | SOC_Phishing_Test_Login |
| Sending Profile | SOC_Mailcow_SMTP |
| Users & Groups | SOC_phishing |
| Phishing URL | http://10.0.0.104 |

### Kampaniyanın başladılması

GoPhish interfeysində Launch Campaign əməliyyatı icra edilmişdir.

Sistem aşağıdakı bildirişi göstərmişdir:

~~~text id="gp84c"
Campaign Scheduled!
~~~

İlkin statistikada aşağıdakı nəticə qeydə alınmışdır:

~~~text id="gp84d"
Email Sent = 2
~~~

Hər iki laboratoriya istifadəçisinin kampaniya məktubunu Inbox qovluğunda aldığı yoxlanılmışdır.

**Nəticə:** Phishing simulyasiyası iki istifadəçi üçün uğurla başladılmışdır.

## 8.4.6 — İstifadəçi davranışlarının izlənməsi

### Test ssenarisi

Kampaniya zamanı iki istifadəçinin fərqli davranışları müşahidə edilmişdir.

### Yusifin davranışı

Yusif:

1. Phishing simulyasiya məktubunu açmışdır.
2. Məktubdakı fərdi keçidə klik etmişdir.
3. Laboratoriya landing page səhifəsinə keçmişdir.
4. Saxta test kodunu formaya daxil etmişdir.
5. Formanı göndərmişdir.

Bu davranış GoPhish statistikasında klik və forma göndərmə hadisəsi kimi qeydə alınmışdır.

### Ayselin davranışı

Aysel:

1. Phishing simulyasiya məktubunu açmışdır.
2. Məktubdakı keçidə klik etməmişdir.
3. Landing page üzərindən məlumat göndərməmişdir.

### Kampaniya statistikası

| Göstərici | Nəticə |
|---|---|
| Göndərilən email | 2 |
| Linkə klik edən | 1 |
| Forma göndərən | 1 |
| Klik faizi | 50% |
| Forma göndərmə faizi | 50% |

### Faizlərin hesablanması

Klik faizi:

~~~text id="gp84e"
1 / 2 × 100 = 50%
~~~

Forma göndərmə faizi:

~~~text id="gp84f"
1 / 2 × 100 = 50%
~~~

**Nəticə:** İki laboratoriya istifadəçisindən biri phishing keçidinə klik etmiş və test formasını göndərmişdir.

## 8.4.7 — Maarifləndirmə qiymətləndirilməsi və hesabat

### Davranışların müqayisəsi

Kampaniya nəticələri iki istifadəçi arasında fərqli təhlükəsizlik davranışlarını göstərmişdir.

| Davranış | Aysel | Yusif |
|---|---|---|
| Email alındı | Bəli | Bəli |
| Email açıldı | Bəli | Bəli |
| Linkə klik edildi | Xeyr | Bəli |
| Test forması göndərildi | Xeyr | Bəli |

Bu nəticə phishing məktublarının tanınması və şübhəli keçidlərin qiymətləndirilməsi üzrə maarifləndirmə ehtiyacını göstərmişdir.

### Müəyyən edilmiş maarifləndirmə mövzuları

Simulyasiya nəticələrinə əsasən aşağıdakı istiqamətlərdə istifadəçi maarifləndirilməsinin vacibliyi qeyd edilmişdir:

- Email göndərən ünvanının diqqətlə yoxlanılması;
- Şübhəli keçidlərin açılmadan əvvəl qiymətləndirilməsi;
- Naməlum səhifələrə hesab və autentifikasiya məlumatlarının daxil edilməməsi;
- Şübhəli email-lərin təhlükəsizlik komandasına bildirilməsi.

### Kampaniyanın tamamlanması

Testlər bitdikdən sonra kampaniya Completed vəziyyətinə keçirilmişdir.

~~~text id="gp84g"
Campaign Status: Completed
~~~

### CSV hesabatları

Nəticələrin sənədləşdirilməsi üçün GoPhish-dən iki CSV faylı ixrac edilmişdir.

| Fayl | Məzmun |
|---|---|
| Results CSV | Kampaniya nəticələrinin xülasəsi |
| Raw Events CSV | Ayrı-ayrı hadisələrin qeydləri |

Bu fayllar kampaniya statistikası və istifadəçi davranışlarının sonradan araşdırılması üçün sübut materialı kimi istifadə edilmişdir.

## 9. Təhlükəsizlik və etik yanaşma

Simulyasiya yalnız laboratoriya hesablarında həyata keçirilmişdir.

Real hesab parollarının toplanması məqsəd kimi seçilməmiş və Capture Passwords funksiyası deaktiv saxlanılmışdır.

Forma daxilində saxta test kodundan istifadə edilmişdir.

Bu yanaşma istifadəçi davranışını qiymətləndirməyə və real autentifikasiya məlumatlarını toplamadan phishing maarifləndirməsi üzrə nəticə əldə etməyə imkan vermişdir.

## 10. Praktiki yoxlama nəticələri

| № | Yoxlama | Nəticə |
|---|---|---|
| 1 | GoPhish quraşdırılması | v0.12.1 |
| 2 | Server | SANDBOX01 |
| 3 | Quraşdırma qovluğu | /opt/gophish |
| 4 | Systemd xidməti | gophish.service |
| 5 | Xidmət statusu | enabled, active (running) |
| 6 | Admin paneli | SSH tuneli ilə açıldı |
| 7 | Administrator parolu | Dəyişdirildi |
| 8 | Hədəf qrupu | SOC_phishing |
| 9 | Hədəf istifadəçilər | 2 |
| 10 | Email şablonu | SOC_Awareness_Phishing_Test |
| 11 | Tracking Image | Aktiv |
| 12 | Landing Page | SOC_Phishing_Test_Login |
| 13 | Capture Submitted Data | Aktiv |
| 14 | Capture Passwords | Deaktiv |
| 15 | SMTP profili | SOC_Mailcow_SMTP |
| 16 | SMTP server | 10.0.0.102:587 |
| 17 | Test email | SOGo Inbox-a çatdı |
| 18 | Kampaniya | SOC_Phishing_Awareness_2026 |
| 19 | Göndərilən məktub | 2 |
| 20 | Klik edən | 1 |
| 21 | Forma göndərən | 1 |
| 22 | Klik faizi | 50% |
| 23 | Forma göndərmə faizi | 50% |
| 24 | Kampaniya statusu | Completed |
| 25 | Results CSV | İxrac edildi |
| 26 | Raw Events CSV | İxrac edildi |

## 11. Əlaqəli sənədlər

- [Bölmə 8 — Ümumi README](README.md)
- [8.1 — Mail Server İnfrastrukturu](mail-server.md)
- [8.2 — Email Security Gateway](email-security-gateway.md)
- [8.3 — Anti-Phishing və Sandboxing](anti-phishing-sandboxing.md)
- [8.5 — Real Domen və SMTP Relay](smtp-relay.md)

## 12. Nəticə

Bölmə 8.4 çərçivəsində SANDBOX01 üzərində GoPhish v0.12.1 platforması quraşdırılmış, systemd xidməti kimi aktivləşdirilmiş və SSH tuneli vasitəsilə idarəetmə panelinə giriş təmin edilmişdir.

SOC_phishing adlı hədəf qrupu, SOC_Awareness_Phishing_Test email şablonu, SOC_Phishing_Test_Login landing page səhifəsi və SOC_Mailcow_SMTP göndərmə profili yaradılmışdır.

Mailcow SMTP Submission xidməti ilə inteqrasiya yoxlanılmış və test email-in SOGo Inbox qovluğuna çatdığı təsdiqlənmişdir.

SOC_Phishing_Awareness_2026 adlı kampaniya iki laboratoriya istifadəçisi üzərində həyata keçirilmişdir.

Kampaniya nəticəsində iki email göndərilmiş, bir istifadəçi phishing keçidinə klik etmiş və bir istifadəçi test formasını göndərmişdir. Klik və forma göndərmə göstəricilərinin hər ikisi 50% olmuşdur.

Simulyasiya nəticələri əsasında phishing keçidlərinin yoxlanılması, göndərən ünvanının qiymətləndirilməsi və şübhəli email-lərin bildirilməsi mövzularında maarifləndirmə ehtiyacı müəyyən edilmişdir.

Kampaniya Completed vəziyyətinə keçirilmiş, Results CSV və Raw Events CSV hesabatları ixrac edilmişdir.

Beləliklə, phishing simulyasiyası laboratoriya mühitində həyata keçirilmiş, istifadəçi davranışları ölçülmüş və nəticələr sənədləşdirilmişdir.
