# Windows'ta Başlangıçta Açılan Programları PS ile Devre Dışı Bırakmak: OneNote ve DeepL Örneği

## Problem Tanımı

Bazı uygulamalar (örneğin OneNote ve DeepL), bilgisayar her açıldığında otomatik olarak çalışmakta ve görev çubuğundaki sistem tepsisinde simge olarak görünmektedir. Bu durum, istenmeyen kaynak tüketimine ve dikkat dağınıklığına yol açabilir. Kullanıcılar bu uygulamaların otomatik başlatılmasını engellemek isteyebilir.

## Amaç

PowerShell komutları kullanılarak, kayıt defteri veya başlangıç klasörü aracılığıyla otomatik olarak başlayan uygulamaların sistem başlangıcında devre dışı bırakılması hedeflenmektedir.

## DeepL Uygulaması İçin İşlem Adımları

### 1. Kayıt defteri girdisinin kontrol edilmesi

Aşağıdaki komut, DeepL uygulamasının kayıt defteri üzerinde başlangıç girdisinin olup olmadığını kontrol eder:

```powershell
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" | Select-Object deepl*
```

### 2. Kayıt girdisinin silinmesi

Eğer ilgili anahtar bulunursa, aşağıdaki komut ile kaldırılabilir:

```powershell
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "deepl" -ErrorAction SilentlyContinue
```

Bu işlem, DeepL uygulamasının sistem açılışında otomatik olarak başlatılmasını engeller.

## OneNote Uygulaması İçin İşlem Adımları

### 1. Başlangıç klasörünün kontrol edilmesi

OneNote uygulaması genellikle başlangıç klasörüne bir kısayol ekleyerek başlatılır. Aşağıdaki komutla bu klasör içinde OneNote ile ilgili bir kısayol olup olmadığı kontrol edilir:

```powershell
Get-ChildItem -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" | Where-Object Name -like "*OneNote*"
```

### 2. Kısayolun silinmesi

Eğer bir kısayol bulunduysa, şu komutla silinebilir:

```powershell
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\OneNote'a Gönder.lnk"
```

## Alternatif Yöntemler

- Görev Yöneticisi > Başlangıç sekmesi üzerinden uygulamaları devre dışı bırakmak
- Ayarlar > Uygulamalar > Başlangıç menüsünden kontrol sağlamak
- Microsoft'un resmi aracı olan Autoruns (Sysinternals) yazılımını kullanmak

## Not

Bazı uygulamalar kendini görev zamanlayıcı ya da servis olarak da başlatabilir. Yukarıdaki işlemler yeterli gelmezse bu yapıların ayrıca incelenmesi gerekir.

## Ekstra Komut: Başlangıçta Açılan Diğer Programları Listeleme

Kayıt defterinde sistem başlangıcında açılan tüm uygulamaları listelemek için:

```powershell
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
```
