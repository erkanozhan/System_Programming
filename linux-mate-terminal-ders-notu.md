# Linux MATE Terminal Komutları Ders Notu

## Neden Linux ve Terminal?

MS-DOS ders notunda komut satırının bilgisayar mühendisinin İngiliz anahtarı olduğundan söz etmiştik. Linux dünyasında bu araç çok daha merkezi bir konumdadır. Windows'ta komut satırı bir alternatifken, Linux'ta terminal neredeyse birincil çalışma ortamıdır. Sunucuların büyük çoğunluğu Linux çalıştırır ve bu sunucuların çoğunda grafik arayüz bile kurulu değildir. Dolayısıyla terminale hakim olmak, bir bilgisayar mühendisi için seçenek değil zorunluluktur.

---

## Linux ve MATE Masaüstü Hakkında

Linux, 1991'de Linus Torvalds tarafından geliştirilmeye başlanan açık kaynaklı (open source) bir işletim sistemi çekirdeğidir (kernel). Çekirdek tek başına bir işletim sistemi oluşturmaz; üzerine eklenen araçlar, kütüphaneler ve masaüstü ortamlarıyla birlikte bir **dağıtım** (distribution, kısaca distro) haline gelir. Ubuntu, Fedora, Debian, Linux Mint bunlardan bazılarıdır.

**MATE** (okunuşu: "ma-te", Güney Amerika'da içilen mate bitkisinden gelir), GNOME 2 masaüstü ortamının devamı olan hafif ve geleneksel bir masaüstü ortamıdır. Klasik menü yapısı, panel düzeni ve düşük sistem kaynak tüketimiyle öne çıkar. Özellikle eski donanımlarda ve sunucu yönetimi yapan kullanıcılar arasında tercih edilir.

MATE'te terminali açmak için:

1. **Üst menü → Uygulamalar → Sistem Araçları → MATE Terminal**
2. Masaüstünde sağ tık → "Terminali Burada Aç"
3. Kısayol: Genellikle **Ctrl + Alt + T** (dağıtıma göre değişebilir)

Açıldığında şuna benzer bir satır görürsünüz:

```
kullanici@bilgisayar:~$
```

Bu satıra **prompt** (komut istemi) denir. Parçalara ayırırsak:

- `kullanici` — oturum açmış kullanıcı adı
- `@` — "at" işareti, İngilizce "şuradaki" anlamında
- `bilgisayar` — makinenin adı (hostname)
- `:` — ayraç
- `~` — bulunduğunuz dizin (`~` ev dizininin kısaltmasıdır, yani `/home/kullanici`)
- `$` — normal kullanıcı olduğunuzu gösterir (`#` ise root/yönetici demektir)

Windows'taki `C:\Users\Kullanici>` satırının Linux karşılığı budur; ama daha fazla bilgi taşır.

---

## Shell Kavramı

Terminal bir penceredir; asıl komutları yorumlayan program **shell** (kabuk) adını taşır. Linux'ta en yaygın shell **Bash** (Bourne Again SHell — "Yeniden Doğan Bourne Kabuğu") olup, Stephen Bourne'un 1979'daki orijinal sh kabuğunun modern devamıdır. MATE Terminal varsayılan olarak Bash kullanır.

Hangi shell kullandığınızı görmek için:

```bash
echo $SHELL
/bin/bash
```

> **MS-DOS karşılaştırması:** Windows'ta cmd.exe ne ise, Linux'ta bash odur. Ama bash çok daha güçlüdür: değişken işlemleri, koşullar, döngüler, fonksiyonlar — hepsi doğrudan shell içinde yapılabilir.

---

## BÖLÜM 1 — Dosya Sistemi ve Temel Gezinme

### Linux Dosya Sistemi Yapısı

Windows'ta her sürücünün bir harfi vardır: `C:\`, `D:\`. Linux'ta böyle bir şey yoktur. Tek bir kök (root) dizin vardır ve o da `/` (eğik çizgi, slash) ile gösterilir. Her şey bu kökten dallanır — USB bellek de, ikinci hard disk de, ağ paylaşımları da bu ağaca bir noktadan bağlanır (mount edilir).

```
/
├── bin/          Temel komutlar (binary — çalıştırılabilir dosyalar)
├── boot/         Önyükleme dosyaları
├── dev/          Aygıt dosyaları (device)
├── etc/          Yapılandırma dosyaları (editable text configuration)
├── home/         Kullanıcı ev dizinleri
│   ├── ali/
│   └── zeynep/
├── lib/          Kütüphaneler (library)
├── media/        Takılabilir aygıtlar (USB, CD)
├── mnt/          Geçici bağlama noktaları (mount)
├── opt/          Opsiyonel yazılımlar
├── proc/         Süreç bilgileri (process) — sanal dosya sistemi
├── root/         root kullanıcısının ev dizini
├── sbin/         Sistem yönetim komutları (system binary)
├── tmp/          Geçici dosyalar (temporary)
├── usr/          Kullanıcı programları ve verileri (Unix System Resources)
│   ├── bin/
│   ├── lib/
│   └── share/
└── var/          Değişken veriler (variable) — loglar, veritabanları
```

Her dizinin bir amacı vardır. `/etc` yapılandırma dosyalarını tutar — bir binanın teknik odası gibidir. `/home` kullanıcıların kişisel alanıdır — binadaki daireler gibi. `/tmp` geçici dosyalar içindir — binanın çöp odası gibi, düzenli olarak temizlenir.

Burada dikkat çeken bir fark: Linux'ta dizin ayracı `/` (slash), Windows'ta `\` (backslash) kullanılır. Bu basit fark, iki sistem arasında geçiş yapanlarda sık hata sebebidir.

> **Not:** Linux dosya sistemi **büyük-küçük harf duyarlıdır** (case-sensitive). `Rapor.txt`, `rapor.txt` ve `RAPOR.TXT` üç farklı dosyadır. Windows'ta bunlar aynı dosyayı ifade eder. Bu fark özellikle başlangıçta dikkat gerektirir.

---

### `pwd` — Neredeyim?

**pwd** (Print Working Directory — Çalışma Dizinini Yazdır) komutu, o an bulunduğunuz dizinin tam yolunu gösterir.

```bash
$ pwd
/home/kullanici
```

Windows'taki `cd` (parametresiz) komutunun karşılığıdır. Terminalde kaybolduğunuzda ilk yazacağınız komut budur.

---

### `ls` — Dizin İçeriğini Listele

**ls** (List — Listele) komutu, Windows'taki `dir` komutunun karşılığıdır.

```bash
$ ls
Belgeler  İndirilenler  Masaüstü  Müzik  Resimler  Videolar
```

Varsayılan çıktı sade ve yatay dizilimlidir. Detay için parametreler eklenir:

```bash
$ ls -l
toplam 24
drwxr-xr-x 2 kullanici kullanici 4096 Şub 16 10:30 Belgeler
drwxr-xr-x 2 kullanici kullanici 4096 Şub 16 09:15 İndirilenler
-rw-r--r-- 1 kullanici kullanici 1234 Şub 15 22:10 rapor.txt
```

Bu çıktıyı satır satır okuyalım. Soldaki `drwxr-xr-x` ifadesi dosya izinlerini (permissions) gösterir — buna ileride döneceğiz. Sonra bağlantı sayısı, sahip (owner), grup (group), boyut (bayt), tarih ve isim gelir.

**Sık kullanılan parametreler:**

| Parametre | Anlamı |
|-----------|--------|
| `ls -l` | Uzun (long) format — detaylı bilgi |
| `ls -a` | Gizli dosyalar dahil tüm (all) dosyalar |
| `ls -la` | İkisinin birleşimi — en yaygın kullanım |
| `ls -lh` | Boyutları okunabilir (human-readable) formatta göster (KB, MB, GB) |
| `ls -lt` | Tarihe (time) göre sırala, en yeni en üstte |
| `ls -lS` | Boyuta (size) göre sırala, en büyük en üstte |
| `ls -R` | Alt dizinleri de (recursive) listele |
| `ls -d */` | Sadece dizinleri listele |

```bash
$ ls -lh
-rw-r--r-- 1 kullanici kullanici 1.2K Şub 15 22:10 rapor.txt
```

`1.2K` ifadesi `1234` bayttan çok daha okunabilirdir.

> **Gizli dosyalar:** Linux'ta nokta (`.`) ile başlayan dosyalar gizlidir. Örneğin `.bashrc`, `.profile`. Bunları görmek için `-a` parametresi şarttır. Windows'taki `attrib +h` mekanizmasının aksine, burada gizlilik sadece isimlendirme kuralıyla sağlanır.

---

### `cd` — Dizin Değiştir

**cd** (Change Directory — Dizin Değiştir), her iki sistemde de aynı adı taşıyan nadir komutlardandır.

```bash
$ cd Belgeler
$ pwd
/home/kullanici/Belgeler

$ cd /var/log
$ pwd
/var/log
```

**Özel kısayollar:**

| Komut | Anlamı |
|-------|--------|
| `cd ..` | Bir üst dizine çık |
| `cd /` | Kök dizine git |
| `cd ~` | Ev dizinine git (veya sadece `cd`) |
| `cd -` | Bir önceki dizine dön |

`cd -` özellikle kullanışlıdır. İki dizin arasında sık sık gidip geliyorsanız, her seferinde uzun yol yazmak yerine `cd -` ile son bulunduğunuz yere dönersiniz. Televizyon kumandasındaki "önceki kanal" tuşu gibidir.

```bash
$ cd /var/log
$ cd /etc
$ cd -
/var/log
```

**Mutlak ve göreli yol:**

- **Mutlak yol:** Kökten başlar. `/home/kullanici/Belgeler`
- **Göreli yol:** Bulunduğunuz yerden başlar. `Belgeler/Raporlar`

Windows'tan farklı olarak Linux'ta sürücü harfi yoktur, dolayısıyla sürücü değiştirme diye bir kavram da yoktur.

---

### `mkdir` — Dizin Oluştur

**mkdir** (Make Directory — Dizin Oluştur), Windows'taki `md` komutunun karşılığıdır.

```bash
$ mkdir Projeler
$ mkdir -p Projeler/Odev1/Veriler
```

`-p` parametresi (parents — üst dizinler) iç içe dizinleri tek seferde oluşturur. Ara dizinler yoksa onları da yaratır. Windows'taki `md Projeler\Odev1\Veriler` komutu varsayılan olarak bunu yapar, Linux'ta ise `-p` parametresi açıkça belirtilmelidir.

---

### `rmdir` ve `rm` — Dizin ve Dosya Silme

**rmdir** (Remove Directory — Dizin Kaldır) sadece boş dizinleri siler:

```bash
$ rmdir BosKlasor
```

Pratikte `rmdir` az kullanılır çünkü dizinler çoğunlukla boş değildir. Dolu dizinleri silmek için `rm` komutu kullanılır:

```bash
$ rm -r Projeler
$ rm -rf Projeler
```

| Parametre | Anlam |
|-----------|-------|
| `-r` | Özyinelemeli (recursive) — alt dizinler dahil sil |
| `-f` | Zorla (force) — onay sorma |
| `-i` | Her dosya için onay iste (interactive) |

> ⚠️ **Dikkat:** `rm -rf /` komutu, sistemdeki her şeyi silmeye çalışır. Modern Linux dağıtımları `--no-preserve-root` olmadan buna izin vermez, ama yine de `rm -rf` komutunu yazmadan önce iki kere, hatta üç kere kontrol edin. Özellikle değişken kullanırken: `rm -rf $DIZIN/` yazıp `$DIZIN` boşsa, bu komut `rm -rf /` haline gelir. Bu hatayı yapan deneyimli sistem yöneticileri bile vardır.

---

### `tree` — Dizin Ağacını Görüntüle

Windows'taki `tree` komutuyla aynı işlevi görür. Çoğu dağıtımda varsayılan olarak kurulu gelmez:

```bash
$ sudo apt install tree    # Debian/Ubuntu tabanlı sistemlerde kurulum
$ tree
.
├── Belgeler
│   ├── Raporlar
│   └── Sunumlar
├── Kod
│   ├── Python
│   └── Java
└── Veriler
    ├── Ham
    └── Islemli
```

`tree -L 2` sadece iki seviye derinliğe kadar gösterir. `tree -f` tam dosya yollarını, `tree -h` dosya boyutlarını okunabilir formatta gösterir.

---

### `clear` — Ekranı Temizle

Windows'taki `cls` komutunun karşılığıdır.

```bash
$ clear
```

Kısayol: **Ctrl + L** aynı işi yapar ve daha hızlıdır. Parmaklarınız zamanla bunu otomatik yapacaktır.

---

### 🔨 Uygulama 1 — Dizin Yapısı Oluşturma ve Gezinme

```bash
# 1. Çalışma dizini oluştur
mkdir -p ~/DersTest
cd ~/DersTest

# 2. Proje yapısını oluştur
mkdir -p Belgeler/Raporlar
mkdir -p Belgeler/Sunumlar
mkdir -p Kod/Python
mkdir -p Kod/Java
mkdir -p Veriler/Ham
mkdir -p Veriler/Islemli

# 3. Yapıyı doğrula
tree

# 4. Gezinme pratiği
cd Kod/Python
pwd
cd ../Java
pwd
cd ~/DersTest
pwd
cd -

# 5. ls ile kontrol
ls -la
ls -R
```

`~` (tilde) karakteri ev dizininin kısayoludur. `~/DersTest` ifadesi `/home/kullanici/DersTest` anlamına gelir. Bu kısayol her kullanıcı için kendi ev dizinini gösterir — taşınabilir bir yol ifadesidir.

`#` ile başlayan satırlar yorum (comment) satırlarıdır. Bash bunları atlar. Windows'taki `REM` komutunun karşılığıdır.

---

## BÖLÜM 2 — Dosya İşlemleri

### `touch` — Dosya Oluştur / Zaman Damgasını Güncelle

**touch** komutu, dosya yoksa boş bir dosya yaratır, varsa zaman damgasını (timestamp) günceller.

```bash
$ touch dosya.txt
$ touch dosya1.txt dosya2.txt dosya3.txt
```

Latince *tangere* (dokunmak) kökünden gelen İngilizce "touch" kelimesi burada tam karşılığını bulur: dosyaya "dokunursunuz", ya yaratırsınız ya da zaman damgasını güncellersiniz.

> **MS-DOS karşılığı:** Windows'ta boş dosya yaratmak için `echo. > dosya.txt` veya `type nul > dosya.txt` yazılırdı. Linux'ta `touch` çok daha temiz bir çözümdür.

---

### `echo` ve Yönlendirme

Windows'taki gibi `echo` metni ekrana yazar ve yönlendirme operatörleriyle dosyaya yazabilir:

```bash
$ echo "Merhaba Dunya"
Merhaba Dunya

$ echo "Birinci satir" > dosya.txt
$ echo "Ikinci satir" >> dosya.txt
```

`>` üzerine yazar, `>>` ekler — bu mantık her iki sistemde de aynıdır.

Bash'te çift tırnak (`"`) ve tek tırnak (`'`) arasında fark vardır:

```bash
$ ISIM="Linux"
$ echo "Merhaba $ISIM"
Merhaba Linux

$ echo 'Merhaba $ISIM'
Merhaba $ISIM
```

Çift tırnak içinde değişkenler açılır (expand edilir), tek tırnak içinde her şey olduğu gibi kalır. Bu ayrım Bash programlamada sık karşılaşılan bir hatanın kaynağıdır.

---

### `cat` — Dosya İçeriğini Göster ve Birleştir

**cat** (Concatenate — Birleştir) komutu, Windows'taki `type` komutunun karşılığıdır ama daha yeteneklidir.

```bash
$ cat dosya.txt
Birinci satir
Ikinci satir
```

**Birden fazla dosyayı birleştirme:**

```bash
$ cat dosya1.txt dosya2.txt > birlesik.txt
```

Bu komut iki dosyanın içeriğini birleştirip yeni bir dosyaya yazar. `cat`'in asıl adının "concatenate" (birleştir) olmasının sebebi budur.

**Satır numarası ile gösterme:**

```bash
$ cat -n dosya.txt
     1  Birinci satir
     2  Ikinci satir
```

---

### `less` ve `more` — Sayfa Sayfa Okuma

Uzun dosyalarda `cat` her şeyi bir anda ekrana döker ve baş taraf kaybolur. `less` ve `more` komutları dosyayı sayfa sayfa gösterir.

```bash
$ less /var/log/syslog
$ more /var/log/syslog
```

`less`, `more`'un gelişmiş versiyonudur. Adı bir kelime oyunudur: "less is more" (az, çoktur).

| Tuş | İşlev (less içinde) |
|-----|---------------------|
| Space | Bir sayfa ileri |
| b | Bir sayfa geri |
| / | Metin ara (aşağı doğru) |
| ? | Metin ara (yukarı doğru) |
| n | Sonraki arama sonucu |
| g | Dosya başına git |
| G | Dosya sonuna git |
| q | Çık |

`less` içindeyken `/hata` yazıp Enter'a basarsanız, dosyada "hata" kelimesini arar. Büyük log dosyalarını incelerken vazgeçilmez bir yöntemdir.

---

### `head` ve `tail` — Dosyanın Başı ve Sonu

```bash
$ head dosya.txt           # İlk 10 satır (varsayılan)
$ head -n 5 dosya.txt      # İlk 5 satır
$ tail dosya.txt           # Son 10 satır
$ tail -n 20 dosya.txt     # Son 20 satır
$ tail -f /var/log/syslog  # Canlı takip (follow)
```

`tail -f` özellikle log dosyalarını izlerken çok kullanılır. `-f` (follow — takip et) parametresi, dosyaya yeni satır eklendikçe onu anında ekrana yansıtır. Bir güvenlik kamerasının canlı yayını gibidir: dosya büyüdükçe yeni satırları görürsünüz. Çıkmak için **Ctrl + C** basarsınız.

> **MS-DOS karşılığı:** Windows'ta `head` ve `tail` komutu yoktur. Benzer işlem ancak `more` veya `findstr` ile dolambaçlı yollardan yapılabilir.

---

### `cp` — Dosya Kopyala

**cp** (Copy — Kopyala), Windows'taki `copy` komutunun karşılığıdır.

```bash
$ cp dosya.txt yedek.txt
$ cp dosya.txt Belgeler/
$ cp dosya.txt Belgeler/yeni_isim.txt
```

**Dizin kopyalama:**

```bash
$ cp -r Kaynak/ Hedef/
```

`-r` (recursive — özyinelemeli) parametresi dizinleri alt dizinleriyle birlikte kopyalar. Windows'taki `xcopy /s` veya `robocopy` işlevinin karşılığıdır.

**Faydalı parametreler:**

| Parametre | Anlam |
|-----------|-------|
| `-r` | Dizinleri özyinelemeli kopyala |
| `-i` | Üzerine yazmadan önce sor (interactive) |
| `-v` | Her kopyalanan dosyayı göster (verbose — ayrıntılı) |
| `-p` | İzinleri ve zaman damgasını koru (preserve) |
| `-u` | Sadece daha yeni dosyaları kopyala (update) |

```bash
$ cp -rvi Projeler/ Yedek/
```

Bu komut Projeler dizinini Yedek'e kopyalar, her dosya için bilgi verir ve üzerine yazmadan önce sorar.

---

### `mv` — Taşı veya Yeniden Adlandır

**mv** (Move — Taşı), Windows'taki `move` ve `ren` komutlarının birleşimidir.

```bash
$ mv dosya.txt Belgeler/         # Taşı
$ mv eski_isim.txt yeni_isim.txt # Yeniden adlandır
$ mv Belgeler/rapor.txt .        # Belgeler'den bulunduğun dizine taşı
```

Sondaki `.` (nokta) "bulunduğum dizin" anlamına gelir. `..` bir üst dizin, `.` bulunduğunuz dizindir.

---

### `rm` — Dosya Sil

**rm** (Remove — Kaldır), Windows'taki `del` komutunun karşılığıdır.

```bash
$ rm dosya.txt
$ rm -i dosya.txt     # Onay iste
$ rm *.txt            # Tüm .txt dosyalarını sil
$ rm -r dizin/        # Dizini içeriğiyle birlikte sil
```

Linux'ta çöp kutusu kavramı terminal düzeyinde yoktur. `rm` ile silinen dosya gider. Masaüstü ortamında dosya yöneticisinden sildiğinizde çöp kutusuna gider, ama terminalden sildiğinizde doğrudan silinir.

---

### `ln` — Bağlantı Oluştur (Link)

**ln** (Link — Bağlantı) komutu, Windows'taki kısayolların (shortcut) daha güçlü bir versiyonunu oluşturur.

```bash
$ ln -s /var/log/syslog ~/loglar_kisayol    # Sembolik bağlantı
$ ln dosya.txt dosya_hardlink.txt            # Sert bağlantı
```

İki tür bağlantı vardır:

- **Sembolik bağlantı** (symbolic link, symlink): Bir dosyaya veya dizine işaret eden kısayoldur. `-s` parametresiyle oluşturulur. Orijinal silinirse bağlantı kırılır.
- **Sert bağlantı** (hard link): Aynı veriye farklı bir isim verir. Orijinal silinse bile veri erişilebilir kalır, çünkü veri diskte tek bir yerdedir ve iki isim aynı veriye işaret eder.

Sembolik bağlantılar çok daha yaygın kullanılır. Uzun dizin yollarına kısayol oluşturmak, farklı versiyonlar arasında geçiş yapmak gibi senaryolarda kullanılır.

---

### Joker Karakterler (Wildcards / Globbing)

Windows'ta da olan `*` ve `?` joker karakterleri Linux'ta da geçerlidir, üzerine birkaç ek vardır:

| Joker | Anlam | Örnek |
|-------|-------|-------|
| `*` | Sıfır veya daha fazla karakter | `*.txt` — tüm txt dosyaları |
| `?` | Tam bir karakter | `dosya?.txt` — dosya1.txt, dosyaA.txt |
| `[abc]` | Köşeli parantez içindeki karakterlerden biri | `dosya[123].txt` — dosya1.txt, dosya2.txt, dosya3.txt |
| `[a-z]` | Aralıktaki karakterlerden biri | `[a-z]*.txt` — küçük harfle başlayan txt dosyaları |
| `[!abc]` | Bu karakterler dışındakiler | `dosya[!0-9].txt` — sayı ile bitmeyenler |
| `{a,b,c}` | Küme parantezi — alternatifleri dener | `*.{txt,md,csv}` — txt, md veya csv uzantılı dosyalar |

```bash
$ ls *.{jpg,png,gif}      # Tüm resim dosyaları
$ cp rapor[1-5].txt Yedek/ # rapor1.txt'den rapor5.txt'ye kadar kopyala
```

Küme parantezi (`{}`) özelliği Bash'e özgüdür ve Windows cmd'de yoktur. Birden fazla uzantıyı tek satırda ele almak için çok pratiktir.

---

### 🔨 Uygulama 2 — Dosya İşlemleri Pratiği

```bash
# 1. Çalışma alanı oluştur
mkdir -p ~/DosyaPratik && cd ~/DosyaPratik

# 2. Dosyalar oluştur
echo "Birinci dosya icerigi" > dosya1.txt
echo "Ikinci dosya icerigi" > dosya2.txt
echo "Ucuncu dosya icerigi" > dosya3.txt

# 3. Dosyaları listele
ls -l

# 4. cat ile içeriği göster
cat dosya1.txt

# 5. Dosyaya ekleme yap
echo "Eklenen satir" >> dosya1.txt
cat -n dosya1.txt

# 6. Yedek dizini oluştur ve kopyala
mkdir Yedek
cp *.txt Yedek/
ls -l Yedek/

# 7. Dosya yeniden adlandır
mv dosya1.txt ana_dosya.txt
ls

# 8. Sembolik bağlantı oluştur
ln -s ~/DosyaPratik/ana_dosya.txt ~/Masaustu/kisayol.txt
ls -l ~/Masaustu/kisayol.txt

# 9. Bir dosyayı sil (onaylı)
rm -i dosya3.txt

# 10. Yapıyı kontrol et
tree ~/DosyaPratik
```

`&&` operatörü Windows'taki gibi çalışır: birinci komut başarılıysa ikinciyi çalıştırır.

---

## BÖLÜM 3 — Metin İşleme

Linux'un en güçlü yanlarından biri metin işleme araçlarıdır. Windows'ta `find` ve `findstr` ile yapılabilen işlemler, Linux'ta çok daha zengin bir araç setiyle yapılır.

### `grep` — Metin Ara

**grep** (Global Regular Expression Print — Genel Düzenli İfade Yazdırma) Linux'un en önemli komutlarından biridir.

```bash
$ grep "hata" log.txt
$ grep -i "hata" log.txt       # Büyük-küçük harf duyarsız
$ grep -n "hata" log.txt       # Satır numarası göster
$ grep -c "hata" log.txt       # Eşleşen satır sayısı
$ grep -r "TODO" ~/Projeler/   # Alt dizinlerde de ara
$ grep -v "bilgi" log.txt      # Eşleşmeyen satırları göster
```

| Parametre | Anlam |
|-----------|-------|
| `-i` | Büyük-küçük harf duyarsız (ignore case) |
| `-n` | Satır numarası (number) |
| `-c` | Eşleşme sayısı (count) |
| `-r` | Özyinelemeli arama (recursive) |
| `-v` | Ters eşleşme — eşleşmeyenleri göster (invert) |
| `-l` | Sadece dosya adlarını göster (files with matches) |
| `-w` | Tam kelime eşleştir (word) |
| `--color` | Eşleşen kısmı renklendir |

**Düzenli ifade (regex) örnekleri:**

```bash
$ grep "^hata" log.txt         # Satır başında "hata" olanlar
$ grep "hata$" log.txt         # Satır sonunda "hata" olanlar
$ grep "^$" dosya.txt          # Boş satırlar
$ grep -E "[0-9]{3}" log.txt   # Üç basamaklı sayı içeren satırlar
```

`-E` parametresi genişletilmiş düzenli ifadeleri (Extended Regular Expression) etkinleştirir. `grep -E` yerine `egrep` de yazılabilir.

> **MS-DOS karşılığı:** `grep` Windows'taki `findstr` komutunun çok daha güçlü bir versiyonudur. Bir İsviçre çakısı gibidir — metin işlemenin hemen her aşamasında karşınıza çıkar.

---

### `wc` — Sayma

**wc** (Word Count — Kelime Sayısı) dosyadaki satır, kelime ve karakter sayısını verir.

```bash
$ wc dosya.txt
  50  200 1234 dosya.txt
```

Çıktı sırasıyla: satır sayısı, kelime sayısı, bayt sayısı.

```bash
$ wc -l dosya.txt    # Sadece satır sayısı (lines)
$ wc -w dosya.txt    # Sadece kelime sayısı (words)
$ wc -c dosya.txt    # Sadece bayt sayısı (characters/bytes)
```

Pipe ile birleştirildiğinde çok kullanışlı olur:

```bash
$ ls -l | wc -l       # Dizindeki dosya/dizin sayısı
$ grep "hata" log.txt | wc -l  # "hata" içeren satır sayısı
```

---

### `sort` — Sırala

```bash
$ sort isimler.txt               # Alfabetik sırala
$ sort -r isimler.txt            # Ters sırala (reverse)
$ sort -n sayilar.txt            # Sayısal sırala (numeric)
$ sort -k 2 tablo.txt            # 2. sütuna göre sırala (key)
$ sort -u isimler.txt            # Tekrarları kaldır (unique)
$ sort -t ":" -k 3 -n /etc/passwd  # : ayracı ile 3. alana göre sayısal sırala
```

`-t` ayraç karakterini (delimiter), `-k` sıralama yapılacak sütunu belirtir.

---

### `cut` — Sütun Kes

**cut** komutu, her satırdan belirli sütunları veya alanları keser.

```bash
$ cut -d ":" -f 1 /etc/passwd     # : ile ayırıp 1. alanı al
$ cut -d ":" -f 1,3 /etc/passwd   # 1. ve 3. alanları al
$ cut -c 1-10 dosya.txt           # Her satırın ilk 10 karakteri
```

`-d` ayraç (delimiter), `-f` alan numarası (field), `-c` karakter pozisyonu belirtir.

---

### `uniq` — Tekrarları Kaldır

**uniq** (Unique — Benzersiz), ardışık tekrar eden satırları kaldırır. Ardışık olmayan tekrarlar için önce `sort` ile sıralamak gerekir.

```bash
$ sort isimler.txt | uniq          # Tekrarsız liste
$ sort isimler.txt | uniq -c       # Her satırın kaç kez tekrarlandığını göster
$ sort isimler.txt | uniq -d       # Sadece tekrar edenleri göster
```

`sort | uniq` birleşimi o kadar sık kullanılır ki neredeyse tek bir komut gibi düşünülür.

---

### `sed` — Akış Düzenleyici

**sed** (Stream Editor — Akış Düzenleyici), metin üzerinde bul-değiştir ve dönüşüm işlemleri yapar. Dosyayı açmadan, komut satırından düzenleme yapmak için kullanılır.

```bash
$ sed 's/eski/yeni/' dosya.txt         # Her satırdaki ilk eşleşmeyi değiştir
$ sed 's/eski/yeni/g' dosya.txt        # Tüm eşleşmeleri değiştir (global)
$ sed -i 's/eski/yeni/g' dosya.txt     # Dosyayı yerinde değiştir (in-place)
$ sed '5d' dosya.txt                    # 5. satırı sil (delete)
$ sed '/^#/d' dosya.txt                # # ile başlayan satırları sil
$ sed -n '10,20p' dosya.txt            # 10-20 arası satırları yazdır (print)
```

`s` komutu substitution (yer değiştirme) anlamına gelir. `g` bayrağı global (tümü) demektir — onsuz sadece her satırdaki ilk eşleşme değişir.

`-i` parametresi dosyayı doğrudan değiştirir, bu yüzden dikkatli kullanılmalıdır. Güvenli yol: önce `-i` olmadan çalıştırıp çıktıyı kontrol edin, sonra `-i` ekleyin.

---

### `awk` — Metin İşleme Dili

**awk** (yaratıcıları Aho, Weinberger, Kernighan'ın soyadlarının baş harfleri), başlı başına bir programlama dilidir ama çoğunlukla tek satırlık komutlarla kullanılır. Sütun bazlı veri işlemede son derece güçlüdür.

```bash
$ awk '{print $1}' dosya.txt            # Her satırın 1. sütunu
$ awk '{print $1, $3}' dosya.txt        # 1. ve 3. sütun
$ awk -F ":" '{print $1}' /etc/passwd   # : ayracı ile 1. alan
$ awk '$3 > 100' veri.txt               # 3. sütunu 100'den büyük satırlar
$ awk '{toplam += $1} END {print toplam}' sayilar.txt  # Toplam hesapla
```

`$1`, `$2`, `$3` sırasıyla birinci, ikinci, üçüncü sütunu ifade eder. `$0` tüm satırdır. `-F` alan ayracını belirtir (varsayılan boşluk/tab).

---

### Boru Hatları (Pipes) — Komutları Zincirleme

Linux'un felsefesi "tek bir işi iyi yapan küçük araçlar"dır. Bu araçlar `|` (pipe) ile birbirine bağlanarak karmaşık işlemler yapılır.

```bash
# En çok disk kullanan 5 dizini bul
du -sh /var/* 2>/dev/null | sort -rh | head -5

# Sistemdeki kullanıcıları alfabetik listele
cut -d ":" -f 1 /etc/passwd | sort

# Log dosyasında en çok tekrar eden hata mesajını bul
grep "ERROR" /var/log/syslog | awk '{print $6}' | sort | uniq -c | sort -rn | head -5

# Çalışan süreçleri bellek kullanımına göre sırala
ps aux | sort -k 4 -rn | head -10
```

Her `|` bir borunun bağlantı noktasıdır. Bir komutun çıktısı, bir sonraki komutun girdisi olur. Fabrikadaki montaj hattı gibi düşünün: her istasyon bir işlem yapar ve ürünü bir sonrakine geçirir.

---

### 🔨 Uygulama 3 — Metin İşleme Pratiği

```bash
# 1. Örnek veri dosyası oluştur
cat > ogrenciler.csv << 'EOF'
Ad,Soyad,Numara,Not
Ali,Yilmaz,2001,85
Zeynep,Kaya,2002,92
Mehmet,Demir,2003,78
Canan,Aksoy,2004,95
Burak,Celik,2005,88
Ayse,Sahin,2006,72
Emre,Ozturk,2007,91
Fatma,Acar,2008,65
Hasan,Yildiz,2009,83
Derya,Korkmaz,2010,97
EOF

# 2. Dosya içeriğini göster
cat -n ogrenciler.csv

# 3. Sadece isimleri listele (başlık hariç)
tail -n +2 ogrenciler.csv | cut -d "," -f 1

# 4. Notu 90 ve üzeri olanları bul
awk -F "," '$4 >= 90 {print $1, $2, $4}' ogrenciler.csv

# 5. İsimlere göre alfabetik sırala (başlık hariç)
tail -n +2 ogrenciler.csv | sort -t "," -k 1

# 6. Not ortalamasını hesapla
tail -n +2 ogrenciler.csv | awk -F "," '{toplam += $4; sayac++} END {print "Ortalama:", toplam/sayac}'

# 7. Kaç öğrenci var?
tail -n +2 ogrenciler.csv | wc -l

# 8. "Ali" veya "Ayse" içeren satırlar
grep -E "Ali|Ayse" ogrenciler.csv

# 9. Notlara göre azalan sırada listele
tail -n +2 ogrenciler.csv | sort -t "," -k 4 -rn

# 10. Sonuçları dosyaya kaydet
tail -n +2 ogrenciler.csv | sort -t "," -k 4 -rn > sirali_notlar.csv
cat sirali_notlar.csv
```

`tail -n +2` ifadesi "2. satırdan itibaren göster" anlamına gelir, böylece başlık satırını atlarsınız. `+` işareti burada "bu satırdan başla" demektir.

`<< 'EOF'` yapısı **here document** olarak adlandırılır. `EOF` etiketine kadar olan tüm satırları girdi olarak kullanır. Çok satırlı metin oluştururken pratiktir.

---

## BÖLÜM 4 — Dosya İzinleri ve Sahiplik

Linux çok kullanıcılı (multi-user) bir işletim sistemidir. Bu yüzden "bu dosyaya kim erişebilir, kim değiştirebilir" sorusu temel bir güvenlik meselesidir. Windows'ta da izin sistemi vardır ama GUI üzerinden yönetilir; Linux'ta izinler komut satırından yönetilir ve dosya sisteminin ayrılmaz bir parçasıdır.

### İzin Yapısı

`ls -l` çıktısını tekrar inceleyelim:

```
-rw-r--r-- 1 kullanici grup 1234 Şub 15 22:10 rapor.txt
drwxr-xr-x 2 kullanici grup 4096 Şub 16 10:30 Belgeler
```

İlk sütundaki 10 karakterlik dizgiyi parçalayalım:

```
-  rw-  r--  r--
│  │    │    │
│  │    │    └── Diğerleri (others) — herkes
│  │    └─────── Grup (group) — dosya sahibinin grubu
│  └──────────── Sahip (owner/user) — dosyanın sahibi
└─────────────── Tür: - dosya, d dizin, l bağlantı
```

Her üçlüde:
- `r` — okuma (read)
- `w` — yazma (write)
- `x` — çalıştırma (execute); dizinler için içine girme

`rw-r--r--` şu anlama gelir: sahip okuyup yazabilir, grup ve diğerleri sadece okuyabilir.

---

### `chmod` — İzinleri Değiştir

**chmod** (Change Mode — Mod Değiştir) komutu dosya izinlerini ayarlar.

**Sembolik (symbolic) yöntem:**

```bash
$ chmod u+x script.sh      # Sahibe çalıştırma izni ekle
$ chmod g+w dosya.txt       # Gruba yazma izni ekle
$ chmod o-r dosya.txt       # Diğerlerinden okuma iznini kaldır
$ chmod a+r dosya.txt       # Herkese okuma izni ekle
$ chmod u+rwx,g+rx,o+r dosya.txt  # Birden fazla ayar
```

| Harf | Kim | | Harf | Ne |
|------|-----|-|------|----|
| `u` | Sahip (user) | | `r` | Okuma (read) |
| `g` | Grup (group) | | `w` | Yazma (write) |
| `o` | Diğerleri (others) | | `x` | Çalıştırma (execute) |
| `a` | Herkes (all) | | | |

**Sayısal (octal) yöntem:**

Her izin bir sayıya karşılık gelir: `r=4`, `w=2`, `x=1`. Bunlar toplanarak üç basamaklı bir sayı oluşturulur.

```
rwx = 4+2+1 = 7
rw- = 4+2+0 = 6
r-x = 4+0+1 = 5
r-- = 4+0+0 = 4
```

```bash
$ chmod 755 script.sh    # rwxr-xr-x — sahip her şey, diğerleri oku-çalıştır
$ chmod 644 dosya.txt    # rw-r--r-- — sahip oku-yaz, diğerleri sadece oku
$ chmod 700 gizli/       # rwx------ — sadece sahip erişebilir
$ chmod 600 sifre.txt    # rw------- — sadece sahip okuyup yazabilir
```

Yaygın izin kalıpları:

| Sayı | İzin | Kullanım |
|------|------|----------|
| `755` | rwxr-xr-x | Çalıştırılabilir dosyalar, dizinler |
| `644` | rw-r--r-- | Normal dosyalar |
| `700` | rwx------ | Özel dizinler |
| `600` | rw------- | Hassas dosyalar (anahtarlar, parolalar) |

---

### `chown` — Sahiplik Değiştir

**chown** (Change Owner — Sahip Değiştir) komutu dosyanın sahibini ve grubunu değiştirir. Root yetkisi gerektirir.

```bash
$ sudo chown ali dosya.txt           # Sahibi ali yap
$ sudo chown ali:gelistiriciler dosya.txt  # Sahip ve grubu değiştir
$ sudo chown -R ali:ali ~/Projeler/  # Özyinelemeli
```

---

### 🔨 Uygulama 4 — İzin Pratiği

```bash
# 1. Test dosyaları oluştur
cd ~/DersTest
echo '#!/bin/bash' > betik.sh
echo 'echo "Bu bir betik dosyasidir"' >> betik.sh

# 2. İzinleri incele
ls -l betik.sh

# 3. Çalıştırmayı dene (izin hatası alacaksınız)
./betik.sh

# 4. Çalıştırma izni ekle
chmod u+x betik.sh
ls -l betik.sh

# 5. Tekrar çalıştır
./betik.sh

# 6. Sayısal yöntemle izin ayarla
chmod 755 betik.sh
ls -l betik.sh

# 7. Gizli dosya oluştur ve izinlerini kısıtla
echo "gizli bilgi" > .sifreler.txt
chmod 600 .sifreler.txt
ls -la .sifreler.txt
```

`#!/bin/bash` satırına **shebang** denir. İşletim sistemine "bu dosyayı bash ile çalıştır" der. `#!` karakterlerinden sonra yorumlayıcının (interpreter) yolu yazılır.

---

## BÖLÜM 5 — Sistem Bilgisi ve Süreç Yönetimi

### `uname` — Sistem Kimliği

```bash
$ uname -a
Linux bilgisayar 5.15.0-92-generic #102-Ubuntu SMP x86_64 GNU/Linux
```

`-a` (all) parametresi çekirdek adı, sürümü, mimari ve diğer bilgileri tek satırda gösterir. Windows'taki `ver` komutunun genişletilmiş halidir.

---

### `hostname` — Bilgisayar Adı

```bash
$ hostname
bilgisayar

$ hostname -I    # IP adreslerini göster
192.168.1.105
```

---

### `whoami` ve `id` — Kullanıcı Bilgisi

```bash
$ whoami
kullanici

$ id
uid=1000(kullanici) gid=1000(kullanici) gruplar=1000(kullanici),27(sudo),100(users)
```

`id` komutu, kullanıcı kimliği (UID — User ID), grup kimliği (GID — Group ID) ve üye olunan grupları gösterir.

---

### `uptime` — Sistem Çalışma Süresi

```bash
$ uptime
 14:30:25 up 15 days,  3:22,  2 users,  load average: 0.15, 0.20, 0.18
```

Bu tek satır şunu söyler: saat 14:30, sistem 15 gündür açık, 2 kullanıcı bağlı, son 1-5-15 dakikadaki ortalama yük (load average) 0.15, 0.20, 0.18.

Load average değerleri, CPU üzerindeki iş yükünü gösterir. Tek çekirdekli bir işlemcide 1.0 tam kapasite demektir, 4 çekirdeklide 4.0.

---

### `df` — Disk Kullanımı

**df** (Disk Free — Boş Disk Alanı) komutu, bağlı dosya sistemlerinin kullanım durumunu gösterir.

```bash
$ df -h
Dosyasistemi    Boyut Kull. Boş  Kull% Bağ-noktası
/dev/sda1         50G   32G  16G   68% /
/dev/sda2        200G  120G  70G   63% /home
tmpfs             4G  200M  3.8G    5% /tmp
```

`-h` (human-readable) boyutları GB, MB cinsinden gösterir. Windows'taki `wmic logicaldisk` komutunun karşılığıdır ama çok daha okunabilir.

---

### `du` — Dizin Boyutu

**du** (Disk Usage — Disk Kullanımı) belirli bir dizinin ne kadar yer kapladığını gösterir.

```bash
$ du -sh ~/Belgeler
1.2G    /home/kullanici/Belgeler

$ du -sh ~/Belgeler/*     # Alt dizinlerin boyutları
200M    /home/kullanici/Belgeler/Raporlar
800M    /home/kullanici/Belgeler/Sunumlar
```

`-s` (summary — özet) toplamı gösterir, `-h` okunabilir birim kullanır.

---

### `free` — Bellek Kullanımı

```bash
$ free -h
               toplam    kullan.   boş      paylaş.  arabel.   kullan.
Bellek:         16Gi      8.2Gi    3.1Gi     512Mi    4.7Gi     7.3Gi
Takas:          4.0Gi     200Mi    3.8Gi
```

"Takas" (swap), RAM dolduğunda diske taşan bellek alanıdır. Fiziksel belleğin yetmediği durumlarda devreye girer ama diskten okuma RAM'den çok daha yavaş olduğu için performansı düşürür.

---

### `ps` — Çalışan Süreçler

**ps** (Process Status — Süreç Durumu), Windows'taki `tasklist` komutunun karşılığıdır.

```bash
$ ps                    # Sadece kendi terminal süreçleriniz
$ ps aux                # Tüm süreçler, detaylı
$ ps aux | grep firefox # firefox süreçlerini filtrele
```

`aux` parametreleri: `a` (all users — tüm kullanıcılar), `u` (user-oriented format — kullanıcı odaklı), `x` (terminalsiz süreçler dahil).

```
USER       PID %CPU %MEM    VSZ   RSS TTY STAT START   TIME COMMAND
root         1  0.0  0.1 169012 11232 ?   Ss   Şub01   0:05 /sbin/init
kullanici 3456 12.5  5.2 2345678 845632 ? Sl  14:00   2:30 firefox
```

Sütunlar: kullanıcı, süreç kimliği (PID), CPU yüzdesi, bellek yüzdesi, sanal ve fiziksel bellek, terminal, durum, başlangıç, toplam CPU süresi, komut.

---

### `top` ve `htop` — Canlı Süreç İzleme

**top** komutu, süreçleri canlı olarak izler. Windows'taki Görev Yöneticisi'nin terminal karşılığıdır.

```bash
$ top
```

| Tuş | İşlev (top içinde) |
|-----|---------------------|
| q | Çık |
| M | Bellek kullanımına göre sırala |
| P | CPU kullanımına göre sırala |
| k | Süreç sonlandır (PID sor) |
| 1 | Her CPU çekirdeğini ayrı göster |

**htop** daha renkli ve kullanışlı bir alternatiftir (kurulum gerektirebilir):

```bash
$ sudo apt install htop
$ htop
```

---

### `kill` — Süreç Sonlandır

**kill** komutu, bir sürece sinyal (signal) gönderir. Windows'taki `taskkill` komutunun karşılığıdır.

```bash
$ kill 3456          # SIGTERM — nazikçe sonlandır (varsayılan)
$ kill -9 3456       # SIGKILL — zorla sonlandır
$ kill -15 3456      # SIGTERM — nazikçe sonlandır (açık belirtim)
```

`SIGTERM` (sinyal 15) programa "lütfen temiz bir şekilde kapan" der. Program kaydetmesi gerekenleri kaydedip kapanabilir. `SIGKILL` (sinyal 9) ise anında sonlandırır, program hiçbir temizlik yapamaz. Önce `kill` deneyin, cevap vermezse `kill -9` kullanın.

**killall** komut adına göre sonlandırır:

```bash
$ killall firefox
```

---

### 🔨 Uygulama 5 — Sistem İzleme

```bash
# 1. Sistem bilgilerini topla
echo "=== SISTEM BILGISI ===" > ~/sistem_raporu.txt
uname -a >> ~/sistem_raporu.txt

echo "" >> ~/sistem_raporu.txt
echo "=== BILGISAYAR ADI ===" >> ~/sistem_raporu.txt
hostname >> ~/sistem_raporu.txt

echo "" >> ~/sistem_raporu.txt
echo "=== CALISMA SURESI ===" >> ~/sistem_raporu.txt
uptime >> ~/sistem_raporu.txt

echo "" >> ~/sistem_raporu.txt
echo "=== BELLEK DURUMU ===" >> ~/sistem_raporu.txt
free -h >> ~/sistem_raporu.txt

echo "" >> ~/sistem_raporu.txt
echo "=== DISK KULLANIMI ===" >> ~/sistem_raporu.txt
df -h >> ~/sistem_raporu.txt

echo "" >> ~/sistem_raporu.txt
echo "=== EN COK CPU KULLANAN 10 SUREC ===" >> ~/sistem_raporu.txt
ps aux --sort=-%cpu | head -11 >> ~/sistem_raporu.txt

echo "" >> ~/sistem_raporu.txt
echo "=== EN COK BELLEK KULLANAN 10 SUREC ===" >> ~/sistem_raporu.txt
ps aux --sort=-%mem | head -11 >> ~/sistem_raporu.txt

# 2. Raporu görüntüle
less ~/sistem_raporu.txt
```

`ps aux --sort=-%cpu` süreçleri CPU kullanımına göre azalan sırada sıralar. Baştaki `-` azalan (descending) sıralama demektir.

---

## BÖLÜM 6 — Ağ (Network) Komutları

### `ip` — Ağ Yapılandırması

Eski `ifconfig` komutunun modern karşılığıdır. Windows'taki `ipconfig` ile karıştırmayın — isim benzerliği yanıltıcıdır.

```bash
$ ip addr show          # Tüm ağ arayüzlerini göster (veya kısaca: ip a)
$ ip addr show eth0     # Belirli arayüz
$ ip route show         # Yönlendirme tablosu (varsayılan ağ geçidi dahil)
$ ip link show          # Arayüz durumları
```

```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP>
    inet 192.168.1.105/24 brd 192.168.1.255 scope global eth0
```

`192.168.1.105/24` ifadesindeki `/24` alt ağ maskesini (subnet mask) CIDR (Classless Inter-Domain Routing) notasyonuyla gösterir. `/24` demek `255.255.255.0` demektir.

> **Not:** Birçok eski kaynak ve kılavuz hâlâ `ifconfig` komutunu referans gösterir. Çoğu modern dağıtımda `ifconfig` varsayılan olarak kurulu gelmez, `ip` komutu tercih edilir. Ancak `ifconfig`'i bilmek eski sistemlerle çalışırken işe yarar:
>
> ```bash
> $ ifconfig           # Ağ arayüzlerini göster
> $ ifconfig eth0 up   # Arayüzü etkinleştir
> ```

---

### `ping` — Bağlantı Testi

Windows'takiyle neredeyse aynıdır, tek fark: Linux'ta `ping` varsayılan olarak sürekli çalışır (Windows'ta 4 paket gönderip durur).

```bash
$ ping google.com           # Sürekli ping (Ctrl+C ile durdur)
$ ping -c 4 google.com     # 4 paket gönder ve dur (count)
$ ping -c 4 -i 2 google.com # 2 saniye aralıkla (interval)
$ ping 192.168.1.1          # Yerel ağ geçidine
```

**Sorun giderme stratejisi** (Windows ders notundan hatırlayın):

1. `ping 127.0.0.1` → Loopback çalışıyor mu?
2. `ping 192.168.1.1` → Ağ geçidine ulaşılıyor mu?
3. `ping 8.8.8.8` → İnternete çıkılıyor mu?
4. `ping google.com` → DNS çalışıyor mu?

Aynı katmanlı yaklaşım her iki sistemde de geçerlidir.

---

### `traceroute` — Yol İzleme

Windows'taki `tracert` komutunun karşılığıdır.

```bash
$ traceroute google.com
$ traceroute -n google.com    # DNS çözümlemesi yapma (sadece IP göster)
$ traceroute -m 15 google.com # En fazla 15 hop dene
```

Kurulu değilse: `sudo apt install traceroute`

---

### `nslookup` ve `dig` — DNS Sorgusu

`nslookup` her iki sistemde de vardır. Linux'ta daha güçlü bir alternatif olan `dig` (Domain Information Groper — Alan Adı Bilgi Araştırıcısı) da mevcuttur.

```bash
$ nslookup google.com

$ dig google.com
$ dig google.com +short       # Sadece IP adresini göster
$ dig -x 142.250.187.206     # Ters DNS sorgusu (IP'den isme)
$ dig google.com MX           # E-posta sunucularını sorgula
```

`dig` çıktısı `nslookup`'a göre çok daha detaylıdır: sorgu süresi, yetki bilgisi, TTL değerleri hepsi görünür.

---

### `ss` — Ağ Bağlantıları

Eski `netstat` komutunun modern karşılığıdır (ss: Socket Statistics — Soket İstatistikleri).

```bash
$ ss -tuln              # TCP/UDP dinleyen portlar
$ ss -tunap             # Tüm bağlantılar, süreç bilgisiyle
```

| Parametre | Anlam |
|-----------|-------|
| `-t` | TCP bağlantıları |
| `-u` | UDP bağlantıları |
| `-l` | Dinleyen (listening) portlar |
| `-n` | Sayısal gösterim (numeric) |
| `-a` | Tüm bağlantılar (all) |
| `-p` | Süreç bilgisi (process) |

```bash
$ ss -tuln | grep 80       # 80 numaralı portu kullanan servisi bul
$ ss -tunap | grep ssh     # SSH bağlantılarını göster
```

> **netstat kullanımı:** Eski sistemlerde veya alışkanlıkla `netstat` de kullanılabilir:
> ```bash
> $ netstat -tulnp
> ```
> Parametreler `ss` ile benzerdir.

---

### `curl` ve `wget` — URL'den Veri Çekme

**curl** (Client URL) ve **wget** (Web Get) komutları, komut satırından web istekleri yapmayı sağlar.

```bash
$ curl https://example.com                  # Sayfayı ekrana yazdır
$ curl -o sayfa.html https://example.com    # Dosyaya kaydet (output)
$ curl -I https://example.com              # Sadece HTTP başlıklarını göster
$ curl -s https://api.example.com/veri     # Sessiz mod (silent) — ilerleme gösterme

$ wget https://example.com/dosya.zip       # Dosyayı indir
$ wget -c https://example.com/buyuk.iso    # Kesilen indirmeye devam et (continue)
```

`curl` özellikle API testlerinde çok kullanılır. REST API'lere istek göndermek, JSON yanıtlarını almak için standart araçtır:

```bash
$ curl -s https://api.github.com/users/torvalds | head -20
```

---

### 🔨 Uygulama 6 — Ağ Teşhisi

```bash
# 1. IP yapılandırması
echo "=== AG RAPORU ===" > ~/ag_raporu.txt
echo "Tarih: $(date)" >> ~/ag_raporu.txt

echo "" >> ~/ag_raporu.txt
echo "=== IP YAPILANDIRMASI ===" >> ~/ag_raporu.txt
ip addr show >> ~/ag_raporu.txt

echo "" >> ~/ag_raporu.txt
echo "=== VARSAYILAN AG GECIDI ===" >> ~/ag_raporu.txt
ip route show default >> ~/ag_raporu.txt

# 2. Bağlantı testleri
echo "" >> ~/ag_raporu.txt
echo "=== PING TESTI (localhost) ===" >> ~/ag_raporu.txt
ping -c 3 127.0.0.1 >> ~/ag_raporu.txt

echo "" >> ~/ag_raporu.txt
echo "=== PING TESTI (Google DNS) ===" >> ~/ag_raporu.txt
ping -c 3 8.8.8.8 >> ~/ag_raporu.txt

# 3. DNS sorgusu
echo "" >> ~/ag_raporu.txt
echo "=== DNS SORGUSU ===" >> ~/ag_raporu.txt
dig google.com +short >> ~/ag_raporu.txt

# 4. Açık portlar
echo "" >> ~/ag_raporu.txt
echo "=== ACIK PORTLAR ===" >> ~/ag_raporu.txt
ss -tuln >> ~/ag_raporu.txt

# 5. Raporu oku
less ~/ag_raporu.txt
```

`$(date)` ifadesi, `date` komutunun çıktısını satıra yerleştirir. Buna **komut ikamesi** (command substitution) denir.

---

## BÖLÜM 7 — Paket Yönetimi

Windows'ta program kurmak için genellikle bir web sitesinden .exe indirip çalıştırırsınız. Linux'ta ise merkezi bir **paket deposu** (package repository) sistemi vardır. Bir uygulama mağazası gibi düşünün, ama komut satırından yönetilen ve çok daha kapsamlı bir mağaza.

Debian/Ubuntu tabanlı sistemlerde (MATE genellikle bunlardan biriyle gelir) paket yöneticisi **apt** (Advanced Package Tool — Gelişmiş Paket Aracı) kullanılır.

```bash
$ sudo apt update                # Paket listesini güncelle
$ sudo apt upgrade               # Kurulu paketleri güncelle
$ sudo apt install htop          # Paket kur
$ sudo apt remove htop           # Paketi kaldır
$ sudo apt purge htop            # Paketi yapılandırmasıyla birlikte kaldır
$ sudo apt search "metin editoru" # Paket ara
$ apt list --installed           # Kurulu paketleri listele
```

`sudo` (Super User DO — Süper Kullanıcı Olarak Yap) komutu, bir komutu yönetici (root) yetkisiyle çalıştırır. Windows'taki "Yönetici olarak çalıştır" seçeneğinin karşılığıdır. Paket kurma ve kaldırma gibi sistem değişikliği gerektiren işlemler `sudo` gerektirir.

**Sık kullanılan paket işlemleri:**

```bash
$ sudo apt update && sudo apt upgrade -y  # Güncelle (onay sorma)
$ dpkg -l | grep firefox                  # Kurulu paketlerde firefox ara
$ apt show htop                           # Paket hakkında bilgi göster
```

`dpkg` (Debian Package), apt'nin alt seviye aracıdır. `dpkg -l` tüm kurulu paketleri listeler.

---

## BÖLÜM 8 — Kabuk Betikleri (Shell Scripts)

Windows'taki batch dosyalarının Linux karşılığı kabuk betikleridir (shell scripts). Dosya uzantısı geleneksel olarak `.sh`'tir.

### İlk Betik

```bash
#!/bin/bash
# sistem_bilgi.sh — Sistem bilgilerini ekrana yazdıran betik

echo "================================"
echo "  Sistem Bilgi Raporu"
echo "================================"
echo ""
echo "Bilgisayar : $(hostname)"
echo "Kullanici  : $(whoami)"
echo "Tarih      : $(date '+%d.%m.%Y %H:%M')"
echo "Cekirdek   : $(uname -r)"
echo "Calisma S. : $(uptime -p)"
echo ""
echo "================================"
```

Kaydetme ve çalıştırma:

```bash
$ nano sistem_bilgi.sh      # nano editörüyle yaz
$ chmod +x sistem_bilgi.sh  # Çalıştırma izni ver
$ ./sistem_bilgi.sh         # Çalıştır
```

`$(komut)` yapısı, komutun çıktısını metin içine yerleştirir. `date '+%d.%m.%Y %H:%M'` tarihi istediğimiz formatta verir.

---

### Değişkenler ve Kullanıcı Girdisi

```bash
#!/bin/bash

# Değişken tanımlama (= etrafında boşluk OLMAMAL)
PROJE="Linux Dersi"
VERSIYON=1

echo "Proje: $PROJE, Versiyon: $VERSIYON"

# Kullanıcıdan girdi alma
read -p "Adinizi girin: " ISIM
echo "Merhaba $ISIM!"
```

> **Kritik not:** Bash'te değişken atamada `=` işaretinin etrafında boşluk olmamalıdır. `ISIM="Ali"` doğru, `ISIM = "Ali"` hatalıdır. Bu, Windows batch dosyalarından farklı bir kuraldır ve sık yapılan hatalardan biridir.

---

### Komut Satırı Parametreleri

```bash
#!/bin/bash
# yedekle.sh — Basit yedekleme betiği

if [ -z "$1" ]; then
    echo "Kullanim: $0 [kaynak_dizin]"
    exit 1
fi

KAYNAK="$1"
HEDEF="$HOME/Yedekler/$(date '+%Y%m%d_%H%M%S')"

echo "Yedekleme basliyor..."
echo "Kaynak : $KAYNAK"
echo "Hedef  : $HEDEF"

mkdir -p "$HEDEF"
cp -rv "$KAYNAK" "$HEDEF/"

echo "Yedekleme tamamlandi!"
```

`$0` betik adı, `$1` birinci parametre, `$2` ikinci parametre. `$#` parametre sayısı, `$@` tüm parametreler.

`-z` testi "değişken boş mu" kontrol eder. `[ ]` Bash'te koşul testi yapmak için kullanılan yapıdır.

---

### Koşullu İfadeler

```bash
#!/bin/bash

read -p "Bir sayi girin: " SAYI

if [ "$SAYI" -gt 100 ]; then
    echo "$SAYI sayisi 100'den buyuktur."
elif [ "$SAYI" -eq 100 ]; then
    echo "$SAYI tam olarak 100'e esittir."
else
    echo "$SAYI sayisi 100'den kucuktur."
fi
```

| Operatör | Anlam | İngilizce |
|----------|-------|-----------|
| `-eq` | Eşit | Equal |
| `-ne` | Eşit değil | Not Equal |
| `-lt` | Küçük | Less Than |
| `-le` | Küçük veya eşit | Less or Equal |
| `-gt` | Büyük | Greater Than |
| `-ge` | Büyük veya eşit | Greater or Equal |

**Dosya testleri:**

| Test | Anlam |
|------|-------|
| `-f dosya` | Dosya var mı? |
| `-d dizin` | Dizin var mı? |
| `-r dosya` | Okunabilir mi? |
| `-w dosya` | Yazılabilir mi? |
| `-x dosya` | Çalıştırılabilir mi? |
| `-s dosya` | Dosya boş değil mi? (size > 0) |

```bash
if [ -f "/etc/passwd" ]; then
    echo "/etc/passwd dosyasi mevcut."
fi

if [ -d "$HOME/Yedekler" ]; then
    echo "Yedek dizini var."
else
    mkdir -p "$HOME/Yedekler"
    echo "Yedek dizini olusturuldu."
fi
```

---

### Döngüler

**for döngüsü:**

```bash
#!/bin/bash

# Dosyaları dolaş
for dosya in *.txt; do
    echo "Dosya: $dosya"
done

# Sayısal döngü
for i in {1..10}; do
    echo "Sayi: $i"
done

# C-stili döngü
for ((i=1; i<=10; i++)); do
    echo "Sayi: $i"
done
```

**while döngüsü:**

```bash
#!/bin/bash
SAYAC=1
while [ $SAYAC -le 5 ]; do
    echo "Adim: $SAYAC"
    SAYAC=$((SAYAC + 1))
done
```

`$(( ))` aritmetik işlem yapısıdır. `SAYAC=$((SAYAC + 1))` ifadesi sayacı bir artırır.

---

### 🔨 Uygulama 7 — Kapsamlı Betik

Aşağıdaki betiği `tam_rapor.sh` olarak kaydedin:

```bash
#!/bin/bash
# tam_rapor.sh — Kapsamlı sistem raporu betiği

RAPOR="$HOME/Masaustu/sistem_raporu_$(date '+%Y%m%d').txt"

# Başlık
{
    echo "======================================="
    echo "  SISTEM RAPORU"
    echo "  Tarih: $(date '+%d.%m.%Y %H:%M:%S')"
    echo "======================================="

    # Temel bilgiler
    echo ""
    echo "--- SISTEM BILGILERI ---"
    echo "Bilgisayar : $(hostname)"
    echo "Kullanici  : $(whoami)"
    echo "Cekirdek   : $(uname -r)"
    echo "Calisma S. : $(uptime -p)"

    # Bellek
    echo ""
    echo "--- BELLEK DURUMU ---"
    free -h

    # Disk
    echo ""
    echo "--- DISK KULLANIMI ---"
    df -h | grep -v tmpfs

    # Ev dizini boyutu
    echo ""
    echo "--- EV DIZINI BOYUTU ---"
    du -sh "$HOME" 2>/dev/null

    # En çok kaynak kullanan süreçler
    echo ""
    echo "--- EN COK CPU KULLANAN 5 SUREC ---"
    ps aux --sort=-%cpu | head -6

    echo ""
    echo "--- EN COK BELLEK KULLANAN 5 SUREC ---"
    ps aux --sort=-%mem | head -6

    # Ağ bilgisi
    echo ""
    echo "--- AG BILGISI ---"
    ip -4 addr show | grep inet | grep -v 127.0.0.1

    echo ""
    echo "--- ACIK PORTLAR ---"
    ss -tuln 2>/dev/null

    # Oturum açmış kullanıcılar
    echo ""
    echo "--- AKTIF KULLANICILAR ---"
    who

} > "$RAPOR"

echo "Rapor olusturuldu: $RAPOR"
echo ""
echo "Ilk 30 satir:"
head -30 "$RAPOR"
```

Burada `{ }` (küme parantezi) birden fazla komutun çıktısını gruplayıp tek bir yönlendirmeyle dosyaya yazmanızı sağlar. Her satırda ayrı ayrı `>> "$RAPOR"` yazmaktan çok daha temizdir.

`grep -v tmpfs` ifadesi, tmpfs dosya sistemlerini çıktıdan çıkarır (geçici, bellek tabanlı dosya sistemleri olduğu için disk raporunda genellikle ilgilenilmez).

---

## BÖLÜM 9 — Faydalı İleri Komutlar

### `find` — Dosya Bul

Linux'taki `find`, Windows'taki `dir /s` komutunun çok daha güçlü bir versiyonudur.

```bash
$ find /home -name "*.txt"                    # İsme göre bul
$ find /home -name "*.txt" -mtime -7          # Son 7 günde değiştirilmiş txt dosyaları
$ find /var/log -size +10M                    # 10 MB'dan büyük dosyalar
$ find . -type d -name "test"                 # "test" adlı dizinleri bul
$ find . -name "*.tmp" -delete               # .tmp dosyalarını bul ve sil
$ find . -name "*.java" -exec grep -l "main" {} \;  # main içeren java dosyaları
```

| Parametre | Anlam |
|-----------|-------|
| `-name` | Dosya adına göre ara |
| `-iname` | Büyük-küçük harf duyarsız isim |
| `-type f` | Sadece dosyalar |
| `-type d` | Sadece dizinler |
| `-size +10M` | 10 MB'dan büyük |
| `-mtime -7` | Son 7 günde değiştirilmiş |
| `-user ali` | ali kullanıcısına ait |
| `-perm 644` | İzni 644 olanlar |
| `-exec cmd {} \;` | Bulunan her dosya için komut çalıştır |

`-exec` parametresi `find`'ı son derece güçlü kılar. `{}` bulunan dosyanın yerine geçer, `\;` exec bloğunun sonunu belirtir.

---

### `tar` — Arşivleme

**tar** (Tape Archive — Bant Arşivi), birden fazla dosya ve dizini tek bir arşiv dosyasında toplar. Adı manyetik bant döneminden kalmadır.

```bash
# Arşiv oluştur ve sıkıştır (gzip)
$ tar -czvf yedek.tar.gz Projeler/

# Arşiv içeriğini listele
$ tar -tzvf yedek.tar.gz

# Arşivi aç
$ tar -xzvf yedek.tar.gz
$ tar -xzvf yedek.tar.gz -C /hedef/dizin/   # Belirli dizine aç
```

| Parametre | Anlam |
|-----------|-------|
| `-c` | Oluştur (create) |
| `-x` | Aç/çıkar (extract) |
| `-t` | İçeriği listele (list) |
| `-z` | gzip sıkıştırması |
| `-j` | bzip2 sıkıştırması |
| `-v` | Ayrıntılı çıktı (verbose) |
| `-f` | Dosya adı belirt (file) |

`.tar.gz` (veya `.tgz`) hem arşivlenmiş hem gzip ile sıkıştırılmış dosya demektir. Windows dünyasındaki `.zip` dosyasının Linux karşılığı olarak düşünebilirsiniz, ama mekanizma farklıdır: `tar` arşivler, `gzip` sıkıştırır — iki ayrı iş, iki ayrı araç, birlikte kullanılır.

---

### `which` ve `whereis` — Komut Konumu

```bash
$ which python3
/usr/bin/python3

$ whereis python3
python3: /usr/bin/python3 /usr/lib/python3 /usr/share/man/man1/python3.1.gz
```

`which` sadece çalıştırılabilir dosyanın yolunu gösterir. `whereis` ayrıca kaynak kodu ve kılavuz (man) sayfasının yerini de bulur.

Windows'taki `where` komutunun karşılığıdır.

---

### `man` — Kılavuz Sayfaları

**man** (Manual — Kılavuz), Linux'un yerleşik dokümantasyon sistemidir. Her komutun ayrıntılı bir kılavuz sayfası vardır.

```bash
$ man ls
$ man grep
$ man chmod
```

Kılavuz `less` komutuyla gösterilir, aynı tuşlarla gezinilir (`/` ile ara, `q` ile çık).

```bash
$ man -k "copy"    # "copy" ile ilgili tüm kılavuz sayfalarını ara
```

Windows'taki `komut /?` yardımının çok daha kapsamlı karşılığıdır. Bir komut hakkında her şeyi öğrenmek istiyorsanız `man` ilk durağınızdır.

---

### `alias` — Komut Kısayolu

Sık kullandığınız uzun komutlara kısa isimler verebilirsiniz:

```bash
$ alias ll='ls -la'
$ alias guncelle='sudo apt update && sudo apt upgrade -y'
$ alias rapor='ps aux --sort=-%mem | head -10'
```

Artık `ll` yazarak `ls -la` çalıştırabilirsiniz. Bu tanımlar oturum sonunda kaybolur. Kalıcı olması için `~/.bashrc` dosyasına eklenmesi gerekir:

```bash
$ echo "alias ll='ls -la'" >> ~/.bashrc
$ source ~/.bashrc    # Değişiklikleri uygula (yeniden oturum açmadan)
```

`.bashrc` dosyası her yeni terminal açıldığında otomatik çalışan betiktir — terminalin başlangıç ayarları dosyası.

---

### `history` — Komut Geçmişi

```bash
$ history            # Tüm geçmiş
$ history 20         # Son 20 komut
$ !100               # 100 numaralı komutu tekrar çalıştır
$ !!                 # Son komutu tekrar çalıştır
$ !grep              # "grep" ile başlayan son komutu çalıştır
```

`sudo !!` özellikle kullanışlıdır: bir komutu normal kullanıcı olarak çalıştırıp yetki hatası aldığınızda, `sudo !!` yazarak aynı komutu root yetkisiyle tekrar çalıştırırsınız.

**Ctrl + R** ile geçmişte arama yapabilirsiniz: basın, aramak istediğiniz kelimeyi yazın, eşleşen komut görünür. Enter ile çalıştırın.

---

## Komut Referans Tablosu — MS-DOS ve Linux Karşılaştırması

| İşlev | MS-DOS / cmd | Linux / Bash |
|-------|-------------|--------------|
| Dizin listele | `dir` | `ls` |
| Dizin değiştir | `cd` | `cd` |
| Dizin oluştur | `md` / `mkdir` | `mkdir` |
| Dizin sil | `rd` / `rmdir` | `rmdir` / `rm -r` |
| Ağaç göster | `tree` | `tree` |
| Neredeyim | `cd` (parametresiz) | `pwd` |
| Ekran temizle | `cls` | `clear` / Ctrl+L |
| Dosya içeriği | `type` | `cat` / `less` / `more` |
| Dosya kopyala | `copy` / `xcopy` | `cp` |
| Dosya taşı | `move` | `mv` |
| Dosya sil | `del` | `rm` |
| Yeniden adlandır | `ren` | `mv` |
| Metin ara | `find` / `findstr` | `grep` |
| Sırala | `sort` | `sort` |
| Ekrana yaz | `echo` | `echo` |
| Ortam değişkenleri | `set` | `env` / `export` |
| Sistem bilgisi | `systeminfo` | `uname -a` / `lsb_release -a` |
| Bilgisayar adı | `hostname` | `hostname` |
| Kullanıcı bilgisi | `whoami` | `whoami` / `id` |
| IP yapılandırması | `ipconfig` | `ip addr` / `ifconfig` |
| Bağlantı testi | `ping` | `ping` |
| Yol izleme | `tracert` | `traceroute` |
| DNS sorgusu | `nslookup` | `nslookup` / `dig` |
| Ağ bağlantıları | `netstat` | `ss` / `netstat` |
| Süreç listesi | `tasklist` | `ps` / `top` / `htop` |
| Süreç sonlandır | `taskkill` | `kill` / `killall` |
| Dosya bul | `dir /s` / `where` | `find` / `which` / `locate` |
| Yardım | `komut /?` | `man komut` / `komut --help` |
| Yorum satırı | `REM` | `#` |
| Batch/Script | `.bat` | `.sh` |
| Disk kullanımı | `wmic logicaldisk` | `df -h` |
| Kapatma | `shutdown /s` | `shutdown -h now` / `poweroff` |
| Yeniden başlat | `shutdown /r` | `shutdown -r now` / `reboot` |
| Dosya izinleri | `attrib` | `chmod` / `chown` |
| Paket kurma | (yok — .exe indirme) | `apt install` |
| Arşivleme | (yok — harici araç) | `tar` |

---

## Ek: Terminal Kısayolları

| Kısayol | İşlev |
|---------|-------|
| **Tab** | Otomatik tamamlama (dosya, dizin, komut) |
| **Ctrl + C** | Çalışan komutu durdur |
| **Ctrl + Z** | Komutu arka plana gönder (duraklat) |
| **Ctrl + D** | Oturumu kapat (exit) |
| **Ctrl + L** | Ekranı temizle (clear) |
| **Ctrl + R** | Komut geçmişinde ara |
| **Ctrl + A** | İmleci satır başına götür |
| **Ctrl + E** | İmleci satır sonuna götür |
| **Ctrl + W** | Son kelimeyi sil |
| **Ctrl + U** | İmleçten satır başına kadar sil |
| **Ctrl + K** | İmleçten satır sonuna kadar sil |
| **Yukarı/Aşağı Ok** | Önceki komutlar arasında gezin |
| **!!** | Son komutu tekrar çalıştır |
| **!$** | Son komutun son argümanı |

Bu kısayollar, terminalde çalışma hızınızı önemli ölçüde artırır. Özellikle **Tab** tuşu ve **Ctrl + R** günlük kullanımda en çok vakit kazandıran ikilidir.

---

## İlerisi için tavsiyeler

Linux terminali, MS-DOS'tan çok daha derin ve geniş bir araç setidir. İlk bakışta bunaltıcı görünebilir ama her komutu ezberlemeye çalışmak yerine "ne yapmak istiyorum" sorusundan yola çıkıp doğru aracı bulmak daha sağlıklı bir yaklaşımdır. `man` sayfaları, `--help` parametresi ve Tab tuşu her zaman yanınızdadır.

Linux felsefesi "küçük araçları birleştirerek büyük işler yap" üzerine kuruludur. Tek bir karmaşık program yerine, `grep`, `sort`, `cut`, `awk` gibi basit araçları pipe (`|`) ile birbirine bağlayarak inanılmaz esnek çözümler üretebilirsiniz. Bu düşünce biçimini benimsemek, sadece Linux'ta değil, genel olarak yazılım mühendisliğinde size avantaj sağlayacaktır.
