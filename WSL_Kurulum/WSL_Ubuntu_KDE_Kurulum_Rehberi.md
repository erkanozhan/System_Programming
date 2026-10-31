# WSL ile Ubuntu + KDE Masaüstü Kurulumu (Windows 11)

WSL (Windows Subsystem for Linux — Linux için Windows Alt Sistemi), Windows üzerinde sanal makine kurmadan gerçek bir Linux dağıtımı çalıştırmayı sağlar. Bu rehber, derste kullanılan Linux komutlarını Windows bilgisayarında denemek isteyenler içindir. Komutların kendisi için [Linux terminal ders notuna](../linux-mate-terminal-ders-notu.md) bakılabilir.

> **Önce şunu bilin:** Windows 11'de WSL, grafik Linux uygulamalarını doğrudan çalıştırabilen WSLg bileşeniyle birlikte gelir. Yalnızca terminal veya tek tek grafik uygulamalar (örneğin `gedit`, `firefox`) gerekiyorsa aşağıdaki 4–8. adımlara gerek yoktur; uygulama Ubuntu terminalinden adıyla başlatılır ve Windows masaüstünde kendi penceresinde açılır. KDE gibi tam bir masaüstü ortamı isteniyorsa xrdp ile Uzak Masaüstü bağlantısı kurulur.

## Adım Adım Kurulum

### 1. WSL'yi Etkinleştirin

**PowerShell'i yönetici olarak açın** ve şu komutu çalıştırın:

``` powershell
wsl --install
```

> Bu komut WSL2 altyapısını ve varsayılan dağıtım olarak Ubuntu'yu kurar. Başka bir dağıtım kurmak için önce `wsl --list --online` ile kullanılabilir dağıtımlar listelenir, ardından `wsl --install -d <dağıtım-adı>` yazılır. Kurulum sonunda bilgisayarın yeniden başlatılması istenebilir.

------------------------------------------------------------------------

### 2. Ubuntu İlk Ayarları

Ubuntu ilk açıldığında:

-   Yeni bir kullanıcı adı girin.
-   Parola belirleyin (yazarken ekranda karakter görünmez; bu normaldir).

------------------------------------------------------------------------

### 3. Paketleri Güncelleyin

Ubuntu terminalinde:

``` bash
sudo apt update && sudo apt upgrade -y
```

------------------------------------------------------------------------

### 4. KDE Plasma Masaüstünü Kurun

``` bash
sudo apt install kde-plasma-desktop -y
```

------------------------------------------------------------------------

### 5. xrdp Kurulumu

``` bash
sudo apt install xrdp -y
```

Windows'un kendi Uzak Masaüstü hizmeti de 3389 numaralı portu kullanır. Çakışmayı önlemek için xrdp'nin portunu 3390 olarak değiştirin:

``` bash
sudo sed -i 's/^port=3389/port=3390/' /etc/xrdp/xrdp.ini
```

`systemctl` komutunun çalışması için WSL'de systemd'nin etkin olması gerekir. Güncel Ubuntu kurulumlarında varsayılan olarak etkindir; `cat /etc/wsl.conf` çıktısında `[boot]` başlığı altında `systemd=true` satırı görülmelidir. Ardından:

``` bash
sudo systemctl enable --now xrdp
```

------------------------------------------------------------------------

### 6. KDE Oturumu Tanımlayın

``` bash
echo "startplasma-x11" > ~/.xsession
```

------------------------------------------------------------------------

### 7. WSL Dağıtımını Kapatın ve Yeniden Başlatın

``` bash
exit
```

Sonra Windows terminalinden:

``` powershell
wsl --shutdown
```

Ardından Başlat menüsünden **Ubuntu**'yu yeniden açın. xrdp hizmeti dağıtım açıldığında başlar; Uzak Masaüstü bağlantısı sırasında Ubuntu penceresi açık kalmalıdır.

------------------------------------------------------------------------

### 8. Windows'tan KDE'ye Bağlanın

-   **Başlat** menüsüne **Uzak Masaüstü Bağlantısı** yazın ve uygulamayı açın.
-   Bilgisayar adresi olarak şunu girin:

```text
localhost:3390
```

Kullanıcı adı ve parolanızı Ubuntu'da belirlediğiniz şekilde girin.

------------------------------------------------------------------------

### 8.1 Bağlantı Sorunu Yaşarsanız

Ubuntu terminalinde şu komutla WSL'nin IP adresini öğrenin:

``` bash
hostname -I
```

Ayrıntılı çıktı için `ip addr show eth0` komutu kullanılabilir; `inet` satırındaki adres WSL'nin adresidir. Eski kaynaklarda bu iş için `ifconfig` komutu ve `net-tools` paketi önerilir; bu araç kullanımdan kalkmıştır ve `ip` komutu tercih edilmelidir.

Bulduğunuz adresi (örneğin `172.25.250.17`) port numarasıyla birlikte kullanın:

```text
172.25.250.17:3390
```

Bağlantı yine kurulamıyorsa `sudo systemctl status xrdp` ile hizmetin çalışıp çalışmadığını kontrol edin.

------------------------------------------------------------------------

## Kurulum Tamamlandı

Artık KDE masaüstünü WSL üzerinden grafik arayüzle kullanabilirsiniz.
