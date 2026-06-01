#!/usr/bin/env bash
mkdir -p iPod

for file in *.mkv; do
    # Ignora os arquivos que já foram gerados dentro da pasta iPod
    [ -f "iPod/$file" ] && continue

    # Pega o nome do arquivo sem a extensão .mp4
    videoName="${file%.*}"
    
    # Define o nome esperado para a legenda correspondente (.srt)
    subtitleFile="${videoName}.srt"

    # Verifica se o arquivo de legenda realmente existe antes de rodar o FFmpeg
    if [ -f "$subtitleFile" ]; then
        echo "Processando: $file com a legenda: $subtitleFile"
        
        ffmpeg -i "$file" \
        -vf "scale=320:-2,pad=320:240:(ow-iw)/2:(oh-ih)/2,subtitles=filename='${subtitleFile}':fontsdir=/System/Library/Fonts:force_style='FontName=Helvetica,FontSize=28,PrimaryColour=&HFFFFFF&,OutlineColour=&H000000&,Outline=3,Alignment=2,MarginV=15'" \
        -c:v libx264 \
        -profile:v baseline \
        -level 1.3 \
        -x264-params "ref=1:bframes=0:weightp=0" \
        -r 30 \
        -b:v 700k \
        -maxrate 700k \
        -bufsize 1400k \
        -pix_fmt yuv420p \
        -c:a aac \
        -b:a 128k \
        -ar 44100 \
        -ac 2 \
        -movflags +faststart \
        "iPod/${videoName}_iPod.mp4"
    else
        echo "Aviso: Legenda não encontrada para $file (pulando arquivo)"
    fi
done