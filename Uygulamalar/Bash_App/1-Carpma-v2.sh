#!/bin/bash

while true

do
 clear
 echo "İki sayıyı çarpmak için değer giriniz"
 read -p "Birinci sayıyı giriniz: " num1
 read -p "İkinci sayıyı giriniz: " num2

if ! [[ "$num1" =~ ^-?[0-9]+(\.[0-9]+)?$ && "$num2" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
# Girilen değerler sayı değilse hata mesajı 
# gösterilir ve kullanıcıdan devam etmek için bir tuşa basması istenir.
# Burada =~ operatörünü kullanarak düzenli ifade (regex) ile sayısal değerleri
# kontrol ediyoruz.
# ^-? : Sayının başında isteğe bağlı olarak negatif işareti olabilir.
# [0-9]+ : Bir veya daha fazla rakam içermelidir.
# (\.[0-9]+)? : Ondalık kısmı isteğe bağlı olarak içerebilir, 
# ancak varsa bir nokta ve ardından bir veya daha fazla rakam içermelidir.

echo "Lütfen yalnızca sayı giriniz. Ondalık ayırıcı olarak virgül yerine nokta (.) kullanınız."
read -n 1 -s -r -p "Devam etmek için bir tuşa basınız"
continue
fi
 # Çarpma İşlemi
 sonuc=$(echo "scale=3; $num1*$num2" | bc)
 echo "Çarpma İşleminin Sonucu: $sonuc"

    while true
        do
        read -p "Devam etmek istiyor musunuz (Evet/Hayır)?" secim
        case $secim in
            [Ee]*)
            break;;

            [Hh]*)
            echo "Programdan çıkılıyor. Hoşça kalın."
            exit;;

            *) echo "Lütfen Evet için E, Hayır için H kullanınız"
        esac   
        done
done
