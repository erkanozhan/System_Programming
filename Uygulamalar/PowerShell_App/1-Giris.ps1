$name=Read-Host "Adınızı Girin"
$age=Read-Host "Yaşınızı Girin"
if ($age -lt 18) {
Write-Output "Çocuk"
} else {
    Write-Output "Yetişkin"
}