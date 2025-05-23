Get-ChildItem | ForEach-Object {
   Write-Output "Dosya: $($_.Name)- Boyut: $($_.Length) byte"
} 