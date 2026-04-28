#!/bin/bash

echo "Web servisi kontrol paneline hoş geldiniz."
echo "Lütfen bir işlem seçin: [baslat | durdur | yeniden_baslat]"
read islem

case "$islem" in
    baslat)
        google-chrome "https://www.apache.org/" &
        ;;
    durdur)
        echo "Servis kapatılıyor..."
        # systemctl stop apache2
        ;;
    yeniden_baslat)
        echo "Servis kapatılıp tekrar açılıyor..."
        # systemctl restart apache2
        ;;
    *)
        echo "Hata: Geçersiz bir parametre girdiniz. Sistemde değişiklik yapılmadı."
        ;;
esac