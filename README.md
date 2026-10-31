# Sistem Programlama Ders Notları

Bu depo, Sistem Programlama (System Programming) dersinin ders notlarını ve uygulama kodlarını içerir. Ders; işletim sisteminin kullanıcıya sunduğu arayüzleri, komut satırı kabuklarını (cmd, PowerShell, Bash), kabuk programlamayı ve süreç, dosya, izin, akış gibi temel sistem kavramlarını ele alır.

Notlar Türkçe yazılmıştır; teknik terimlerin İngilizce karşılıkları ilk geçtikleri yerde parantez içinde verilir.

## Önerilen Okuma Sırası

| Sıra | Dosya | İçerik |
|------|-------|--------|
| 1 | [sistem_programlamaya_giris.md](sistem_programlamaya_giris.md) | Sistem programlamanın kapsamı, derleme, ortam değişkenleri, dosya izinleri, dosya tanımlayıcıları, süreçler ve sinyaller |
| 2 | [MS-DOS.md](MS-DOS.md) | Windows Komut İstemi (cmd): dosya sistemi, dosya işlemleri, yönlendirme, ağ ve süreç komutları, batch dosyaları |
| 3 | [PowerShell_Giris/PowerShell.md](PowerShell_Giris/PowerShell.md) | PowerShell temelleri: cmdlet yapısı, nesne tabanlı boru hattı, yürütme ilkesi, servis, ağ, olay günlüğü, uzak yönetim, hata yönetimi |
| 4 | [PowerShell_Giris/2-Baslangic_prog_yonetme.md](PowerShell_Giris/2-Baslangic_prog_yonetme.md) | Windows başlangıç programlarının kayıt defteri, başlangıç klasörü ve görev zamanlayıcı üzerinden yönetimi |
| 5 | [PowerShell_Giris/3-Uygulamalar.md](PowerShell_Giris/3-Uygulamalar.md) | PowerShell betik uygulamaları |
| 6 | [linux-mate-terminal-ders-notu.md](linux-mate-terminal-ders-notu.md) | Linux terminali ve Bash: dosya sistemi, metin işleme, izinler, süreçler, ağ, paket yönetimi ve kapsamlı kabuk programlama (Bölüm 8) |

## Uygulamalar

| Klasör / Dosya | İçerik |
|----------------|--------|
| [Uygulamalar/Bash_App](Uygulamalar/Bash_App/) | Bash betikleri: çarpma, T.C. kimlik numarası denetimi ve kaydı, dosya okuma, dosya boyutu; ayrıca [fonksiyonlar](Uygulamalar/Bash_App/Functions.md), [yedekleme ve cron](Uygulamalar/Bash_App/yedekleme.md), [T.C. kimlik betiğinin açıklaması](Uygulamalar/Bash_App/2-TC_kimlik_kontrol-Aciklama.md) ve alıştırma verisi [notlar.csv](Uygulamalar/Bash_App/notlar.csv) |
| [Uygulamalar/PowerShell_App](Uygulamalar/PowerShell_App/) | PowerShell betikleri: giriş, dosya boyutu, uzak bilgisayarda komut çalıştırma, servis denetimi |
| [Uygulamalar/Network_App/nginx_web_server.md](Uygulamalar/Network_App/nginx_web_server.md) | Nginx web sunucusu kurulumu ve yerel ağda istemci-sunucu iletişimi |
| [WSL_Kurulum/WSL_Ubuntu_KDE_Kurulum_Rehberi.md](WSL_Kurulum/WSL_Ubuntu_KDE_Kurulum_Rehberi.md) | Windows 11 üzerinde WSL ile Ubuntu ve KDE masaüstü kurulumu |

Görseller `images/` ve `PowerShell_Giris/images/` klasörlerindedir.

## Çalışma Ortamı

- **Linux bölümleri** Ubuntu MATE veya başka bir Debian/Ubuntu tabanlı dağıtım üzerinde denenmek üzere yazılmıştır. Windows kullananlar WSL rehberini izleyebilir.
- **PowerShell bölümleri** Windows ile birlikte gelen Windows PowerShell 5.1 ve ayrıca kurulan PowerShell 7 için geçerlidir; iki sürüm arasındaki farklar PowerShell notunun girişinde özetlenmiştir.
- Bash betiklerini çalıştırmadan önce çalıştırma izni verilmelidir: `chmod +x betik.sh`.

## Güvenlik Notu

Notlarda dosya silme (`rm -rf`, `rd /s /q`), servis durdurma ve sistem ayarı değiştirme komutları yer alır. Bu komutlar yalnızca deneme klasörlerinde ve kişisel bilgisayarlarda, ilgili uyarılar okunduktan sonra çalıştırılmalıdır.

## Lisans

Bu depo [LICENSE](LICENSE) dosyasında belirtilen koşullarla paylaşılmaktadır.
