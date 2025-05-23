#!/bin/bash

if [[ -f "deneme.txt" ]]; then
	echo "Dosya var"
	
	while IFS= read -r okudugu_sey; 
	do
	echo "Okunan Satır:$okudugu_sey"
	done < "deneme.txt"
else
echo "Dosya bulunamadı"
fi

## Bash `IFS` (Internal Field Separator) Nedir?

# `IFS`, yani **Internal Field Separator**, Bash kabuğunda veri ayrıştırmak için kullanılan **özel bir değişkendir**. 
# Genellikle `read`, `for`, `set`, ve `awk` gibi komutlarla kullanılırken satır veya kelime bazlı veri işlemede alanların nasıl bölüneceğini belirler.


# `IFS` değişkeni, birden fazla karakter içerebilir ve bu karakterler, veri ayrıştırma işlemi sırasında alanları ayırmak için kullanılır. Örneğin, boşluk, tab veya yeni satır gibi karakterler `IFS` değişkeninde tanımlanabilir.
## Varsayılan IFS

# Varsayılan olarak Bash’te `IFS` aşağıdaki karakterleri içerir:

# IFS=" \t\n"
