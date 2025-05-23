$name=Read-Host "Adınızı Girin"
[int]$age=Read-Host "Yaşınızı Girin"
if ($age -lt 18) {
Write-Output "Çocuk"
} else {
    Write-Output "Yetişkin"
}

# PowerShell'i Yönetici olarak çalıştırıp, aşağıdaki komutları çalıştırırsanız,
# güvenlik ayarlarını değiştirebilirsiniz.
# `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
