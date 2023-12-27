#!/usr/bin/env fish
echo "Digite o numero da legenda "
read varLegenda

echo "Voce digitou : "

for file in *.mkv
    set name(echo $file | cut -d'.' -f1)
    echo $name
    ffmpeg -i $file -map 0:$varLegenda (basename $file .mkv).ssa
end
