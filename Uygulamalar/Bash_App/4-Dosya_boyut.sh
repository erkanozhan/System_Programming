#!/bin/bash
# Bulunulan dizindeki her dosyanın boyutunu ve toplam boyutu bayt cinsinden yazar.

toplam=0

for file in *; do
    # Yalnızca normal dosyaları say; dizinleri ve dizin boşsa kalan "*" desenini atla
    [[ -f "$file" ]] || continue

    # stat -c %s: dosyanın boyutunu bayt cinsinden tam sayı olarak verir
    # (%s burada "size" anlamındadır; metin biçimi değildir).
    boyut=$(stat -c %s "$file")

    # (( )) aritmetik bağlamdır; += burada sayısal toplama yapar.
    # Aritmetik bağlam dışında yazılan size+=... ise metinleri yan yana ekler
    # (örneğin 10 ve 20 için sonuç 30 değil, "1020" olur).
    (( toplam += boyut ))

    echo "$file dosyasının boyutu: $boyut bayt"
done

echo "Toplam boyut: $toplam bayt"
