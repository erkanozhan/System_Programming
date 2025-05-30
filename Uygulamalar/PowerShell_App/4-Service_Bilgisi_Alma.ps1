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