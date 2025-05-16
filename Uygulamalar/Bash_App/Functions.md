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

````

# Örnek: Kullanıcıdan Ad/Yaş Alıp Fonksiyona Geçirme
Kullanıcıdan read komutu ile girdi alıp bu girdiyi bir fonksiyona argüman olarak geçirmek yaygın bir senaryodur. read komutunun varsayılan olarak girdiyi boşluklara göre ayırarak birden fazla değişkene atadığını unutmamak önemlidir.

``` bash
#!/bin/bash
# Bu betiğin bash kabuğu ile çalıştırılacağını belirtir.

# Ad ve yaş argümanlarını alan fonksiyon (Örnek 2'deki gibi)
bilgi_ver(){
	echo "Ad: $1"
	echo "Yaş: $2"
	echo "Toplam $# argüman alındı"
	echo "Tüm argümanlar: $@"
}

# Kullanıcıdan girdiyi alırken read komutunu boşlukla ayrılmış değişkenler için kullan.
# read komutu, kullanıcıdan alınan satırı boşluklara göre ayırarak 'ad' ve 'yas' değişkenlerine atar.
read -p "Lütfen adınızı ve yaşınızı boşluk bırakarak girin (Örn: Ali 30): " ad yas

echo "--------------------"
echo "Girilen değerler (read sonrası):"
echo "Ad değişkeni: '$ad'"
echo "Yaş değişkeni: '$yas'"
echo "--------------------"

# Fonksiyonu, alınan ad ve yaş değişkenlerinin değerlerini AYRI AYRI argüman olarak çağır.
# Çift tırnaklar ("$ad", "$yas"), değişken değerlerinde boşluk olsa bile
# bunların tek bir argüman olarak kalmasını sağlar (örneğin, "Mehmet Ali" adı).
bilgi_ver "$ad" "$yas"

echo "--------------------"
echo "Fonksiyon çağrısı tamamlandı."

