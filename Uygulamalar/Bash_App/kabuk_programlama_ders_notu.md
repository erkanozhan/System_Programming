# Kabuk Programlama (Shell Programming)

Bir işletim sistemi (Operating System, OS) katmanlı bir yapıdır. En altta donanım (Hardware), onun üzerinde çekirdek (Kernel), kullanıcıya dönük tarafta ise kabuk (Shell) bulunur. Kullanıcı komutu doğrudan çekirdeğe değil, kabuğa verir; kabuk da bu isteği yorumlayıp çekirdeğin anlayacağı biçime dönüştürür. Çekirdeğe doğrudan müdahale etmeye çalışmak, bir fabrikanın ana elektrik panosuna el yordamıyla dokunmaya benzer. İş yapılır gibi görünür, ama hata payı büyüktür. Kabuk ise o fabrikanın kontrol masasındaki düzenli düğmeler ve göstergeler gibidir.

Kabuk üzerinde art arda komut çalıştırmak günlük işlerde yeterlidir. Aynı işlemleri tekrar tekrar yapmak gerektiğinde ise betik (Script, Latince *scriptum*, yazılmış metin) devreye girer. Kabuk programlama, bu betikler aracılığıyla sistem işlerini düzenli, tekrarlanabilir ve denetlenebilir hale getirme işidir.

![Kabuk, çekirdek ve donanım ilişkisi](../../images/shell-katmanlari.svg)

Kabuk sözcüğü yerindedir; çünkü çekirdeği dış etkilerden koruyan ve kullanıcıya daha güvenli bir çalışma alanı sunan katman budur. Bir terminal penceresinde gördüğünüz satır yalnızca bir yazı alanı değildir. Orası, komutların ayrıştırıldığı, dosya yollarının genişletildiği, değişkenlerin çözüldüğü, süreçlerin başlatıldığı ve sonuçların toplandığı çalışma masasıdır.

## Kabuk Neden Öğrenilir? (Why Shell?)

Kabuk bilgisi, yalnızca betik yazanlar için değil, sistemle ciddi biçimde çalışan herkes için gereklidir. Linux açılırken hizmetlerin devreye alınması, oturum ortamının hazırlanması, bakım görevlerinin zamanlanması gibi birçok işin arkasında kabuk mantığı vardır. Bir sistem yöneticisi hiç sıfırdan betik yazmasa bile, mevcut betikleri okuyabilmeli, ne yaptıklarını anlayabilmeli ve gerektiğinde düzeltebilmelidir.

Kabuk programlamanın güçlü olduğu yerler genellikle şunlardır:

| İş türü | Neden uygun? |
|---|---|
| Günlük bakım işleri | Dosya temizleme, arşivleme, yedekleme ve raporlama kısa komut zincirleriyle yapılır. |
| Log inceleme | `grep`, `awk`, `sort`, `uniq` gibi araçlar birlikte çok verimli çalışır. |
| Hızlı prototip | Büyük bir yazılıma başlamadan önce iş akışını küçük ölçekte sınamak kolaydır. |
| Sistem otomasyonu | Kurulum, servis başlatma, dosya üretme, görev planlama gibi işler betikleştirilir. |
| Araçları birleştirme | Kabuk, tek bir dev araç değil; küçük araçları birbirine bağlayan bir iskelettir. |

Burada önemli nokta şudur: Kabuk çoğu zaman tek başına bütün işi yapan yapı değildir. Daha çok, atölyedeki çeşitli tezgahlar arasında malzeme taşıyan düzenli bir üretim bandı gibi çalışır. `grep` ayıklar, `awk` biçimler, `sort` sıralar, `uniq` tekrarları sayar. Kabuk bunların sırasını kurar.

Kabuk öğrenme eşiği bakımından da elverişlidir. Kural sayısı sınırlıdır, kısa betikler çoğu zaman çabuk ayağa kalkar ve hata ayıklama adım adım yapılabilir. Bu yüzden kabuk, sistem yönetimi için temel bir çalışma aracıdır; ayrıca karmaşık bir uygulamanın ilk taslağını çıkarmak için de çok elverişlidir. Önce küçük bir maket kurulur, akış doğrulanır, darboğazlar görülür; ardından gerekiyorsa C, C++, Java veya Python gibi daha ağır araçlara geçilir.

## Hangi İşte Kabuk, Hangi İşte Başka Araç? (Choosing the Right Tool)

Kabuk her işin ilacı değildir. Doğru araç seçimi, sistem programlamada doğrudan verimlilik meselesidir.

| Kabuk için uygun olmayan işler | Neden? |
|---|---|
| Yoğun işlem gücü isteyen hesaplamalar | Yorumlanan yapı, derlenen dillere göre daha yavaştır. |
| Ondalıklı ve hassas matematik | Bash tam sayı odaklıdır; kayan noktalı işlemler için ek araç gerekir. |
| Karmaşık veri yapıları | Çok boyutlu diziler, ağaç yapıları ve sıkı tip denetimi sınırlıdır. |
| Grafik arayüz üretimi | Kabuk bu iş için tasarlanmamıştır. |
| Doğrudan donanım ve sürücü erişimi | Çekirdek düzeyi denetim gerektiğinde C benzeri araçlar daha uygundur. |
| Yoğun ağ soketi işlemleri | Uçtan uca ağ programı yazmak için daha güçlü çalışma zamanları gerekir. |
| Yoğun kütüphane bağımlılığı olan büyük projeler | Modüler mimari ve derleme zinciri daha belirgin araçlar ister. |
| Güvenlik açısından kritik kapalı sistemler | Kabuk betikleri kaynak kodu açık biçimde taşır; saklı dağıtım için uygun değildir. |

![Kabuk ve derlenen dil karşılaştırması](../../images/shell-vs-compiled.svg)

Kısa bir benzetme yerli yerine oturur. Kabuk, fabrikanın taşıma bandıdır; malzemeyi istasyonlar arasında iyi dolaştırır. Derlenen diller ise ağır sanayi tezgahlarıdır; ölçü hassaslaştığında, hız kritik hale geldiğinde ve donanıma yakın çalışmak gerektiğinde onlar devreye girer.

## Betik Dosyası Nasıl Çalışır? (Script Execution)

Bir kabuk betiği düz metin dosyasıdır. `.sh` uzantısı bir gelenektir; zorunluluk değildir. Asıl önemli olan iki şey vardır:

1. Dosyanın çalıştırılabilir izin taşıması
2. İlk satırda uygun yorumlayıcının (Interpreter, açıklayıcı) belirtilmesi

```bash
#!/usr/bin/env bash

echo "Kullanıcı: $USER"
echo "Dizin: $PWD"
```

İlk satırdaki `#!` işaretine *shebang* denir. Çekirdek dosyayı açar, bu satıra bakar ve betiği hangi programın çalıştıracağını anlar. `#!/usr/bin/env bash` kullanımı, sistemdeki `bash` yorumlayıcısını `PATH` üzerinden bulduğu için taşınabilir bir tercihtir.

```bash
chmod u+rx ilk_betik.sh
./ilk_betik.sh
```

Bir betik şu yollarla da çağrılabilir:

```bash
bash ilk_betik.sh
sh ilk_betik.sh
./ilk_betik.sh
```

`./betik.sh` en doğal kullanım biçimidir; çünkü dosyadaki shebang satırına uyar. `sh < betik.sh` biçimi ise genellikle tercih edilmez. Betiğin standart girdisini (Standard Input, stdin) kapatabileceği için `read` gibi yapılarda beklenmeyen sonuçlar doğurur.

![Betiğin çalışma akışı](../../images/bash-script-execution.svg)

Buradaki işleyişi sakin bir mutfak düzeniyle düşünebilirsiniz. Kağıtta yazan tarif betiktir. Şefin tarifin başında hangi mutfak düzenine göre çalışılacağını belirtmesi shebang satırıdır. O satır yoksa, tarifi kimin okuyup uygulayacağı belirsizleşir.

## Özel Karakterler ve Tırnaklama (Special Characters and Quoting)

Kabukta bazı karakterler, yazıldıkları hâlin ötesinde anlam taşır. Bunlara özel karakterler (Special Characters) denir. Düz metin gibi görünen bir satır, aslında bu karakterler yüzünden belirli bir kurala göre işlenir.

| Karakter | İşlevi |
|---|---|
| `#` | Yorum başlatır. Shebang satırındaki `#!` ise özel durumdur. |
| `;` | Aynı satırda komut ayırır. |
| `;;` | `case` yapısında bir seçeneği kapatır. |
| `.` | `source` ile eşdeğer yerleşik komuttur; başka bir dosyayı aynı kabuk içinde çalıştırır. |
| `*` | Dosya adı genişletmede her şeyi eşleyen joker karakterdir. |
| `?` | Tek karakter eşler. |
| `|` | Boru hattı kurar; bir komutun çıktısını diğerine aktarır. |
| `&` | Komutu arka planda başlatır. |
| `<` ve `>` | Girdi ve çıktı yönlendirmesi yapar. |
| `\` | Kaçış karakteridir; kendisinden sonraki karakterin özel anlamını bastırır. |

Örneğin:

```bash
echo "ilk"; echo "ikinci"
```

Kabuk bu satırı iki ayrı komut olarak görür. Benzer biçimde:

```bash
. ./ortam.sh
```

bu satır, `ortam.sh` dosyasını yeni bir süreç açmadan mevcut kabukta yürütür. Bir reçeteyi yan odaya göndermek yerine aynı masada açıp uygulamak gibi düşünülebilir.

Kabukta tırnaklama (Quoting), özel karakterlerin yeniden yorumlanmasını engellemek için kullanılır. Basit ama çok kritik bir kavramdır.

| Biçim | Davranış |
|---|---|
| `"..."` | Çift tırnak: değişken, komut ikamesi ve bazı kaçışlar çalışır; metin tek parça kalır. |
| `'...'` | Tek tırnak: neredeyse her şeyi olduğu gibi korur. |
| `$'...'` | Kaçış dizilerini yorumlar; `\n`, `\t`, `\x22` gibi. |
| `\` | Tek karakteri düz metne çevirir. |

Çift tırnağın asıl değeri, sözcük bölünmesini engellemesidir. Kabuk bir satırı boşluklara göre parçalarken, tırnaklar bu parçalanmayı durdurur.

```bash
liste="bir iki uc"

for oge in $liste; do
    echo "$oge"
done

for oge in "$liste"; do
    echo "$oge"
done
```

İlk döngü üç ayrı sözcük üretir. İkincisi tek öğe üretir. Dosya adlarında boşluk varsa bu fark doğrudan hataya dönüşür.

```bash
dosya_adi="hafta 6 notları.txt"
cp "$dosya_adi" arsiv/
```

Desen eşleme (Globbing) ile tırnaklamanın ilişkisi de önemlidir:

```bash
ls [Vv]*
ls '[Vv]*'
```

İlk komut, deseni genişletir. İkincisi, deseni düz metin kabul eder. Mutfakta ölçü kabını açık bırakmakla kapağını kapatmak arasındaki fark gibidir; içerik aynı görünür, ama davranış değişir.

Kaçış dizileri özellikle `echo -e` ve `$'...'` ile birlikte görünür:

```bash
echo -e "Satir 1\nSatir 2"
sekme=$'\t'
echo "kolon1${sekme}kolon2"
```

## Değişkenler, Parametreler ve Genişletme (Variables, Parameters and Expansion)

Kabukta değişkenlerin büyük bölümü metin gibi ele alınır. Bu yüzden değişkeni, üzerine etiket yapıştırılmış bir kavanoz gibi düşünmek yararlıdır. Etiket isimdir, içindeki içerik değerdir. Bash bu anlamda tip bağımsızdır; yani sayı da çoğu zaman metin gibi taşınır.

```bash
ders_adi="Sistem Programlama"
hafta=6
rapor_dosyasi="hafta_06_rapor.txt"
```

Sözdizimi (Syntax, Eski Yunanca *syntaxis*, düzen) burada katıdır: `=` işaretinin iki yanında boşluk bırakılmaz. Aksi halde kabuk, bunu atama değil komut çağrısı sayar.

```bash
dosya_adi="sonuc listesi.txt"

echo "$dosya_adi"
cp "$dosya_adi" arsiv/
```

Kabukta değişkenin adı ile değeri ayrıdır. `degisken` adın kendisi, `$degisken` ise onun değeridir. Değişkenin “çıplak” kullanılabildiği yerler sınırlıdır: atama, `export`, `unset`, `readonly` ve `(( ... ))` gibi aritmetik bağlamlar.

Kabuk betikleri komut satırından parametre de alabilir:

| İfade | Anlamı |
|---|---|
| `$0` | Betiğin adı |
| `$1`, `$2` | Birinci ve ikinci parametre |
| `$#` | Parametre sayısı |
| `$@` | Tüm parametreler |
| `$?` | Son komutun çıkış kodu |
| `$$` | Geçerli betiğin süreç kimliği |
| `$!` | Son arka plan sürecinin kimliği |

```bash
#!/usr/bin/env bash

echo "Betik: $0"
echo "Birinci argüman: $1"
echo "Toplam argüman: $#"
```

`"$@"` ile `$*` arasındaki fark da unutulmamalıdır. `"$@"`, parametreleri tek tek korur; `$*` ise onları bir araya sıkıştırma eğilimindedir. Fonksiyon ve döngü içinde `"$@"` daha güvenli seçimdir.

Ortam değişkenleri (Environment Variables), alt süreçlere de taşınan değerlerdir:

```bash
echo "$HOME"
echo "$PATH"
echo "$PWD"
echo "$BASH"
echo "$BASH_VERSION"
```

Yeni bir ortam değişkeni dışarı açmak için:

```bash
export PROJE_DIZINI="$PWD/proje"
```

Bu satırı bir apartman benzetmesiyle düşünmek yararlı olur. Normal değişken kendi dairenizde durur. `export` edildiğinde alt katlarda çalışan süreçler de o bilgiyi görür.

Alan ayırıcısı (Internal Field Separator, IFS), kabuğun sözcük bölme sırasında kullandığı özel değişkendir. Varsayılan olarak boşluk, sekme ve satır sonu üzerinden çalışır. Bu yüzden dosya satırlarını güvenli okumak istediğinizde `IFS=` ile geçici olarak boş bırakmak ve `read -r` kullanmak iyi bir alışkanlıktır.

```bash
while IFS= read -r satir; do
    echo "$satir"
done < rapor.txt
```

Buradaki `-r`, ters eğik çizgiyi olduğu gibi korur. Özellikle Windows yol adları ya da kaçış karakteri içeren satırlar okunurken fark yaratır.

Değişken üzerinde temel denetim komutları şöyledir:

```bash
readonly SABIT_YOL="/opt/uygulama"
unset gecici_deger
```

Parametre genişletme (Parameter Expansion), dışarıdan ek süreç açmadan metni dönüştürmenin en verimli yollarından biridir.

| Yapı | İşlevi |
|---|---|
| `${var}` | Değişkeni açık biçimde çağırır. |
| `${var:-varsayilan}` | Değişken boş ya da tanımsızsa varsayılanı kullanır. |
| `${var:=varsayilan}` | Boş ya da tanımsızsa varsayılanı atar. |
| `${var:?mesaj}` | Yoksa hata verip betiği durdurur. |
| `${#var}` | Uzunluğu verir. |
| `${var#desen}` / `${var##desen}` | Baştan siler. |
| `${var%desen}` / `${var%%desen}` | Sondan siler. |
| `${var/eski/yeni}` | İlk eşleşmeyi değiştirir. |
| `${var//eski/yeni}` | Tüm eşleşmeleri değiştirir. |

```bash
hedef_dizin=${1:-/var/log}
gerekli_deger=${KAYNAK_DIZIN:?KAYNAK_DIZIN tanimli olmali}

dosya="rapor.txt"
echo "${dosya%.txt}"

yol="/home/kullanici/proje/rapor.txt"
echo "${yol##*/}"
echo "${yol%/*}"
```

Bu işlemler, bir dosya adının etiketini söküp yeni etiket yapıştırmak gibidir. Dışarıdan `basename` ya da `dirname` çağırmadan kabuğun kendi belleğinde yapılır.

## Test Yapıları ve Karar Verme (Test Constructs and Branching)

Kabukta doğruluk kavramı çoğu öğrencinin ilk anda beklediğinden biraz farklıdır. Burada asıl ölçüt sayıların kendisi değil, komutun çıkış durumudur. UNIX geleneğinde `0` başarı demektir. Dolayısıyla `if`, “koşul doğru mu” diye değil, “bu komut başarıyla bitti mi” diye sorar.

En temel yapı şudur:

```bash
if komut; then
    echo "Başarılı"
else
    echo "Başarısız"
fi
```

Yani `if`, yalnızca köşeli parantez içindeki denetimleri değil, herhangi bir komutun sonucunu test edebilir:

```bash
if grep -q "ERROR" uygulama.log; then
    echo "Hata kaydi bulundu."
fi
```

Kabukta üç temel test biçimi vardır:

| Yapı | Özelliği |
|---|---|
| `[ ... ]` | Klasik test yapısıdır; `test` komutunun kısa yazımıdır. |
| `[[ ... ]]` | Bash'in genişletilmiş test yapısıdır; sözcük bölünmesi ve dosya adı genişletmesi burada daha güvenlidir. |
| `(( ... ))` | Aritmetik denetim içindir; C diline yakın davranır. |

```bash
not=72

if [ "$not" -ge 50 ]; then
    echo "Ders geçildi."
else
    echo "Ders tekrar alınacak."
fi
```

Buradaki `-ge`, *greater than or equal* ifadesinin kısaltmasıdır; “büyük veya eşit” anlamına gelir. Benzer biçimde `-gt` büyük, `-lt` küçük, `-eq` eşit denetiminde kullanılır.

`[[ ... ]]` yapısı özellikle metin karşılaştırmalarında ve desen denetiminde daha rahat çalışır:

```bash
dosya="/etc/passwd"

if [[ -e "$dosya" ]]; then
    echo "Dosya var."
fi

if [[ "$USER" == a* ]]; then
    echo "Kullanici adi a ile basliyor."
fi
```

Dosya testleri pratikte çok kullanılır:

| Operatör | Anlamı |
|---|---|
| `-e` | Varlık denetimi |
| `-f` | Normal dosya |
| `-d` | Dizin |
| `-s` | Boyutu sıfırdan büyük dosya |
| `-r` | Okunabilir |
| `-w` | Yazılabilir |
| `-x` | Çalıştırılabilir |
| `-L` | Sembolik bağ |
| `-t` | Bir terminale bağlı akış |

Örneğin:

```bash
if [[ -d "$HOME" && -w "$HOME" ]]; then
    echo "Ev dizini yazilabilir durumda."
fi
```

Buradaki `&&` ve `||`, kısa devreli mantık operatörleridir. İlki başarıdan sonra, ikincisi başarısızlıktan sonra devreye girer.

```bash
[ -d "$HOME" ] || echo "Ev dizini bulunamadi."
```

`(( ... ))` ise sayısal düşünmek gerektiğinde daha rahattır:

```bash
sayac=5

if (( sayac > 3 )); then
    echo "Sayac buyuktur."
fi
```

Burada dikkat edilmesi gereken incelik şudur: `(( ... ))` içindeki ifade sıfır dışı ise mantıksal olarak doğru kabul edilir ve çıkış durumu `0` olur. Yani aritmetik anlam ile çıkış kodu ilişkisi ters yönde görünür.

Çoklu seçim gereken yerde `case` temiz çözümdür:

```bash
read -r secim

case "$secim" in
    e|E)
        echo "Ekleme islemi"
        ;;
    s|S)
        echo "Silme islemi"
        ;;
    *)
        echo "Gecersiz secim" >&2
        ;;
esac
```

Buradaki `;;`, her dalın kapandığını gösterir. Sınıfta yoklama alırken her isimden sonra yeni satıra geçmek gibi düşünün; ayırıcı olmazsa satırlar birbirine karışır.

## Döngüler, Komut İkamesi ve Aritmetik (Loops, Command Substitution and Arithmetic)

Döngü (Loop), tekrarlanan işi düzenler. Latince *iterare* kökünden gelen yineleme (Iteration), aynı işlemi art arda yürütme fikridir.

```bash
for dosya in *.log; do
    echo "İşlenen dosya: $dosya"
done
```

Bu yapı dizindeki her `.log` dosyasını tek tek ele alır. Bahçede sıraya dizilmiş saksıları tek tek sulamak gibi düşünün; hortumu her seferinde yeniden kurmazsınız, aynı hareketi listedeki her öğe için sürdürürsünüz.

`while` döngüsü, koşul doğru kaldığı sürece çalışır:

```bash
sayac=1

while (( sayac <= 5 )); do
    echo "Tur: $sayac"
    (( sayac++ ))
done
```

Kabuk, C benzeri döngü söz dizimine de izin verir:

```bash
for (( i=0; i<5; i++ )); do
    echo "i = $i"
done
```

Komut ikamesi (Command Substitution), bir komutun standart çıktısını alıp başka bir yerde kullanma yöntemidir. Eski biçimi ters tırnak olsa da güncel ve okunaklı biçim `$( ... )` yapısıdır.

```bash
bugun=$(date +%F)
kullanici_sayisi=$(who | wc -l)
betik_adi=$(basename "$0")
```

Komut ikamesi, komutun `stdout` akışını alır. Bu nedenle iyi yazılmış UNIX araçları birbirine rahat bağlanır. Mutfakta bir aşçının hazırladığı sosun, doğrudan diğer aşçının tenceresine dökülmesi gibi düşünün.

```bash
rapor=$(grep -c "ERROR" uygulama.log)
echo "Hata sayisi: $rapor"
```

Bir dosyanın içeriğini okumak için:

```bash
icerik=$(cat rapor.txt)
```

Bash, kısa bir biçime daha izin verir:

```bash
icerik=$(<rapor.txt)
```

Bu yazım özellikle küçük ve tek dosyalı okumalar için sade bir yoldur.

Aritmetik genişletme (Arithmetic Expansion) için modern tercih `$(( ... ))` yapısıdır:

```bash
a=10
b=3

toplam=$(( a + b ))
kalan=$(( a % b ))
```

Değişken adının başına burada `$` koymak zorunlu değildir. Bash bu bağlamda isimleri sayısal değer olarak okuyabilir.

```bash
(( a++ ))
(( b += 5 ))
sonuc=$(( (a + b) * 2 ))
```

`let` komutu da aynı aileye aittir:

```bash
let "a += 2"
```

Eski `$[ ... ]` biçimi artık tercih edilmez; okunaklı ve taşınabilir olan yapı `$(( ... ))` ile `(( ... ))` ikilisidir.

Ondalıklı işlem gerektiğinde kabuğun doğal sınırına çarparız. Böyle durumlarda `bc` gibi yardımcı araçlar devreye girer:

```bash
oran=$(echo "scale=2; 22 / 7" | bc)
echo "$oran"
```

## Süreçler, Çıkış Kodu ve Arka Plan İşleri (Processes, Exit Status and Background Jobs)

Kabukta çalıştırdığınız her dış komut, sistemde bir süreç (Process, Latince *processus*, ilerleyiş) olarak yer alır. Çekirdek bu süreci izler ve iş bittiğinde kabuğa sayısal bir sonuç döndürür. Buna çıkış durumu (Exit Status) denir.

- `0` değeri, işlemin başarıyla bittiğini gösterir.
- `0` dışındaki değerler, bir soruna işaret eder.

Kuramsal olarak son komutun sonucuna `$?` ile bakılır:

```bash
mkdir arsiv
echo $?
```

Fakat pratikte komutu doğrudan `if` içinde kullanmak daha temizdir:

```bash
if mkdir arsiv; then
    echo "Dizin oluşturuldu."
else
    echo "Dizin oluşturulamadı." >&2
fi
```

Buradaki `>&2`, metni standart hata akışına gönderir. Böylece normal çıktı ile hata çıktısı birbirine karışmaz.

Kabukta bağımsız işleri arka planda başlatmak için `&` kullanılır:

```bash
gzip buyuk_1.log &
gzip buyuk_2.log &
gzip buyuk_3.log &
wait
echo "Sıkıştırma tamamlandı."
```

`wait` komutu, başlatılmış arka plan işlerinin bitmesini bekler. Bu kavramı mutfaktaki üç ayrı ocak gibi düşünebilirsiniz. Üç tencereyi art arda aynı gözde kaynatırsanız toplam süre uzar; üç uygun göz varsa ve işler birbirinden bağımsızsa süre kısalır.

```text
Seri çalışma süresi       = t1 + t2 + t3
Arka plan çalışma süresi ≈ max(t1, t2, t3)
```

Bu yaklaşık eşitliktir; çünkü işlemci, disk ve bellek aynı anda zorlanıyorsa işler birbirini yavaşlatabilir. Yine de bağımsız görevler için kabuğun sunduğu bu yöntem oldukça kullanışlıdır.

![Arka plan işleri ve wait ilişkisi](../../images/job-control.svg)

İş (Job) ile süreç kavramını karıştırmamak gerekir. `jobs`, kabuğun tuttuğu arka plan işlerini gösterir. `ps` ise sistem genelindeki süreçleri listeler. İlki sınıf içi yoklama defteri gibidir; ikincisi okulun tüm öğrenci işleri kaydı gibidir.

## Boru Hattı, Yönlendirme ve Çok Satırlı Girdi (Pipelines, Redirection and Here Documents)

Kabuk programlamanın en güçlü yönlerinden biri, küçük araçları bir boru hattı (Pipeline) içinde birleştirebilmesidir. Bu, klasik UNIX yaklaşımının özüdür: büyük işi, küçük ve iyi tanımlanmış parçalara bölmek.

```bash
grep "ERROR" uygulama.log | awk '{print $5}' | sort | uniq -c
```

Bu satırda:

1. `grep` hata satırlarını seçer.
2. `awk` gerekli alanı ayırır.
3. `sort` sıralar.
4. `uniq -c` tekrar sayısını verir.

![Boru hattı örneği](../../images/pipe-chain.svg)

Üretim bandı benzetmesi burada çok işe yarar. İlk işçi arızalı ürünleri seçer, ikinci işçi etiketine bakar, üçüncü işçi aynı olanları yan yana dizer, dördüncü işçi de kaçar tane olduğunu sayar. Tek bir işçi her şeyi yapsa daha çok yorulur; iş bölümü verim sağlar.

Veri akışının sağlıklı anlaşılması için dosya tanımlayıcı (File Descriptor, FD) kavramı da bilinmelidir. Her süreç üç temel kanal ile başlar:

| Numara | Adı | Varsayılan hedef |
|---|---|---|
| `0` | Standart girdi (Standard Input, stdin) | Klavye |
| `1` | Standart çıktı (Standard Output, stdout) | Terminal |
| `2` | Standart hata (Standard Error, stderr) | Terminal |

![Dosya tanımlayıcıları ve yönlendirme](../../images/io-redirection.svg)

![Dosya tanımlayıcıları tesisat benzetmesi](../../images/fd-plumbing-analogy.svg)

En temel yönlendirme örnekleri şöyledir:

```bash
komut > sonuc.txt
komut >> sonuc.txt
komut 2> hata.log
komut > tum_cikti.log 2>&1
komut < girdi.txt
komut &> birlikte.log
```

`2>&1` ifadesi, hata akışını standart çıktının gittiği yere bağlar. Sıra önemlidir. Önce standart çıktı dosyaya yönlendirilir, sonra hata akışı o yeni hedefe bağlanır.

`/dev/null` ise işletim sisteminin boşaltım kutusu gibidir. Gerekmediğiniz bir çıktıyı oraya gönderirsiniz; veri yazılır, ama saklanmaz.

```bash
komut > /dev/null 2>&1
```

Here document, çok satırlı girdiyi tek blok hâlinde bir komuta verme yöntemidir:

```bash
cat <<EOF
Sunucu: localhost
Port: 8080
Durum: aktif
EOF
```

Sınır belirteci olan `EOF`, keyfi bir etikettir. Yeter ki blok içinde yanlışlıkla tekrar etmesin.

Değişken genişlemesi istemiyorsanız etiketi tırnaklarsınız:

```bash
cat <<'EOF'
$HOME burada genislemez.
$(date) burada calismaz.
EOF
```

Bir here document, fonksiyona da girdi verebilir:

```bash
oku_kisi() {
    read -r ad
    read -r soyad
}

oku_kisi <<EOF
Ali
Yilmaz
EOF
```

Here string ise tek satırlık hızlı bir biçimdir:

```bash
grep "bash" <<< "bash bir kabuktur"
```

Blok yorumlamak için kullanılan pratik bir kalıp da vardır:

```bash
: <<'YORUM'
Bu bölüm geçici olarak devre dışı bırakıldı.
Birden fazla satır burada tutulabilir.
YORUM
```

## Alt Kabuk ve Kod Bloğu (Subshells and Code Blocks)

Kabukta parantez ile açılan komut grubu alt kabuk (Subshell) üretir:

```bash
deger=10

(
    deger=99
    echo "Ic kisim: $deger"
)

echo "Disarisi: $deger"
```

İçeride `99`, dışarıda `10` görülür. Çünkü parantez içi, ayrı bir çocuk süreçte çalışır. Orada yapılan değişiklikler ana kabuğa geri taşınmaz.

Bu yapı günlük hayatta mutfakta bir deneme tezgahı kurmaya benzer. Sosu ayrı kapta karıştırırsınız; beğenmezseniz ana tencere etkilenmez.

Alt kabuklar şu işlerde kullanışlıdır:

- Geçici dizin değişikliği yapmak
- Ayrı ortam değişkenleriyle deneme yürütmek
- Paralel alt görevleri arka planda çalıştırmak

```bash
(cd /var/log && ls *.log)
echo "$PWD"
```

Yukarıdaki `cd`, dışarıdaki çalışma dizinini değiştirmez.

Süslü parantez ise farklıdır:

```bash
deger=10
{ deger=99; }
echo "$deger"
```

Burada yeni bir alt kabuk açılmaz. Aynı süreç içinde çalışıldığı için değişiklik dışarıya taşar. Parantez ile süslü parantez farkı, ayrı bir laboratuvar odasında deney yapmakla aynı masada deney yapmak arasındaki fark gibidir.

## Fonksiyonlar ve Yerel Değişkenler (Functions and Local Variables)

Fonksiyon (Function), tekrarlanan işi tek bir isim altında toplar. Bash'te iki yaygın yazım vardır:

```bash
rapor_uret() {
    echo "Rapor olusturuluyor"
}
```

veya

```bash
function rapor_uret {
    echo "Rapor olusturuluyor"
}
```

Taşınabilirlik bakımından ilk yazım daha sade ve daha yaygındır.

Bir fonksiyon, Bash açısından küçük bir alt yordam gibidir. Aynı kod parçasını üç yerde kopyalamak yerine tek yere koyarsınız. Atölyede her iş için yeniden ölçü almaktansa sabit bir kalıp kullanmak gibi.

Fonksiyon parametre alabilir:

```bash
dosya_bilgisi() {
    echo "Dosya: $1"
    echo "Boyut: $(stat -c %s "$1" 2>/dev/null)"
}
```

Burada önemli nokta şudur: Bash'te fonksiyon içinde tanımlanan değişken, `local` demediğiniz sürece küresel davranabilir.

```bash
sayac=10

arttir() {
    local sayac=99
    echo "Fonksiyon ici: $sayac"
}

arttir
echo "Fonksiyon disi: $sayac"
```

![Fonksiyonlarda değişken kapsamı](../../images/bash-variable-scope.svg)

Yerel değişken (Local Variable) yalnızca o fonksiyon bloğunda görünür. Bu alışkanlık, özellikle uzun betiklerde çok önemlidir. Aksi halde fonksiyon, fark etmeden dışarıdaki değişkeni ezebilir. Sınıf listesinde karalama yaptığınızı sanırken asıl resmi yoklama kağıdını karalamış olmak gibi bir durum oluşur.

Fonksiyonun dönüşü çoğu zaman `stdout` ile yapılır; `return` ise sayısal çıkış kodu içindir.

```bash
topla() {
    echo $(( $1 + $2 ))
}

sonuc=$(topla 3 4)
echo "$sonuc"
```

## Diziler (Arrays)

Dizi (Array), aynı ad altında birden fazla öğe tutan veri yapısıdır. Bash'te diziler sıfır tabanlıdır; yani ilk öğe `0` indisindedir.

```bash
meyveler=("elma" "armut" "yesil erik")

echo "${meyveler[0]}"
echo "${meyveler[2]}"
echo "${#meyveler[@]}"
```

Burada:

- `${meyveler[0]}` ilk öğeyi verir
- `${#meyveler[@]}` öğe sayısını verir
- `"${meyveler[@]}"` tüm öğeleri tek tek koruyarak açar

```bash
for meyve in "${meyveler[@]}"; do
    echo "$meyve"
done
```

Tırnak burada yine kritik önemdedir. Özellikle öğe içinde boşluk varsa, tırnaksız kullanım dizi elemanını parçalar.

Yeni öğe eklemek mümkündür:

```bash
meyveler+=("muz")
```

Belirli öğeyi kaldırmak için:

```bash
unset 'meyveler[1]'
```

Bash dizileri düz tablolardan biraz daha esnektir; atlanmış indisler bırakılabilir. Fakat bu yapı POSIX `sh` için taşınabilir değildir. Yani diziler, Bash'e özgü rahatlıklardan biridir.

## Hata Ayıklama ve Yazım Düzeni (Debugging and Style)

Kabuk betiklerinde hata ayıklama (Debugging) çoğu zaman düşündüğünüzden daha erken başlar. Çünkü küçük bir boşluk hatası bile, ilk bakışta tuhaf görünen bir hata mesajı üretir.

Şu örneğe dikkat edin:

```bash
if [$a -gt 27 ]; then
    echo "$a"
fi
```

Buradaki sorun mantıktan çok sözdizimidir. `[` komutu ile değişken arasında boşluk bırakılmamıştır. Kabuk bunu `"[37"` gibi tek bir komut adı sanabilir. Bu yüzden Bash betiklerinde boşluk, çoğu zaman yalnız görsel düzen değil, anlamın bizzat kendisidir.

Pratik hata ayıklama araçları şunlardır:

```bash
bash -n betik.sh
bash -v betik.sh
bash -x betik.sh
```

| Komut | İşlevi |
|---|---|
| `bash -n` | Sözdizimini çalıştırmadan denetler. |
| `bash -v` | Satırları yürütmeden önce görünür kılar. |
| `bash -x` | Komutları açılmış halleriyle iz sürerek gösterir. |

Betiğin içine de ayar konabilir:

```bash
set -u
set -x
```

`set -u`, tanımsız değişken kullanımında betiği durdurur. Bu, yanlış değişken adı yazıldığında sessizce boş değerle devam etmesini önler.

İz sürmek için sade `echo` satırları hâlâ çok etkilidir:

```bash
DEBUG=1

debecho() {
    if [[ -n "$DEBUG" ]]; then
        echo "$1" >&2
    fi
}
```

Buradaki yaklaşım temizdir; çünkü iz mesajları standart hata akışına gider. Normal çıktı ile karışmaz.

Temizlik işleri için `trap` komutu önemlidir:

```bash
tmp_dosya=$(mktemp)
trap 'rm -f "$tmp_dosya"' EXIT INT TERM
```

Bu satır, betik normal bittiğinde ya da `Ctrl+C` ile kesildiğinde geçici dosyanın silinmesini sağlar. Atölyeyi terk etmeden önce masayı toplama alışkanığı gibi düşünün.

Yazım düzeni için birkaç ilke yerinde olur:

- Kısa ve tek işi yapan fonksiyonlar yazın.
- Değişkenleri anlamlı adlandırın.
- Her değişken kullanımını tırnaklamak gerektiğini varsayın.
- Uzun boru hatlarını bölerek okunur hâle getirin.
- Hata çıktısını `stderr` akışına yönlendirin.
- Betiği en başta küçük örnek veriyle deneyin.

Kabuk betiği “zekice” göründüğü için iyi sayılmaz. Bakımı kolay, yan etkisi sınırlı ve okunur olduğu ölçüde değerlidir.

## Kısa Bir Betik İncelemesi (A Small Script)

Aşağıdaki örnek, dosya denetimi, parametre kullanımı, fonksiyon, boru hattı, yönlendirme, `trap` ve çıkış kodunu aynı yerde toplar:

```bash
#!/usr/bin/env bash

log_dizini=${1:-/var/log}
rapor_dosyasi=${2:-hata_ozeti.txt}
gecici_dosya=$(mktemp)

trap 'rm -f "$gecici_dosya"' EXIT INT TERM

rapor_uret() {
    local kaynak_dizin=$1
    local hedef_dosya=$2

    grep -R "ERROR" "$kaynak_dizin" 2>/dev/null \
        | awk -F: '{print $1}' \
        | sort \
        | uniq -c \
        > "$hedef_dosya"
}

if [[ ! -d "$log_dizini" ]]; then
    echo "Dizin bulunamadi: $log_dizini" >&2
    exit 1
fi

if rapor_uret "$log_dizini" "$gecici_dosya"; then
    mv "$gecici_dosya" "$rapor_dosyasi"
    echo "Rapor uretildi: $rapor_dosyasi"
else
    echo "Rapor uretilemedi." >&2
    exit 2
fi
```

Bu betik şu işleri yapar:

- Kullanıcı dizin vermezse varsayılan olarak `/var/log` kullanır.
- Dizin gerçekten var mı diye bakar.
- Geçici dosya oluşturur.
- Betik kesilse bile geçici dosyayı temizler.
- Hata satırlarını toplar.
- Hataların hangi dosyalarda yoğunlaştığını sayar.
- Sonucu kalıcı rapor dosyasına taşır.

Bu tür betikler küçük görünür, ama sistem yönetiminde değeri buradan gelir. İnsan eliyle on dakika sürecek işi birkaç satırla her gün aynı doğrulukta yapabilirler.

## Sonuç Yerine

Kabuk programlama, donanıma en yakın araç değildir; en hızlı araç da değildir. Buna rağmen sistem programlamada yeri çok sağlamdır. Çünkü düzen kurar, tekrar eden işi standartlaştırır, küçük araçları bir araya getirir ve sistemin günlük işleyişini görünür kılar. İyi bir kabuk bilgisi, yalnızca birkaç komut ezberlemek değildir; bir işletim sisteminin nasıl konuştuğunu anlamaktır.
