# BÖLMƏ 8 — EMAIL TƏHLÜKƏSİZLİYİ EKOSİSTEMİ

## 1. Məqsəd

Bu bölmədə korporativ elektron poçt infrastrukturunun təhlükəsiz qurulması, email autentifikasiyası, şifrəli kommunikasiya, spam və phishing aşkarlanması, təhlükəsizlik şlüzü, sandbox mühiti və phishing simulyasiyası üzrə həyata keçirilmiş işlər sənədləşdirilmişdir.

Tətbiq olunan müdafiə modeli bir neçə səviyyədən ibarətdir:
1. Mailcow — korporativ email xidmətləri.
2. Proxmox Mail Gateway — email trafikinin yoxlanılması və filtrasiyası.
3. SpamAssassin — spam və phishing indikatorlarının aşkarlanması.
4. Docker Sandbox — şübhəli məzmunun izolyasiya olunmuş analizi.
5. GoPhish — nəzarətli phishing simulyasiyası.

## 2. İnfrastruktur

| Server | IP ünvanı | Texnologiya | Təyinat |
|---|---|---|---|
| MAIL01 | 10.0.0.102 | Mailcow | Korporativ email serveri |
| ESG01 | 10.0.0.103 | Proxmox Mail Gateway | Email təhlükəsizlik şlüzü |
| SANDBOX01 | 10.0.0.104 | Docker, GoPhish | Sandbox və phishing simulyasiyası |

Bu komponentlər P1 — Identity & Mail Security mühitinin tərkibində hazırlanmışdır.

## 3. Tapşırıq 8.1 — Mail Server

MAIL01 üzərində Mailcow email platforması quraşdırıldı. Korporativ istifadəçilər üçün poçt qutuları yaradıldı və SOGo interfeysindən daxili email göndərilməsi və qəbulu yoxlanıldı.

Email domeninin autentifikasiyası üçün SPF, DKIM və DMARC DNS qeydləri konfiqurasiya edildi. DMARC siyasəti p=reject rejimində tətbiq edildi.

Daxili CA sertifikatı Mailcow xidmətlərinə yerləşdirildi. Dörd əsas poçt xidmətində TLS 1.3 əlaqəsi yoxlanıldı. SMTP, IMAP və POP3 üzərində şifrəsiz autentifikasiya cəhdlərinin bloklanması test edildi.

Ubuntu Server üçün CIS Level 1 Server auditi aparıldı və 110 uyğunsuzluq qeydə alındı. Xidmətlərin işləməsinə təsir etməmək üçün avtomatik düzəliş aparılmadı.

## 4. Tapşırıq 8.2 — Email Security Gateway

ESG01 üzərində Proxmox Mail Gateway quraşdırıldı və MAIL01 qarşısında təhlükəsizlik şlüzü kimi yerləşdirildi.

Mailcow serverinə birbaşa SMTP girişini məhdudlaşdırmaq üçün firewall qaydaları tətbiq edildi.

| Bağlantı testi | Nəticə |
|---|---|
| ESG01 → MAIL01, TCP/25 | Uğurlu |
| DC01 → MAIL01, TCP/25 | Bloklandı |

Firewall sayğacında 5 paket və 260 baytın bloklandığı müşahidə edildi.

## 5. Tapşırıq 8.3 — Anti-Phishing və Sandbox

SANDBOX01 üzərində Docker əsaslı izolyasiya olunmuş analiz mühiti hazırlandı.

Proxmox Mail Gateway ilə SANDBOX01 arasında SSH bağlantısı və .eml fayl ötürülməsi yoxlanıldı.

SpamAssassin üçün /etc/mail/spamassassin/custom.cf faylında SOC_PHISHING_URL adlı xüsusi qayda yaradıldı. Qayda soc-phishing-test.invalid laboratoriya domenini aşkarlamaq üçün konfiqurasiya edildi və spam balına +10 əlavə etdi.

Lokal test nəticələri:
- spamassassin --lint — uğurlu;
- X-Spam-Flag: YES;
- Spam score: 12.3;
- PMG statusu: quarantine.

## 6. Tapşırıq 8.4 — Phishing Simulyasiyası

SANDBOX01 üzərində GoPhish v0.12.1 quraşdırıldı və gophish.service xidməti yaradıldı.

SOC_Phishing_Awareness_2026 adlı kampaniya hazırlandı. Email şablonu, landing page, SMTP profili və SOC_phishing istifadəçi qrupu konfiqurasiya edildi.

Kampaniya iki laboratoriya hesabı üzərində başladıldı.

| Göstərici | Nəticə |
|---|---|
| Göndərilmiş email | 2 |
| Şübhəli keçidlə qarşılıqlı əlaqə | 1 istifadəçi |
| Kampaniya statusu | Completed |
| İxrac edilmiş nəticələr | Results CSV, Raw Events CSV |

## 7. Tapşırıq 8.5 — Real Domen və SMTP Relay

Real domen, SMTP relay və email deliverability üzrə testlər layihənin email infrastrukturunun ayrıca mərhələsi kimi aparıldı.

## 8. Texniki sənədlər

- [Mail Server və TLS](mail-server.md)
- [Email Security Gateway](email-security-gateway.md)
- [Anti-Phishing və Sandbox](anti-phishing-sandbox.md)
- [GoPhish Simulyasiyası](phishing-simulation.md)

## 9. Nəticə

Mailcow, Proxmox Mail Gateway, SpamAssassin, Docker Sandbox və GoPhish komponentlərindən ibarət email təhlükəsizliyi mühiti quruldu. Email autentifikasiyası, şifrəli bağlantılar, SMTP giriş məhdudiyyətləri, phishing aşkarlanması, karantin və istifadəçi simulyasiyası üzrə praktiki nəticələr əldə edildi.
