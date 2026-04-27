read -p "Devam etmek istiyor musunuz? (E/H): " cevap

case "$cevap" in
    [eE] | [eE][vV][eE][tT])
        echo "İşleme devam ediliyor. Dosyalar kopyalanıyor..."
        ;;
    [hH] | [hH][aA][yY][ıI][rR])
        echo "İşlem kullanıcı tarafından iptal edildi."
        ;;
    *)
        echo "Tanımsız giriş. İşlem sonlandırılıyor."
        ;;
esac