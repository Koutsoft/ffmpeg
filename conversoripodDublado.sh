#!/usr/bin/env bash
mkdir -p iPod
for file in *.mp4; do 
    # Cleaner way to strip the extension, avoiding any dot issues
    videoName="${file%.*}"

    ffmpeg -i "$file" \
    -c:v libx264 \
    -vf "scale=320:240:force_original_aspect_ratio=decrease,pad=320:240:(ow-iw)/2:(oh-ih)/2" \
    -profile:v baseline \
    -level 1.3 \
    -x264-params "ref=1:bframes=0:weightp=0:cabac=0:subme=1:me=dia" \
    -r 30 \
    -b:v 400k \
    -maxrate 600k \
    -bufsize 600k \
    -pix_fmt yuv420p \
    -c:a aac \
    -b:a 128k \
    -ar 44100 \
    -ac 2 \
    -movflags +faststart \
    "iPod/${videoName}.mp4"
done
