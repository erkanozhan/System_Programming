#!/bin/bash

while true
do
clear
echo "İki sayıyı çarpmak için değerleri giriniz"
read -p "Birinci Sayı: " num1
read -p "İkinci Sayı: " num2

# Çarpma İşlemi
result=$(echo "scale=3; $num1*$num2" |bc)
echo "Çarpma İşleminin Sonucu:$result"
	while true
	do
read -p "Başka bir işlem yapmak istiyor musunuz (Evet/Hayır)? " secim
case $secim in
	[Ee]*)
    	  break;;
	[Hh]*)
	echo "Programdan çıkılıyor. Hoşça kalın."
	exit;;
	*) echo "Lütfen Evet için E, Hayır için H giriniz";;
esac
	done

done