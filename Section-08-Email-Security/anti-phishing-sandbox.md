# 8.3 — ANTI-PHISHING VƏ SANDBOXING

## 1. Məqsəd

Bu mərhələdə CSOC email təhlükəsizlik infrastrukturuna əlavə analiz və anti-phishing mexanizmləri inteqrasiya edilmişdir.

Əsas məqsəd şübhəli email məzmununu, URL-ləri və əlavələri əsas mail serverdən ayrılmış mühitdə qiymətləndirmək, phishing əlamətlərini müəyyən etmək və aşkarlanan təhlükəli məktubların Email Security Gateway tərəfindən karantinə yerləşdirilməsini təmin etməkdir.

Həyata keçirilmiş işlər:

- SANDBOX01 serverinin hazırlanması;
- Docker əsaslı izolyasiya olunmuş analiz mühitinin yaradılması;
- Şəbəkə izolyasiyasının yoxlanılması;
- Şübhəli URL və email əlavələri üçün statik analiz;
- ESG01 və SANDBOX01 arasında SSH əsaslı analiz prototipi;
- SpamAssassin üçün xüsusi SOC_PHISHING_URL qaydası;
- Xüsusi phishing testinin yoxlanılması;
- Proxmox Mail Gateway karantin mexanizminin təsdiqlənməsi.

## 8.3.1 — SANDBOX01 serverinin hazırlanması

### Server infrastrukturu

SANDBOX01 adlı Ubuntu Server 24.04 virtual maşını yaradılmışdır.

| Parametr | Dəyər |
|---|---|
| Server adı | SANDBOX01 |
| IP ünvanı | 10.0.0.104 |
| Əməliyyat sistemi | Ubuntu Server 24.04 |
| Konteyner platforması | Docker |
| Əsas təyinat | Email və URL analizi |
| Əlaqəli təhlükəsizlik sistemi | ESG01 — Proxmox Mail Gateway |

SANDBOX01 şübhəli email obyektlərinin ayrıca analiz edilməsi üçün hazırlanmışdır.

### Arxitekturada yerləşməsi

SANDBOX01 birbaşa istifadəçi poçt qutusu xidməti göstərmir.

Bu serverin rolu email təhlükəsizlik yoxlamaları üçün ayrıca analiz mühiti təmin etməkdir.

~~~text
Email göndərən
      |
      v
ESG01 — Proxmox Mail Gateway
      |
      +--> Spam və antivirus analizi
      |
      +--> Şübhəli email / URL
      |           |
      |           v
      |      SANDBOX01
      |      İzolyasiya olunmuş analiz
      |
      v
Mail filter və karantin qərarı
      |
      v
MAIL01 — Mailcow
~~~

Bu sxem analiz komponentlərinin layihədəki məntiqi əlaqəsini göstərir. ESG ilə Sandbox arasında SSH əsaslı prototip hazırlanmışdır; sxem bütün məktubların avtomatik Sandbox-a ötürüldüyünü ifadə etmir.

## 8.3.2 — Docker sandbox mühitinin yaradılması

### İzolyasiya məqsədi

Şübhəli URL və faylların analizində əsas təhlükəsizlik tələblərindən biri həmin obyektlərin korporativ serverlərə təsir etməsinin qarşısını almaqdır.

Buna görə SANDBOX01 üzərində Docker əsaslı ayrıca analiz mühiti hazırlanmışdır.

### Docker şəbəkəsi

Sandbox konteynerləri üçün daxili Docker şəbəkəsi yaradılmışdır.

Şəbəkə adı:

~~~text
soc-sandbox-net
~~~

Bu şəbəkənin daxili rejimdə işləməsi konfiqurasiya edilmişdir.

### Şəbəkə izolyasiyasının yoxlanılması

Docker şəbəkəsinin parametrləri yoxlanılmış və aşağıdakı nəticə əldə edilmişdir:

~~~text
Internal=true
~~~

Daha sonra sandbox mühitindən xarici IP ünvanına bağlantı cəhdi aparılmışdır.

Test ünvanı:

~~~text
1.1.1.1
~~~

Nəticə:

~~~text
Network unreachable
~~~

Bu nəticə test edilən konteyner mühitinin xarici şəbəkəyə birbaşa çıxışının olmadığını göstərmişdir.

### Konteyner təhlükəsizlik məhdudiyyətləri

Sandbox mühitində aşağıdakı nəzarətlər tətbiq edilmişdir:

- Daxili Docker şəbəkəsi;
- Konteyner imtiyazlarının məhdudlaşdırılması;
- Read-only fayl sistemi;
- Yaddaş istifadəsinə limit;
- Proses sayına limit;
- Xarici şəbəkəyə çıxışın məhdudlaşdırılması.

Bu məhdudiyyətlər şübhəli obyektlərin analizi zamanı konteynerin istifadə edə biləcəyi resursları və əməliyyat imkanlarını azaltmaq məqsədi daşıyır.

## 8.3.3 — Şübhəli URL-lərin statik analizi

### Məqsəd

Phishing məktublarında istifadəçilərin saxta giriş səhifələrinə və ya zərərli resurslara yönləndirilməsi geniş yayılmış riskdir.

Bu mərhələdə URL-lərin ilkin qiymətləndirilməsi üçün statik analiz yanaşmasından istifadə edilmişdir.

### Statik analiz yanaşması

Statik URL analizinin məqsədi ünvanı brauzerdə açmadan onun mətn və struktur xüsusiyyətlərini qiymətləndirməkdir.

Bu yanaşmada şübhəli domenlər, qeyri-adi URL strukturları və test indikatorları analiz üçün istifadə oluna bilər.

Layihədə xüsusi phishing aşkarlama qaydasının yoxlanılması üçün aşağıdakı test domeni seçilmişdir:

~~~text
soc-phishing-test.invalid
~~~

Bu domen real istifadəçilərə yönəlmiş zərərli infrastruktur deyil, təhlükəsizlik qaydasının test edilməsi üçün istifadə olunan indikator olmuşdur.

### Təhlükəsizlik əhəmiyyəti

Statik analiz ilkin filtr kimi istifadə edilə bilər.

Bununla belə, yalnız URL mətninin analizi bütün phishing və zərərli fəaliyyət növlərini aşkar etmək üçün kifayət deyil. Layihədə bu nəzarət ESG spam və antivirus yoxlamaları ilə birlikdə tətbiq edilmişdir.

## 8.3.4 — Email əlavələrinin analizi

### Məqsəd

Email əlavələri zərərli məzmunun çatdırılması üçün istifadə oluna bildiyindən onların əsas email serverdən ayrılmış mühitdə yoxlanılması nəzərdə tutulmuşdur.

SANDBOX01 üzərində şübhəli email əlavələrinin statik analizi üçün testlər aparılmışdır.

### Analiz yanaşması

Email əlavələrinin qiymətləndirilməsi aşağıdakı prinsiplərə əsaslanır:

1. Email obyektinin analiz mühitinə ötürülməsi;
2. Əlavə və məzmunun statik yoxlanılması;
3. Şübhəli indikatorların müəyyən edilməsi;
4. Analiz nəticəsinin email təhlükəsizlik qərarında istifadə edilməsi.

Bu mərhələdə layihənin əsas diqqəti izolyasiya olunmuş analiz mühitinin yaradılmasına və ESG ilə inteqrasiya imkanlarının yoxlanılmasına yönəlmişdir.

### ESG antivirus yoxlaması ilə əlaqə

Bölmə 8.2-də ESG01 üzərində ClamAV antivirusu EICAR test nümunəsini aşkarlamışdır.

EICAR nümunəsi daşıyan email əlavəsi bloklanmış və Virus Quarantine bölməsinə yerləşdirilmişdir.

Bu nəticə email əlavələrinin təhlükəsizlik yoxlamasının ESG səviyyəsində işlədiyini göstərmişdir.

## 8.3.5 — ESG01 və SANDBOX01 arasında analiz prototipi

### İnteqrasiya məqsədi

Email Security Gateway tərəfindən qəbul edilmiş şübhəli məktubların ayrıca analiz serverində yoxlanılması üçün ESG01 və SANDBOX01 arasında inteqrasiya prototipi hazırlanmışdır.

### SSH əsaslı ötürmə

Prototipdə SSH bağlantısından istifadə edilmişdir.

Analiz üçün email obyektləri .eml formatında nəzərdə tutulmuşdur.

.eml formatı məktubun başlıqlarını, məzmununu və MIME strukturunu saxlayan email faylı formatıdır.

### Prototipin iş prinsipi

~~~text
ESG01
  |
  | Şübhəli email
  v
.eml faylı
  |
  | SSH əsaslı ötürmə
  v
SANDBOX01
  |
  | Analiz skripti
  v
Statik analiz nəticəsi
~~~

### Tətbiq nəticəsi

ESG01 və SANDBOX01 arasında SSH əsaslı .eml analiz prototipi üzərində iş aparılmışdır.

Bu komponenti bütün daxil olan məktubları avtomatik analiz edən tam istehsalat inteqrasiyası kimi deyil, layihədə hazırlanmış və sınaqdan keçirilmiş inteqrasiya prototipi kimi qiymətləndirmək lazımdır.

## 8.3.6 — SpamAssassin üçün xüsusi anti-phishing qaydası

### Məqsəd

Email məzmununda müəyyən edilmiş phishing indikatoru aşkarlandıqda spam balının artırılması və məktubun karantinə yönləndirilməsi üçün xüsusi qayda hazırlanmışdır.

Bu yoxlama Proxmox Mail Gateway üzərində həyata keçirilmişdir.

### Qayda faylı

SpamAssassin konfiqurasiyasında aşağıdakı fayldan istifadə edilmişdir:

~~~text
/etc/mail/spamassassin/custom.cf
~~~

### SOC_PHISHING_URL qaydası

Qayda adı:

~~~text
SOC_PHISHING_URL
~~~

Test indikatoru:

~~~text
soc-phishing-test.invalid
~~~

Tətbiq edilmiş əlavə spam balı:

~~~text
+10
~~~

Qaydanın məntiqi email məzmununda test domeni aşkar edildikdə məktubun spam balını artırmaqdır.

### Qaydanın yoxlanılması

Xüsusi qayda əlavə edildikdən sonra SpamAssassin konfiqurasiyasının sintaktik düzgünlüyü yoxlanılmışdır.

Lint yoxlaması uğurla tamamlanmışdır.

Bu test konfiqurasiya faylının SpamAssassin tərəfindən qəbul edilə bildiyini göstərmişdir.

## 8.3.7 — Phishing test məktubunun analizi

### Test ssenarisi

SOC_PHISHING_URL qaydasının işləməsini yoxlamaq üçün test indikatorunu daşıyan email hazırlanmışdır.

Email məzmununda aşağıdakı domen istifadə edilmişdir:

~~~text
soc-phishing-test.invalid
~~~

Məktub Proxmox Mail Gateway üzərindən analiz edilmişdir.

### Spam balı

Test nəticəsində aşağıdakı göstəricilər əldə edilmişdir:

| Parametr | Nəticə |
|---|---|
| Xüsusi qayda | SOC_PHISHING_URL |
| Test indikatoru | soc-phishing-test.invalid |
| Qaydanın əlavə balı | +10 |
| Yekun spam balı | 12.3 |
| Spam statusu | X-Spam-Flag: YES |

### X-Spam-Flag yoxlaması

Email analizinin nəticəsində aşağıdakı başlıq müşahidə edilmişdir:

~~~text
X-Spam-Flag: YES
~~~

Bu nəticə test məktubunun spam kimi işarələndiyini göstərmişdir.

### Karantin testi

Spam balının yüksəlməsi nəticəsində məktub Proxmox Mail Gateway tərəfindən karantinə yerləşdirilmişdir.

Testin nəticəsi:

- Xüsusi phishing indikatoru aşkar edilmişdir;
- SOC_PHISHING_URL qaydası tətbiq edilmişdir;
- Spam balı 12.3 olmuşdur;
- X-Spam-Flag YES nəticəsi alınmışdır;
- Məktub PMG karantininə yerləşdirilmişdir.

**Nəticə:** Xüsusi anti-phishing qaydası və karantin mexanizmi praktik testlə yoxlanılmışdır.

## 9. Təhlükəsizlik nəzarətlərinin ümumi arxitekturası

Bu bölmədəki nəzarətlər email təhlükəsizliyinin bir neçə fərqli mərhələsini əhatə edir.

| Təhlükəsizlik qatı | Komponent | Funksiya |
|---|---|---|
| Email Gateway | ESG01 / PMG | SMTP trafikinə təhlükəsizlik nəzarəti |
| Spam Analysis | SpamAssassin | Email məzmununun qiymətləndirilməsi |
| Antivirus | ClamAV | Zərərli əlavə imzalarının aşkarlanması |
| Custom Detection | SOC_PHISHING_URL | Phishing indikatorunun aşkarlanması |
| Quarantine | PMG | Şübhəli məktubların saxlanması |
| Isolated Analysis | SANDBOX01 | Ayrılmış analiz mühiti |
| Container Isolation | Docker | Şəbəkə və resurs məhdudiyyətləri |
| Integration Prototype | SSH / .eml | ESG ilə Sandbox arasında analiz prototipi |

## 10. Praktiki yoxlama nəticələri

| № | Yoxlama | Nəticə |
|---|---|---|
| 1 | SANDBOX01 hazırlanması | Tamamlandı |
| 2 | Docker analiz mühiti | Yaradıldı |
| 3 | soc-sandbox-net | Konfiqurasiya edildi |
| 4 | Docker Internal parametri | true |
| 5 | Xarici IP bağlantısı | Network unreachable |
| 6 | Read-only fayl sistemi | Konfiqurasiya edildi |
| 7 | Konteyner resurs limitləri | Tətbiq edildi |
| 8 | Şübhəli URL analizi | Statik analiz testləri |
| 9 | Email əlavələrinin analizi | Statik analiz testləri |
| 10 | ESG və Sandbox əlaqəsi | SSH əsaslı prototip |
| 11 | Email fayl formatı | .eml |
| 12 | SpamAssassin custom.cf | Konfiqurasiya edildi |
| 13 | SOC_PHISHING_URL | Yaradıldı |
| 14 | Xüsusi spam balı | +10 |
| 15 | SpamAssassin lint | Uğurlu |
| 16 | Test məktubunun spam balı | 12.3 |
| 17 | X-Spam-Flag | YES |
| 18 | PMG karantin | Təsdiqləndi |

## 11. Əlaqəli sənədlər

- [Bölmə 8 — Ümumi README](README.md)
- [8.1 — Mail Server İnfrastrukturu](mail-server.md)
- [8.2 — Email Security Gateway](email-security-gateway.md)
- [8.4 — Phishing Simulyasiyası](phishing-simulation.md)
- [8.5 — Real Domen və SMTP Relay](smtp-relay.md)

## 12. Nəticə

Bölmə 8.3 çərçivəsində SANDBOX01 üzərində Docker əsaslı izolyasiya olunmuş analiz mühiti yaradılmışdır.

soc-sandbox-net şəbəkəsi daxili rejimdə konfiqurasiya edilmiş, Internal=true nəticəsi alınmış və 1.1.1.1 ünvanına bağlantı cəhdi Network unreachable nəticəsi ilə tamamlanmışdır.

Konteynerlər üçün imtiyaz, fayl sistemi və resurs məhdudiyyətləri tətbiq edilmişdir.

Şübhəli URL və email əlavələrinin statik analizi üzərində iş aparılmış, ESG01 ilə SANDBOX01 arasında SSH və .eml faylları əsasında inteqrasiya prototipi hazırlanmışdır.

Proxmox Mail Gateway üzərində SpamAssassin üçün SOC_PHISHING_URL adlı xüsusi phishing aşkarlama qaydası yaradılmışdır. Qayda test indikatoru üçün +10 spam balı tətbiq etmişdir.

Praktiki testdə məktubun yekun spam balı 12.3 olmuş, X-Spam-Flag YES nəticəsi alınmış və məktub PMG karantininə yerləşdirilmişdir.

Beləliklə, email təhlükəsizlik infrastrukturu izolyasiya olunmuş analiz mühiti, xüsusi phishing aşkarlama qaydası və karantin mexanizmi ilə genişləndirilmişdir.
