#!/bin/bash

while true

do
 clear
 echo "İki sayıyı çarpmak için değer giriniz"
 read -p "Birinci sayıyı giriniz: " num1
 read -p "İkinci sayıyı giriniz: " num2

if ! [[ "$num1" =~ ^-?[0-9]+(\.[0-9]+)?$ && "$num2" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
echo "Lütfen sadece sayı giriniz. Ondalık ayraç olarak+
virgül yerine . kullanınız"
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
            echo "Programdan çıkılıyor. Hoşçakalın"
            exit;;

            *) echo "Lütfen Evet için E, Hayır için H kullanınız"
        esac   
        done
done
