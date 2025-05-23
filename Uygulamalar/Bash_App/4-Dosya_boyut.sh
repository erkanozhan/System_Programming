#!/usr/bin/bash
for file in *; do
    size=$(stat -c %s "$file")

    echo "Dosya: $file, Boyut: $size byte"
    done
   