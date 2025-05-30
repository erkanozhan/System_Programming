$remotePC = "BLUE"

# Bağlanılacak uzak bilgisayarın IP adresi

$cred = Get-Credential
# Kimlik doğrulama için kullanıcıdan kullanıcı adı ve parola ister

Invoke-Command -ComputerName $remotePC -ScriptBlock {
    Get-Process
    # Uzak bilgisayarda çalışan işlemleri listeler
} -Credential $cred
# Sağlanan kimlik bilgileriyle komutu çalıştırır