# UYARI: Servis başlatma/durdurma yönetici yetkisi ister; PowerShell'i "Yönetici olarak" açın.
# Deneme için Windows Update (wuauserv) veya Windows Defender gibi kritik servisleri kullanmayın.
$serviceName = "Spooler"  # Yazdırma kuyruğu servisinin adını değişkene atar

$service = Get-Service -Name $serviceName  
# Yukarıda tanımlanan servisin nesnesini getirir ve $service değişkenine atar

if ($service.Status -eq "Running") {
    # Eğer servis halihazırda çalışıyorsa...
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