# MS-DOS ve Komut Satırı (Command Prompt) Ders Notu

## Neden Komut Satırı?

Bilgisayarla ilk etkileşim aslında bir metin ekranında başladı. Fare yoktu, pencereler yoktu; sadece yanıp sönen bir imleç (cursor) ve klavye vardı. Kullanıcı bir komut yazardı, bilgisayar cevap verirdi. Bu diyalog biçimi, grafik arayüzlerin (GUI — Graphical User Interface, Grafik Kullanıcı Arayüzü) yaygınlaşmasıyla geri plana düştü ama hiçbir zaman önemini kaybetmedi.

Bugün bir sunucu (server) yönetiyorsanız, büyük olasılıkla karşınızda bir komut satırı var. Bir ağ sorununu teşhis edecekseniz, yine komut satırına düşersiniz. Yüzlerce dosyayı toplu olarak yeniden adlandırmak istediğinizde fareyle tek tek tıklamak yerine tek bir satır yazarsınız. Kısacası komut satırı, bilgisayar mühendisinin İngiliz anahtarıdır — her zaman çantada bulunur.

---

## MS-DOS Nedir?

MS-DOS (Microsoft Disk Operating System — Microsoft Disk İşletim Sistemi), 1981'de IBM PC ile birlikte piyasaya çıkan, metin tabanlı bir işletim sistemiydi. "DOS" kelimesinin kökü "Disk Operating System" kısaltmasıdır; yani disk üzerinde çalışan işletim sistemi. Windows'un ilk sürümleri aslında DOS üzerinde bir kabuk (shell) olarak çalışıyordu.

Bugün Windows üzerinde kullandığımız **Komut İstemi** (Command Prompt, kısaca **cmd**), MS-DOS'un doğrudan devamı sayılır. Komutların büyük çoğunluğu aynıdır. Bu yüzden "MS-DOS komutları" ile "cmd komutları" ifadeleri pratikte birbirinin yerine kullanılır.

> **Not:** Windows 10/11'de **PowerShell** adında daha gelişmiş bir komut satırı da bulunur. Bu derste odak noktamız klasik cmd komutlarıdır; çünkü bunlar temeldir ve PowerShell'i anlamak için de bu temelin sağlam olması gerekir.

---

## Komut İstemi'ni Açmak

Birkaç yol var:

1. **Win + R** tuşlarına basıp `cmd` yazın, Enter'a basın.
2. Başlat menüsüne `cmd` veya `Komut İstemi` yazın.
3. Yönetici (administrator) olarak açmak için sağ tıklayıp "Yönetici olarak çalıştır" seçin.

Açıldığında şöyle bir satır görürsünüz:

```
C:\Users\KullaniciAdi>
```

Bu satıra **prompt** (komut istemi) denir. Buradaki `C:\Users\Kullanici` sizin o an bulunduğunuz dizini (directory, klasör) gösterir. `>` işareti ise "komutunu bekliyorum" demektir. Bilgisayar tam anlamıyla sizinle konuşmaya hazır.

---

## BÖLÜM 1 — Dosya Sistemi ve Temel Gezinme

### Dosya Sistemi Yapısı

Windows'un dosya sistemi bir ağaç (tree) yapısındadır. Kök (root) en üsttedir ve `C:\` ile gösterilir. Her şey bu kökten dallanır.

```
C:\
├── Users\
│   ├── Kullanici\
│   │   ├── Desktop\
│   │   ├── Documents\
│   │   └── Downloads\
├── Windows\
│   ├── System32\
│   └── Temp\
├── Program Files\
└── Program Files (x86)\
```

Her `\` (ters eğik çizgi, backslash) bir dizin seviyesini ayırır. `C:\Users\Kullanici\Desktop` ifadesi şu anlama gelir: C sürücüsü → Users klasörü → Kullanici klasörü → Desktop klasörü.

---

### `ver` — Sürüm Bilgisi

**ver** (version — sürüm) komutu, işletim sisteminin sürüm numarasını gösterir.

```
C:\>ver

Microsoft Windows [Sürüm 10.0.19045.3803]
```

Kısa, öz, işe yarar. Özellikle uzaktan bağlandığınız bir makinede "Bu hangi Windows?" sorusuna anında cevap verir.

---

### `cls` — Ekranı Temizle

**cls** (Clear Screen — Ekranı Temizle) komutu ekrandaki tüm yazıları siler ve imleci sol üst köşeye taşır.

```
C:\>cls
```

Ekran kalabalıklaştığında `cls` yazıp temiz bir sayfa açmak, defterde yeni bir sayfaya geçmek gibidir.

---

### `date` ve `time` — Tarih ve Saat

```
C:\>date /t
16.02.2026

C:\>time /t
14:30
```

`/t` parametresi (switch), sadece göster ama değiştirme anlamına gelir. `/t` olmadan yazarsanız, sistem sizden yeni tarih/saat girmenizi ister.

---

### `dir` — Dizin İçeriğini Listele

**dir** (Directory — Dizin) komutu, bulunduğunuz klasörün içeriğini listeler. Latince *dirigere* (yönlendirmek) kökünden gelir — sizi dosyalarınıza yönlendirir.

```
C:\Users\Kullanici>dir
```

Çıktıda her satırda bir dosya veya klasör görürsünüz:

```
 C:\Users\Kullanici dizini

16.02.2026  10:30    <DIR>          Desktop
16.02.2026  09:15    <DIR>          Documents
16.02.2026  08:45    <DIR>          Downloads
15.02.2026  22:10         1.234.567 rapor.docx
15.02.2026  20:05            45.678 notlar.txt
               2 Dosya       1.280.245 bayt
               3 Dizin  50.123.456.789 bayt boş
```

`<DIR>` etiketi dizinleri, sayılar ise dosya boyutlarını (bayt cinsinden) gösterir.

**Sık kullanılan parametreler:**

| Parametre | Anlamı |
|-----------|--------|
| `dir /w` | Geniş (wide) format — sadece isimler, yan yana |
| `dir /p` | Sayfa sayfa (page) gösterir, bir ekran dolunca durur |
| `dir /a` | Gizli (hidden) dosyalar dahil tüm (all) dosyaları gösterir |
| `dir /s` | Alt dizinleri de (subdirectories) tarar |
| `dir /o:n` | İsme göre (name) sıralar |
| `dir /o:s` | Boyuta göre (size) sıralar |
| `dir /o:d` | Tarihe göre (date) sıralar |

```
C:\>dir /s *.txt
```

Bu komut, C:\ altındaki tüm `.txt` dosyalarını alt klasörler dahil arar. Bir nevi basit bir dosya arama motorudur.

---

### `cd` — Dizin Değiştir

**cd** (Change Directory — Dizin Değiştir) komutu, dosya sistemi ağacında hareket etmenizi sağlar.

```
C:\>cd Users
C:\Users>cd Kullanici
C:\Users\Kullanici>cd Desktop
C:\Users\Kullanici\Desktop>
```

Bu üç adımı tek satırda da yazabilirsiniz:

```
C:\>cd Users\Kullanici\Desktop
```

**Özel kısayollar:**

| Komut | Anlamı |
|-------|--------|
| `cd ..` | Bir üst dizine çık (parent directory) |
| `cd \` | Doğrudan köke (root) dön |
| `cd` | (parametresiz) Bulunduğun dizini göster |

`..` (iki nokta) her zaman "bir üst klasör" demektir. Bunu bir binanın asansörü gibi düşünün: `cd ..` bir kat yukarı, `cd \` doğrudan zemin kata.

**Mutlak (absolute) ve göreli (relative) yol farkı:**

- **Mutlak yol:** Kökten başlar. `cd C:\Windows\System32`
- **Göreli yol:** Bulunduğunuz yerden başlar. `cd Documents\Odevler`

**Sürücü değiştirme:**

`cd` komutu sürücü değiştirmez. Başka bir sürücüye geçmek için sadece sürücü harfini ve iki noktayı yazın:

```
C:\>D:
D:\>
```

---

### `md` (veya `mkdir`) — Dizin Oluştur

**md** (Make Directory — Dizin Oluştur) komutu yeni bir klasör yaratır.

```
C:\>md Projeler
C:\>md Projeler\Odev1\Veriler
```

İkinci komut, iç içe üç klasörü tek seferde oluşturur. Eğer `Projeler` zaten varsa, sadece alt klasörleri yaratır.

---

### `rd` (veya `rmdir`) — Dizin Sil

**rd** (Remove Directory — Dizin Kaldır) komutu bir klasörü siler. Latince *removere* (kaldırmak, uzaklaştırmak) kökünden.

```
C:\>rd Projeler\Odev1\Veriler
```

Varsayılan olarak sadece boş dizinleri siler. İçi dolu bir dizini silmek için:

```
C:\>rd /s /q Projeler
```

- `/s` — alt dizinler dahil her şeyi sil (subdirectories)
- `/q` — onay sorma, sessizce sil (quiet)

> ⚠️ **Dikkat:** `rd /s /q` geri dönüşü olmayan bir işlemdir. Çöp kutusuna gitmez. Bu komutu yazmadan önce iki kere düşünün. Bir cerrahın neşteri nasıl dikkatli kullanılması gerekiyorsa, bu komut da öyle.

---

### `tree` — Dizin Ağacını Görüntüle

**tree** komutu, bulunduğunuz dizinden itibaren ağaç yapısını çizer.

```
C:\Projeler>tree
C:\PROJELER
├───Odev1
│   ├───Kod
│   └───Veriler
├───Odev2
└───Final
```

`tree /f` parametresi dosyaları da gösterir. `tree /a` ise ASCII karakterleri kullanır (ağaç çizim karakterleri yerine `+`, `-`, `|` kullanır).

---

### 🔨 Uygulama 1 — Dizin Yapısı Oluşturma

Aşağıdaki klasör yapısını komut satırından oluşturun:

```
C:\DersTest\
├── Belgeler\
│   ├── Raporlar\
│   └── Sunumlar\
├── Kod\
│   ├── Python\
│   └── Java\
└── Veriler\
    ├── Ham\
    └── Islemli\
```

**Çözüm:**

```bat
C:\>md DersTest
C:\>cd DersTest
C:\DersTest>md Belgeler\Raporlar
C:\DersTest>md Belgeler\Sunumlar
C:\DersTest>md Kod\Python
C:\DersTest>md Kod\Java
C:\DersTest>md Veriler\Ham
C:\DersTest>md Veriler\Islemli
C:\DersTest>tree
```

Son `tree` komutuyla yapıyı doğrulayın.

---

## BÖLÜM 2 — Dosya İşlemleri

### `echo` — Ekrana Yaz ve Dosya Oluştur

**echo**, kendisinden sonra gelen metni ekrana yazar. Ama asıl gücü, yönlendirme (redirection) ile birlikte kullanıldığında ortaya çıkar.

```
C:\>echo Merhaba Dunya
Merhaba Dunya

C:\>echo Bu bir test dosyasidir > test.txt
```

İkinci komut, `test.txt` adında bir dosya yaratır ve içine "Bu bir test dosyasidir" yazar. `>` operatörü çıktıyı ekran yerine dosyaya yönlendirir. Dosya zaten varsa üzerine yazar.

```
C:\>echo Ikinci satir >> test.txt
```

`>>` (çift büyüktür) ise dosyanın sonuna ekler (append), üzerine yazmaz. Aradaki fark kritiktir: `>` silip yazar, `>>` ekler.

Bunu şöyle düşünün: `>` yeni bir sayfa açar, `>>` sayfanın altına not düşer.

---

### `type` — Dosya İçeriğini Göster

**type** komutu, bir metin dosyasının içeriğini ekrana döker.

```
C:\>type test.txt
Bu bir test dosyasidir
Ikinci satir
```

Dosya uzunsa ekrandan kayıp gider. Bunu engellemek için `more` ile birlikte kullanın:

```
C:\>type uzundosya.txt | more
```

Buradaki `|` (pipe, boru) operatörü, bir komutun çıktısını başka bir komutun girdisi yapar. `type` dosyayı okur, `more` onu sayfa sayfa gösterir. Boru hattı benzetmesi tam da budur: bir komutun ürettiği veri, borudan geçip diğerine akar.

---

### `copy` — Dosya Kopyala

**copy** komutu, bir dosyayı başka bir konuma kopyalar.

```
C:\>copy test.txt Belgeler\test.txt
        1 dosya kopyalandı.

C:\>copy test.txt yedek.txt
        1 dosya kopyalandı.
```

İlk komut dosyayı başka bir dizine, ikincisi aynı dizinde farklı isimle kopyalar.

**Birden fazla dosyayı kopyalamak:**

```
C:\>copy *.txt Belgeler\
```

`*` (yıldız) joker karakteri (wildcard) "ne olursa olsun" anlamına gelir. `*.txt` demek "adı ne olursa olsun, uzantısı .txt olan her dosya" demektir.

Bir diğer joker karakter `?` ise tam olarak bir karakteri temsil eder:

| Joker | Anlam | Örnek | Eşleşir |
|-------|-------|-------|---------|
| `*` | Sıfır veya daha fazla karakter | `*.txt` | rapor.txt, a.txt, notlar.txt |
| `?` | Tam olarak bir karakter | `rapor?.txt` | rapor1.txt, raporA.txt |

```
C:\>copy rapor?.txt Yedek\
```

Bu komut rapor1.txt, rapor2.txt gibi dosyaları kopyalar ama rapor10.txt'yi kopyalamaz (çünkü `?` tek karakter demektir).

---

### `move` — Dosya Taşı veya Yeniden Adlandır

**move** komutu, dosyayı bir yerden başka bir yere taşır. Kaynak konumdan silinir, hedef konuma yazılır. Aynı klasör içinde kullanılırsa yeniden adlandırma (rename) işlevi görür.

```
C:\>move test.txt Belgeler\
        1 dosya taşındı.

C:\>move eskiisim.txt yeniisim.txt
        1 dosya taşındı.
```

---

### `ren` — Yeniden Adlandır

**ren** (Rename — Yeniden Adlandır) sadece isim değiştirmeye odaklıdır. Taşıma yapmaz.

```
C:\>ren rapor.txt rapor_v2.txt
```

Joker karakterlerle toplu yeniden adlandırma yapılabilir:

```
C:\>ren *.txt *.bak
```

Bu komut tüm `.txt` uzantılı dosyaların uzantısını `.bak` yapar. Yedekleme senaryolarında işe yarar.

---

### `del` — Dosya Sil

**del** (Delete — Sil) komutu dosyaları siler. Latince *delere* (yok etmek, silmek) kökünden.

```
C:\>del test.txt
C:\>del *.tmp
C:\>del /p *.txt
```

`/p` parametresi her dosya için onay ister (prompt). Toplu silme yaparken güvenlik ağı gibidir.

`/f` parametresi salt okunur (read-only) dosyaları da silmeye zorlar (force), `/s` ise alt dizinlerdeki dosyaları da siler.

> ⚠️ Tıpkı `rd /s /q` gibi, `del` de çöp kutusuna göndermez; doğrudan siler.

---

### `xcopy` ve `robocopy` — Gelişmiş Kopyalama

`copy` basit işler içindir. Daha karmaşık kopyalama işlerinde `xcopy` ve `robocopy` (Robust File Copy — Sağlam Dosya Kopyalama) kullanılır.

```
C:\>xcopy Kaynak Hedef /s /e
```

- `/s` — alt dizinleri de kopyala (boş olanlar hariç)
- `/e` — boş alt dizinleri de dahil et (empty)

```
C:\>robocopy Kaynak Hedef /mir
```

`/mir` (mirror — ayna) parametresi, hedef dizini kaynağın tam bir yansıması yapar. Kaynakta olmayan dosyaları hedeften siler. Yedekleme (backup) işlemlerinin temel aracıdır.

---

### `attrib` — Dosya Özniteliklerini Yönet

**attrib** (Attribute — Öznitelik) komutu, dosyaların gizli (hidden), salt okunur (read-only), arşiv (archive) gibi özelliklerini gösterir ve değiştirir.

```
C:\>attrib test.txt
A            C:\test.txt

C:\>attrib +r +h test.txt
C:\>attrib test.txt
A  R  H      C:\test.txt
```

| Harf | Öznitelik | Anlam |
|------|-----------|-------|
| `R` | Read-only | Salt okunur |
| `H` | Hidden | Gizli |
| `S` | System | Sistem dosyası |
| `A` | Archive | Arşiv (yedekleme için işaretli) |

`+` ekler, `-` kaldırır:

```
C:\>attrib -r -h test.txt
```

---

### 🔨 Uygulama 2 — Dosya İşlemleri Pratiği

Aşağıdaki adımları sırayla uygulayın:

```bat
REM 1. Çalışma dizini oluştur
md C:\DosyaPratik
cd C:\DosyaPratik

REM 2. Üç dosya oluştur
echo Birinci dosya icerigi > dosya1.txt
echo Ikinci dosya icerigi > dosya2.txt
echo Ucuncu dosya icerigi > dosya3.txt

REM 3. Dosyaları listele
dir

REM 4. Yedek klasörü oluştur ve dosyaları kopyala
md Yedek
copy *.txt Yedek\

REM 5. Bir dosyayı yeniden adlandır
ren dosya1.txt ana_dosya.txt

REM 6. İçerikleri kontrol et
type ana_dosya.txt

REM 7. Bir dosyaya ekleme yap
echo Bu satir eklendi >> ana_dosya.txt
type ana_dosya.txt

REM 8. Dosya özniteliğini değiştir
attrib +r dosya2.txt
attrib dosya2.txt

REM 9. Salt okunur dosyayı silmeyi dene
del dosya2.txt

REM 10. Özniteliği kaldırıp tekrar dene
attrib -r dosya2.txt
del dosya2.txt

REM 11. Ağaç yapısını kontrol et
tree /f
```

`REM` (Remark — Açıklama) komutu, satırın bir yorum olduğunu belirtir. Bilgisayar bu satırları atlar; bunlar tamamen sizin için yazılmış notlardır.

---

## BÖLÜM 3 — Yönlendirme ve Boru Hatları

Komut satırının en güçlü özelliklerinden biri, komutları birbirine bağlayabilmektir. Bu mekanizmayı anlamak, tek tek komut bilmekten çok daha değerlidir.

### Yönlendirme Operatörleri

| Operatör | İşlev | Örnek |
|----------|-------|-------|
| `>` | Çıktıyı dosyaya yaz (üzerine yazar) | `dir > liste.txt` |
| `>>` | Çıktıyı dosyaya ekle | `echo yeni satir >> liste.txt` |
| `<` | Dosyadan girdi al | `sort < isimler.txt` |
| `\|` | Bir komutun çıktısını diğerine aktar | `dir \| find "txt"` |
| `2>` | Hata mesajlarını dosyaya yönlendir | `dir olmayan 2> hatalar.txt` |
| `2>&1` | Hata ve normal çıktıyı birleştir | `komut > log.txt 2>&1` |

Her komutun üç standart kanalı (stream) vardır:

- **stdin** (Standard Input — Standart Girdi): Normalde klavye
- **stdout** (Standard Output — Standart Çıktı): Normalde ekran
- **stderr** (Standard Error — Standart Hata): Normalde ekran

Yönlendirme operatörleri bu kanalları farklı yerlere bağlar. Bir su tesisatı düşünün: stdin musluk, stdout lavabo, stderr taşma deliği. Yönlendirme ile boruları istediğiniz yere bağlarsınız.

---

### `find` — Metin Ara

**find** komutu, bir dosya içinde veya bir komutun çıktısında belirli bir metni arar.

```
C:\>find "hata" log.txt
C:\>dir | find "txt"
C:\>find /i "ARANACAK" dosya.txt
C:\>find /c "hata" log.txt
```

| Parametre | Anlam |
|-----------|-------|
| `/i` | Büyük-küçük harf duyarsız (ignore case) |
| `/c` | Eşleşen satır sayısını göster (count) |
| `/n` | Satır numaralarını göster (number) |
| `/v` | Eşleşmeyen satırları göster (reverse/inverse) |

Aranacak metin çift tırnak içinde yazılır. Bu zorunludur.

---

### `findstr` — Gelişmiş Metin Ara

**findstr** (Find String — Dize Bul), `find` komutunun daha güçlü versiyonudur. Düzenli ifade (regular expression, regex) desteği sunar.

```
C:\>findstr /r "^hata" log.txt
C:\>findstr /s /i "parola" *.txt
```

- `/r` — düzenli ifade (regex) kullan
- `/s` — alt dizinlerde de ara
- `/i` — büyük-küçük harf duyarsız

`^hata` ifadesi "satır başında hata kelimesi olan satırlar" demektir. `^` düzenli ifadelerde "satır başı" anlamına gelir.

---

### `sort` — Sırala

```
C:\>sort isimler.txt
C:\>dir /b | sort
C:\>sort /r isimler.txt
```

`/r` parametresi ters sıralama (reverse) yapar. `dir /b` (bare, sadece dosya adları) ile `sort` birleştirildiğinde dosyalar alfabetik sıralanır.

---

### 🔨 Uygulama 3 — Yönlendirme ve Boru Hattı Pratiği

```bat
REM 1. Dizin listesini dosyaya kaydet
dir C:\Windows > dizin_listesi.txt

REM 2. Sadece .exe dosyalarını filtrele
find ".exe" dizin_listesi.txt

REM 3. .exe dosyalarını ayrı bir dosyaya kaydet
find ".exe" dizin_listesi.txt > exe_dosyalari.txt

REM 4. Kaç .exe dosyası var?
find /c ".exe" dizin_listesi.txt

REM 5. Bir veri dosyası oluştur ve sırala
echo Zeynep > ogrenciler.txt
echo Ali >> ogrenciler.txt
echo Mehmet >> ogrenciler.txt
echo Canan >> ogrenciler.txt
echo Burak >> ogrenciler.txt
sort ogrenciler.txt

REM 6. Sıralı halini yeni dosyaya kaydet
sort ogrenciler.txt > sirali_ogrenciler.txt
type sirali_ogrenciler.txt
```

---

## BÖLÜM 4 — Ortam Değişkenleri ve Sistem Bilgisi

### `set` — Ortam Değişkenleri

Ortam değişkenleri (Environment Variables), işletim sisteminin ve programların kullandığı anahtar-değer çiftleridir. Bir telefon rehberi gibidir: bir isme karşılık bir değer tutar.

```
C:\>set
```

Parametresiz `set` komutu, tanımlı tüm ortam değişkenlerini listeler. Önemli olanlardan bazıları:

| Değişken | İçeriği |
|----------|---------|
| `%PATH%` | Çalıştırılabilir dosyaların arandığı dizinler |
| `%USERPROFILE%` | Kullanıcı ana dizini |
| `%TEMP%` | Geçici dosyaların tutulduğu dizin |
| `%OS%` | İşletim sistemi adı |
| `%COMPUTERNAME%` | Bilgisayar adı |
| `%USERNAME%` | Oturum açmış kullanıcı adı |

Bir ortam değişkenine erişmek için `%` işaretleri arasına alırsınız:

```
C:\>echo %USERNAME%
Kullanici

C:\>echo %COMPUTERNAME%
MASAUSTU-01

C:\>cd %USERPROFILE%\Desktop
```

**Kendi değişkeninizi tanımlamak:**

```
C:\>set PROJE=C:\Projeler\Odev1
C:\>cd %PROJE%
C:\>echo %PROJE%
C:\Projeler\Odev1
```

Bu tanım sadece o komut satırı penceresi açık olduğu sürece geçerlidir. Pencereyi kapattığınızda kaybolur.

---

### `path` — Çalıştırma Yolu

**PATH** değişkeni özel bir ortam değişkenidir. Bir komut yazdığınızda, sistem o komutu önce bulunduğunuz dizinde, sonra PATH'teki dizinlerde arar.

```
C:\>path
PATH=C:\Windows\System32;C:\Windows;C:\Python39;...

C:\>path %PATH%;C:\YeniProgram
```

PATH'e yeni bir dizin eklemek, sisteme "komut ararken buraya da bak" demektir. Noktalı virgül (`;`) ayraç olarak kullanılır.

---

### `systeminfo` — Sistem Bilgisi

Bu komut, bilgisayar hakkında kapsamlı bir bilgi raporu üretir.

```
C:\>systeminfo
```

Çıktıda işletim sistemi sürümü, kurulum tarihi, fiziksel bellek miktarı, ağ kartı bilgileri, son başlatma zamanı (boot time) ve daha fazlası bulunur.

Belirli bir bilgiyi çekmek için `find` ile birlikte kullanabilirsiniz:

```
C:\>systeminfo | find "Toplam Fiziksel Bellek"
C:\>systeminfo | find "Son Önyükleme"
```

---

### `hostname` — Bilgisayar Adı

```
C:\>hostname
MASAUSTU-01
```

Kısa ve öz. Ağ üzerinde hangi makinede olduğunuzu anında söyler.

---

### `whoami` — Kim Olduğunuzu Gösterir

```
C:\>whoami
masaustu-01\kullanici
```

Özellikle sunucularda, hangi kullanıcı hesabıyla oturum açtığınızı doğrulamak için kullanılır.

---

## BÖLÜM 5 — Ağ (Network) Komutları

Bir bilgisayar mühendisi için ağ komutları, bir doktorun stetoskopu gibidir. Ağ sorunlarının teşhisi bu komutlarla başlar.

### `ipconfig` — IP Yapılandırması

**ipconfig** (IP Configuration — IP Yapılandırması), ağ bağdaştırıcılarının (network adapter) bilgilerini gösterir.

```
C:\>ipconfig
```

Temel çıktı:

```
Ethernet bağdaştırıcısı Ethernet:
   IPv4 Adresi. . . . . . . . . . . : 192.168.1.105
   Alt Ağ Maskesi . . . . . . . . .  : 255.255.255.0
   Varsayılan Ağ Geçidi. . . . . . . : 192.168.1.1
```

**Önemli parametreler:**

| Parametre | İşlev |
|-----------|-------|
| `ipconfig /all` | Detaylı bilgi (MAC adresi, DNS sunucuları dahil) |
| `ipconfig /release` | DHCP adresini serbest bırak |
| `ipconfig /renew` | DHCP'den yeni adres al |
| `ipconfig /flushdns` | DNS önbelleğini temizle |

`ipconfig /flushdns` özellikle sık kullanılır. Bir web sitesine erişemiyorsanız ve başkaları erişebiliyorsa, önce DNS önbelleğini temizlemek iyi bir başlangıçtır. Eski bir telefon numarasını rehberden silip güncelini yazmak gibidir.

---

### `ping` — Bağlantı Testi

**ping** komutu, hedef bir bilgisayara küçük paketler gönderir ve cevap süresini ölçer. Adı, denizaltıların sonar sinyalinden gelir.

```
C:\>ping google.com

google.com [142.250.187.206] sunucusuna ping atılıyor 32 bayt veri ile:
142.250.187.206 yanıt: bayt=32 süre=12ms TTL=117
142.250.187.206 yanıt: bayt=32 süre=11ms TTL=117
142.250.187.206 yanıt: bayt=32 süre=12ms TTL=117
142.250.187.206 yanıt: bayt=32 süre=11ms TTL=117

142.250.187.206 için Ping istatistikleri:
    Paket: Gönderilen = 4, Alınan = 4, Kaybolan = 0 (kayıp %0)
Ortalama gidiş-dönüş (ms): Minimum = 11ms, Maksimum = 12ms, Ortalama = 11ms
```

**Dikkat edilecek değerler:**

- **Süre (time):** Paketin gidip gelme süresi. 1-30ms mükemmel, 100ms+ sorunlu olabilir.
- **TTL (Time to Live — Yaşam Süresi):** Paketin kaç yönlendirici (router) geçebileceğini belirler.
- **Kayıp (loss):** %0 olmalı. Kayıp varsa ağda sorun var demektir.

```
C:\>ping -t google.com       REM Sürekli ping at (Ctrl+C ile durdur)
C:\>ping -n 10 google.com    REM 10 paket gönder
C:\>ping 192.168.1.1          REM Yerel ağ geçidine ping
```

**Sorun giderme stratejisi:**

1. `ping 127.0.0.1` → Kendi TCP/IP yığınınız (loopback) çalışıyor mu?
2. `ping 192.168.1.1` → Varsayılan ağ geçidine (router) ulaşıyor musunuz?
3. `ping 8.8.8.8` → İnternete çıkabiliyor musunuz? (Google DNS)
4. `ping google.com` → DNS çözümlemesi (resolution) çalışıyor mu?

Her adım başarılıysa bir sonrakine geçin. Hangi adımda başarısız olursa, sorun orada veya bir öncesindedir. Bu yöntem katman katman (layer by layer) sorun gidermenin temelidir.

---

### `tracert` — Yol İzleme

**tracert** (Trace Route — Yol İzleme), paketlerin hedefe ulaşana kadar geçtiği her yönlendiriciyi (router/hop) gösterir.

```
C:\>tracert google.com

  1     1 ms     1 ms     1 ms  192.168.1.1
  2    10 ms     9 ms    10 ms  isp-router.example.com
  3    12 ms    11 ms    12 ms  core-router.example.com
  ...
 10    15 ms    14 ms    15 ms  142.250.187.206
```

Her satır bir "atlama" (hop) noktasıdır. Sürelerin aniden arttığı veya `* * *` (zaman aşımı) görülen nokta, darboğazın olası konumudur. Bir kargo takip numarası gibi düşünün: paketin hangi aktarma merkezlerinden geçtiğini gösterir.

---

### `nslookup` — DNS Sorgusu

**nslookup** (Name Server Lookup — Ad Sunucusu Sorgusu), bir alan adının (domain name) IP adresini sorgular.

```
C:\>nslookup google.com
Sunucu:  dns.example.com
Adres:  192.168.1.1

Yetkili olmayan yanıt:
Ad:     google.com
Adres:  142.250.187.206
```

"Yetkili olmayan yanıt" (non-authoritative answer), cevabın doğrudan o alan adının yetkili DNS sunucusundan değil, yerel DNS sunucunuzun önbelleğinden geldiğini ifade eder.

```
C:\>nslookup -type=mx google.com    REM E-posta sunucularını sorgula
C:\>nslookup -type=ns google.com    REM Ad sunucularını sorgula
```

---

### `netstat` — Ağ Bağlantıları

**netstat** (Network Statistics — Ağ İstatistikleri), bilgisayarınızın aktif ağ bağlantılarını gösterir.

```
C:\>netstat -an
C:\>netstat -b
C:\>netstat -ano
```

| Parametre | Anlam |
|-----------|-------|
| `-a` | Tüm bağlantıları göster (all) |
| `-n` | Adresleri sayısal göster, DNS çözümleme yapma (numeric) |
| `-b` | Her bağlantıyı hangi programın kullandığını göster (binary) |
| `-o` | İlgili süreç kimliğini (PID — Process ID) göster |

`netstat -ano` özellikle güvenlik analizi için değerlidir. Hangi port açık, hangi programın hangi bağlantıyı kullandığını gösterir.

---

### 🔨 Uygulama 4 — Ağ Teşhisi

Aşağıdaki adımları uygulayıp çıktıları bir dosyaya kaydedin:

```bat
REM 1. IP yapılandırmanızı kaydedin
ipconfig /all > ag_raporu.txt

REM 2. Varsayılan ağ geçidine ping atın
echo. >> ag_raporu.txt
echo ====== PING TEST ====== >> ag_raporu.txt
ping -n 4 192.168.1.1 >> ag_raporu.txt

REM 3. DNS çözümlemesini test edin
echo. >> ag_raporu.txt
echo ====== DNS TEST ====== >> ag_raporu.txt
nslookup google.com >> ag_raporu.txt

REM 4. Bir siteye yol izleme yapın
echo. >> ag_raporu.txt
echo ====== TRACERT ====== >> ag_raporu.txt
tracert -h 10 google.com >> ag_raporu.txt

REM 5. Raporu görüntüleyin
type ag_raporu.txt | more
```

`echo.` (noktayla birlikte, boşluk yok) boş bir satır yazar. `-h 10` parametresi tracert'in en fazla 10 hop denemesini sağlar (varsayılan 30'dur ve uzun sürebilir).

---

## BÖLÜM 6 — Süreç ve Görev Yönetimi

### `tasklist` — Çalışan Süreçler

**tasklist** komutu, çalışan tüm süreçleri (process) listeler. Windows Görev Yöneticisi'nin (Task Manager) komut satırı karşılığıdır.

```
C:\>tasklist

Görüntü Adı                 PID Oturum Adı       Otr# Bellek Kullanımı
========================= ======== ================ ==== ===============
System Idle Process              0 Services            0          8 K
System                           4 Services            0      2.048 K
chrome.exe                   12456 Console             1    250.000 K
notepad.exe                   8832 Console             1      8.192 K
```

**Filtreleme:**

```
C:\>tasklist | find "chrome"
C:\>tasklist /fi "memusage gt 100000"
```

İkinci komut, bellek kullanımı 100 MB'ın üzerindeki süreçleri filtreler. `fi` filtre (filter), `gt` büyüktür (greater than) demektir.

---

### `taskkill` — Süreç Sonlandır

```
C:\>taskkill /pid 12456
C:\>taskkill /im notepad.exe
C:\>taskkill /im chrome.exe /f
```

| Parametre | Anlam |
|-----------|-------|
| `/pid` | Süreç kimliğiyle (PID) sonlandır |
| `/im` | Görüntü adıyla (image name) sonlandır |
| `/f` | Zorla (force) sonlandır |

`/f` parametresini kullanmak son çaredir. Önce `/f` olmadan deneyin; bu, programa "lütfen kapat" mesajı gönderir. `/f` ile "hemen kapat, sormuyorum" dersiniz.

---

## BÖLÜM 7 — Toplu İş Dosyaları (Batch Files)

Buraya kadar öğrendiğimiz tüm komutları tek tek elle yazdık. Peki ya aynı işlemleri her gün yapıyorsanız? İşte burada toplu iş dosyaları (batch files) devreye girer.

Batch dosyası, `.bat` veya `.cmd` uzantılı bir metin dosyasıdır. İçindeki komutları satır satır çalıştırır. Bir tarif defteri gibidir: her satır bir adımdır.

### İlk Batch Dosyası

Herhangi bir metin editörüyle (Notepad yeterlidir) şu içeriği yazıp `merhaba.bat` olarak kaydedin:

```bat
@echo off
echo ================================
echo   Sistem Bilgi Raporu
echo ================================
echo.
echo Bilgisayar Adi : %COMPUTERNAME%
echo Kullanici      : %USERNAME%
echo Tarih          : %DATE%
echo Saat           : %TIME%
echo.
echo ================================
pause
```

`@echo off` satırı, komutların kendisini ekrana yazmayı kapatır. Sadece çıktıları gösterir. Bu olmadan her komutun kendisi de ekrana basılır ve çıktı karmaşık görünür.

`pause` komutu "Devam etmek için bir tuşa basın..." mesajını gösterir ve kullanıcının tuşa basmasını bekler. Bu olmadan pencere hemen kapanır ve çıktıyı okuyamazsınız.

---

### Değişkenler ve Parametre Alma

```bat
@echo off
set /p ISIM=Adinizi girin: 
echo Merhaba %ISIM%, sisteme hosgeldiniz!
```

`set /p` kullanıcıdan girdi alır (prompt). Girilen değer `ISIM` değişkenine atanır.

**Komut satırı parametreleri:**

`yedekle.bat` adında bir dosya oluşturun:

```bat
@echo off
if "%1"=="" (
    echo Kullanim: yedekle.bat [kaynak_dizin]
    exit /b 1
)

set KAYNAK=%1
set HEDEF=%USERPROFILE%\Yedekler\%DATE:~0,2%-%DATE:~3,2%-%DATE:~6,4%

echo Yedekleme basliyor...
echo Kaynak : %KAYNAK%
echo Hedef  : %HEDEF%

md "%HEDEF%" 2>nul
xcopy "%KAYNAK%" "%HEDEF%" /s /e /y

echo Yedekleme tamamlandi!
```

`%1` birinci parametre, `%2` ikinci parametre demektir. Dosyayı şöyle çalıştırırsınız:

```
C:\>yedekle.bat C:\Projeler
```

`%DATE:~0,2%` ifadesi, DATE değişkeninin 0. karakterinden başlayarak 2 karakter al demektir. Böylece tarih parçalarını ayırıp klasör adı olarak kullanabilirsiniz.

`2>nul` ifadesi hata mesajlarını `nul` (boşluğa, hiçbir yere) yönlendirir. Dizin zaten varsa hata mesajını bastırır.

---

### Koşullu İfadeler (`if`)

```bat
@echo off
set /p SAYI=Bir sayi girin: 

if %SAYI% GTR 100 (
    echo %SAYI% sayisi 100'den buyuktur.
) else if %SAYI% EQU 100 (
    echo %SAYI% tam olarak 100'e esittir.
) else (
    echo %SAYI% sayisi 100'den kucuktur.
)
```

| Operatör | Anlam | İngilizcesi |
|----------|-------|-------------|
| `EQU` | Eşit | Equal |
| `NEQ` | Eşit değil | Not Equal |
| `LSS` | Küçük | Less Than |
| `LEQ` | Küçük veya eşit | Less or Equal |
| `GTR` | Büyük | Greater Than |
| `GEQ` | Büyük veya eşit | Greater or Equal |

**Dosya/dizin varlığı kontrolü:**

```bat
if exist rapor.txt (
    echo Dosya mevcut, aciliyor...
    type rapor.txt
) else (
    echo Dosya bulunamadi!
)

if exist C:\Yedekler (
    echo Yedek dizini mevcut.
) else (
    echo Yedek dizini olusturuluyor...
    md C:\Yedekler
)
```

---

### Döngüler (`for`)

```bat
@echo off
REM Tüm .txt dosyalarını listele
for %%f in (*.txt) do (
    echo Dosya: %%f
)
```

> **Önemli ayrım:** Komut satırında doğrudan yazarken `%f`, batch dosyası içinde `%%f` kullanılır. Bu, batch yorumlayıcısının (interpreter) bir tasarım kararıdır; alışıncaya kadar kafa karıştırabilir.

**Sayısal döngü:**

```bat
@echo off
for /l %%i in (1,1,10) do (
    echo Sayi: %%i
)
```

`/l` (loop) parametresi: `(başlangıç, artış, bitiş)` formatında çalışır. Bu örnek 1'den 10'a kadar birer birer sayar.

**Dizin içindeki dosyaları işleme:**

```bat
@echo off
for /r C:\Projeler %%f in (*.java) do (
    echo Java dosyasi bulundu: %%f
)
```

`/r` (recursive — özyinelemeli) parametresi alt dizinleri de tarar.

---

### 🔨 Uygulama 5 — Sistem Raporu Batch Dosyası

Aşağıdaki batch dosyasını `sistem_raporu.bat` olarak kaydedin ve çalıştırın:

```bat
@echo off
set RAPOR=%USERPROFILE%\Desktop\sistem_raporu.txt

echo ======================================= > "%RAPOR%"
echo   SISTEM RAPORU - %DATE% %TIME%        >> "%RAPOR%"
echo ======================================= >> "%RAPOR%"

echo. >> "%RAPOR%"
echo --- BILGISAYAR BILGILERI ---           >> "%RAPOR%"
echo Bilgisayar : %COMPUTERNAME%            >> "%RAPOR%"
echo Kullanici  : %USERNAME%                >> "%RAPOR%"
hostname                                    >> "%RAPOR%"

echo. >> "%RAPOR%"
echo --- IP YAPILANDIRMASI ---              >> "%RAPOR%"
ipconfig                                    >> "%RAPOR%"

echo. >> "%RAPOR%"
echo --- AKTIF BAGLENTILAR ---              >> "%RAPOR%"
netstat -an | find "ESTABLISHED"            >> "%RAPOR%"

echo. >> "%RAPOR%"
echo --- EN COK BELLEK KULLANAN SURECLER --- >> "%RAPOR%"
tasklist /fi "memusage gt 50000"            >> "%RAPOR%"

echo. >> "%RAPOR%"
echo --- DISK KULLANIMI ---                 >> "%RAPOR%"
wmic logicaldisk get name,size,freespace    >> "%RAPOR%"

echo.
echo Rapor olusturuldu: %RAPOR%
echo Acmak icin Enter'a basin...
pause >nul
type "%RAPOR%" | more
```

Bu dosya, sisteminizin anlık bir fotoğrafını çeker. Gerçek dünyada sistem yöneticileri (system administrators) bu tür scriptleri zamanlanmış görevlerle (scheduled tasks) otomatik çalıştırırlar.

`wmic` (Windows Management Instrumentation Command-line), Windows'un yönetim altyapısına komut satırından erişim sağlar. `logicaldisk` mantıksal diskleri, `get name,size,freespace` ise disk adı, toplam boyut ve boş alan bilgilerini çeker.

---

## BÖLÜM 8 — Faydalı İleri Komutlar

### `where` — Dosya Konumu Bul

Linux'taki `which` komutunun Windows karşılığıdır. Bir komutun veya dosyanın PATH üzerindeki yerini gösterir.

```
C:\>where python
C:\Python39\python.exe

C:\>where notepad
C:\Windows\System32\notepad.exe
```

"Python çalışmıyor" dediğinizde `where python` yazarak Python'un PATH'te olup olmadığını kontrol edebilirsiniz.

---

### `fc` — Dosya Karşılaştır

**fc** (File Compare — Dosya Karşılaştır), iki dosya arasındaki farkları gösterir.

```
C:\>fc dosya1.txt dosya2.txt
C:\>fc /n dosya1.txt dosya2.txt
```

`/n` satır numaralarını gösterir. Basit bir diff (fark) aracıdır.

---

### `shutdown` — Kapatma ve Yeniden Başlatma

```
C:\>shutdown /s /t 60         REM 60 saniye sonra kapat
C:\>shutdown /r /t 0          REM Hemen yeniden başlat
C:\>shutdown /a                REM Planlanmış kapatmayı iptal et
C:\>shutdown /l                REM Oturumu kapat (logoff)
```

| Parametre | Anlam |
|-----------|-------|
| `/s` | Kapat (shutdown) |
| `/r` | Yeniden başlat (restart) |
| `/t` | Bekleme süresi saniye cinsinden (time) |
| `/a` | İptal et (abort) |

---

### `sfc` — Sistem Dosyası Denetimi

**sfc** (System File Checker — Sistem Dosyası Denetleyicisi), bozulmuş veya değiştirilmiş Windows sistem dosyalarını tarar ve onarır.

```
C:\>sfc /scannow
```

Yönetici yetkisi gerektirir. Tarama birkaç dakika sürer. Bir bilgisayar "tuhaf davranıyorsa" — mavi ekran veriyor, programlar çöküyor — bu komut iyi bir başlangıç noktasıdır.

---

### `chkdsk` — Disk Denetimi

**chkdsk** (Check Disk — Disk Denetimi), diskteki dosya sistemi hatalarını tarar.

```
C:\>chkdsk C:
C:\>chkdsk C: /f /r
```

| Parametre | Anlam |
|-----------|-------|
| `/f` | Hataları düzelt (fix) |
| `/r` | Bozuk sektörleri bul ve okunabilir veriyi kurtar (recover) |

`/f` ve `/r` ile çalıştırmak, sistem sürücüsünde (genellikle C:) yeniden başlatma gerektirir; çünkü disk kullanımdayken onarılamaz.

---

### `clip` — Panoya Kopyala

```
C:\>dir | clip
C:\>ipconfig | clip
C:\>type dosya.txt | clip
```

Komutun çıktısı doğrudan panoya (clipboard) kopyalanır. Ardından istediğiniz yere yapıştırabilirsiniz (Ctrl+V). Basit ama çok pratik bir araçtır.

---

### Komut Zincirleme

Birden fazla komutu tek satırda çalıştırmanın üç yolu vardır:

| Operatör | Davranış | Örnek |
|----------|----------|-------|
| `&` | İkisini de çalıştır (sonuç ne olursa olsun) | `dir & echo Bitti` |
| `&&` | Birincisi başarılıysa ikinciyi çalıştır | `md Test && echo Olusturuldu` |
| `\|\|` | Birincisi başarısızsa ikinciyi çalıştır | `cd Olmayan \|\| echo Dizin yok` |

`&&` bir güvenlik mekanizmasıdır: "önce şunu yap, başarılı olursan sonra bunu yap." Sıralı işlemlerde çok kullanılır.

---

## Komut Referans Tablosu

Derste ele alınan tüm komutların özet tablosu:

| Komut | Açılımı | Türkçesi | İşlevi |
|-------|---------|----------|--------|
| `ver` | Version | Sürüm | İşletim sistemi sürümünü gösterir |
| `cls` | Clear Screen | Ekranı Temizle | Ekranı temizler |
| `date` | Date | Tarih | Sistem tarihini gösterir/ayarlar |
| `time` | Time | Saat | Sistem saatini gösterir/ayarlar |
| `dir` | Directory | Dizin | Dizin içeriğini listeler |
| `cd` | Change Directory | Dizin Değiştir | Çalışma dizinini değiştirir |
| `md` | Make Directory | Dizin Oluştur | Yeni dizin yaratır |
| `rd` | Remove Directory | Dizin Kaldır | Dizini siler |
| `tree` | Tree | Ağaç | Dizin yapısını ağaç olarak çizer |
| `echo` | Echo | Yankı | Ekrana metin yazar / dosyaya yönlendirir |
| `type` | Type | Tür/Yaz | Dosya içeriğini görüntüler |
| `copy` | Copy | Kopyala | Dosya kopyalar |
| `move` | Move | Taşı | Dosya taşır / yeniden adlandırır |
| `ren` | Rename | Yeniden Adlandır | Dosya adını değiştirir |
| `del` | Delete | Sil | Dosya siler |
| `xcopy` | Extended Copy | Genişletilmiş Kopyala | Gelişmiş kopyalama |
| `robocopy` | Robust File Copy | Sağlam Dosya Kopyalama | En gelişmiş kopyalama aracı |
| `attrib` | Attribute | Öznitelik | Dosya özniteliklerini yönetir |
| `find` | Find | Bul | Metin arar |
| `findstr` | Find String | Dize Bul | Gelişmiş metin arama (regex) |
| `sort` | Sort | Sırala | Satırları sıralar |
| `set` | Set | Ayarla | Ortam değişkenlerini yönetir |
| `path` | Path | Yol | Çalıştırma yolunu gösterir/ayarlar |
| `systeminfo` | System Information | Sistem Bilgisi | Sistem bilgilerini gösterir |
| `hostname` | Host Name | Bilgisayar Adı | Bilgisayar adını gösterir |
| `whoami` | Who Am I | Ben Kimim | Oturum bilgisini gösterir |
| `ipconfig` | IP Configuration | IP Yapılandırması | Ağ yapılandırmasını gösterir |
| `ping` | Ping | Ping | Ağ bağlantısını test eder |
| `tracert` | Trace Route | Yol İzleme | Paket rotasını izler |
| `nslookup` | Name Server Lookup | Ad Sunucusu Sorgusu | DNS sorgusu yapar |
| `netstat` | Network Statistics | Ağ İstatistikleri | Ağ bağlantılarını listeler |
| `tasklist` | Task List | Görev Listesi | Çalışan süreçleri listeler |
| `taskkill` | Task Kill | Görev Sonlandır | Süreç sonlandırır |
| `where` | Where | Nerede | Dosya/komut konumunu bulur |
| `fc` | File Compare | Dosya Karşılaştır | İki dosyayı karşılaştırır |
| `shutdown` | Shutdown | Kapatma | Sistemi kapatır/yeniden başlatır |
| `sfc` | System File Checker | Sistem Dosyası Denetleyicisi | Sistem dosyalarını onarır |
| `chkdsk` | Check Disk | Disk Denetimi | Disk hatalarını tarar |
| `clip` | Clipboard | Pano | Çıktıyı panoya kopyalar |

---

## 🔨 Uygulama 6 — Kapsamlı Final Uygulaması

Bu uygulamada öğrenilen komutların çoğunu bir arada kullanacaksınız. Her adımı sırayla uygulayın.

**Senaryo:** Bir proje dizin yapısı oluşturacak, dosyalarla çalışacak, bir ağ testi yapacak ve sonuçları raporlayacaksınız.

```bat
REM ========================================
REM  ADIM 1: Proje Yapisi Olusturma
REM ========================================
md C:\FinalTest
cd C:\FinalTest
md src\main
md src\test
md docs
md output

REM Yapıyı doğrula
tree

REM ========================================
REM  ADIM 2: Dosyalar Olusturma
REM ========================================
echo public class Main {           > src\main\Main.java
echo     public static void main(String[] args) { >> src\main\Main.java
echo         System.out.println("Merhaba");       >> src\main\Main.java
echo     }                                        >> src\main\Main.java
echo }                                            >> src\main\Main.java

echo # Proje Dokumantasyonu > docs\README.txt
echo Bu bir test projesidir. >> docs\README.txt
echo Olusturulma tarihi: %DATE% >> docs\README.txt

REM Dosyaları kontrol et
type src\main\Main.java
echo.
type docs\README.txt

REM ========================================
REM  ADIM 3: Dosya Islemleri
REM ========================================
REM Yedek al
md backup
xcopy src backup\src /s /e /y
xcopy docs backup\docs /s /e /y

REM Yedek yapısını doğrula
echo.
echo === Yedek Yapisi ===
tree backup /f

REM ========================================
REM  ADIM 4: Arama ve Filtreleme
REM ========================================
REM Tüm .java dosyalarını bul
echo.
echo === Java Dosyalari ===
dir /s /b *.java

REM "Main" kelimesini içeren satırları bul
echo.
echo === Main iceren satirlar ===
findstr /s /i "main" src\*.java

REM ========================================
REM  ADIM 5: Ag Testi ve Raporlama
REM ========================================
echo === AG RAPORU === > output\rapor.txt
echo Tarih: %DATE% %TIME% >> output\rapor.txt
echo. >> output\rapor.txt

echo --- Ping Testi (localhost) --- >> output\rapor.txt
ping -n 2 127.0.0.1 >> output\rapor.txt

echo. >> output\rapor.txt
echo --- DNS Sorgusu --- >> output\rapor.txt
nslookup google.com >> output\rapor.txt

echo. >> output\rapor.txt
echo --- Aktif Baglentilar --- >> output\rapor.txt
netstat -an | find "ESTABLISHED" >> output\rapor.txt

echo.
echo Rapor olusturuldu: output\rapor.txt
echo.
type output\rapor.txt | more

REM ========================================
REM  ADIM 6: Temizlik (Opsiyonel)
REM ========================================
REM Dikkat: Asagidaki komut her seyi siler!
REM cd \
REM rd /s /q C:\FinalTest
```

---

## Ek: Sık Kullanılan Kısayollar

| Kısayol | İşlev |
|---------|-------|
| **Tab** | Dosya/dizin adını otomatik tamamla |
| **Yukarı/Aşağı Ok** | Önceki komutlar arasında gezin |
| **F7** | Komut geçmişi penceresini aç |
| **Ctrl+C** | Çalışan komutu durdur |
| **Ctrl+V** | Yapıştır (Windows 10+) |
| **Sağ tık** | Yapıştır (eski Windows sürümlerinde) |

**Tab** tuşu özellikle uzun dizin adları yazarken büyük kolaylık sağlar. İlk birkaç harfi yazıp Tab'a basın; sistem tamamlar. Birden fazla eşleşme varsa Tab'a tekrar basarak diğerlerine geçersiniz.

---

## Son Söz

Komut satırı, bilgisayar mühendisliğinin temel araçlarından biridir. GUI araçları her şeyi güzelce paketler ve sunar, ama arka planda dönen mekanizmaları anlamak istiyorsanız komut satırı doğrudan o mekanizmalarla konuşmanızı sağlar. Bugün öğrendiğimiz komutlar hem Windows hem de (isimleri biraz farklı olsa da) Linux/macOS ortamlarının temelini oluşturur.

Bu komutları ezberlemeye çalışmak yerine, sık sık kullanarak kas hafızası (muscle memory) oluşturmak en etkili yoldur. Bir tereddüt yaşadığınızda `komut /?` yazmanız yeterlidir — her komutun kendi yardım sayfası vardır:

```
C:\>dir /?
C:\>xcopy /?
C:\>ping /?
```

Bu, komut satırının kendi içindeki kılavuzudur. Her zaman elinizin altındadır.