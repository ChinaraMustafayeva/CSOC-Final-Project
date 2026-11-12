# 8.1 — MAIL SERVER İNFRASTRUKTURU VƏ EMAIL TƏHLÜKƏSİZLİYİ

## 1. Məqsəd

Bu mərhələdə CSOC layihəsi üçün korporativ email infrastrukturu qurulmuş və email xidmətlərinin təhlükəsizliyini təmin edən əsas mexanizmlər tətbiq edilmişdir.

Mail server kimi Mailcow platforması seçilmişdir.

Həyata keçirilmiş işlər:

- Ubuntu Server 24.04 üzərində MAIL01 serverinin hazırlanması;
- Docker əsaslı Mailcow platformasının quraşdırılması;
- Daxili email domeninin yaradılması;
- SOGo vasitəsilə istifadəçilər arasında email mübadiləsi;
- SPF, DKIM və DMARC konfiqurasiyası;
- CA01 tərəfindən verilmiş sertifikatla TLS bağlantılarının qorunması;
- SMTP, IMAP və POP3 xidmətlərində şifrəsiz autentifikasiyanın bloklanması;
- CIS Ubuntu Linux Level 1 təhlükəsizlik auditi.

## 8.1.1 — MAIL01 serverinin hazırlanması

### Server infrastrukturu

MAIL01 adlı Ubuntu Server 24.04 virtual maşını yaradılmışdır.

| Parametr | Dəyər |
|---|---|
| Server adı | MAIL01 |
| Əməliyyat sistemi | Ubuntu Server 24.04 |
| Əsas IP ünvanı | 10.0.0.102 |
| Daxili şəbəkə IP-si | 192.168.100.60 |
| Mail platforması | Mailcow |
| Daxili domen | konrderk.test |
| Mail hostname | mail.konrderk.test |
| Konteyner platforması | Docker |
| Konfiqurasiya qovluğu | /opt/mailcow-dockerized |

MAIL01 korporativ laboratoriya infrastrukturunda daxili poçt xidmətlərinin mərkəzi serveri kimi hazırlanmışdır.

### Şəbəkə və DNS

Serverin şəbəkə interfeysləri konfiqurasiya edilmiş, daxili domen adlarının həlli üçün DNS qeydləri hazırlanmışdır.

mail.konrderk.test adı Mailcow xidmətinin hostname dəyəri kimi istifadə edilmişdir.

## 8.1.2 — Docker və Mailcow quraşdırılması

### Docker infrastrukturu

MAIL01 üzərində Docker və Docker Compose hazırlanmışdır.

Mailcow layihəsi aşağıdakı qovluqda yerləşdirilmişdir:

~~~text id="l1x8bf"
/opt/mailcow-dockerized
~~~

Mailcow konfiqurasiyası hazırlanarkən mail hostname kimi mail.konrderk.test təyin edilmişdir.

### Mailcow xidmətlərinin başladılması

Docker Compose vasitəsilə Mailcow konteynerləri başladılmışdır.

İdarəetmə üçün istifadə olunan əsas əmrlər:

~~~bash id="l8m01a"
cd /opt/mailcow-dockerized
sudo docker compose up -d
sudo docker compose ps
~~~

Quraşdırma tamamlandıqdan sonra 18 Docker konteynerinin işlədiyi yoxlanılmışdır.

### Mailcow komponentləri

| Komponent | Funksiya |
|---|---|
| Postfix | SMTP vasitəsilə email ötürülməsi |
| Dovecot | IMAP və POP3 xidmətləri |
| Nginx | HTTPS və veb interfeys |
| SOGo | İstifadəçilər üçün webmail |
| Rspamd | Spam analizi |
| ClamAV | Antivirus yoxlaması |
| Unbound | DNS xidməti |
| MariaDB | Mailcow verilənlər bazası |
| Redis | Keş və yardımçı xidmətlər |

### Resurs optimallaşdırılması

İlkin mərhələdə MAIL01 serverinə 4 GB RAM ayrılmışdır.

Mailcow konteynerlərinin, xüsusilə antivirus və yardımçı xidmətlərin daha stabil işləməsi üçün RAM 8 GB-a artırılmışdır.

Bu dəyişiklikdən sonra xidmətlərin işləmə vəziyyəti yenidən yoxlanılmışdır.

## 8.1.3 — Email domeni və istifadəçi hesabları

### Daxili domen

Mailcow idarəetmə panelində aşağıdakı domen əlavə edilmişdir:

~~~text id="l8m01b"
konrderk.test
~~~

Bu domen laboratoriya daxilində korporativ email mübadiləsi üçün istifadə edilmişdir.

### Poçt qutuları

İki test istifadəçisi üçün email hesabları yaradılmışdır.

| İstifadəçi | Email ünvanı |
|---|---|
| Aysel | aysel@konrderk.test |
| Yusif | yusif@konrderk.test |

### SOGo webmail testi

Mailcow-un SOGo interfeysindən istifadə edilərək daxili email mübadiləsi yoxlanılmışdır.

Test ardıcıllığı:

1. Ayselin email hesabına daxil olunmuşdur.
2. Yusifin email ünvanına yeni məktub hazırlanmışdır.
3. Məktubun mövzusu Konrderk Mail Test təyin edilmişdir.
4. Məktub göndərilmişdir.
5. Yusifin email hesabına daxil olunmuşdur.
6. Məktubun Inbox qovluğuna çatması yoxlanılmışdır.
7. Məktubun məzmununun oxunması təsdiqlənmişdir.

**Nəticə:** Mailcow üzərindən daxili istifadəçilər arasında email göndərilməsi və qəbulu uğurla həyata keçirilmişdir.

## 8.1.4 — SPF, DKIM və DMARC konfiqurasiyası

Email spoofing və saxta göndərən ünvanlarından istifadə risklərini azaltmaq üçün üç əsas email autentifikasiya mexanizmi konfiqurasiya edilmişdir.

### SPF — Sender Policy Framework

SPF göndərən domen adından hansı serverlərin email göndərə biləcəyini müəyyən etmək üçün istifadə edilmişdir.

Daxili domen üçün aşağıdakı TXT qeydi yaradılmışdır:

~~~dns id="l8m01c"
konrderk.test. IN TXT "v=spf1 ip4:192.168.100.60 -all"
~~~

Parametrlərin izahı:

| Parametr | Mənası |
|---|---|
| v=spf1 | SPF versiyası |
| ip4:192.168.100.60 | İcazə verilmiş mail server IP-si |
| -all | Siyahıda olmayan mənbələr üçün hard fail |

Bu qeyd konrderk.test domenindən məktub göndərməyə icazə verilən IPv4 mənbəyini müəyyən edir.

### DKIM — DomainKeys Identified Mail

DKIM vasitəsilə göndərilən email-lərin kriptoqrafik imzalanması üçün Mailcow-un DKIM funksiyası istifadə edilmişdir.

2048 bitlik DKIM açarı yaradılmışdır.

Public key aşağıdakı DNS qeydinə əlavə edilmişdir:

~~~text id="l8m01d"
dkim._domainkey.konrderk.test
~~~

DKIM konfiqurasiyasının məqsədi məktubun domen tərəfindən imzalandığını və imzalanmış məzmunun dəyişdirilmədiyini yoxlamağa imkan yaratmaqdır.

### DMARC — Domain-based Message Authentication, Reporting and Conformance

SPF və DKIM nəticələrinə əsaslanan domen siyasəti üçün DMARC konfiqurasiya edilmişdir.

Daxili domen üçün aşağıdakı TXT qeydi yaradılmışdır:

~~~dns id="l8m01e"
_dmarc.konrderk.test. IN TXT "v=DMARC1; p=reject; pct=100; adkim=s; aspf=s"
~~~

| Parametr | Təyinat |
|---|---|
| v=DMARC1 | DMARC versiyası |
| p=reject | DMARC yoxlamasından keçməyən məktubların rədd edilməsi siyasəti |
| pct=100 | Siyasətin 100% tətbiqi |
| adkim=s | DKIM üçün strict alignment |
| aspf=s | SPF üçün strict alignment |

### DNS qeydlərinin yoxlanılması

SPF, DKIM və DMARC qeydləri DNS sorğuları ilə yoxlanılmışdır.

Diaqnostika üçün istifadə oluna bilən əmrlər:

~~~bash id="l8m01f"
dig TXT konrderk.test
dig TXT dkim._domainkey.konrderk.test
dig TXT _dmarc.konrderk.test
~~~

**Nəticə:** Daxili email domeni üçün SPF, DKIM və DMARC DNS konfiqurasiyaları yaradılmış və yoxlanılmışdır.

## 8.1.5 — Daxili CA sertifikatı və TLS

### Məqsəd

SMTP, IMAP, POP3 və veb interfeys bağlantılarında istifadəçi məlumatlarının və autentifikasiya trafikinın şifrələnməsi üçün TLS tətbiq edilmişdir.

### Sertifikat infrastrukturu

Sertifikat infrastrukturu Bölmə 2-də yaradılmış PKI mühitinə əsaslanır.

| Komponent | Dəyər |
|---|---|
| Certificate Authority | CA01 |
| Root CA | CORP-ROOT-CA |
| Mail hostname | mail.konrderk.test |
| Mail server | MAIL01 |

CA01 üzərində MAIL01 üçün sertifikat alınmış və Mailcow xidmətlərinə tətbiq edilmişdir.

### TLS xidmətləri

Aşağıdakı dörd protokolda TLS 1.3 bağlantısı yoxlanılmışdır.

| Xidmət | Port | Təhlükəsiz bağlantı |
|---|---|---|
| HTTPS | TCP 443 | TLS 1.3 |
| SMTP Submission | TCP 587 | STARTTLS / TLS 1.3 |
| IMAPS | TCP 993 | TLS 1.3 |
| POP3S | TCP 995 | TLS 1.3 |

Test nəticələrində aşağıdakı kriptoqrafik parametrlər müşahidə edilmişdir:

~~~text id="l8m01g"
Protocol: TLSv1.3
Cipher: TLS_AES_256_GCM_SHA384
Verification: OK
~~~

### HTTPS testi

Mailcow veb interfeysinin TLS bağlantısı yoxlanılmışdır.

Diaqnostika üçün OpenSSL əmri:

~~~bash id="l8m01h"
openssl s_client -connect mail.konrderk.test:443 -servername mail.konrderk.test
~~~

### SMTP STARTTLS testi

SMTP Submission xidmətində STARTTLS dəstəyi yoxlanılmışdır.

~~~bash id="l8m01i"
openssl s_client -starttls smtp -connect mail.konrderk.test:587 -servername mail.konrderk.test
~~~

### IMAPS testi

IMAP xidmətinin TLS ilə işləməsi yoxlanılmışdır.

~~~bash id="l8m01j"
openssl s_client -connect mail.konrderk.test:993 -servername mail.konrderk.test
~~~

### POP3S testi

POP3 xidmətinin TLS ilə işləməsi yoxlanılmışdır.

~~~bash id="l8m01k"
openssl s_client -connect mail.konrderk.test:995 -servername mail.konrderk.test
~~~

**Nəticə:** Dörd xidmət üzrə TLS 1.3 bağlantısı və sertifikat etibarlılığı yoxlanılmışdır.

## 8.1.6 — Şifrəsiz autentifikasiyanın bloklanması

### Məqsəd

İstifadəçi adı və parolun şifrələnməmiş bağlantı üzərindən ötürülməsinin qarşısını almaq üçün SMTP, IMAP və POP3 xidmətlərində plaintext authentication məhdudiyyətləri yoxlanılmışdır.

### SMTP testi

SMTP xidmətinə TLS aktivləşdirilmədən bağlantı yoxlanılmışdır.

Test zamanı serverin şifrəsiz bağlantıda AUTH imkanını təqdim etmədiyi müşahidə edilmişdir.

**Nəticə:** SMTP autentifikasiyası üçün TLS tələbi yoxlanılmışdır.

### IMAP testi

IMAP protokolunda şifrəsiz autentifikasiya cəhdi aparılmışdır.

Server aşağıdakı cavabı qaytarmışdır:

~~~text id="l8m01l"
NO [PRIVACYREQUIRED]
~~~

Bu cavab təhlükəsiz bağlantı olmadan autentifikasiya əməliyyatının qəbul edilmədiyini göstərmişdir.

### POP3 testi

POP3 protokolunda şifrəsiz autentifikasiya yoxlanılmışdır.

Server aşağıdakı cavabı qaytarmışdır:

~~~text id="l8m01m"
Plaintext authentication disallowed on non-secure connections
~~~

**Nəticə:** SMTP, IMAP və POP3 xidmətlərində şifrəsiz autentifikasiya cəhdlərinin qarşısının alındığı praktiki testlərlə təsdiqlənmişdir.

## 8.1.7 — CIS Ubuntu Linux Level 1 auditi

### Məqsəd

MAIL01 serverinin əməliyyat sistemi səviyyəsində təhlükəsizlik vəziyyətini qiymətləndirmək üçün CIS Ubuntu Linux Level 1 audit yoxlaması aparılmışdır.

CIS Benchmark server konfiqurasiyasını təhlükəsizlik tövsiyələri ilə müqayisə etməyə imkan verir.

### Audit nəticəsi

Audit nəticəsində 110 uyğunsuzluq müəyyən edilmişdir.

| Parametr | Nəticə |
|---|---|
| Server | MAIL01 |
| Əməliyyat sistemi | Ubuntu Server 24.04 |
| Audit standartı | CIS Ubuntu Linux Level 1 |
| Müəyyən edilmiş uyğunsuzluqlar | 110 |

### Risk qiymətləndirilməsi

Audit nəticəsində müəyyən edilmiş uyğunsuzluqlar təhlükəsizlik baxımından nəzərdən keçirilmişdir.

Mailcow çoxsaylı Docker konteynerlərindən və email xidmətlərindən ibarət olduğu üçün bəzi əməliyyat sistemi sərtləşdirmə tədbirlərinin xidmətlərə təsir etməsi mümkündür.

Bu səbəbdən uyğunsuzluqların avtomatik və kütləvi şəkildə aradan qaldırılması əvəzinə, onların Mailcow-un işləməsinə təsiri nəzərə alınmışdır.

### Audit yanaşması

- Uyğunsuzluqlar müəyyən edilmişdir.
- Audit nəticələri sənədləşdirilmişdir.
- Mailcow xidmətlərinin davamlılığı nəzərə alınmışdır.
- Sərtləşdirmə dəyişikliklərinin mümkün əməliyyat təsiri qiymətləndirilmişdir.

**Nəticə:** MAIL01 üçün CIS Level 1 auditinin nəticələri əldə edilmiş və 110 uyğunsuzluq sənədləşdirilmişdir.

## 9. Təhlükəsizlik nəzarətlərinin yekun cədvəli

| Təhlükəsizlik istiqaməti | Tətbiq edilmiş həll | Yoxlama nəticəsi |
|---|---|---|
| Mail server | Mailcow | 18 konteyner işləyirdi |
| Resurs optimallaşdırılması | RAM artırılması | 4 GB → 8 GB |
| Daxili email | SOGo | Aysel → Yusif məktubu çatdı |
| SPF | DNS TXT | Konfiqurasiya edildi |
| DKIM | 2048 bit açar | DNS qeydi yaradıldı |
| DMARC | p=reject | Siyasət yaradıldı |
| Sertifikat | CORP-ROOT-CA | Mailcow-a tətbiq edildi |
| HTTPS | TCP 443 | TLS 1.3 |
| SMTP STARTTLS | TCP 587 | TLS 1.3 |
| IMAPS | TCP 993 | TLS 1.3 |
| POP3S | TCP 995 | TLS 1.3 |
| Sertifikat etibarlılığı | OpenSSL | Verification: OK |
| SMTP plaintext auth | TLS tələbi | Şifrəsiz AUTH təqdim edilmədi |
| IMAP plaintext auth | PRIVACYREQUIRED | Bloklandı |
| POP3 plaintext auth | Non-secure auth restriction | Bloklandı |
| CIS Benchmark | Ubuntu Linux Level 1 | 110 uyğunsuzluq |

## 10. Arxitekturada rolu

MAIL01 email xidmətlərinin əsas serveridir.

Sonrakı mərhələdə ESG01 üzərində qurulmuş Proxmox Mail Gateway ilə inteqrasiya edilərək SMTP trafiki əlavə təhlükəsizlik yoxlamalarından keçirilmişdir.

Email axınının ümumi məntiqi:

~~~text id="l8m01n"
Email göndərən
      |
      v
ESG01 — Email Security Gateway
      |
      | Spam və antivirus yoxlaması
      v
MAIL01 — Mailcow
      |
      +--> Postfix
      +--> Dovecot
      +--> SOGo
      |
      v
İstifadəçinin poçt qutusu
~~~

Bu arxitekturada MAIL01 email mübadiləsini, ESG01 isə email təhlükəsizlik yoxlamalarını həyata keçirir.

## 11. Əlaqəli sənədlər

- [Bölmə 8 — Ümumi README](README.md)
- [8.2 — Email Security Gateway](email-security-gateway.md)
- [8.3 — Anti-Phishing və Sandboxing](anti-phishing-sandboxing.md)
- [8.4 — Phishing Simulyasiyası](phishing-simulation.md)
- [8.5 — Real Domen və SMTP Relay](smtp-relay.md)

## 12. Nəticə

Bölmə 8.1 çərçivəsində MAIL01 üzərində Mailcow əsaslı korporativ email infrastrukturu qurulmuşdur.

Daxili konrderk.test domeni əlavə edilmiş, istifadəçi poçt qutuları yaradılmış və SOGo üzərindən Ayseldən Yusifə email göndərilməsi və qəbulu uğurla yoxlanılmışdır.

Email autentifikasiyası üçün SPF, DKIM və DMARC qeydləri konfiqurasiya edilmiş, DMARC siyasətində p=reject tətbiq olunmuşdur.

CA01 tərəfindən verilmiş daxili sertifikat Mailcow xidmətlərinə tətbiq edilmiş, HTTPS, SMTP STARTTLS, IMAPS və POP3S protokollarında TLS 1.3 və sertifikat etibarlılığı yoxlanılmışdır.

SMTP, IMAP və POP3 xidmətlərində şifrəsiz autentifikasiya bloklanmışdır.

MAIL01 üzərində CIS Ubuntu Linux Level 1 auditi aparılmış, 110 uyğunsuzluq müəyyən edilmiş və onların aradan qaldırılmasının Mailcow xidmətlərinə mümkün təsiri nəzərə alınmışdır.

Beləliklə, email xidmətlərinin qurulması ilə yanaşı, domen autentifikasiyası, nəqliyyat səviyyəsində şifrələmə, təhlükəsiz istifadəçi girişi və əməliyyat sistemi auditi də həyata keçirilmişdir.
