#!/bin/bash
# 2-TC_kimlik_kontrol betiklerinin oluşturduğu tcno.txt dosyasını satır satır okur.

dosya="tcno.txt"

if [[ -f "$dosya" ]]; then
	echo "Dosya var"

	# IFS= : satır başındaki ve sonundaki boşlukların silinmesini engeller.
	# -r   : ters eğik çizgi (\) karakterlerini kaçış karakteri olarak değil,
	#        düz karakter olarak okur. -r olmadan "a\nb" satırı "anb" olarak okunurdu.
	while IFS= read -r okunan_satir
	do
		echo "Okunan satır: $okunan_satir"
	done < "$dosya"   # < ile dosya adı arasında boşluk bırakmak isteğe bağlıdır.
else
	echo "Dosya bulunamadı"
fi

## Bash `IFS` (Internal Field Separator) Nedir?

# `IFS`, yani **Internal Field Separator** (iç alan ayırıcı), Bash kabuğunda veri
# ayrıştırmak için kullanılan özel bir değişkendir. `read` komutunun okuduğu
# satırı, değişken genişlemesi sonrasında sözcük bölmeyi (word splitting) ve
# "$*" açılımını etkiler; yani satır veya kelime bazlı veri işlemede alanların
# nasıl bölüneceğini belirler. (`awk` bu değişkeni kullanmaz; awk'ın kendi alan
# ayırıcısı FS değişkeni ve -F seçeneğidir.)

# `IFS` değişkeni birden fazla karakter içerebilir ve bu karakterler, veri
# ayrıştırma işlemi sırasında alanları ayırmak için kullanılır. Örneğin boşluk,
# sekme (tab) veya yeni satır karakterleri `IFS` değişkeninde tanımlanabilir.

## Varsayılan IFS

# Varsayılan olarak Bash'te `IFS` şu üç karakteri içerir: boşluk, sekme, yeni satır.
# IFS=$' \t\n'
