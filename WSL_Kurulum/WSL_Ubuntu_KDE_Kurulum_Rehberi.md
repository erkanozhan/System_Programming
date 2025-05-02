# WSL ile Ubuntu + KDE Masaüstü Kurulumu (Windows 11)

## 🔧 Adım Adım Kurulum

### 1. WSL'i Etkinleştir

**PowerShell'i yönetici olarak açın** ve şu komutu çalıştırın:

``` powershell
wsl --install
```

> Bu komut WSL2 motorunu ve dağıtımı seçip -d parametresi ile adını yazmalısınız. İsterseniz Ubuntu dağıtımını kurar. Kurulum sonunda bilgisayar yeniden başlatılabilir.

------------------------------------------------------------------------

### 2. Ubuntu İlk Ayarları

Ubuntu ilk açıldığında:

-   Yeni kullanıcı adı girin
-   Şifre belirleyin

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
sudo systemctl enable xrdp
sudo service xrdp start
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

------------------------------------------------------------------------

### 8. Windows’tan KDE’ye Bağlanın

-   **Başlat** → **Uzak Masaüstü Bağlantısı** yazın.
-   IP adresi olarak şunu girin:

```         
127.0.0.1:3389
```

Kullanıcı adı ve şifrenizi Ubuntu’da belirlediğiniz şekilde girin.

------------------------------------------------------------------------

### ⚠️ 8.1 Bağlantı Sorunu Yaşarsanız

Ubuntu terminalinde şu komutla IP adresini öğrenin:

``` bash
ifconfig
```

Eğer `ifconfig` yüklü değilse:

``` bash
sudo apt install net-tools -y
```

Çıktıdaki `inet` satırında görülen adresi (örneğin `172.25.248.1`) şu şekilde kullanın:

```         
172.25.248.1:3389
```

------------------------------------------------------------------------

## ✅ Kurulum Tamamlandı

Artık KDE masaüstünü WSL üzerinden grafik arayüzle kullanabilirsiniz.
