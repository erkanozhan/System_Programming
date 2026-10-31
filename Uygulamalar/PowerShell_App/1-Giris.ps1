$name=Read-Host "Adınızı Girin"
[int]$age=Read-Host "Yaşınızı Girin"
if ($age -lt 18) {
    Write-Output "$name, çocuk yaş grubundasınız."
} else {
    Write-Output "$name, yetişkin yaş grubundasınız."
}

# Betik "çalıştırma devre dışı" hatası verirse, yürütme ilkesini yalnızca kendi
# kullanıcı hesabınız için değiştirebilirsiniz (yönetici yetkisi gerekmez):
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Ayrıntı: PowerShell_Giris/PowerShell.md, "Execution Policy" bölümü
