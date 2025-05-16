# Bash Betiği: Dizin Yedekleme

Bu betik, belirli bir kaynak dizinini `tar` ve `gzip` kullanarak arşivleyip sıkıştırır ve hedef dizine güncel tarihle birlikte kaydeder.

## Betik Kodu


```bash
#!/bin/bash
# Bu betiğin bash kabuğu ile çalıştırılacağını belirtir.

# Yedeklenecek (kaynak) dizinin yolunu bir değişkene atar.
kaynak_dir="/home/fx/Desktop/kaynak"

# Yedek dosyasının kaydedileceği (hedef) dizinin yolunu bir değişkene atar.
hedef_dir="/home/fx/Desktop/hedef"

# Güncel tarihi YYYY-MM-DD formatında alır ve bir değişkene atar.
# Örneğin, 27 Ekim 2023 için "2023-10-27" değerini alır.
DATE=$(date +%Y-%m-%d)

# Yedek dosyasının adını ve tam yolunu oluşturur.
# Hedef dizin, sabit bir önek ("yedek_"), güncel tarih ve ".tar.gz" uzantısını birleştirir.
# Örneğin, "/home/fx/Desktop/hedef/yedek_2023-10-27.tar.gz" gibi bir dosya adı oluşur.
yedek_file="${hedef_dir}/yedek_$DATE.tar.gz"

# tar komutu ile yedekleme işlemini yapar:
# -c: Arşiv oluştur (create).
# -z: Oluşturulan arşivi gzip ile sıkıştır (gzip).
# -f: Arşiv dosyasının adını ve yolunu belirt (file). Bu durumda "$yedek_file" değişkenindeki değeri kullanır.
# -C "$kaynak_dir": Bu çok önemlidir! tar komutunu çalıştırmadan önce belirtilen "$kaynak_dir" dizinine geçiş yapar.
#                  Bu, arşivi oluştururken dosya yollarının "$kaynak_dir" önekiyle başlamasını engeller.
#                  Yani, arşivin içinde 'kaynak/dosya1' yerine 'dosya1' bulunur.
tar -czf "$yedek_file" -C "$kaynak_dir"

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

Açılan düzenleyiciye aşağıdaki satırı ekliyorsunuz:

```bash
0 22 * * * /home/fx/Desktop/backup.sh > /dev/null 2>&1
```

Bu satır, betiğinizin her gece saat 22:00'da (akşam 10) çalışmasını sağlayacak bir cron görevidir. Şimdi bu satırın her bölümünü açıklayalım:

*   **`0 22 * * *`**: Bu kısım, komutun ne zaman çalışacağını belirten zamanlama alanıdır. Sırasıyla:
    *   `0`: Dakika (0-59). **0** dakikada çalışacak (yani tam saatte).
    *   `22`: Saat (0-23). **22** saatte çalışacak (24 saat formatında akşam 10:00).
    *   `*`: Ayın günü (1-31). Yıldız (`*`) her gün anlamına gelir.
    *   `*`: Ay (1-12). Yıldız (`*`) her ay anlamına gelir.
    *   `*`: Haftanın günü (0-7, 0 veya 7 Pazar'ı temsil eder, 1 Pazartesi). Yıldız (`*`) haftanın her günü anlamına gelir.
    *   **Sonuç:** Bu zamanlama `Her gün, her ay, haftanın her günü saat 22:00'ın 0. dakikasında` çalışacak demektir. Yani, her gece tam 22:00'da.

*   **`/home/fx/Desktop/backup.sh`**: Bu kısım, çalıştırılacak komutun veya betiğin tam yolunu belirtir. Cron, görevi çalıştırmak için bu yolu kullanacaktır.
    *   **Önemli Not:** Bu betiğin çalıştırılabilir iznine sahip olması gerekir. Genellikle betik dosyasının bulunduğu dizinde şu komutla bu izin verilir: `chmod +x /home/fx/Desktop/backup.sh`

*   **`> /dev/null 2>&1`**: Bu kısım, betiğin çıktısını yönlendirmek için kullanılır.
    *   Normalde, bir cron işinin çıktısı (hem standart çıktı `stdout` hem de standart hata `stderr`), crontab sahibine e-posta olarak gönderilir.
    *   `>`: Standart çıktıyı yönlendirir.
    *   `/dev/null`: Linux'ta "kara delik" olarak bilinen özel bir dosyadır. Buraya yazılan her şey yok sayılır. `> /dev/null` betiğin normal çıktısını /dev/null'a gönderir.
    *   `2>&1`: Bu kısım, standart hata çıktısını (file descriptor 2) standart çıktının (file descriptor 1) yönlendirildiği yere (yani zaten `/dev/null`'a) yönlendirir. `&` işareti, `1`'in dosya tanımlayıcısı olduğunu belirtmek için kullanılır.
    *   **Amacı:** Bu yönlendirme, betik her çalıştığında (başarılı veya başarısız olsun) crontab sahibine e-posta gönderilmesini engeller. Betik sessizce çalışır ve çıktılar veya hatalar atılır. Genellikle düzenli çalışan ve beklenmedik bir çıktı üretmeyen betikler için tercih edilir.

Kaydedip çıkınız.
