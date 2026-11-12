# 8.2 — Email Security Gateway

## Məqsəd
Mailcow serverinə yönələn SMTP trafikinin mərkəzi təhlükəsizlik şlüzü vasitəsilə idarə olunması və birbaşa bağlantıların məhdudlaşdırılması.

## İnfrastruktur
| Server | IP | Təyinat |
|---|---|---|
| ESG01 | 10.0.0.103 | Proxmox Mail Gateway |
| MAIL01 | 10.0.0.102 | Mailcow email serveri |

## Arxitektura
Gələn email trafiki üçün ESG01 təhlükəsizlik şlüzü kimi yerləşdirildi. Mailcow serverinə birbaşa SMTP girişinin məhdudlaşdırılması üçün firewall qaydaları tətbiq edildi.

## Görülən işlər
1. ESG01 serverində Proxmox Mail Gateway quraşdırıldı.
2. Email trafiki üçün təhlükəsizlik şlüzü konfiqurasiya edildi.
3. MAIL01 serverinə TCP/25 girişi firewall vasitəsilə məhdudlaşdırıldı.
4. ESG01-dən MAIL01-ə SMTP bağlantısı test edildi.
5. DC01-dən MAIL01-ə birbaşa SMTP bağlantısı test edildi.
6. Firewall bloklama sayğacları yoxlanıldı.

## Test nəticələri
| Test | Nəticə |
|---|---|
| ESG01 → MAIL01:25 | Uğurlu |
| DC01 → MAIL01:25 | Bloklandı |
| Bloklanan paketlər | 5 |
| Bloklanan trafik | 260 bayt |

## Təhlükəsizlik nəticəsi
Test edilmiş marşrutda Mailcow-a birbaşa SMTP bağlantısı bloklandı, ESG01 üzərindən bağlantı isə uğurlu oldu. Bu, email trafikinin təhlükəsizlik şlüzü üzərindən yönləndirilməsi üçün tətbiq edilən şəbəkə məhdudiyyətinin işlədiyini göstərdi.

## Nəticə
Proxmox Mail Gateway Mailcow infrastrukturu qarşısında yerləşdirildi. SMTP girişinə firewall nəzarəti tətbiq edildi və şlüzdən yan keçən test bağlantısı bloklandı.
