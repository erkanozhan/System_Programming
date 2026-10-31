# Bash Programı: T.C. Kimlik Numarası Kontrol ve Kayıt Sistemi

Bu Bash betiği (script), kullanıcıdan T.C. Kimlik Numarası (TCKN) alır, bu numaranın formatını (11 hane, sadece rakam, ilk hane 0 değil) doğrular, geçerliyse `tcno.txt` adlı bir dosyaya kaydeder ve kullanıcıya başka bir TCKN girmek isteyip istemediğini sorar.

## Çalışma Mantığı

Betik, sonsuz bir ana döngü içinde çalışır ve her döngüde şunları yapar:
1.  Ekranı temizler.
2.  Kullanıcıdan bir TCKN girmesini ister.
3.  Tanımlanan bir düzenli ifade (regex) ile TCKN'nin geçerliliğini kontrol eder.
    *   Geçersizse: Bir hata mesajı gösterir.
    *   Geçerliyse: "Doğru Giriş" mesajını gösterir, TCKN'yi `tcno.txt` dosyasına ekler ve "Başarıyla kaydedildi" mesajını gösterir.
4.  Kullanıcıya devam edip etmek istemediğini soran bir iç döngüye girer.
    *   "Evet" (E/e) cevabı verilirse: İç döngüden çıkar ve ana döngünün başına döner (yeni bir TCKN girişi için).
    *   "Hayır" (H/h) cevabı verilirse: Bir veda mesajı gösterir ve betikten tamamen çıkar.
    *   Geçersiz bir cevap verilirse: Uygun giriş için tekrar sorar.

## Betik Kodu

Kodun tamamı, satır satır açıklamalarıyla birlikte [2-TC_kimlik_kontrol-v2.sh](2-TC_kimlik_kontrol-v2.sh) dosyasındadır; aynı kodun fareyle üzerine gelindiğinde açıklama gösteren sürümü [tc_kimlik_kontrol_aciklamali_kod.html](tc_kimlik_kontrol_aciklamali_kod.html) dosyasındadır. Kayıtları okuyan betik ise [3-Dosya_Okuma.sh](3-Dosya_Okuma.sh) dosyasıdır.

```bash
#!/bin/bash
while true
do
clear
read -p "Lütfen kaydetmek istediğiniz T.C. Kimlik Numarasını giriniz: " tcno
kontrol='^[1-9][0-9]{10}$'

if ! [[ "$tcno" =~ $kontrol ]]; then
echo "Lütfen başında 0 olmayan, 11 haneli ve yalnızca rakamlardan oluşan bir numara giriniz."
else
echo "Doğru Giriş"

echo "$tcno" >> tcno.txt
echo "Başarıyla kaydedildi"
fi
while true
        do
        read -p "Devam etmek istiyor musunuz (Evet/Hayır)?" secim
        case $secim in
            [Ee]*)
            break;;

            [Hh]*)
            echo "Programdan çıkılıyor. Hoşça kalın."
            exit;;

            *) echo "Lütfen Evet için E, Hayır için H kullanınız"
        esac
        done
done
```

## Kod Açıklaması ve Kullanılan Parametreler

1.  **`#!/bin/bash`**:
    *   Shebang. Betiğin Bash yorumlayıcısı ile çalıştırılacağını belirtir.

2.  **`while true`** (Dış Döngü):
    *   Sonsuz bir döngü başlatır. Betik, kullanıcı açıkça `exit` komutuyla çıkış yapana kadar çalışmaya devam eder.

3.  **`clear`**:
    *   Terminal ekranını temizler. Her yeni TCKN girişi öncesinde temiz bir görünüm sağlar.

4.  **`read -p "Lütfen kaydetmek istediğiniz T.C. Kimlik Numarasını giriniz: " tcno`**:
    *   **`read`**: Kullanıcıdan girdi almak için kullanılan bir Bash yerleşik komutudur.
    *   **`-p "Lütfen kaydetmek istediğiniz T.C. Kimlik Numarasını giriniz: "`**: Prompt (istem) seçeneği. `read` komutu girdi beklemeye başlamadan önce tırnak içindeki metni ekranda gösterir.
    *   **`tcno`**: Kullanıcının girdiği değerin atanacağı değişkenin adıdır.

5.  **`kontrol='^[1-9][0-9]{10}$'`**:
       *   **`'^[1-9][0-9]{10}$'`**: Değişkene atanan düzenli ifadedir (regex).
        *   **`^`**: Satırın/dizenin başlangıcını ifade eder.
        *   **`[1-9]`**: İlk karakterin '1' ile '9' arasında bir rakam olması gerektiğini belirtir (TCKN '0' ile başlamaz).
        *   **`[0-9]{10}`**: Sonraki 10 karakterin '0' ile '9' arasında rakamlar olması gerektiğini belirtir (`{10}` tam olarak 10 tane anlamına gelir).
        *   **`$`**: Satırın/dizenin sonunu ifade eder.
        *   Bu regex, girdinin hem **sayısal** olmasını, hem **tam olarak 11 haneli** olmasını hem de **ilk hanesinin 0 olmamasını** aynı anda kontrol eder.

6.  **`if ! [[ "$tcno" =~ $kontrol ]]; then ... else ... fi`**:
    *   **`if ! [...]`**: Koşulun *doğru olmaması* durumunda (yani girilen `tcno` regex ile eşleşmiyorsa, yani geçersizse) `then` bloğu çalışır.
    *   **`[[ ... ]]`**: Bash'in gelişmiş test yapısıdır.
    *   **`"$tcno"`**: Değerlendirilecek olan `tcno` değişkenidir. Çift tırnak içinde kullanılması, boş veya özel karakter içeren girdilerde hataları önler.
    *   **`=~`**: Regex eşleşme operatörüdür. Solundaki metnin (string) sağındaki regex ile eşleşip eşleşmediğini kontrol eder.
    *   **`$kontrol`**: Regex desenini içeren değişkendir.
    *   **`then`**: Eğer `if` koşulu doğruysa (yani `tcno` geçersizse) çalıştırılacak komut bloğunu başlatır.
    *   **`else`**: Eğer `if` koşulu yanlışsa (yani `tcno` geçerliyse) çalıştırılacak komut bloğunu başlatır.
    *   **`fi`**: `if` koşullu bloğunu sonlandırır.

7.  **`echo "Lütfen başında 0 olmayan, 11 haneli ve yalnızca rakamlardan oluşan bir numara giriniz."`**:
    *   Eğer TCKN geçersizse, kullanıcıya hatanın ne olduğu hakkında bilgi veren mesajı yazdırır.

8.  **`echo "Doğru Giriş"`**:
    *   Eğer TCKN geçerliyse, bu mesajı yazdırır.

9.  **`echo "$tcno" >> tcno.txt`**:
    *   **`echo "$tcno"`**: `$tcno` değişkeninin (geçerli TCKN) değerini standart çıktıya yazar.
    *   **`>>`**: Yönlendirme operatörüdür (append/ekleme modu). Solundaki komutun standart çıktısını, sağında belirtilen `tcno.txt` dosyasına ekler. Dosya yoksa oluşturulur; varsa, yeni veri dosyanın sonuna eklenir, üzerine yazılmaz.
    *   **`tcno.txt`**: TCKN'lerin kaydedileceği dosyanın adıdır.

10. **`echo "Başarıyla kaydedildi"`**:
    *   Kaydetme işlemi sonrası kullanıcıya bilgi mesajı gösterir.

11. **`while true`** (İç Döngü):
    *   Kullanıcı geçerli bir devam etme seçeneği (Evet/Hayır) girene kadar devam eden bir döngü başlatır.

12. **`read -p "Devam etmek istiyor musunuz (Evet/Hayır)?" secim`**:
    *   Kullanıcıdan devam edip etmeme kararını alır ve `secim` değişkenine atar. `-p` parametresi ile istem gösterilir.

13. **`case $secim in ... esac`**:
    *   `$secim` değişkeninin değerine göre farklı eylemler gerçekleştiren bir yapıdır.
    *   **`[Ee]*)`**: Eğer `secim` "E" veya "e" harfi ile başlıyorsa (örneğin "Evet", "E", "evet") bu blok çalışır.
        *   **`break`**: İçteki `while true` döngüsünü sonlandırır. Kontrol, dıştaki ana `while true` döngüsünün başına döner (yeni bir TCKN girişi için).
        *   **`;;`**: `case` içindeki her bir kalıp bloğunun sonunu belirtir.
    *   **`[Hh]*)`**: Eğer `secim` "H" veya "h" harfi ile başlıyorsa bu blok çalışır.
        *   **`echo "Programdan çıkılıyor. Hoşça kalın."`**: Bir veda mesajı gösterir.
        *   **`exit`**: Tüm Bash betiğini sonlandırır.
    *   **`*)`**: Yukarıdaki kalıplardan hiçbirine uymayan herhangi bir girdi için bu blok çalışır (varsayılan durum).
        *   **`echo "Lütfen Evet için E, Hayır için H kullanınız"`**: Kullanıcıya geçerli bir giriş yapması için bir mesaj gösterir.
    *   **`esac`**: `case` yapısını sonlandırır.

14. **`done`** (İç Döngü için):
    *   İçteki `while` döngüsünü kapatır.

15. **`done`** (Dış Döngü için):
    *   Dıştaki ana `while` döngüsünü kapatır.

## Alıştırma: Biçim Doğru, Numara Geçerli mi?

Yukarıdaki düzenli ifade yalnızca numaranın **biçimini** denetler. `12345678901` gibi bir numara bu denetimden geçer ama gerçek bir T.C. Kimlik Numarası değildir. Gerçek numaralarda son iki hane, ilk dokuz haneden hesaplanan **kontrol haneleridir**. Bu, banka hesaplarındaki IBAN numaralarında bulunan kontrol hanelerine benzer: bir hane yanlış yazıldığında sistem, numaranın var olup olmadığına bakmadan hatayı hesapla yakalar.

Hanelere soldan sağa d1, d2, ..., d11 diyelim. Kurallar şunlardır:

1. d10 = ((d1 + d3 + d5 + d7 + d9) × 7 − (d2 + d4 + d6 + d8)) mod 10
2. d11 = (d1 + d2 + ... + d10) mod 10

Bash'te bir metnin i. karakterine `${tcno:i:1}` ile erişilir (indis 0'dan başlar). Örneğin d1, `${tcno:0:1}` ifadesidir.

**Görev:** `2-TC_kimlik_kontrol-v2.sh` betiğini, biçim denetiminden sonra bu iki kuralı `$(( ))` aritmetiği ile denetleyecek biçimde genişletin. Kurallardan biri tutmazsa "Kontrol haneleri hatalı" mesajı verilsin ve numara dosyaya yazılmasın. Bash'te `%` işlemi negatif sayılarda negatif sonuç verebildiğinden 1. kuraldaki sonucu `(( (x % 10 + 10) % 10 ))` biçiminde pozitife çevirmeyi unutmayın.

Denemek için kural 1 ve 2'ye uyan `10000000146` numarasını kullanabilirsiniz.