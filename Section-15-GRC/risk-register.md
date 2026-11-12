# 15.2 — Risk Register və Risklərin Qiymətləndirilməsi

## Məqsəd

Korporativ infrastrukturun informasiya təhlükəsizliyi risklərini müəyyənləşdirmək, onların ehtimal və təsirini qiymətləndirmək və risklərin azaldılması üçün təhlükəsizlik nəzarətlərini planlaşdırmaq.

## Risk Register

Layihədə R-01-dən R-20-yə qədər identifikatorlarla 20 riskdən ibarət Risk Register hazırlanmışdır.

Risklər aşağıdakı yanaşma ilə qiymətləndirilmişdir:

Risk Score = Likelihood × Impact

Burada:
- Likelihood — riskin başvermə ehtimalı;
- Impact — riskin təşkilata mümkün təsiri;
- Risk Score — ümumi risk göstəricisidir.

## Risk səviyyələri

| Risk balı | Səviyyə |
|---|---|
| 1–4 | Low |
| 5–9 | Medium |
| 10–16 | High |
| 17–25 | Critical |

## Risk nümunələri

| ID | Risk | İlkin qiymət | İlkin bal | Hədəf qiymət | Hədəf bal |
|---|---|---|---|---|---|
| R-01 | DC01 komprometasiyası | 3 × 5 | 15 — High | 2 × 5 | 10 — High |
| R-02 | DC02 replikasiya nasazlığı | 3 × 4 | 12 — High | 2 × 3 | 6 — Medium |
| R-19 | Təhlükəsizlik yeniləmələrinin gecikməsi | 4 × 4 | 16 — High | 2 × 3 | 6 — Medium |
| R-20 | İnsidentə gec reaksiya | 4 × 4 | 16 — High | 2 × 3 | 6 — Medium |

Bu cədvəl layihənin 20 risklik reyestrindən seçilmiş nümunələri göstərir.

## Risklərin azaldılması

### R-01 — DC01 komprometasiyası
Domain Controller sisteminin komprometasiyası identifikasiya infrastrukturuna yüksək təsir göstərə bilər.

Riskin azaldılması üçün layihədə tətbiq edilmiş təhlükəsizlik yanaşmaları:
- Tiered Administration;
- İmtiyazlı girişlərin ayrılması;
- Jump Server üzərindən idarəetmə;
- Audit və monitorinq.

İlkin risk balı 15, hədəf risk balı 10 olaraq qiymətləndirilmişdir.

### R-02 — DC02 replikasiya nasazlığı
Domain Controller replikasiyasında problem identifikasiya xidmətlərinin davamlılığına təsir edə bilər.

Risk reyestrində ilkin bal 12, hədəf bal isə 6 kimi göstərilmişdir.

### R-19 — Yeniləmələrin gecikməsi
Təhlükəsizlik yeniləmələrinin gecikməsi məlum zəifliklərin istismar ehtimalını artıra bilər.

İlkin risk balı 16, hədəf risk balı 6 kimi qiymətləndirilmişdir.

### R-20 — İnsidentə gec reaksiya
Təhlükəsizlik hadisələrinin gec aşkarlanması və gec cavablandırılması mümkün zərərin artmasına səbəb ola bilər.

İlkin risk balı 16, hədəf risk balı 6 kimi müəyyən edilmişdir.

## Risklərin monitorinqi

Risklərin idarə edilməsi prosesində aşağıdakı fəaliyyətlər nəzərdə tutulmuşdur:
1. Risklərin reyestrdə saxlanması;
2. Ehtimal və təsir göstəricilərinin qiymətləndirilməsi;
3. Azaldıcı təhlükəsizlik tədbirlərinin müəyyən edilməsi;
4. Hədəf risk səviyyələrinin hesablanması;
5. Risk reyestrinin aylıq nəzərdən keçirilməsi.

## Nəticə

20 riskdən ibarət Risk Register hazırlanmış, risklərin ehtimal və təsir əsasında qiymətləndirilməsi aparılmış və risklərin azaldılması üçün hədəf göstəricilər müəyyən edilmişdir.
