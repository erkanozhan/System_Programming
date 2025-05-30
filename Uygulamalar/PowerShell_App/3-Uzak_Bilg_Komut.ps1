$remotePC = "10.202.18.62"
# Uzak bilgisayarın IP adresi bir değişkende saklanır.

$cred = Get-Credential
# Kullanıcıdan kimlik doğrulama amacıyla kullanıcı adı ve parola bilgileri alınır.

Invoke-Command -ComputerName $remotePC -ScriptBlock {
    Get-Process
    # Hedef bilgisayarda çalışan tüm süreçler sorgulanır ve listelenir.
} -Credential $cred
# Komut, sağlanan kimlik bilgileriyle birlikte uzak bilgisayarda yürütülür.
