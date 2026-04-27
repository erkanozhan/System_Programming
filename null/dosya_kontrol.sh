#!/bin/bash

dosya_adi="rapor.txt"

if [ -f "$dosya_adi" ]; then
    echo "$dosya_adi bulundu, okuma işlemine geçiliyor."
    cat "$dosya_adi"
else
    echo "Hata: $dosya_adi bulunamadı. Lütfen dosyanın yolunu kontrol edin."
fi