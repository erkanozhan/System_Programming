#!/usr/bin/bash
for file in *; do
    size+=$(stat -c %s "$file")
    # stat komutu ile dosyanın boyutunu byte cinsinden alıyoruz.
    # -c %s ifadesi, stat komutunun sadece dosya boyutunu döndürmesini sağlar.
    # "$file" ifadesi, stat komutuna dosya adını argüman olarak verir.
    # Döngü her dosya için çalışır ve dosya adını ve boyutunu ekrana yazdırır.
    # %s ifadesi, string formatında dosya boyutunu byte cinsinden döndürür.


    echo "$file Dosyasının Boyutu: $size bytes"
    done
   echo "Toplam Boyut: $size bytes"