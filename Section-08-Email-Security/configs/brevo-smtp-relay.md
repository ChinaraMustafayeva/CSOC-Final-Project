# Brevo SMTP Relay — Configuration Documentation

## Layihə
CSOC Final Project — Section 08: Email Security

## İstifadə olunan sistemlər
- Mail Server: MAIL01 (Mailcow)
- SMTP Relay Provider: Brevo
- Əsas domen: konrderk.com
- Relay subdomain: send.konrderk.com
- DNS Provider: Namecheap BasicDNS

## Konfiqurasiya
- Brevo Transactional Email xidməti aktivləşdirilib.
- Mailcow ilə Brevo SMTP Relay inteqrasiyası aparılıb.
- Domen təsdiqi üçün DNS qeydləri əlavə edilib.
- DKIM üçün iki CNAME qeydi yaradılıb.
- DMARC TXT qeydi əlavə edilib.
- SMTP autentifikasiya məlumatları repoya daxil edilməyib.

## Hesabatda qeyd edilən test nəticələri
- Gmail-ə real test məktubu göndərilib.
- SPF: PASS
- DKIM: VALID
- Mail-Tester: 5.9/10

## Təhlükəsizlik
Heç bir SMTP parolu, API açarı və ya token saxlanılmır.
