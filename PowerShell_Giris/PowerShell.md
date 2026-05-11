
# PowerShell

PowerShell, Microsoft tarafından geliştirilen, .NET platformu üzerine inşa edilmiş bir **komut satırı kabuğu** (command-line shell) ve **betik dili**dir (scripting language). Windows, macOS ve Linux üzerinde çalışır.

## Kabuk (Shell) Kavramı

"Kabuk" terimi kasıtlı seçilmiş bir isimdir: işletim sisteminin çekirdeğini (kernel) dışarıdan saran, kullanıcıyla çekirdek arasında aracılık eden katmana verilen addır. Terminal penceresine yazdığınız komut doğrudan donanıma ulaşmaz; önce kabuğun içinden geçer.

Bir restoranı düşünün: siparişi siz verirsiniz, garson mutfakla konuşur, sonucu size getirir. Siz mutfakla doğrudan muhatap olmazsınız. Kabuk da tam bu rolü üstlenir — sizin yazdıklarınızı işletim sisteminin anlayacağı biçime çevirir ve yanıtı size geri sunar.

PowerShell, klasik Unix/Linux kabuklarından (Bash, sh, zsh) köklü biçimde ayrılır: komut çıktıları **düz metin değil, .NET nesneleridir**. Bu ayrım ilk bakışta küçük görünse de pratikte her şeyi değiştirir; bunu pipeline konusunda somut olarak göreceğiz.

---

## Cmdlet Yapısı (Verb-Noun Pattern)

PowerShell komutlarına **cmdlet** (*command-let*, "küçük komut" anlamında) denir. Her cmdlet `Fiil-İsim` (Verb-Noun) biçiminde adlandırılır:

| Cmdlet | Anlamı |
| --- | --- |
| `Get-Process` | Çalışan süreçleri listele |
| `Set-Location` | Çalışma dizinini değiştir |
| `New-Item` | Yeni dosya veya klasör oluştur |
| `Remove-Item` | Dosya veya klasör sil |
| `Stop-Process` | Süreci durdur |
| `Start-Service` | Sistem hizmetini başlat |

Bu adlandırma standardı öğrenildiğinde, daha önce hiç karşılaşılmamış bir cmdlet adı tahmin edilebilir hale gelir. "Hizmetleri nasıl listelerim?" sorusunun yanıtı `Get-Service`'tir; denemeden önce bile bilinebilir. Desen bir kez oturdu mu, binlerce cmdlet kendiliğinden anlamlıdır.

![Cmdlet Verb-Noun Yapısı](images/ps-cmdlet-yapi.svg)

---

## Temel Komutlar

### Değişken Tanımlama (Variable)

PowerShell'de değişkenler `$` işaretiyle başlar:

```powershell
$isim = "Ali"
Write-Output "Merhaba $isim"
```

### Süreçleri Listeleme

```powershell
Get-Process
```

### Filtreleme: CPU Kullanımı 50'yi Aşan Süreçler

```powershell
Get-Process | Where-Object { $_.CPU -gt 50 }
```

`$_` sözdizimi, pipeline'dan gelen **geçerli nesneyi** temsil eder. Her nesne geçerken "bu nesnenin CPU özelliği 50'den büyük mü?" sorusu sorulur; evet ise ileri iletilir, hayır ise elenir.

### Klasör İçeriğini Listeleme

```powershell
Get-ChildItem C:\Users
```

`gci` kısaltmasıyla da yazılabilir. Linux'taki `ls` komutunun işlevsel karşılığıdır.

### Fonksiyon Tanımı (Function)

```powershell
function Selamla($isim) {
    "Merhaba, $isim."
}

Selamla "Ali"
```

---

## Pipeline (Boru Hattı)

`|` (pipe, boru hattı) operatörü, PowerShell'in en belirleyici özelliğidir. Bir fabrika üretim bandını düşünün: birinci istasyon hammaddeyi işleyip ikinciye verir, ikinci kendi işini yapıp üçüncüye aktarır. Her istasyon yalnızca kendine düşen işi yapar, ama sonuçta ortaya çıkan ürün tüm istasyonların katkısıdır. PowerShell pipeline'ı da böyle çalışır — her komut, bir sonrakine **işlenmiş nesne** iletir:

```powershell
Get-Process | Where-Object { $_.CPU -gt 50 } | Sort-Object CPU -Descending
```

Bu tek satır şunu yapar:

1. Tüm süreçleri alır,
2. CPU > 50 olanları filtreler,
3. CPU değerine göre büyükten küçüğe sıralar.

![Pipeline Nesne Akışı](images/ps-pipeline.svg)

**PowerShell ile Bash Karşılaştırması:**

```bash
# Bash: metin tabanlı — sütun sırası değişirse veya boşluk sayısı artarsa kod kırılabilir
ps aux | awk '{print $11, $3}' | sort -k2 -rn
```

```powershell
# PowerShell: nesne tabanlı — alan adıyla erişilir, biçim sorunları yoktur
Get-Process | Select-Object Name, CPU | Sort-Object CPU -Descending
```

Bash'te veriyi kullanabilmek için `awk`, `grep`, `cut` gibi araçlarla metni elle ayrıştırmak gerekir; çıktı biçimi değiştiğinde kod kırılabilir. PowerShell'de nesne üzerinde çalışıldığından bu kırılganlık yoktur.

---

## Execution Policy (Yürütme İlkesi)

PowerShell, betiklerin çalıştırılmasını güvenlik amacıyla kısıtlar. Windows'ta varsayılan politika `Restricted`'dir: hiçbir `.ps1` dosyası çalışmaz.

"Execute" kelimesi Latince *exsequi*'den gelir: "sonuna kadar götürmek, gerçekleştirmek." Policy ise Yunanca *politeia*'dan: "yönetim düzeni." Yani Execution Policy, "hangi betiklerin çalıştırılmasına izin verildiğini düzenleyen kural" demektir. Bu kural sisteme dışarıdan gelen zararlı betiklere karşı bir güvenlik katmanıdır.

![Execution Policy Düzeyleri](images/ps-execution-policy.svg)

| Politika | Davranış |
| --- | --- |
| `Restricted` | Hiçbir betik çalışmaz (Windows varsayılanı) |
| `AllSigned` | Yalnızca dijital imzalı betikler çalışır |
| `RemoteSigned` | Yerel betikler serbest; uzaktan indirilenler imza ister |
| `Unrestricted` | Her şey çalışır; üretim ortamı için önerilmez |

Mevcut politika düzeyini görmek için:

```powershell
Get-ExecutionPolicy -List
```

Geliştirme ortamı için önerilen ayar:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Bu komut yönetici yetkisi **gerektirmez**; yalnızca kendi kullanıcı hesabınıza uygulanır. Tüm sistemi kapsayan bir değişiklik için `-Scope LocalMachine` kullanılır ve bu durumda PowerShell'i **Yönetici (Administrator) olarak** açmak gerekir.

---

## PowerShell Betiği (.ps1) Oluşturma ve Çalıştırma

### Betik Dosyası Oluşturma

Uzantısı `.ps1` olan bir dosya oluşturun (örnek: `1-Giris.ps1`). `.ps1` uzantısı, PowerShell 1.0'dan gelen tarihsel bir isimlendirmedir.

```powershell
Write-Output "PowerShell betiği çalıştı."
```

### Betiği Çalıştırma

```powershell
./1-Giris.ps1
```

> **Not:** PowerShell hem `.\` (backslash, Windows) hem de `./` (forward slash, Unix) yol ayracını kabul eder. Her ikisi de çalışır; Linux alışkanlığıyla `./` yazmak doğrudur.

---

## Yardım Alma (Get-Help)

Herhangi bir cmdlet hakkında ayrıntılı bilgi için:

```powershell
Get-Help Get-Process
Get-Help Get-Process -Examples
Get-Help Get-Process -Full
```

`-Examples` parametresi, cmdlet'in gerçek kullanım örneklerini getirir. Yeni bir cmdlet öğrenirken belgeleri okumaya buradan başlamak en verimli yoldur.

---

## Dosya Boyutu Sorgulama

```powershell
(Get-Item "C:\dosya\yolu\ornek.txt").Length
```

`Get-Item` bir `FileInfo` nesnesi döndürür. Noktadan sonra gelen `Length`, bu nesnenin bayt cinsinden boyutunu tutan özelliğidir (property). Parantez, önce cmdlet'in çalıştırılmasını, ardından dönen nesne üzerindeki özelliğe erişilmesini sağlar.
