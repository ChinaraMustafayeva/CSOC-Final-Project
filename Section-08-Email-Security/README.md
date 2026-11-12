# BÖLMƏ 8 — EMAIL SECURITY

## 1. Ümumi məlumat

Bu bölmədə CSOC layihəsi çərçivəsində korporativ email infrastrukturu qurulmuş, email autentifikasiyası və şifrələnməsi tətbiq edilmiş, zərərli məktubların yoxlanılması üçün Email Security Gateway və izolyasiya olunmuş analiz mühiti hazırlanmışdır.

İstifadəçilərin phishing hücumlarına reaksiyasını qiymətləndirmək üçün GoPhish ilə nəzarətli simulyasiya keçirilmişdir.

Layihənin əsas istiqamətləri:

- 8.1 — Mail Server İnfrastrukturu
- 8.2 — Email Security Gateway
- 8.3 — Anti-Phishing və Sandboxing
- 8.4 — Phishing Simulyasiyası
- 8.5 — Real Domen, SMTP Relay və Email

8.5 hissəsi əsas tapşırıqda ayrıca tələb olunmayan, lakin layihə çərçivəsində həyata keçirilmiş əlavə işdir.

## 2. İnfrastruktur

| Server | IP ünvanı | Texnologiya | Təyinat |
|---|---|---|---|
| MAIL01 | 10.0.0.102 | Ubuntu Server 24.04, Mailcow | Korporativ email |
| ESG01 | 10.0.0.103 | Proxmox Mail Gateway 9.1 | Spam və antivirus yoxlaması |
| SANDBOX01 | 10.0.0.104 | Ubuntu Server 24.04, Docker | URL və fayl analizi |
| SANDBOX01 | 10.0.0.104 | GoPhish v0.12.1 | Phishing simulyasiyası |
| DC01 | 192.168.100.10 | Active Directory DNS | Daxili DNS qeydləri |
| CA01 | 192.168.100.40 | CORP-ROOT-CA | TLS sertifikatlarının verilməsi |

MAIL01 serverinin daxili şəbəkədə 192.168.100.60/24 ünvanı da konfiqurasiya edilmişdir.

Daxili email domeni: konrderk.test

Mail serverin DNS adı: mail.konrderk.test

## 3. Bölmə 8.1 — Mail Server İnfrastrukturu

### 3.1. Mailcow platformasının qurulması

MAIL01 üzərində Docker və Docker Compose quraşdırılmışdır.

Mailcow /opt/mailcow-dockerized qovluğuna yerləşdirilmiş və mail.konrderk.test adı ilə konfiqurasiya edilmişdir.

Əsas komponentlər:

- Postfix — SMTP xidməti;
- Dovecot — IMAP və POP3 xidmətləri;
- Nginx — veb interfeys;
- Rspamd — spam analizi;
- ClamAV — antivirus;
- SOGo — istifadəçi webmail interfeysi;
- Unbound — DNS xidməti.

Quraşdırmadan sonra 18 Docker konteynerinin işlədiyi yoxlanılmışdır.

Mailcow-un antivirus və digər xidmətlərinin stabil işləməsi üçün RAM 4 GB-dan 8 GB-a artırılmışdır.

### 3.2. Email hesabları və daxili məktub testi

konrderk.test domeni Mailcow-a əlavə edilmişdir.

İki poçt qutusu yaradılmışdır:

- aysel@konrderk.test
- yusif@konrderk.test

SOGo interfeysində Ayselin hesabından Yusifə Konrderk Mail Test mövzulu məktub göndərilmişdir.

Məktubun Yusifin Inbox qovluğuna çatması və məzmununun oxunması təsdiqlənmişdir.

### 3.3. SPF, DKIM və DMARC

Email domeninin autentifikasiyası üçün DNS qeydləri yaradılmışdır.

**SPF:**

~~~text
v=spf1 ip4:192.168.100.60 -all
~~~

**DKIM:**

Mailcow-un 2048 bitlik DKIM public key məlumatı dkim._domainkey.konrderk.test TXT qeydinə əlavə edilmişdir.

**DMARC:**

~~~text
v=DMARC1; p=reject; pct=100; adkim=s; aspf=s
~~~

SPF, DKIM və DMARC qeydləri DNS sorğuları ilə yoxlanılmışdır.

### 3.4. Daxili CA sertifikatı və TLS

CA01 üzərində CORP-ROOT-CA tərəfindən MAIL01 üçün sertifikat verilmişdir.

Sertifikat Mailcow xidmətlərinə tətbiq edilmişdir.

| Xidmət | Port | Nəticə |
|---|---|---|
| HTTPS | 443 | TLS 1.3 |
| SMTP STARTTLS | 587 | TLS 1.3 |
| IMAPS | 993 | TLS 1.3 |
| POP3S | 995 | TLS 1.3 |

Testlərdə TLS_AES_256_GCM_SHA384 şifrələmə dəsti və Verification: OK nəticəsi əldə edilmişdir.

### 3.5. Şifrəsiz autentifikasiyanın bloklanması

SMTP, IMAP və POP3 protokollarında şifrəsiz istifadəçi autentifikasiyası ayrıca yoxlanılmışdır.

- SMTP: TLS aktiv olmadan AUTH imkanı təqdim edilməmişdir.
- IMAP: Şifrəsiz giriş NO [PRIVACYREQUIRED] cavabı ilə bloklanmışdır.
- POP3: Şifrəsiz giriş Plaintext authentication disallowed on non-secure connections cavabı ilə rədd edilmişdir.

### 3.6. CIS Benchmark auditi

MAIL01 serverində CIS Ubuntu Linux Level 1 audit yoxlaması aparılmışdır.

Audit nəticəsində 110 uyğunsuzluq müəyyən edilmişdir.

Mailcow xidmətlərinin işləməsinə mümkün təsir nəzərə alınaraq sərtləşdirmə dəyişiklikləri ayrıca qiymətləndirilmişdir.

## 4. Bölmə 8.2 — Email Security Gateway

### 4.1. ESG01 və Proxmox Mail Gateway

ESG01 üzərində Proxmox Mail Gateway 9.1 quraşdırılmışdır.

İdarəetmə ünvanı:

https://10.0.0.103:8006

Server parametrləri:

| Parametr | Dəyər |
|---|---|
| CPU | 2 vCPU |
| RAM | 3 GB |
| Disk | 40 GB |
| Hostname | esg.konrderk.test |

### 4.2. SMTP marşrutlaşdırılması

konrderk.test domeni ESG üzərində Relay Domain kimi əlavə edilmişdir.

Email axını aşağıdakı prinsiplə təşkil edilmişdir:

~~~text
SMTP göndərən
      |
      v
ESG01 — Proxmox Mail Gateway
      |
      | Spam və antivirus yoxlaması
      v
MAIL01 — Mailcow
      |
      v
İstifadəçi poçt qutusu
~~~

### 4.3. Spam filtri

Proxmox Mail Gateway-də spam filtrləmə aktivləşdirilmiş və test məktubları üzərində analiz yoxlanılmışdır.

### 4.4. EICAR antivirus testi

ClamAV antivirus xidməti yoxlanılmışdır.

EICAR test nümunəsi analiz edilmiş və Eicar-Test-Signature FOUND nəticəsi alınmışdır.

ESG loglarında aşağıdakı nəticələr qeydə alınmışdır:

- virus detected: Eicar-Test-Signature;
- rule: Block Viruses.

EICAR nümunəsi daşıyan məktub MAIL01-ə ötürülməmiş, Virus Quarantine bölməsinə yerləşdirilmişdir.

### 4.5. ESG bypass məhdudiyyəti

MAIL01 üzərində Docker-in SMTP TCP/25 portuna birbaşa giriş riskini azaltmaq üçün DOCKER-USER firewall qaydaları tətbiq edilmişdir.

| Bağlantı | Nəticə |
|---|---|
| ESG01 → MAIL01:25 | İcazə verildi |
| DC01 → MAIL01:25 | Bloklandı |

Firewall sayğacında 5 paket və 260 bayt bloklanmış trafik qeydə alınmışdır.

Bu test ESG-dən yan keçən SMTP bağlantısının yoxlanılmış IPv4 marşrutunda bloklandığını təsdiqləmişdir.

## 5. Bölmə 8.3 — Anti-Phishing və Sandboxing

### 5.1. SANDBOX01

SANDBOX01 üzərində Docker əsaslı izolyasiya olunmuş analiz mühiti yaradılmışdır.

Docker şəbəkəsinin adı:

soc-sandbox-net

Tətbiq edilmiş məhdudiyyətlər:

- Daxili Docker şəbəkəsi;
- Konteyner imtiyazlarının məhdudlaşdırılması;
- Read-only fayl sistemi;
- Yaddaş və proses limitləri;
- Xarici şəbəkəyə çıxışın məhdudlaşdırılması.

Şəbəkə yoxlamasında Internal=true nəticəsi alınmışdır.

Xarici 1.1.1.1 ünvanına bağlantı cəhdində Network unreachable nəticəsi əldə edilmişdir.

### 5.2. Şübhəli URL və attachment analizi

Şübhəli URL-lərin və email əlavələrinin əsas serverlərdən ayrılmış mühitdə yoxlanılması üçün analiz testləri aparılmışdır.

### 5.3. Phishing qaydaları və karantin

Proxmox Mail Gateway üzərində phishing aşkarlanması və karantin mexanizmləri konfiqurasiya edilmişdir.

SpamAssassin üçün xüsusi SOC_PHISHING_URL qaydası hazırlanmışdır.

Test domeni:

soc-phishing-test.invalid

Qayda üçün spam balı +10 təyin edilmişdir.

Test nəticələri:

| Göstərici | Nəticə |
|---|---|
| Xüsusi qayda | SOC_PHISHING_URL |
| Əlavə spam balı | +10 |
| Yekun spam balı | 12.3 |
| X-Spam-Flag | YES |
| Nəticə | PMG karantini |

### 5.4. ESG və Sandbox inteqrasiyası

ESG01 ilə SANDBOX01 arasında SSH əsaslı email analiz prototipi hazırlanmışdır.

Email fayllarının .eml formatında ötürülməsi və analiz skripti vasitəsilə yoxlanılması üzərində iş aparılmışdır.

## 6. Bölmə 8.4 — Phishing Simulyasiyası

### 6.1. GoPhish quraşdırılması

SANDBOX01 üzərində GoPhish v0.12.1 quraşdırılmışdır.

Quraşdırma qovluğu:

/opt/gophish

GoPhish üçün systemd xidməti yaradılmışdır:

gophish.service

Xidmətin enabled və active (running) vəziyyətində olduğu yoxlanılmışdır.

### 6.2. Kampaniyanın hazırlanması

Laboratoriya istifadəçiləri üçün phishing email şablonu, landing page, hədəf qrupu və SMTP profili hazırlanmışdır.

Kampaniya adı:

SOC_Phishing_Awareness_2026

Simulyasiya ünvanı:

http://10.0.0.104

### 6.3. Kampaniya nəticələri

| Göstərici | Nəticə |
|---|---|
| Göndərilən məktub | 2 |
| Linkə klik edən istifadəçi | 1 |
| Form göndərən istifadəçi | 1 |
| Klik faizi | 50% |
| Forma göndərmə faizi | 50% |
| Kampaniya statusu | Completed |

Test zamanı Yusif məktubdakı keçidə klik etmiş və laboratoriya səhifəsində saxta test kodu göndərmişdir.

Aysel məktubu açmış, lakin keçidə klik etməmiş və məlumat göndərməmişdir.

### 6.4. Maarifləndirmə nəticələri

Simulyasiya nəticələrinə əsasən aşağıdakı mövzularda istifadəçi maarifləndirilməsi ehtiyacı müəyyən edilmişdir:

- Göndərən ünvanının yoxlanılması;
- Şübhəli keçidlərə klik edilməməsi;
- Giriş məlumatlarının naməlum formalara daxil edilməməsi;
- Şübhəli email-lərin təhlükəsizlik komandasına bildirilməsi.

Kampaniyanın Results CSV və Raw Events CSV məlumatları ixrac edilmişdir.

## 7. Bölmə 8.5 — Real Domen və SMTP Relay

Bu hissə əsas tapşırıqdan əlavə həyata keçirilmiş praktik işdir.

### 7.1. Real domen

konrderk.com real domeni əldə edilmişdir.

SMTP relay üçün aşağıdakı subdomen seçilmişdir:

send.konrderk.com

DNS üzərində domen təsdiqi, DKIM və DMARC qeydləri konfiqurasiya edilmişdir.

### 7.2. Brevo SMTP Relay

Mailcow Brevo Transactional Email xidməti ilə inteqrasiya edilmişdir.

| Parametr | Dəyər |
|---|---|
| SMTP Relay | smtp-relay.brevo.com |
| Port | 587 |
| Göndərən | security@send.konrderk.com |

Gmail hesabına real test məktubu göndərilmiş və Inbox qovluğuna çatması təsdiqlənmişdir.

### 7.3. Mail-Tester nəticələri

| Test | Bal |
|---|---|
| İlkin test | 5.9/10 |
| Təkrar test | 5.8/10 |

SPF PASS və DKIM VALID nəticələri əldə edilmişdir.

Çatdırılma keyfiyyətinə təsir edən domen reputasiyası, relay IP reputasiyası və tracking pixel xəbərdarlıqları da müəyyən edilmişdir.

CGNAT səbəbindən internetdən Mailcow-a birbaşa email qəbulu bu mərhələdə qurulmamışdır. Xaricə Brevo SMTP Relay vasitəsilə məktub göndərilməsi isə uğurla yoxlanılmışdır.

## 8. Yekun nəticələr

| İstiqamət | Tətbiq edilmiş həll | Praktiki nəticə |
|---|---|---|
| Mail Server | Mailcow | Daxili email mübadiləsi uğurlu |
| Email Authentication | SPF, DKIM, DMARC | DNS qeydləri yoxlanıldı |
| TLS | Daxili CA sertifikatı | Dörd protokolda TLS 1.3 |
| Plaintext Auth | Postfix, Dovecot | Şifrəsiz giriş bloklandı |
| Security Audit | CIS Benchmark | 110 uyğunsuzluq müəyyən edildi |
| Email Gateway | Proxmox Mail Gateway | SMTP marşrutu və spam filtri |
| Antivirus | ClamAV | EICAR bloklandı |
| SMTP Firewall | DOCKER-USER | ESG bypass testi bloklandı |
| Sandboxing | Docker | İzolyasiya yoxlanıldı |
| Anti-Phishing | SpamAssassin, PMG | Phishing test məktubu karantinə düşdü |
| Phishing Simulation | GoPhish | 2 göndərildi, 1 klik, 1 forma |
| SMTP Relay | Brevo | Gmail Inbox-a məktub çatdı |

## 9. Əlaqəli texniki sənədlər

- [8.1 — Mail Server İnfrastrukturu](mail-server.md)
- [8.2 — Email Security Gateway](email-security-gateway.md)
- [8.3 — Anti-Phishing və Sandboxing](anti-phishing-sandboxing.md)
- [8.4 — Phishing Simulyasiyası](phishing-simulation.md)
- [8.5 — Real Domen və SMTP Relay](smtp-relay.md)

## 10. Nəticə

Bölmə 8 çərçivəsində korporativ email xidmətləri üçün çoxqatlı təhlükəsizlik infrastrukturu qurulmuşdur.

MAIL01 üzərində Mailcow vasitəsilə daxili email mübadiləsi təmin edilmiş, SPF, DKIM və DMARC siyasətləri yaradılmış, daxili CA sertifikatı ilə TLS bağlantıları qorunmuş və şifrəsiz autentifikasiya bloklanmışdır.

ESG01 üzərində Proxmox Mail Gateway vasitəsilə spam və antivirus yoxlamaları tətbiq edilmiş, EICAR nümunəsi bloklanmış və birbaşa SMTP bağlantısının ESG-dən yan keçməsi firewall qaydaları ilə məhdudlaşdırılmışdır.

SANDBOX01 üzərində izolyasiya olunmuş analiz mühiti hazırlanmış, xüsusi phishing aşkarlama qaydası və karantin mexanizmi yoxlanılmışdır.

GoPhish vasitəsilə iki laboratoriya istifadəçisi üzərində phishing simulyasiyası aparılmış, klik və forma göndərmə nəticələri qeydə alınmışdır.

Əlavə olaraq real domen və Brevo SMTP Relay inteqrasiyası həyata keçirilmiş, Gmail-ə real məktub çatdırılması təsdiqlənmişdir.
