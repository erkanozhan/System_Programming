#!/bin/bash
while true
do
clear
read -p "Lütfen Kaydetmek istediğiniz T.C Kimlik Noyu Giriniz" tcno
kontrol='^[1-9][0-9]{10}$'

if ! [[ "$tcno" =~ $kontrol ]]; then
echo "Lütfen sadece 11 hane, başında 0 olmadan olacak şekilde rakam giriniz"
else
echo "Doğru Giriş"

echo "$tcno" >> deneme.txt 
echo "Başarıyla kaydedildi"
fi
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