#!/bin/bash
echo "TC Kimlik No Giriniz"
kontrol='^[0-9]+$' 
read tcno
if ! [[ "$tcno" =~ $kontrol ]]; then
echo "Numara giriniz"
elif [[ ${#tcno} -ne 11 ]]
then
echo "TC Kimlik no 11 haneli olmalıdır"
else 
echo "Doğru giriş"
echo "$tcno" >> tcno.txt
# Burada çift büyüktür işareti (>>) kullanarak tcno.txt 
# dosyasına tcno değişkeninin içeriğini dosyanın sonunaekliyoruz. 
# Eğer tek büyüktür işareti (>) kullanırsak, tcno.txt dosyasının 
# içeriği silinir ve sadece son girilen tcno değeri kalır.
fi
