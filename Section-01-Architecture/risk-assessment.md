# 1.2 — RİSK QİYMƏTLƏNDİRİLMƏSİ VƏ MÜDAFİƏ TƏDBİRLƏRİ

## Məqsəd

CSOC infrastrukturu üçün müəyyən edilmiş təhdidlərin ehtimal və potensial təsir əsasında qiymətləndirilməsi, kritik risklərin prioritetləşdirilməsi və təhlükəsizlik nəzarətləri ilə əlaqələndirilməsi.

Bu sənəd Bölmə 1.2-də aparılmış STRIDE əsaslı təhdid modelləşdirilməsinin risk qiymətləndirmə hissəsini əhatə edir.

## Metodologiya

Risk = Likelihood × Impact

Likelihood və Impact 1-dən 5-ə qədər qiymətləndirilmişdir.

| Bal | Ehtimal | Təsir |
|---|---|---|
| 1 | Çox aşağı | Çox zəif |
| 2 | Aşağı | Zəif |
| 3 | Orta | Orta |
| 4 | Yüksək | Ciddi |
| 5 | Çox yüksək | Kritik |

Risk səviyyələri:

| Bal | Səviyyə |
|---|---|
| 1–4 | Aşağı |
| 5–9 | Orta |
| 10–16 | Yüksək |
| 17–25 | Kritik |

Bu model laboratoriya arxitekturasının analitik risk qiymətləndirilməsidir.

## 5×5 Risk Assessment Matrix

| Ehtimal / Təsir | 1 | 2 | 3 | 4 | 5 |
|---|---:|---:|---:|---:|---:|
| 5 — Çox yüksək | 5 | 10 | 15 | 20 | 25 |
| 4 — Yüksək | 4 | 8 | 12 | 16 | 20 |
| 3 — Orta | 3 | 6 | 9 | 12 | 15 |
| 2 — Aşağı | 2 | 4 | 6 | 8 | 10 |
| 1 — Çox aşağı | 1 | 2 | 3 | 4 | 5 |

## Hücum ssenarilərinin risk bölgüsü

Layihədə 18 hücum ssenarisi qiymətləndirilmişdir.

| Risk səviyyəsi | Ssenari sayı |
|---|---:|
| Kritik | 4 |
| Yüksək | 13 |
| Orta | 1 |
| Aşağı | 0 |
| Ümumi | 18 |

### Kritik risklər

| № | Risk | Ehtimal | Təsir | Bal |
|---|---|---:|---:|---:|
| 1 | AD hesabının ələ keçirilməsi | 4 | 5 | 20 |
| 2 | Administrator hesabının icazəsiz istifadəsi | 4 | 5 | 20 |
| 8 | Phishing vasitəsilə hesab məlumatlarının ələ keçirilməsi | 5 | 4 | 20 |
| 14 | Backup məlumatlarının silinməsi və ya dəyişdirilməsi | 4 | 5 | 20 |

## Risklər və arxitektura nəzarətləri

### Identity Security

Əsas risklər:
- Active Directory hesablarının komprometasiyası;
- Administrator girişlərinin ələ keçirilməsi;
- Lokal administrator parollarının sızması;
- Keycloak autentifikasiyasına hücum;
- PKI sertifikatlarının icazəsiz istifadəsi.

Əlaqəli müdafiə komponentləri:
- Active Directory;
- Tiered Access Model;
- JumpServer PAM;
- Keycloak MFA;
- Windows LAPS;
- Active Directory Certificate Services.

Bu nəzarətlər istifadəçi və administrator autentifikasiyasının gücləndirilməsi, imtiyazlı girişlərin mərkəzləşdirilməsi və lokal parolların avtomatik rotasiyası məqsədilə arxitekturaya daxil edilmişdir.

### Mail Security

Əsas risklər:
- Phishing;
- Zərərli attachment;
- Saxta göndərici;
- Mail Gateway qaydalarının dəyişdirilməsi.

Əlaqəli müdafiə komponentləri:
- Mailcow;
- Proxmox Mail Gateway;
- SpamAssassin;
- Docker Sandbox.

Email trafikinin təhlükəsizlik şlüzündən keçirilməsi, phishing indikatorlarının aşkarlanması və şübhəli mesajların karantinə yönləndirilməsi müdafiə modelinin əsas hissələridir.

### Network Security

Əsas risklər:
- Firewall qaydalarının dəyişdirilməsi;
- İcazəsiz şəbəkə bağlantıları;
- DMZ-dən daxili şəbəkəyə lateral movement;
- Honeypot izolyasiyasının pozulması.

Əlaqəli nəzarətlər:
- nftables;
- Suricata IDS/IPS;
- LAN, DMZ, Database, Backup və Quarantine seqmentasiyası.

### Data Protection

Əsas risklər:
- PostgreSQL məlumat sızması;
- Backup məlumatlarının silinməsi;
- Ehtiyat nüsxələrin zədələnməsi.

Əlaqəli komponentlər:
- DB01-in ayrıca Database zonasında yerləşdirilməsi;
- Restic;
- P2-BACKUP serverinin ayrıca Backup zonasında saxlanması.

### Monitoring və Threat Intelligence

Əsas risklər:
- Təhlükəsizlik loglarının dəyişdirilməsi;
- Monitorinq xidmətinin əlçatanlığının pozulması;
- Təhdid göstəricilərinin manipulyasiyası.

Əlaqəli komponentlər:
- Wazuh;
- MISP.

## Qalıq risklər

| Qalıq risk | Mümkün təsir | Riskin idarə olunması yanaşması |
|---|---|---|
| Phishing mesajına aldanma | Hesab məlumatlarının ələ keçirilməsi | Maarifləndirmə və MFA |
| Administrator hesabının komprometasiyası | Kritik sistemlərə giriş | PAM, sessiya monitorinqi, minimum səlahiyyət |
| Firewall yanlış konfiqurasiyası | Seqmentasiyanın zəifləməsi | Qaydaların nəzərdən keçirilməsi |
| Backup məlumatlarının zədələnməsi | Məlumat itkisi | Bərpa sınaqları və bütövlük yoxlaması |
| Monitorinq xidmətinin dayanması | Hadisələrin gec aşkarlanması | Əlçatanlıq monitorinqi |
| Bulud idarəetmə hesablarının ələ keçirilməsi | Azure resurslarına icazəsiz giriş | MFA və rol əsaslı giriş |
| Sandbox izolyasiyasının pozulması | Digər sistemlərə təsir | Konteyner və şəbəkə izolyasiyası |

## Bölmə 15 ilə əlaqə

Bölmə 1.2-dəki 18 STRIDE hücum ssenarisi arxitektura yönümlü threat modeling nəticəsidir.

Bölmə 15-də isə ayrıca R-01–R-20 identifikatorları ilə 20 riskdən ibarət GRC Risk Register hazırlanmışdır.

Bu iki qiymətləndirmə fərqli məqsədlərə xidmət edir:
- Bölmə 1.2 — hücum ssenarilərinin texniki təhlili;
- Bölmə 15.2 — təşkilati risklərin reyestri və hədəf risk göstəriciləri.

## Nəticə

18 hücum ssenarisi risk matrisi ilə qiymətləndirilmişdir. Dörd kritik risk müəyyən edilmiş, müdafiə komponentləri təhlükə kateqoriyaları ilə əlaqələndirilmiş və qalıq risklər nəzərdən keçirilmişdir.
