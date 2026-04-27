#!/bin/bash
# Shebang: Bu satır, betiğin hangi yorumlayıcı (interpreter) ile çalıştırılacağını belirtir.
# /bin/bash, betiğin Bash kabuğu tarafından yorumlanacağını ifade eder.
# Bu, betiği doğrudan çalıştırılabilir hale getirir (örneğin, ./betik.sh).
#

while true
do
    # `while true` döngüsü: Betiğin sürekli olarak çalışmasını sağlar.
    # Kullanıcı "Hayır" diyerek çıkış yapana kadar bu döngü devam eder.
    #

    clear
    # `clear` komutu: Terminal ekranını temizler. Her yeni T.C. Kimlik No girişi öncesi ekranı düzenli tutar.
    #

    read -p "Lütfen Kaydetmek istediğiniz T.C Kimlik Noyu Giriniz" tcno
    # `read` komutu: Kullanıcıdan girdi almak için kullanılır.
    # `-p` (prompt) seçeneği, kullanıcıya gösterilecek mesajı belirtir.
    # Girilen değer `tcno` değişkenine atanır.
    #

    kontrol='^[1-9][0-9]{10}$'
    # `kontrol` değişkeni: T.C. Kimlik Numarası için bir düzenli ifade (Regular Expression - Regex) tanımlar.
    # Regex, metin desenlerini eşleştirmek için güçlü bir araçtır.
    #
    # Açıklama:
    # `^`: Satırın başlangıcı.
    # `[1-9]`: İlk karakter 0 olamaz, 1 ile 9 arasında bir rakam olmalıdır.
    # `[0-9]{10}`: Sonraki 10 karakter 0 ile 9 arasında rakam olmalıdır.
    # `$`: Satırın sonu.
    # Bu regex, toplam 11 haneli, ilk hanesi 0 olmayan ve tamamı rakamlardan oluşan bir T.C. Kimlik Numarası formatını kontrol eder.

if ! [[ "$tcno" =~ $kontrol ]]; then
    # `if` koşullu ifadesi: Belirli bir koşulun doğru olup olmadığını kontrol eder.
    # `[[ ]]`: Bash'te genişletilmiş testler için kullanılır. `[ ]`'e göre daha gelişmiş özellikler sunar (örn. regex).
    # `!`: Mantıksal DEĞİL operatörü. Koşulun tersini kontrol eder.
    # `"$tcno"`: `tcno` değişkeninin değeri. Değişkenleri çift tırnak içine almak, boşluk veya özel karakter içeren durumlarda hataları önler.
    # `=~`: Regex eşleştirme operatörü. `"$tcno"` değişkeninin `kontrol` regex'i ile eşleşip eşleşmediğini kontrol eder.
    # Eğer `tcno` regex desenine uymuyorsa (yani geçersizse) bu blok çalışır.
    #
    echo "Lütfen sadece 11 hane, başında 0 olmadan olacak şekilde rakam giriniz"
    # `echo` komutu: Terminale mesaj yazdırır. Bu durumda bir hata mesajı gösterir.
else
    # Eğer `if` koşulu yanlışsa (yani T.C. Kimlik No formatı geçerliyse) bu blok çalışır.
    echo "Doğru Giriş"
    # Başarılı giriş mesajı.

    echo "$tcno" >> deneme.txt
    # Çıktı yönlendirme operatörü `>>`: `tcno` değişkeninin değerini `deneme.txt` adlı dosyanın sonuna ekler.
    # Eğer dosya yoksa oluşturur. `>` tek başına kullanılsaydı dosyanın içeriğini silip yeniden yazardı.
    # Sistem programlamada, dosya G/Ç (Girdi/Çıktı) işlemleri, işletim sisteminin temel işlevlerinden biridir.
    # Her şeyin bir dosya olduğu UNIX felsefesi gereği, bu işlem bir dosya tanımlayıcısı (File Descriptor) üzerinden gerçekleşir.
    #
    echo "Başarıyla kaydedildi"
    # Kayıt işleminin başarılı olduğunu bildiren mesaj.
fi

    # İç `while true` döngüsü: Kullanıcıya devam edip etmek istemediğini sorar.
    # Bu döngü, kullanıcı geçerli bir "Evet" veya "Hayır" cevabı verene kadar devam eder.
    while true
    do
        read -p "Devam etmek istiyor musunuz (Evet/Hayır)?" secim
        # Kullanıcının tercihini `secim` değişkenine atar.

        case $secim in
            # `case` ifadesi: Bir değişkenin değerini birden fazla desenle karşılaştırmak için kullanılır.
            # `if/elif/else` yapısına göre daha okunabilir ve etkilidir, özellikle çok sayıda seçenek olduğunda.
            #

            [Ee]*)
                # `[Ee]*)`: Kullanıcının girdisi 'E' veya 'e' ile başlıyorsa bu deseni eşleştirir.
                # `*` joker karakteri, 'E' veya 'e'den sonra gelen herhangi bir karakter dizisini temsil eder.
                break;;
                # `break` komutu: İçinde bulunduğu döngüyü (bu durumda iç `while true` döngüsünü) sonlandırır.
                # Program ana `while true` döngüsünün başına döner ve yeni bir T.C. Kimlik No girişi ister.

            [Hh]*)
                # `[Hh]*)`: Kullanıcının girdisi 'H' veya 'h' ile başlıyorsa bu deseni eşleştirir.
                echo "Programdan çıkılıyor. Hoşçakalın"
                # Çıkış mesajı.
                exit;;
                # `exit` komutu: Betiğin çalışmasını tamamen sonlandırır.
                # `exit 0` genellikle başarılı çıkışı, `exit 1` veya daha yüksek değerler ise hata durumunu belirtir.
                #

            *) echo "Lütfen Evet için E, Hayır için H kullanınız"
                # `*)`: Yukarıdaki desenlerden hiçbiri eşleşmezse bu varsayılan deseni eşleştirir.
                # Kullanıcıya geçerli bir seçenek girmesi için uyarı verir.
                # Döngü devam eder ve tekrar seçim yapması istenir.
        esac
        # `esac`: `case` ifadesinin sonunu belirtir (case kelimesinin tersten yazılışı).
    done
    # İç `while true` döngüsünün sonu.
done
# Ana `while true` döngüsünün sonu.
