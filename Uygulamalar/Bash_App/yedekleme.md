# Bash Betiği: Dizin Yedekleme

Bu betik, belirli bir kaynak dizinini `tar` ve `gzip` kullanarak arşivleyip sıkıştırır ve hedef dizine güncel tarihle birlikte kaydeder. `tar` komutunun ayrıntıları için [Linux terminal ders notunun tar bölümüne](../../linux-mate-terminal-ders-notu.md#tar--arşivleme) bakılabilir.

## Betik Kodu

Aşağıdaki kodu bir metin düzenleyiciyle `/home/kullanici/backup.sh` adıyla kaydedin (`kullanici` yerine kendi kullanıcı adınızı yazın) ve çalıştırma izni verin: `chmod +x /home/kullanici/backup.sh`. Elle denemek için `/home/kullanici/backup.sh` yazmanız yeterlidir.

```bash
#!/bin/bash
# Bu betiğin bash kabuğu ile çalıştırılacağını belirtir.

# Herhangi bir komut hata verirse betiği durdur; tanımsız değişkeni hata say.
set -euo pipefail

# Yedeklenecek (kaynak) dizinin yolunu bir değişkene atar.
# $HOME, cron altında da kullanıcının ev dizinini gösterir.
kaynak_dir="$HOME/kaynak"

# Yedek dosyasının kaydedileceği (hedef) dizinin yolunu bir değişkene atar.
hedef_dir="$HOME/yedekler"

# Hedef dizin yoksa oluştur (-p: varsa hata verme).
mkdir -p "$hedef_dir"

# Güncel tarihi YYYY-MM-DD formatında alır ve bir değişkene atar.
# Örneğin, 27 Ekim 2023 için "2023-10-27" değerini alır.
DATE=$(date +%Y-%m-%d)

# Yedek dosyasının adını ve tam yolunu oluşturur.
# Hedef dizin, sabit bir önek ("yedek_"), güncel tarih ve ".tar.gz" uzantısını birleştirir.
# Örneğin, "/home/kullanici/yedekler/yedek_2023-10-27.tar.gz" gibi bir dosya adı oluşur.
yedek_file="${hedef_dir}/yedek_$DATE.tar.gz"

# tar komutu ile yedekleme işlemini yapar:
# -c: Arşiv oluştur (create).
# -z: Oluşturulan arşivi gzip ile sıkıştır (gzip).
# -f: Arşiv dosyasının adını ve yolunu belirt (file). Bu durumda "$yedek_file" değişkenindeki değeri kullanır.
# -C "$kaynak_dir": Bu çok önemlidir! tar komutunu çalıştırmadan önce belirtilen "$kaynak_dir" dizinine geçiş yapar.
#                  Bu, arşivi oluştururken dosya yollarının "$kaynak_dir" önekiyle başlamasını engeller.
#                  Yani, arşivin içinde 'kaynak/dosya1' yerine './dosya1' bulunur.
# Sondaki "." : arşive eklenecek içeriktir ("bulunulan dizinin tamamı").
#                  Bu nokta yazılmazsa tar "Cowardly refusing to create an empty archive"
#                  (boş arşiv oluşturmayı reddediyorum) hatasıyla durur.
tar -czf "$yedek_file" -C "$kaynak_dir" .

# Cron çıktıyı günlük dosyasına yazdığında hangi yedeğin alındığı görülsün diye bilgi ver.
echo "$(date '+%F %T') Yedek oluşturuldu: $yedek_file"

```

# Cron ile Otomatik Betik Çalıştırma (Günlük Yedekleme)

Linux/Unix sistemlerinde `cron`, belirli zamanlanmış görevleri (cron işleri) otomatik olarak çalıştırmak için kullanılan bir hizmettir. Bir `crontab` dosyası, bu görevlerin listesini ve ne zaman çalışacaklarını içerir.

## 1. Crontab Düzenleyicisini Açma

Konsolda `crontab -e` komutunu çalıştırmak, mevcut kullanıcının cron görevlerini tanımlayan dosyayı açar.

```bash
crontab -e
```

*   **`crontab`**: Cron zamanlama hizmetinin kullanıcı arayüzü komutu.
*   **`-e`**: "Edit" (düzenle) seçeneği. Kullanıcının crontab dosyasını varsayılan metin düzenleyicisinde açar. Eğer ilk kez kullanılıyorsa, hangi düzenleyiciyi kullanmak istediğiniz sorulabilir (örneğin, `nano`, `vim`).


## 2. Cron Görevini Ekleme

Açılan düzenleyicinin sonuna aşağıdaki satır eklenir:

```bash
0 22 * * * /home/kullanici/backup.sh >> /home/kullanici/yedek.log 2>&1
```

Bu satır, betiğinizin her gece saat 22:00'da (akşam 10) çalışmasını sağlayacak bir cron görevidir. Şimdi bu satırın her bölümünü açıklayalım:

*   **`0 22 * * *`**: Bu kısım, komutun ne zaman çalışacağını belirten zamanlama alanıdır. Sırasıyla:
    *   `0`: Dakika (0-59). **0** dakikada çalışacak (yani tam saatte).
    *   `22`: Saat (0-23). **22** saatte çalışacak (24 saat formatında akşam 10:00).
    *   `*`: Ayın günü (1-31). Yıldız (`*`) her gün anlamına gelir.
    *   `*`: Ay (1-12). Yıldız (`*`) her ay anlamına gelir.
    *   `*`: Haftanın günü (0-7, 0 veya 7 Pazar'ı temsil eder, 1 Pazartesi). Yıldız (`*`) haftanın her günü anlamına gelir.
    *   **Sonuç:** Bu zamanlama `Her gün, her ay, haftanın her günü saat 22:00'ın 0. dakikasında` çalışacak demektir. Yani, her gece tam 22:00'da.

*   **`/home/kullanici/backup.sh`**: Bu kısım, çalıştırılacak betiğin tam yolunu belirtir. Cron, kabuğun aksine `~` kısaltmasını ve kullanıcının `PATH` ayarlarını her zaman tanımadığından tam yol yazılır.
    *   **Önemli Not:** Bu betiğin çalıştırılabilir iznine sahip olması gerekir: `chmod +x /home/kullanici/backup.sh`

*   **`>> /home/kullanici/yedek.log 2>&1`**: Bu kısım, betiğin çıktısını bir günlük (log) dosyasına yönlendirir.
    *   Normalde bir cron işinin çıktısı (hem standart çıktı `stdout` hem de standart hata `stderr`), crontab sahibine e-posta olarak gönderilmeye çalışılır; çoğu masaüstü sisteminde e-posta kurulu olmadığından bu çıktı kaybolur.
    *   `>>`: Standart çıktıyı dosyanın sonuna ekler; önceki günlerin kayıtları silinmez.
    *   `2>&1`: Standart hata çıktısını (file descriptor 2), standart çıktının (file descriptor 1) yönlendirildiği yere, yani aynı günlük dosyasına yönlendirir. `&` işareti, `1`'in bir dosya adı değil dosya tanımlayıcısı olduğunu belirtir.
    *   **Amacı:** Yedekleme gibi kritik bir işte hatanın fark edilmesi gerekir. Çıktı `> /dev/null 2>&1` ile atılsaydı, disk dolduğunda veya kaynak dizin silindiğinde yedek alınamadığı hiç fark edilmezdi. Günlük dosyası `tail /home/kullanici/yedek.log` ile kontrol edilir.

Kaydedip çıkınız. Görevin eklendiğini `crontab -l` ile doğrulayabilirsiniz.
