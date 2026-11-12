# 8.5 — REAL DOMEN, SMTP RELAY VƏ EMAIL DELIVERABILITY TESTLƏRİ

## 1. Giriş və məqsəd

CSOC layihəsinin 8.1-ci mərhələsində Mailcow əsasında daxili korporativ email infrastrukturu qurulmuşdur. 8.5-ci mərhələdə isə həmin infrastrukturu real internet email mühiti ilə inteqrasiya etmək, domen autentifikasiyasını yoxlamaq və xarici poçt xidmətlərinə email göndərilməsini sınaqdan keçirmək məqsədi qoyulmuşdur.

Bu iş çərçivəsində konrderk.com real domeni əldə edilmiş, send.konrderk.com subdomeni hazırlanmış və Mailcow Brevo SMTP Relay xidmətinə qoşulmuşdur.

Əsas məqsədlər:

- Real domenin qeydiyyatdan keçirilməsi;
- İnternet bağlantısında CGNAT məhdudiyyətinin müəyyən edilməsi;
- Real domen üçün DNS autentifikasiya qeydlərinin yaradılması;
- Mailcow-un xarici SMTP Relay ilə inteqrasiyası;
- Gmail hesabına real email göndərilməsi;
- SPF və DKIM nəticələrinin yoxlanılması;
- Mail-Tester ilə email çatdırılma keyfiyyətinin ölçülməsi;
- Aşkar edilmiş çatdırılma problemlərinin sənədləşdirilməsi.

**Qeyd:** Bu mərhələ müəllimin əsas tapşırıq sənədində ayrıca 8.5 tələbi kimi verilməmişdir. Layihənin 8.1-ci mərhələsində qurulmuş email infrastrukturunu real mühitdə sınaqdan keçirmək və Bölmə 8-in sübutlarını genişləndirmək üçün əlavə olaraq həyata keçirilmişdir.

---

## 8.5.1 — CGNAT probleminin müəyyən edilməsi

### İlkin yanaşma

İlk mərhələdə real domen üçün internetdən MAIL01 serverinə birbaşa SMTP bağlantısı yaratmaq planlaşdırılmışdır.

Bunun üçün Netis N3D router üzərində port forwarding tətbiq etmək nəzərdə tutulmuşdur.

Port forwarding vasitəsilə xarici SMTP trafiki daxili şəbəkədəki Mailcow serverinə yönləndirilə bilərdi.

### WAN IP ünvanının yoxlanılması

Routerin WAN interfeysində aşağıdakı IP ünvanı müəyyən edilmişdir:

~~~text
100.66.134.254
~~~

Bu ünvan 100.64.0.0/10 CGNAT diapazonuna aiddir.

CGNAT — Carrier-Grade Network Address Translation — internet provayderinin bir neçə müştərini ortaq publik IPv4 ünvanları vasitəsilə internetə çıxarması üçün istifadə etdiyi mexanizmdir.

### Problemin təsiri

CGNAT səbəbindən router üzərində port forwarding konfiqurasiyası qurmaqla internetdən MAIL01 serverinə birbaşa SMTP bağlantısı təmin etmək mümkün olmamışdır.

Bu məhdudiyyət xüsusilə xaricdən email qəbuluna təsir etmişdir.

### Alternativ həll

Xaricə email göndərilməsini təmin etmək üçün Brevo SMTP Relay xidmətindən istifadə etmək qərara alınmışdır.

Bu yanaşmada MAIL01 serveri internetdən birbaşa SMTP bağlantısı qəbul etmədən, autentifikasiyalı çıxış bağlantısı vasitəsilə Brevo serverinə məktub göndərə bilir.

~~~text
MAIL01 — Mailcow
        |
        | SMTP Submission
        | TCP 587
        v
Brevo SMTP Relay
        |
        v
İnternet email infrastrukturu
        |
        v
Gmail
~~~

**Nəticə:** CGNAT məhdudiyyəti müəyyən edilmiş və xaricə email göndərilməsi üçün SMTP Relay arxitekturası seçilmişdir.

---

## 8.5.2 — Real domenin alınması və DNS konfiqurasiyası

### Domenin qeydiyyatı

Namecheap platforması vasitəsilə aşağıdakı domen bir illik müddətə qeydiyyatdan keçirilmişdir:

~~~text
konrderk.com
~~~

Domenin aktivliyi yoxlanılmışdır.

### DNS idarəetməsi

DNS idarəetməsi üçün Namecheap BasicDNS xidmətindən istifadə edilmişdir.

| Parametr | Dəyər |
|---|---|
| Domen qeydiyyatçısı | Namecheap |
| Əsas domen | konrderk.com |
| Qeydiyyat müddəti | 1 il |
| DNS xidməti | Namecheap BasicDNS |
| SMTP Relay subdomeni | send.konrderk.com |

### Subdomenin seçilməsi

SMTP Relay xidməti üçün aşağıdakı subdomen seçilmişdir:

~~~text
send.konrderk.com
~~~

Bu yanaşmanın məqsədi xarici email göndərmə infrastrukturunu əsas domendən məntiqi olaraq ayırmaq olmuşdur.

### Brevo domen təsdiqi

Brevo platformasında göndərən domenin təsdiqlənməsi üçün Namecheap DNS panelində tələb olunan qeydlər yaradılmışdır.

Hesabatda aşağıdakı konfiqurasiyalar göstərilmişdir:

1. Brevo domen təsdiqi qeydi;
2. İki DKIM CNAME qeydi;
3. DMARC TXT qeydi.

| DNS mexanizmi | Təyinat |
|---|---|
| Domen təsdiqi | Domen üzərində nəzarətin təsdiqi |
| DKIM CNAME №1 | Brevo DKIM autentifikasiyası |
| DKIM CNAME №2 | Brevo DKIM autentifikasiyası |
| DMARC TXT | Email autentifikasiyası siyasəti |

**Qeyd:** Real domen üçün DNS qeydlərinin dəqiq token və CNAME hədəfləri hesabatın mətnində göstərilmədiyindən burada uydurma dəyərlər əlavə edilməmişdir.

### Daxili və real domenin fərqi

Layihədə iki fərqli email domeni istifadə edilmişdir.

| Domen | İstifadə məqsədi |
|---|---|
| konrderk.test | Daxili laboratoriya email mübadiləsi |
| konrderk.com | Real internet domeni |
| send.konrderk.com | Brevo üzərindən email göndərilməsi |

Beləliklə, daxili Mailcow laboratoriyası ilə real email göndərmə infrastrukturu bir-birindən ayrılmışdır.

---

## 8.5.3 — Brevo SMTP Relay inteqrasiyası

### Brevo platformasının hazırlanması

Brevo platformasında hesab yaradılmış və Transactional Email xidməti aktivləşdirilmişdir.

Brevo-nun SMTP Relay funksiyası Mailcow-dan xarici email ünvanlarına məktub göndərmək üçün istifadə edilmişdir.

### Mailcow-da real domenin əlavə edilməsi

Mailcow idarəetmə panelində aşağıdakı domen əlavə edilmişdir:

~~~text
send.konrderk.com
~~~

Bu domen üçün aşağıdakı email hesabı yaradılmışdır:

~~~text
security@send.konrderk.com
~~~

### SMTP Relay parametrləri

Mailcow üzərində xarici SMTP Relay konfiqurasiyası tətbiq edilmişdir.

| Parametr | Dəyər |
|---|---|
| Relay xidməti | Brevo Transactional Email |
| SMTP server | smtp-relay.brevo.com |
| SMTP portu | TCP 587 |
| Autentifikasiya | SMTP istifadəçi adı və açarı |
| Göndərən domen | send.konrderk.com |
| Göndərən email | security@send.konrderk.com |

SMTP istifadəçi adı və açarı məxfi autentifikasiya məlumatları olduğu üçün GitHub sənədinə əlavə edilmir.

### Email göndərmə axını

~~~text
security@send.konrderk.com
             |
             v
MAIL01 — Mailcow
             |
             | SMTP autentifikasiyası
             | TCP 587
             v
smtp-relay.brevo.com
             |
             | İnternet üzərindən çatdırılma
             v
Gmail poçt infrastrukturu
             |
             v
Gmail Inbox
~~~

### Real email testi

Mailcow üzərindən security@send.konrderk.com ünvanından Gmail hesabına test məktubu göndərilmişdir.

Test zamanı:

1. Mailcow-da göndərən email hesabı hazırlanmışdır.
2. Brevo SMTP Relay parametrləri tətbiq edilmişdir.
3. Gmail ünvanına test məktubu göndərilmişdir.
4. Gmail hesabında məktubun çatdırılması yoxlanılmışdır.
5. Məktubun Inbox qovluğuna daxil olduğu təsdiqlənmişdir.

**Nəticə:** Mailcow və Brevo SMTP Relay inteqrasiyası uğurla işləyərək Gmail-ə real email göndərilməsini təmin etmişdir.

---

## 8.5.4 — Mail-Tester ilə email autentifikasiyası və çatdırılma testi

### Testin məqsədi

SMTP Relay inteqrasiyasından sonra göndərilən məktubların autentifikasiya və çatdırılma keyfiyyətini qiymətləndirmək üçün Mail-Tester platformasından istifadə edilmişdir.

Mail-Tester email məzmununu və texniki parametrləri analiz edərək ümumi bal təqdim edir.

### İlkin test

İlkin test nəticəsi:

~~~text
5.9 / 10
~~~

### Təkrar test

Sonrakı test nəticəsi:

~~~text
5.8 / 10
~~~

| Test | Nəticə |
|---|---|
| İlkin Mail-Tester testi | 5.9/10 |
| Təkrar Mail-Tester testi | 5.8/10 |
| Əldə edilmiş ən yüksək bal | 5.9/10 |

### SPF nəticəsi

Mail-Tester yoxlamasında aşağıdakı nəticə əldə edilmişdir:

~~~text
SPF PASS
~~~

Bu nəticə test məktubunun SPF yoxlamasından keçdiyini göstərmişdir.

### DKIM nəticəsi

DKIM yoxlamasında aşağıdakı nəticə əldə edilmişdir:

~~~text
DKIM VALID
~~~

Bu nəticə email-in DKIM imzasının etibarlı olduğunu göstərmişdir.

### Aşkar edilmiş problemlər

Mail-Tester nəticələrində bir neçə çatdırılma keyfiyyəti problemi müəyyən edilmişdir.

| Problem | Təsviri |
|---|---|
| Yeni domen reputasiyası | Domenin yeni olması reputasiya qiymətləndirilməsinə təsir etmişdir |
| SMTP Relay IP reputasiyası | Brevo relay IP-si ilə bağlı xəbərdarlıq |
| SpamCop | Relay IP-sinin SpamCop siyahısında görünməsi |
| HTML formatı | Email məzmununun formatı ilə bağlı xəbərdarlıq |
| Tracking pixel | Brevo tərəfindən əlavə edilən izləmə elementi ilə bağlı xəbərdarlıq |

Bu nəticələr SPF və DKIM yoxlamalarının uğurlu olmasının email-in mütləq yüksək çatdırılma balı alacağı anlamına gəlmədiyini göstərmişdir.

### Problemlərin azaldılması üçün görülən iş

HTML formatı ilə bağlı xəbərdarlıqları azaltmaq üçün SOGo webmail interfeysində məktubun formatı dəyişdirilmişdir.

Yeni format:

~~~text
Plain text
~~~

Bundan sonra Mail-Tester yoxlaması təkrarlanmışdır.

Təkrar testdə 5.8/10 nəticəsi alınmışdır.

Brevo tərəfindən əlavə edilən tracking pixel və SMTP Relay IP reputasiyası ilə bağlı xəbərdarlıqlar qalmışdır.

### Testin qiymətləndirilməsi

| Nəzarət | Nəticə |
|---|---|
| Real email göndərilməsi | Uğurlu |
| Gmail Inbox-a çatdırılma | Təsdiqləndi |
| SPF | PASS |
| DKIM | VALID |
| Mail-Tester ilkin bal | 5.9/10 |
| Mail-Tester təkrar bal | 5.8/10 |
| Plain text formatına keçid | Həyata keçirildi |
| Tracking pixel xəbərdarlığı | Qaldı |
| Relay IP reputasiyası xəbərdarlığı | Qaldı |

**Nəticə:** Domen autentifikasiyası və real email çatdırılması yoxlanılmış, eyni zamanda email reputasiyası və məzmunu ilə bağlı problemlər müəyyən edilmişdir.

---

## 8.5.5 — Məhdudiyyətlər və təhlükəsizlik qiymətləndirilməsi

### CGNAT məhdudiyyəti

Brevo vasitəsilə xaricə məktub göndərilməsi uğurla işləsə də, internetdən Mailcow-a birbaşa SMTP bağlantısı yaratmaq mümkün olmamışdır.

Bu səbəbdən xarici internetdən MAIL01 serverinə birbaşa email qəbulu həmin mərhələdə qurulmamışdır.

### SMTP Relay-in rolu

Brevo SMTP Relay xaricə email göndərilməsi üçün istifadə edilmişdir.

Bu inteqrasiya xarici email qəbulunu avtomatik olaraq təmin etmir.

### Email reputasiyası

Mail-Tester nəticələri aşağıdakı amillərin çatdırılma keyfiyyətinə təsir edə bildiyini göstərmişdir:

- Domenin reputasiyası;
- SMTP Relay IP ünvanının reputasiyası;
- Email məzmununun formatı;
- Tracking pixel istifadəsi.

### Nəticələrin düzgün şərhi

Layihədə aşağıdakı nəticələr praktik olaraq təsdiqlənmişdir:

- Real domen əldə edilmişdir;
- DNS autentifikasiya qeydləri yaradılmışdır;
- Brevo SMTP Relay inteqrasiyası qurulmuşdur;
- Gmail Inbox-a məktub çatdırılmışdır;
- SPF PASS nəticəsi alınmışdır;
- DKIM VALID nəticəsi alınmışdır;
- Mail-Tester ilə çatdırılma balı ölçülmüşdür.

Bununla yanaşı, xarici email qəbulunun CGNAT səbəbindən qurulmadığı və reputasiya xəbərdarlıqlarının qaldığı da sənədləşdirilmişdir.

---

## 9. Arxitektura xülasəsi

~~~text
                 DAXİLİ LABORATORİYA

             MAIL01 — Mailcow
                10.0.0.102
                    |
                    | SMTP TCP 587
                    v

                 İNTERNET

           smtp-relay.brevo.com
                    |
                    v
            Xarici email xidməti
                    |
                    v
                Gmail Inbox


               DNS İNFRASTRUKTURU

             Namecheap BasicDNS
                    |
                    +-- konrderk.com
                    |
                    +-- send.konrderk.com
                          |
                          +-- Domen təsdiqi
                          +-- DKIM CNAME x2
                          +-- DMARC TXT
~~~

Bu sxem real email göndərmə və domen autentifikasiyası komponentlərini göstərir.

---

## 10. Praktiki yoxlama nəticələri

| № | Tapşırıq və ya yoxlama | Nəticə |
|---|---|---|
| 1 | Netis N3D router yoxlaması | Aparıldı |
| 2 | WAN IP | 100.66.134.254 |
| 3 | CGNAT məhdudiyyəti | Müəyyən edildi |
| 4 | Real domenin alınması | konrderk.com |
| 5 | Domen qeydiyyatı | 1 il |
| 6 | DNS xidməti | Namecheap BasicDNS |
| 7 | SMTP Relay subdomeni | send.konrderk.com |
| 8 | Domen təsdiqi qeydi | Yaradıldı |
| 9 | DKIM CNAME qeydləri | 2 ədəd |
| 10 | DMARC TXT qeydi | Yaradıldı |
| 11 | Brevo hesabı | Yaradıldı |
| 12 | Transactional Email | Aktivləşdirildi |
| 13 | Mailcow real domeni | Əlavə edildi |
| 14 | Email hesabı | security@send.konrderk.com |
| 15 | SMTP Relay serveri | smtp-relay.brevo.com |
| 16 | SMTP portu | TCP 587 |
| 17 | SMTP autentifikasiyası | İstifadəçi adı və açar |
| 18 | Gmail-ə email göndərilməsi | Uğurlu |
| 19 | Gmail Inbox | Məktub çatdı |
| 20 | SPF | PASS |
| 21 | DKIM | VALID |
| 22 | İlkin Mail-Tester | 5.9/10 |
| 23 | Təkrar Mail-Tester | 5.8/10 |
| 24 | SOGo Plain text | Tətbiq edildi |
| 25 | Tracking pixel xəbərdarlığı | Qaldı |
| 26 | SMTP Relay IP reputasiyası | Xəbərdarlıq qaldı |
| 27 | Xaricdən birbaşa email qəbulu | CGNAT səbəbindən qurulmadı |

---

## 11. Sübut materialları

Bu mərhələnin nəticələrini təsdiqləyən sübutlar layihə hesabatında təqdim edilmişdir.

Əsas sübut istiqamətləri:

- Router üzərində WAN IP və CGNAT yoxlaması;
- Namecheap domen və DNS konfiqurasiyası;
- Brevo domen autentifikasiyası;
- Mailcow SMTP Relay parametrləri;
- Gmail Inbox-a çatmış test məktubu;
- Mail-Tester ilkin 5.9/10 nəticəsi;
- Mail-Tester təkrar 5.8/10 nəticəsi;
- SPF PASS və DKIM VALID nəticələri;
- Çatdırılma keyfiyyəti ilə bağlı xəbərdarlıqlar.

---

## 12. Əlaqəli sənədlər

- [Bölmə 8 — Ümumi README](README.md)
- [8.1 — Mail Server İnfrastrukturu](mail-server.md)
- [8.2 — Email Security Gateway](email-security-gateway.md)
- [8.3 — Anti-Phishing və Sandboxing](anti-phishing-sandboxing.md)
- [8.4 — Phishing Simulyasiyası](phishing-simulation.md)

---

## 13. Ümumi nəticə

Bölmə 8.5 çərçivəsində daxili Mailcow infrastrukturu real email göndərmə mühiti ilə inteqrasiya edilmişdir.

Netis N3D router üzərində 100.66.134.254 WAN IP ünvanı müəyyən edilmiş və CGNAT məhdudiyyəti səbəbindən internetdən MAIL01-ə birbaşa SMTP bağlantısı qurulmasının mümkün olmadığı aşkar edilmişdir.

Alternativ həll kimi Brevo SMTP Relay seçilmişdir.

Namecheap platformasında konrderk.com domeni bir illik qeydiyyatdan keçirilmiş, Namecheap BasicDNS üzərində send.konrderk.com subdomeni üçün domen təsdiqi, iki DKIM CNAME və DMARC TXT qeydləri yaradılmışdır.

Mailcow üzərində send.konrderk.com domeni və security@send.konrderk.com email hesabı yaradılmışdır. smtp-relay.brevo.com serveri TCP 587 portu vasitəsilə SMTP Relay kimi konfiqurasiya edilmişdir.

Real test zamanı Gmail hesabına məktub göndərilmiş və məktubun Inbox qovluğuna çatması təsdiqlənmişdir.

Mail-Tester yoxlamalarında SPF PASS və DKIM VALID nəticələri əldə edilmişdir. İlkin test 5.9/10, təkrar test isə 5.8/10 olmuşdur.

Email formatı SOGo üzərində Plain text olaraq dəyişdirilsə də, Brevo tracking pixel-ləri və SMTP Relay IP reputasiyası ilə bağlı xəbərdarlıqlar qalmışdır.

Bu mərhələdə xaricə email göndərilməsi uğurla həyata keçirilmiş, lakin CGNAT səbəbindən internetdən Mailcow-a birbaşa email qəbulu qurulmamışdır.

Beləliklə, real domen, DNS autentifikasiyası, SMTP Relay inteqrasiyası və email deliverability yoxlamaları praktik şəkildə həyata keçirilmiş və nəticələr sənədləşdirilmişdir.
