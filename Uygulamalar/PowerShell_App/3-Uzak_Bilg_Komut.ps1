$remotePC = "PC01"
# Uzak bilgisayarın adı (veya IP adresi) bir değişkende saklanır.
# Hedef bilgisayarda WinRM etkin olmalıdır: Enable-PSRemoting -Force (yönetici olarak)

$cred = Get-Credential
# Kullanıcıdan kimlik doğrulama amacıyla kullanıcı adı ve parola bilgileri alınır.

Invoke-Command -ComputerName $remotePC -ScriptBlock {
    Get-Process
    # Hedef bilgisayarda çalışan tüm süreçler sorgulanır ve listelenir.
} -Credential $cred
# Komut, sağlanan kimlik bilgileriyle birlikte uzak bilgisayarda yürütülür.
