#!/bin/bash

while true
do
clear
echo "İki sayıyı çarpmak için değeleri giriniz"
read -p "Birinci Sayı: " num1
read -p "İkinci Sayı: " num2

# Çarpma İşlemi
result=$(echo "scale=2; $num1*$num2" |bc)
echo "Çarpma İşleminin Sonucu:$result"
	while true
	do
read -p "Başka bir işlem yapmak istiyormusunuz (Evet/Hayır)" secim
case $secim in
	[Ee]*)
    	  break;;
	[Hh]*)
	echo "Programdan çıkılıyor. Hoşçakalın";;
esac
	done
done