#!/usr/bin/env fish

for file in *.mkv
    set nomevideo (echo $file | cut -d'.' -f1)
    echo $nomevideo
    set nomelegenda (basename $file .mkv).ssa
    echo $nomelegenda
    ffmpeg -i $file -c:v h264_nvenc -vf "subtitles='$nomelegenda'" $nomevideo.mp4
end
