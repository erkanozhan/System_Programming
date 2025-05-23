
# PowerShell Nedir?

PowerShell, Microsoft tarafından geliştirilen, sistem yöneticilerine ve geliştiricilere yönelik güçlü bir **komut satırı kabuğu** ve **betik dili**dir. .NET tabanlıdır ve **nesne yönelimli** çalışır. Windows, macOS ve Linux sistemlerinde kullanılabilir.

## PowerShell Özellikleri

- **Nesne tabanlıdır**: Komut çıktıları düz metin değil, .NET nesneleridir.
- **Cmdlet** adı verilen yerleşik komutları vardır (örn: `Get-Process`).
- **Pipe (`|`) kullanımı** metin yerine nesneleri aktarır.
- Hem **etkileşimli kabuk** hem de **otomasyon betik dili** olarak çalışır.
- Bash’e göre daha gelişmiş veri işleme ve sistem erişimi imkânı sunar.

---

## Temel PowerShell Komutları

### 1. Değişken Tanımlama ve Yazdırma

```powershell
$isim = "Erkan"
Write-Output "Merhaba $isim"
```

### 2. Sistem Süreçlerini Listeleme

```powershell
Get-Process
```

### 3. CPU Kullanımı 50'den Fazla Olan Süreçleri Filtreleme

```powershell
Get-Process | Where-Object { $_.CPU -gt 50 }
```

### 4. Klasör İçeriğini Listeleme

```powershell
Get-ChildItem "C:\Users\Erkan\Belgeler"
```

Kısayol: `gci` olarak da yazılabilir.

### 5. Fonksiyon Tanımı

```powershell
function Selamla($isim) {
    "Merhaba, $isim. PowerShell'e hoş geldin."
}

Selamla "Erkan"
```

---

## PowerShell Betiği (.ps1) Oluşturma ve Çalıştırma

### 1. Betik Dosyası Oluşturma

Bir `.ps1` dosyası oluşturun (örnek: `1-Giris.ps1`) ve aşağıdaki gibi bir kod yazın:

```powershell
Write-Output "PowerShell betiği başarıyla çalıştı."
```

### 2. Betiği Çalıştırma

Terminalden çalıştırmak için:

```powershell
.\1-Giris.ps1
```

### 3. Execution Policy Ayarını Yapılandırma

PowerShell betiklerinin çalışabilmesi için izin gerekli olabilir. Şu komutla izin verilir:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Politika düzeylerini listelemek için:

```powershell
Get-ExecutionPolicy -List
```

---

## Yardım Alma (Help)

Bir komut hakkında yardım almak için:

```powershell
Get-Help Get-Process
```

---

## PowerShell ile Bash Arasındaki Fark (Örnek)

**PowerShell (nesne yönelimli):**

```powershell
Get-Process | Select-Object Name, CPU
```

**Bash (metin tabanlı):**

```bash
ps aux | awk '{print $11, $3}'
```

PowerShell, işlemleri nesne olarak işlerken Bash düz metinle çalışır. Bu, PowerShell’e veri filtreleme ve dönüştürmede büyük esneklik kazandırır.

---

## Ekstra: PowerShell'de Dosya Boyutu Sorgulama

```powershell
(Get-Item "C:\Users\Erkan\Belgeler\ornek.txt").Length
```

---

PowerShell, sistem yönetimini otomatikleştirmek ve günlük görevleri hızlandırmak için mükemmel bir araçtır. Bash'e göre daha yapısal, nesne tabanlı bir yaklaşım sunar. VS Code gibi editörlerle birlikte kullanıldığında çok daha kullanışlı hale gelebilir.
