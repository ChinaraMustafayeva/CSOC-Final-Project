# DNS Təhlükəsizlik Konfiqurasiyası — CSOC Final Project

## 1. Ümumi məlumat

Bu sənəddə CSOC Final Project çərçivəsində istifadə edilən real domenin DNS təhlükəsizlik qeydləri təsvir olunur.

- Domen: konrderk.com
- E-poçt subdomeni: send.konrderk.com
- DNS provayderi: Namecheap
- SMTP Relay xidməti: Brevo
- Əlaqəli server: MAIL01 (Mailcow)

## 2. DNS qeydləri

| Qeyd növü | Təyinatı | Konfiqurasiya |
|---|---|---|
| CNAME | Brevo DKIM autentifikasiyası — 1-ci qeyd | Konfiqurasiya edilib, dəyər gizlədilib |
| CNAME | Brevo DKIM autentifikasiyası — 2-ci qeyd | Konfiqurasiya edilib, dəyər gizlədilib |
| TXT | E-poçt subdomeni üçün DMARC siyasəti | p=none, hesabat ünvanı gizlədilib |
| TXT | Brevo domen təsdiqi | Konfiqurasiya edilib, təsdiq dəyəri gizlədilib |

Bu dörd qeyd Namecheap Advanced DNS panelində müşahidə edilib.

## 3. E-poçt autentifikasiyası

### DKIM
E-poçt autentifikasiyası üçün Brevo xidmətinə aid iki DKIM CNAME qeydi əlavə edilib.

### DMARC
E-poçt subdomeni üçün monitorinq rejimində (p=none) DMARC TXT qeydi konfiqurasiya edilib.

### SPF
Layihə hesabatında SPF PASS test nəticəsi qeyd olunub. SPF DNS qeydinin dəqiq dəyəri təqdim edilən ekran görüntüsündə görünmür.

## 4. Test nəticələri


- Gmail ünvanına test məktubu göndərilib.
- SPF: PASS
- DKIM: VALID
- Mail-Tester nəticəsi: 5.9/10

## 5. Təhlükəsizlik tədbirləri

- DNS qeydlərinin tam dəyərləri ehtiyat məqsədilə gizlədilib.
- SMTP parolları, API açarları, giriş tokenləri və şəxsi açarlar GitHub-a əlavə edilməyib.
- Bu sənəd DNS konfiqurasiyasının təhlükəsizləşdirilmiş təsviridir, birbaşa tətbiq edilən konfiqurasiya faylı deyil.

