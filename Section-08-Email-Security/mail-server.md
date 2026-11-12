# 8.1 — Mail Server İnfrastrukturu

## Məqsəd
Korporativ email xidmətinin qurulması, göndərilən məktubların autentifikasiyası və poçt protokollarında şifrəli əlaqənin təmin edilməsi.

## İnfrastruktur
| Komponent | Məlumat |
|---|---|
| Server | MAIL01 |
| IP | 10.0.0.102 |
| Email platforması | Mailcow |
| Veb poçt interfeysi | SOGo |
| Sertifikat infrastrukturu | CA01 |

## Tətbiq mərhələləri
1. MAIL01 virtual serveri hazırlandı.
2. Mailcow email platforması quraşdırıldı.
3. Korporativ istifadəçilər üçün poçt qutuları yaradıldı.
4. SOGo üzərindən daxili məktub göndərilməsi və qəbulu yoxlanıldı.
5. SPF və DKIM DNS qeydləri konfiqurasiya edildi.
6. DMARC siyasəti p=reject rejimində tətbiq edildi.
7. CA01-dən alınmış daxili sertifikat Mailcow-a yerləşdirildi.
8. SMTP, IMAP və POP3 xidmətlərində şifrəli əlaqələr test edildi.

## Email autentifikasiyası
| Mexanizm | Tətbiq |
|---|---|
| SPF | Göndərməyə icazəli poçt serverlərinin DNS-də müəyyənləşdirilməsi |
| DKIM | Email mesajlarının kriptoqrafik imzalanması |
| DMARC | p=reject siyasəti |

## TLS testləri
Dörd əsas poçt xidmətində TLS 1.3 bağlantısı yoxlanıldı. Şifrəsiz autentifikasiya cəhdləri SMTP, IMAP və POP3 üzərində sınaqdan keçirildi və bloklanma nəticələri qeydə alındı.

## CIS Benchmark
Ubuntu Server üçün CIS Level 1 Server auditi aparıldı.

| Göstərici | Nəticə |
|---|---|
| Audit | CIS Level 1 Server |
| Aşkarlanmış uyğunsuzluqlar | 110 |
| Avtomatik düzəliş | Tətbiq edilmədi |

Avtomatik düzəliş Mailcow xidmətlərinin fəaliyyətinə təsir göstərə biləcəyi üçün audit nəticələri sənədləşdirildi.

## Nəticə
Mailcow üzərində daxili email mübadiləsi, SPF/DKIM/DMARC autentifikasiyası, TLS 1.3 əlaqələri və şifrəsiz giriş məhdudiyyətləri konfiqurasiya və test edildi.
