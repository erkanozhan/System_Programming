# Nginx Web Sunucusu Kurulumu ve Yerel Ağda İletişim

Ön Koşullar:
- İnternet bağlantısı.
- Sistemde Visual Studio Code (VS Code) yüklü olması.
- Tüm bilgisayarların aynı Yerel Ağa (Local Area Network - LAN) bağlı olması.

Gençler, bir bilgisayarın ağ üzerindeki temel işlevi, ya bir hizmet sunmak ya da sunulan bir hizmetten yararlanmaktır. Bu bağlamda iki temel kavram karşımıza çıkar: Sunucu (Server) ve İstemci (Client). Sunucu kelimesinin etimolojik kökeni Latince *servire* (hizmet etmek) fiiline dayanır; istemci ise yine Latince *cliens* (tabi olan, hizmet alan) kelimesinden türemiştir.

Bu çalışmada, bir web sunucusu (Web Server) kurarak kendi bilgisayarımızı ağdaki diğer cihazlara hizmet verecek yapıya getireceğiz.

## Adım 1: Nginx Web Sunucusunun Kurulumu

Nginx, günümüzde yüksek performanslı, eşzamanlı bağlantıları yönetme kabiliyetiyle öne çıkan bir web sunucusu yazılımıdır. Kuruluma başlamadan önce sistemdeki paket listelerini güncellemek gerekir.

```bash
sudo apt update
sudo apt install nginx -y
```

Burada kullandığımız `apt` (Advanced Package Tool - Gelişmiş Paket Aracı), sistemdeki yazılımları ve bağımlılıklarını yönetmemizi sağlar. Kurulum tamamlandığında Nginx arka planda otomatik olarak çalışmaya başlar. Bir tarayıcı açıp adres çubuğuna `http://localhost` yazdığınızda Nginx'in varsayılan sayfasını görmelisiniz. `localhost`, bilgisayarın kendisine (loopback - geri döngü) yaptığı donanımsal referanstır.

## Adım 2: Güvenlik Duvarı İzinlerini Ayarlama

Sunucu kendi içimizde sorunsuz çalışsa da, dışarıdan gelen isteklere kapalı olabilir. Güvenlik duvarı (Firewall), ağ trafiğini belirli kurallara göre denetleyen bir kalkandır. Ubuntu sistemlerinde genellikle UFW (Uncomplicated Firewall - Karmaşık Olmayan Güvenlik Duvarı) aracı kullanılır.

Ağ üzerindeki iletişim, belirli mantıksal kapılar üzerinden sağlanır. Bilişimde bu kapılara Port denir (Latince *porta* yani kapı kelimesinden gelir). Web trafiği olan HTTP (Hypertext Transfer Protocol - Hipermetin Aktarım Protokolü) standart olarak 80 numaralı portu kullanır.

Sistemdeki güvenlik duvarı profillerini listelemek için:
```bash
sudo ufw app list
```

HTTP trafiğine (80 portu) izin vermek için:
```bash
sudo ufw allow 'Nginx HTTP'
```

Durumu doğrulamak için:
```bash
sudo ufw status
```
Eğer sistem "inactive" yanıtı veriyorsa, güvenlik duvarı devrede değildir ve dışarıdan gelen tüm trafiğe zaten açıktır.

## Adım 3: Web Kök Dizininde Yetki Ayarlaması

Nginx, web sayfalarını varsayılan olarak `/var/www/html` dizininde barındırır. Linux tabanlı işletim sistemlerinde (POSIX standartları) güvenlik mimarisi gereği, bu dizinin sahibi en yetkili kullanıcı olan `root`'tur. Dosyaları doğrudan düzenleyebilmek için bu dizinin sahipliğini (ownership) aktif kullanıcıya devretmemiz gerekir.

```bash
sudo chown -R $USER:$USER /var/www/html
```

Bu komuttaki `chown` (Change Owner - Sahibi Değiştir) ifadesi, dizin hiyerarşisindeki yetkileri mevcut kullanıcımıza (`$USER`) atar. `-R` parametresi ise işlemin alt dizinler için de özyinelemeli (recursive) olarak uygulanmasını sağlar.

## Adım 4: İçerik Oluşturma

Kök dizinde yer alan varsayılan dosyayı bir kod düzenleyici ile açacağız.

```bash
code /var/www/html
```

VS Code açıldığında, dizindeki `index.nginx-debian.html` (veya `index.html`) dosyasını göreceksiniz. Açılan dosyadaki içeriği temizleyip, kendi metninizi barındıran basit bir HTML (HyperText Markup Language - Hipermetin İşaretleme Dili) kod bloğu ekleyebiliriz:

```html
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Sistem Programlama - Nginx</title>
    <style>
        body {
            font-family: sans-serif;
            text-align: center;
            margin-top: 100px;
            background-color: #f4f4f9;
        }
        h1 { color: #2c3e50; }
        p { color: #7f8c8d; }
    </style>
</head>
<body>
    <h1>Merhaba!</h1>
    <p>Bu metin, yerel ağda çalışan bir Nginx sunucusundan iletilmektedir.</p>
</body>
</html>
```

Dosyayı kaydettikten sonra tarayıcıdan `http://localhost` adresini yenilediğinizde, metnin güncellendiğini göreceksiniz.

## Adım 5: Yerel IP Adresini Öğrenme ve Ağ Üzerinde İletişim

Yerel ağdaki diğer makinelerin sunucunuza erişebilmesi için, IP (Internet Protocol - İnternet Protokolü) adresinize ihtiyaçları vardır. IP adresi, ağ üzerindeki cihazların birbirini bulmasını sağlayan mantıksal bir numaralandırma sistemidir.

Terminal üzerinden IP adresinizi öğrenmek için şu komutu kullanın:
```bash
hostname -I
```

Çıktıda genellikle `192.168.x.x` veya `10.x.x.x` formatında bir adres yer alır. Bu adres, bulunduğunuz LAN içerisindeki kimliğinizdir. Diğer cihazlar, tarayıcılarının adres çubuğuna bu IP adresini girerek sizin sunucunuza ulaşabilirler.

Aşağıdaki şemada, bir yerel ağdaki istemci-sunucu iletişiminin temel modeli görülmektedir:

```mermaid
graph LR
    Client["İstemci (Client)<br>Web Tarayıcı"]
    Router(("Ağ Anahtarı<br>(Switch)"))
    Server["Sunucu (Server)<br>Nginx (Örn: 10.220.17.50)"]

    Client -->|" HTTP İsteği (Port 80)"| Router
    Router --> Server
    Server -->|" HTTP Yanıtı (HTML)"| Router
    Router --> Client
```

Bu mimaride istemci HTTP üzerinden 80 numaralı porta bir istek gönderir. Ağ anahtarı bu isteği doğru IP adresine yönlendirir ve sunucu işlediği belgeyi aynı yol üzerinden istemciye geri iletir. Bu yapı web teknolojilerinin temel çalışma prensibidir.
