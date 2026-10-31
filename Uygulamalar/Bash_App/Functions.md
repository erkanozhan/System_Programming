# Bash Fonksiyonları: Tanım, Kullanım ve Örnekler

Bash betiklerinde fonksiyonlar, belirli bir görevi yerine getiren, adlandırılmış ve tekrar kullanılabilir kod bloklarıdır. Fonksiyonlar, betiklerinizi daha düzenli, okunabilir ve yönetilebilir hale getirmenize yardımcı olur. Tekrarlayan kodları tek bir yerde tanımlayıp ihtiyaç duyduğunuzda çağırabilirsiniz.

## 1. Temel Fonksiyon Tanımı ve Çağırma

Bash'te bir fonksiyon tanımlamanın en yaygın yolu şöyledir:

```bash
function fonksiyon_adi {
    # Fonksiyon gövdesi - Çalıştırılacak komutlar burada yer alır.
}
# veya daha kısa formu:
fonksiyon_adi () {
    # Fonksiyon gövdesi
}
```

Fonksiyon, adı yazılarak çağrılır; argümanlar adın ardından boşlukla ayrılarak verilir: `fonksiyon_adi arg1 arg2`. Fonksiyonun içinde bu argümanlara `$1`, `$2`, ... ile; argüman sayısına `$#` ile; tüm argümanlara `"$@"` ile erişilir.

## 2. Örnek: Kullanıcıdan Yaş ve Ad Alıp Fonksiyona Geçirme

Kullanıcıdan `read` komutu ile girdi alıp bu girdiyi bir fonksiyona argüman olarak geçirmek yaygın bir senaryodur. `read` birden fazla değişken adıyla çağrıldığında satırı boşluklardan böler: ilk sözcüğü ilk değişkene, ikinci sözcüğü ikinci değişkene atar; **son değişkene ise satırın geri kalanının tamamını** atar. Bu nedenle boşluk içerebilecek değer (örneğin "Mehmet Ali" gibi iki sözcüklü bir ad) en sona yazılır.

```bash
#!/bin/bash
# Bu betiğin bash kabuğu ile çalıştırılacağını belirtir.

# Yaş ve ad argümanlarını alan fonksiyon
bilgi_ver(){
	echo "Yaş: $1"
	echo "Ad: $2"
	echo "Toplam $# argüman alındı"
	echo "Tüm argümanlar: $@"
}

# read, ilk sözcüğü 'yas' değişkenine, satırın geri kalanını 'ad' değişkenine atar.
# "30 Mehmet Ali" girildiğinde: yas="30", ad="Mehmet Ali"
read -p "Lütfen yaşınızı ve adınızı boşluk bırakarak girin (Örn: 30 Mehmet Ali): " yas ad

echo "--------------------"
echo "Girilen değerler (read sonrası):"
echo "Yaş değişkeni: '$yas'"
echo "Ad değişkeni: '$ad'"
echo "--------------------"

# Fonksiyonu, yaş ve ad değerlerini AYRI AYRI argüman olarak vererek çağır.
# Çift tırnaklar ("$yas", "$ad"), değişken değerinde boşluk olsa bile
# değerin tek bir argüman olarak kalmasını sağlar: "Mehmet Ali" tek argümandır.
# Tırnaksız yazılsaydı (bilgi_ver $yas $ad) fonksiyon 3 argüman alırdı.
bilgi_ver "$yas" "$ad"

echo "--------------------"
echo "Fonksiyon çağrısı tamamlandı."
```

"30 Mehmet Ali" girildiğinde çıktı şöyledir:

```text
--------------------
Girilen değerler (read sonrası):
Yaş değişkeni: '30'
Ad değişkeni: 'Mehmet Ali'
--------------------
Yaş: 30
Ad: Mehmet Ali
Toplam 2 argüman alındı
Tüm argümanlar: 30 Mehmet Ali
--------------------
Fonksiyon çağrısı tamamlandı.
```

Dönüş değerleri (`return` ve komut ikamesi), yerel değişkenler (`local`) ve özyinelemeli fonksiyonlar için [Linux terminal ders notunun 8.11 Fonksiyonlar bölümüne](../../linux-mate-terminal-ders-notu.md#811-fonksiyonlar-functions) bakılabilir.

