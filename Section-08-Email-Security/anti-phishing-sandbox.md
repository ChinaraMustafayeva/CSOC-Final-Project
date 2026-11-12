# 8.3 — Anti-Phishing və Sandboxing

## Məqsəd
Şübhəli email məzmununun aşkarlanması, laboratoriya nümunələrinin izolyasiya olunmuş mühitdə analizi və phishing indikatoru olan məktubların karantinə yönləndirilməsi.

## İnfrastruktur
| Komponent | Təyinat |
|---|---|
| SANDBOX01 | Docker əsaslı analiz mühiti |
| ESG01 | Proxmox Mail Gateway |
| SpamAssassin | Spam və phishing aşkarlanması |
| SSH | Fayl ötürülməsi |

## Sandbox mühiti
SANDBOX01 üzərində Docker əsaslı izolyasiya olunmuş analiz mühiti hazırlandı. Laboratoriya URL və attachment nümunələrinin statik analizi aparıldı.

Proxmox Mail Gateway ilə SANDBOX01 arasında SSH bağlantısı yoxlanıldı. .eml formatlı email nümunələrinin analiz mühitinə ötürülməsi üçün prototip hazırlandı.

## SpamAssassin qaydası
Konfiqurasiya faylı:

/etc/mail/spamassassin/custom.cf

Xüsusi qaydanın adı:

SOC_PHISHING_URL

Aşkarlanan laboratoriya domeni:

soc-phishing-test.invalid

Bu domen aşkarlandıqda spam balına +10 əlavə ediləcək şəkildə qayda konfiqurasiya edildi.

## Konfiqurasiyanın yoxlanılması
SpamAssassin sintaksisi aşağıdakı komanda ilə yoxlanıldı:

spamassassin --lint

Yoxlama uğurla tamamlandı.

## Phishing testi
Laboratoriya məktubuna aşağıdakı URL daxil edildi:

http://soc-phishing-test.invalid/login

Test nəticələri:

| Göstərici | Nəticə |
|---|---|
| X-Spam-Flag | YES |
| Spam score | 12.3 |
| Aşkarlama qaydası | SOC_PHISHING_URL |
| PMG siyasəti | Quarantine/Mark Spam (Level 3) |
| Yekun status | quarantine |

## Nəticə
SpamAssassin üzərində xüsusi phishing aşkarlama qaydası yaradıldı və test edildi. Laboratoriya phishing URL-i olan məktub aşkarlanaraq Proxmox Mail Gateway tərəfindən karantinə yönləndirildi. Docker əsaslı analiz mühiti və email nümunələrinin ötürülməsi prototipi hazırlandı.
