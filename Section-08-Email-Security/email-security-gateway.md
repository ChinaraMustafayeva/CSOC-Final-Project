# 8.2 — EMAIL SECURITY GATEWAY (ESG)

## 1. Məqsəd və əhatə dairəsi

Bu mərhələdə korporativ email infrastrukturunu qorumaq üçün MAIL01 serverinin qarşısında ayrıca Email Security Gateway qurulmuşdur.

Məqsəd daxil olan email-lərin Mailcow-a çatmazdan əvvəl təhlükəsizlik yoxlamasından keçirilməsi, spam və zərərli əlavələrin aşkarlanması, təhlükəli məktubların karantinə yerləşdirilməsi və Mailcow-un SMTP portuna birbaşa girişin məhdudlaşdırılmasıdır.

Email Security Gateway kimi Proxmox Mail Gateway 9.1 platformasından istifadə edilmişdir.

Əsas işlər:

- ESG01 serverinin quraşdırılması;
- Mailcow ilə SMTP relay marşrutunun yaradılması;
- DNS, MX və PTR qeydlərinin konfiqurasiyası;
- SMTP çatdırılma xətalarının araşdırılması;
- Unbound və DNSSEC problemlərinin həlli;
- SpamAssassin, RBL və Razor2 yoxlamaları;
- ClamAV ilə EICAR antivirus testi;
- Virus Quarantine və Tracking Center yoxlamaları;
- DOCKER-USER firewall vasitəsilə SMTP bypass məhdudiyyəti.

## 8.2.1 — ESG01 serverinin qurulması

### Server infrastrukturu

VMware mühitində ESG01 adlı ayrıca virtual maşın yaradılmış və Proxmox Mail Gateway 9.1 quraşdırılmışdır.

| Parametr | Dəyər |
|---|---|
| Server adı | ESG01 |
| IP ünvanı | 10.0.0.103 |
| Hostname | esg.konrderk.test |
| Platforma | Proxmox Mail Gateway 9.1 |
| CPU | 2 vCPU |
| RAM | 3 GB |
| Disk | 40 GB |
| İdarəetmə portu | TCP 8006 |

İdarəetmə paneli:

https://10.0.0.103:8006

Quraşdırmadan sonra veb idarəetmə panelinə giriş edilmiş və xidmətlərin işləmə vəziyyəti yoxlanılmışdır.

### ESG-nin arxitekturada yerləşməsi

ESG01 Mailcow-dan əvvəl email yoxlamalarını həyata keçirən təhlükəsizlik qatı kimi istifadə edilmişdir.

~~~text
SMTP göndərən
      |
      v
ESG01 — Proxmox Mail Gateway
      |
      | SpamAssassin
      | ClamAV
      | Mail Filter
      v
MAIL01 — Mailcow
      |
      v
İstifadəçi poçt qutusu
~~~

Bu modeldə email təhlükəsizlik yoxlamaları poçt serverindən ayrı platformada aparılır.

## 8.2.2 — ESG və Mailcow arasında SMTP marşrutu

### Relay Domain

Proxmox Mail Gateway idarəetmə panelində aşağıdakı bölmədən istifadə edilmişdir:

Configuration → Mail Proxy

konrderk.test domeni Relay Domain kimi əlavə edilmişdir.

### Relay parametrləri

| Parametr | Dəyər |
|---|---|
| Relay Domain | konrderk.test |
| Default Relay | 10.0.0.102 |
| Relay Port | 25 |
| Xarici SMTP portu | 25 |
| Daxili SMTP portu | 26 |

ESG01 daxil olan məktubları təhlükəsizlik yoxlamasından sonra MAIL01-in SMTP xidmətinə ötürmək üçün konfiqurasiya edilmişdir.

### DNS konfiqurasiyası

DC01 DNS serverində aşağıdakı qeydlər yaradılmışdır:

- esg.konrderk.test üçün A qeydi;
- konrderk.test üçün ESG01-ə yönləndirilmiş MX qeydi.

MX qeydi aşağıdakı məntiqə uyğun qurulmuşdur:

~~~dns
konrderk.test. IN MX 10 esg.konrderk.test.
~~~

DNS nəticələri dig sorğuları ilə yoxlanılmışdır.

### SMTP bağlantısının yoxlanılması

ESG01 serverindən MAIL01-in TCP/25 portuna bağlantı testi aparılmışdır:

~~~bash
nc -vz -w 5 10.0.0.102 25
~~~

**Nəticə:** MAIL01-in SMTP portuna ESG01-dən bağlantı uğurlu olmuşdur.

## 8.2.3 — İlkin SMTP xətalarının araşdırılması

### Birinci problem: Sender domain tapılmır

İlkin test məktublarında ESG01 email-i qəbul etsə də, MAIL01 çatdırılmanı rədd etmişdir.

Alınan xəta:

~~~text
450 4.1.8 Sender address rejected: Domain not found
~~~

Araşdırma zamanı test göndəricisi kimi istifadə edilən external.test domeninin DNS-də mövcud olmadığı müəyyən edilmişdir.

Bu vəziyyət göndərən domenin DNS yoxlamasından keçməməsinə səbəb olmuşdur.

### İkinci problem: 554 5.7.1

Sonrakı testdə aşağıdakı SMTP xətası müşahidə edilmişdir:

~~~text
554 5.7.1
~~~

Rspamd loglarında məktubun 18.80 spam balı topladığı müəyyən edilmişdir.

| Parametr | Nəticə |
|---|---|
| SMTP xətası | 554 5.7.1 |
| Spam balı | 18.80 |
| Analiz sistemi | Rspamd |

Problemin əsas amilləri:

- DNS yoxlamaları;
- MX qeydləri;
- PTR və reverse DNS;
- Göndərici autentifikasiyası.

### Həll yanaşması

Problemi aradan qaldırmaq üçün təhlükəsizlik filtrləri deaktiv edilməmişdir.

Bunun əvəzinə DNS və mail marşrutlaşdırma konfiqurasiyası araşdırılmışdır.

Bu yanaşma email təhlükəsizlik nəzarətlərini qoruyaraq infrastruktur problemlərinin aradan qaldırılmasına imkan vermişdir.

## 8.2.4 — Unbound DNS və reverse DNS problemlərinin həlli

### Problemin müəyyən edilməsi

Mailcow-un Unbound konteynerində konrderk.test domeni üçün MX sorğuları düzgün cavab qaytarmırdı.

Eyni sorğu DC01 DNS serverinə birbaşa göndərildikdə MX qeydi görünürdü.

Bu fərq problemin DNS resolver konfiqurasiyası ilə bağlı olduğunu göstərmişdir.

### Səbəb

Araşdırma nəticəsində aşağıdakı hallar müəyyən edilmişdir:

1. Unbound .test zonasını lokal qəbul edirdi.
2. Daxili laboratoriya domeni üçün DNSSEC doğrulaması problem yaradırdı.
3. Mailcow-un DNS sorğuları DC01-dəki daxili DNS qeydlərindən düzgün istifadə etmirdi.

### Forward-zone konfiqurasiyası

konrderk.test domeninə aid sorğuların DC01-ə yönləndirilməsi üçün Unbound konfiqurasiyası dəyişdirilmişdir.

~~~text
forward-zone:
    name: "konrderk.test."
    forward-addr: 192.168.100.10
~~~

### Lokal zona və DNSSEC konfiqurasiyası

Daxili laboratoriya domeni üçün aşağıdakı parametrlər tətbiq edilmişdir:

~~~text
server:
    local-zone: "test." nodefault
    domain-insecure: "konrderk.test."
~~~

Bu dəyişikliklərlə:

- .test zonasının lokal emal davranışı dəyişdirilmişdir;
- konrderk.test sorğuları DC01 DNS serverinə yönləndirilmişdir;
- yalnız daxili konrderk.test domeni üçün DNSSEC istisnası tətbiq edilmişdir.

### Yoxlama

Konfiqurasiya yoxlanılmış və Unbound xidməti yenidən başladılmışdır.

MX sorğusunun nəticəsi:

~~~text
Status: NOERROR
MX: 10 esg.konrderk.test
~~~

Bu nəticə daxili MX qeydinin Unbound vasitəsilə düzgün həll edildiyini göstərmişdir.

### Reverse DNS

ESG01 üçün reverse DNS zonasında PTR qeydi yaradılmışdır.

Daha sonra A və PTR sorğuları yoxlanılmışdır.

### Təhlükəsizlik filtrlərinin saxlanılması

DNS problemləri həll edildikdən sonra da saxta göndəricilərdən istifadə olunan bəzi test məktubları SPF və DMARC yoxlamaları səbəbindən rədd edilmişdir.

Bu davranışa görə SPF və DMARC təhlükəsizlik siyasətləri zəiflədilməmişdir.

## 8.2.5 — Spam filtrinin aktivləşdirilməsi və yoxlanılması

### Spam Detector

Proxmox Mail Gateway-də Spam Detector bölməsi yoxlanılmışdır.

Aşağıdakı mexanizmlərin aktiv olduğu təsdiqlənmişdir:

- RBL yoxlamaları;
- Razor2 yoxlamaları;
- SpamAssassin analizi.

Heuristic Score dəyəri 3 olaraq müəyyən edilmişdir.

### swaks alətinin quraşdırılması

SMTP testlərini həyata keçirmək üçün swaks alətindən istifadə edilmişdir.

Quraşdırma zamanı Proxmox Enterprise repozitoriyası abunəlik olmadığına görə aşağıdakı xəta vermişdir:

~~~text
401 Unauthorized
~~~

Enterprise repozitoriyası deaktiv edildikdən sonra paket uğurla quraşdırılmışdır.

### Spam analizi testi

ESG01-ə test məktubu göndərilmişdir.

Gateway məktubu qəbul etmiş və SpamAssassin analizi aparmışdır.

Nəticə:

~~~text
SA score=0/5
~~~

Bu test məktubun spam yoxlamasından keçirildiyini və filtrin işlədiyini göstərmişdir.

**Nəticə:** ESG01 üzərində spam analizi aktiv vəziyyətdədir.

## 8.2.6 — Antivirus və EICAR testinin bloklanması

### ClamAV antivirus xidməti

Proxmox Mail Gateway-də ClamAV antivirus funksiyası yoxlanılmışdır.

Virus Detector parametrləri:

| Parametr | Dəyər |
|---|---|
| Antivirus | ClamAV |
| Maksimum fayl ölçüsü | 25 MB |
| Maksimum skan ölçüsü | 100 MB |
| Antivirus imzaları | Təxminən 3.64 milyon |

clamav-daemon xidmətinin işlək olduğu təsdiqlənmişdir.

### EICAR testi

Antivirusun zərərli fayl nümunəsini aşkarlamasını yoxlamaq üçün standart EICAR test faylından istifadə edilmişdir.

Fayl clamscan ilə yoxlanılmışdır.

Nəticə:

~~~text
Eicar-Test-Signature FOUND
~~~

Bu nəticə ClamAV mühərrikinin EICAR test imzasını aşkarladığını göstərmişdir.

### Email əlavəsinin yoxlanılması

EICAR nümunəsi email əlavəsi kimi göndərilmiş və ESG üzərindən analiz edilmişdir.

ESG loglarında aşağıdakı qeydlər müşahidə edilmişdir:

~~~text
virus detected: Eicar-Test-Signature
rule: Block Viruses
~~~

### Karantin nəticəsi

EICAR nümunəsi daşıyan məktub:

1. ESG tərəfindən qəbul edilmişdir.
2. ClamAV ilə analiz edilmişdir.
3. EICAR imzası aşkarlanmışdır.
4. Block Viruses qaydasına uyğun emal edilmişdir.
5. MAIL01-ə ötürülməmişdir.
6. Virus Quarantine bölməsinə yerləşdirilmişdir.

Tracking Center bölməsində məktubun karantin statusu yoxlanılmışdır.

**Nəticə:** EICAR nümunəsi daşıyan email əlavəsi ESG tərəfindən aşkarlanmış, bloklanmış və karantinə yerləşdirilmişdir.

## 8.2.7 — ESG-dən yan keçən SMTP bağlantılarının bloklanması

### Problemin müəyyən edilməsi

İlkin yoxlamada MAIL01 üzərində Docker-in SMTP TCP/25 portunu bütün şəbəkə interfeyslərində yayımladığı müşahidə edilmişdir.

Bu konfiqurasiya başqa mənbələrin ESG01-dən keçmədən birbaşa Mailcow SMTP xidmətinə qoşulması riskini yaradırdı.

### Postfix konteyneri

Araşdırma zamanı Postfix konteynerinin daxili Docker IP ünvanı müəyyən edilmişdir:

~~~text
172.22.1.253
~~~

### DOCKER-USER firewall siyasəti

MAIL01 üzərində Docker trafikinə tətbiq olunan DOCKER-USER firewall zəncirində SMTP giriş məhdudiyyəti yaradılmışdır.

Qaydanın məntiqi:

- ESG01 mənbə IP-si olan 10.0.0.103 üçün TCP/25 trafikinə icazə vermək;
- Digər mənbələrdən gələn birbaşa TCP/25 bağlantılarını bloklamaq.

İstifadəçilərin autentifikasiyalı email göndərməsi üçün istifadə olunan TCP/465 və TCP/587 portlarına toxunulmamışdır.

### Mənbə əsaslı bağlantı testi

| Mənbə | Təyinat | Port | Nəticə |
|---|---|---|---|
| ESG01 — 10.0.0.103 | MAIL01 — 10.0.0.102 | TCP 25 | Uğurlu |
| DC01 — 192.168.100.10 | MAIL01 — 10.0.0.102 | TCP 25 | Bloklandı |

### Firewall sayğacı

Bloklanan trafik firewall sayğacında müşahidə edilmişdir.

~~~text
Packets: 5
Bytes: 260
~~~

Bu nəticə test edilmiş IPv4 şəbəkə marşrutunda ESG-dən yan keçən SMTP bağlantısının bloklandığını göstərmişdir.

### Təhlükəsizlik əhəmiyyəti

Bu məhdudiyyət email təhlükəsizlik arxitekturasında mühüm rol oynayır.

Əgər SMTP trafiki birbaşa MAIL01-ə çata bilsəydi, ESG01 üzərindəki spam və antivirus yoxlamalarından yan keçmək mümkün olardı.

DOCKER-USER qaydaları ilə test edilmiş marşrutda bu risk məhdudlaşdırılmışdır.

## 9. Praktiki test nəticələrinin xülasəsi

| № | Test | Nəticə |
|---|---|---|
| 1 | ESG01 serverinin qurulması | Tamamlandı |
| 2 | Proxmox Mail Gateway 9.1 | Quraşdırıldı |
| 3 | İdarəetmə paneli | TCP 8006 üzərindən açıldı |
| 4 | Relay Domain | konrderk.test |
| 5 | Default Relay | 10.0.0.102:25 |
| 6 | DNS MX | ESG01-ə yönləndirildi |
| 7 | ESG01 → MAIL01 SMTP | Uğurlu |
| 8 | Unbound forward-zone | DC01 DNS-ə yönləndirildi |
| 9 | DNSSEC istisnası | Daxili domen üçün tətbiq edildi |
| 10 | MX sorğusu | NOERROR |
| 11 | Reverse DNS | PTR qeydi yaradıldı |
| 12 | RBL və Razor2 | Aktiv |
| 13 | SpamAssassin | SA score=0/5 |
| 14 | ClamAV | Aktiv |
| 15 | EICAR clamscan | FOUND |
| 16 | EICAR email əlavəsi | Bloklandı |
| 17 | Virus Quarantine | Təsdiqləndi |
| 18 | ESG01 → MAIL01:25 | İcazə verildi |
| 19 | DC01 → MAIL01:25 | Bloklandı |
| 20 | Firewall sayğacı | 5 paket / 260 bayt |

## 10. Əlaqəli sənədlər

- [Bölmə 8 — Ümumi README](README.md)
- [8.1 — Mail Server İnfrastrukturu](mail-server.md)
- [8.3 — Anti-Phishing və Sandboxing](anti-phishing-sandboxing.md)
- [8.4 — Phishing Simulyasiyası](phishing-simulation.md)
- [8.5 — Real Domen və SMTP Relay](smtp-relay.md)

## 11. Nəticə

Bölmə 8.2 çərçivəsində ESG01 üzərində Proxmox Mail Gateway 9.1 quraşdırılmış və MAIL01 Mailcow serveri ilə SMTP relay inteqrasiyası həyata keçirilmişdir.

konrderk.test domeninin MX qeydi ESG01-ə yönləndirilmiş, SMTP relay marşrutu qurulmuş və ESG01-dən MAIL01-ə TCP/25 bağlantısı uğurla yoxlanılmışdır.

İlkin SMTP çatdırılma problemləri DNS, MX, PTR, SPF və DMARC yoxlamaları əsasında araşdırılmışdır. Mailcow-un Unbound konfiqurasiyasında daxili domen üçün forward-zone və DNSSEC istisnası tətbiq edilərək MX sorğularının düzgün işləməsi təmin edilmişdir.

Proxmox Mail Gateway-də spam filtri yoxlanılmış, SpamAssassin analizinin işlədiyi təsdiqlənmişdir.

ClamAV antivirusu EICAR test nümunəsini aşkarlamış, təhlükəli əlavə daşıyan email Block Viruses qaydası ilə bloklanaraq Virus Quarantine bölməsinə yerləşdirilmişdir.

MAIL01 üzərində DOCKER-USER firewall qaydaları vasitəsilə yalnız ESG01 mənbəyindən gələn SMTP TCP/25 trafikinə icazə verilmiş, DC01-dən birbaşa SMTP bağlantısı bloklanmışdır.

Beləliklə, email trafiki üçün ayrıca təhlükəsizlik yoxlama qatı, antivirus karantini və SMTP bypass məhdudiyyəti praktik testlərlə təsdiqlənmişdir.
