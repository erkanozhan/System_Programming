# PowerShell Scriptleri

## Örnek 1: Windows Servisini Kontrol Etme

### Script

```powershell
$serviceName = "wuauserv"  # Windows Update servis adını değişkene atar

$service = Get-Service -Name $serviceName  
# Yukarıda tanımlanan servisin nesnesini getirir ve $service değişkenine atar

if ($service.Status -eq "Running") {
    # Eğer servis hali hazırda çalışıyorsa...
    Stop-Service -Name $serviceName -Force
    # Servisi zorla durdurur
    Write-Host "$serviceName servisi durduruldu."
    # Kullanıcıya bilgi verir
} else {
    Start-Service -Name $serviceName
    # Servis çalışmıyorsa başlatılır
    Write-Host "$serviceName servisi başlatıldı."
    # Bilgilendirme yapılır
}
```

---

## Örnek 2: Olay Günlüğünden Son 10 Kaydı Almak

```powershell
Get-EventLog -LogName Application -Newest 10
# "Application" log dosyasından en son 10 girdiyi getirir
```

---

## Örnek 3: Kullanıcıdan Şifre Al ve Şifreli Kaydet

```powershell
$securePassword = Read-Host -AsSecureString "Parolanızı girin"
# Kullanıcıdan şifre alır ve güvenli (SecureString) formatında saklar

$encrypted = ConvertFrom-SecureString $securePassword
# Güvenli şifreyi metin olarak saklanabilir hale getirir (şifrelenmiş string)

Set-Content -Path "sifre.txt" -Value $encrypted
# Şifreli stringi "sifre.txt" dosyasına yazar
```

---

## Örnek 4: Şifreli Parolayı Okuma ve Görüntüleme

```powershell
$encrypted = Get-Content -Path "sifre.txt"
# Şifreli metni dosyadan okur

$securePassword = ConvertTo-SecureString -String $encrypted
# Şifreli metni tekrar güvenli stringe çevirir

$marshal = [System.Runtime.InteropServices.Marshal]
# .NET ile native memory işlemleri yapacak sınıfı çağırır

$bstr = $marshal::SecureStringToBSTR($securePassword)
# Güvenli stringi unmanaged belleğe aktarır

$plainPassword = $marshal::PtrToStringAuto($bstr)
# Unmanaged stringi okunabilir hale getirir

Write-Host "Çözülmüş parola: $plainPassword"
# Ekrana düz metin olarak yazdırır
```

---

## Örnek 5: Zamanlanmış Görev Oluşturma

```powershell
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 5am
# Görevi haftalık ve Pazartesi günleri sabah 05:00'te tetikleyecek bir zamanlayıcı oluşturur

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\scripts\health.ps1"
# Belirtilen PowerShell script dosyasını çalıştırmak için aksiyon tanımlar

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "HealthCheckTask" -Description "Weekly health check"
# Tetikleyici ve aksiyon bilgileri ile birlikte Windows zamanlanmış görev olarak kaydeder
```

---

## Örnek 6: Uzak Bilgisayarda Komut Çalıştırmak

```powershell
$remotePC = "10.1.1.12"
# Uzak bilgisayarın IP adresi bir değişkende saklanır.

$cred = Get-Credential
# Kullanıcıdan kimlik doğrulama amacıyla kullanıcı adı ve parola bilgileri alınır.

Invoke-Command -ComputerName $remotePC -ScriptBlock {
    Get-Process
    # Hedef bilgisayarda çalışan tüm süreçler sorgulanır ve listelenir.
} -Credential $cred
# Komut, sağlanan kimlik bilgileriyle birlikte uzak bilgisayarda yürütülür.
```

---

## Örnek 7: Active Directory Kullanıcılarını Listelemek

```powershell
Import-Module ActiveDirectory
# AD modülünü yükler (yüklü olmalı)

Get-ADUser -Filter * -Property Name, Department | 
    Select-Object Name, Department
# Tüm kullanıcıları getirir ve adları ile departman bilgilerini gösterir
```

---

## Örnek 8: CSV Dosyasını Filtreleme

```powershell
$students = Import-Csv "ogrenciler.csv"
# CSV dosyasını alır ve her satırı nesne olarak yükler

$passed = $students | Where-Object { $_.Not -ge 50 }
# Notu 50 ve üzeri olan öğrencileri filtreler

$passed | Export-Csv -Path "gecenler.csv" -NoTypeInformation
# Bu öğrencileri yeni bir CSV dosyasına yazar
```

---

## Örnek 9: Belirli Olay Kimliğini Listelemek

```powershell
Get-EventLog -LogName System | Where-Object { $_.InstanceID -eq 10010 }
# Sistem olay günlüğünde yalnızca olay kimliği 10010 olanları getirir
```

---

## Örnek 10: .NET Math Sınıfını Kullanmak

```powershell
$pi = [System.Math]::PI
# Pi sabitini alır

$sqrt = [System.Math]::Sqrt(64)
# 64'ün karekökünü alır

Write-Host "Pi Sayısı: $pi, Karekök(64): $sqrt"
# Sonuçları ekrana yazdırır
```

---

## Kaynak

- **Kitap**: *Ultimate PowerShell Automation for System Administration*  
  Prashanth Jayaram, Rajendra Gupta (2024)  
- **Yayınevi**: Orange Education Pvt. Ltd.  
- **Github**: [https://github.com/ava-orange-education](https://github.com/ava-orange-education)
