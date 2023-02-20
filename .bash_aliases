# internet statistics
alias ist='vnstat -i wlx004311005971'
# onegai | Execute the previous command as sudo
alias onegai='echo sudo $(fc -ln -1) ; sudo $(fc -ln -1)'
# baka | Version control [baka pull master, baka push master]
alias baka='git'

gbrd() {
    git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')
    do git branch -D $branch
done
}

# Utilities ololol
# Using curl for Direct Downloads because wget is too mainstream
# First param is for the link, second is the output filename
ddcurl() {
    curl --retry 9999 $1 -C - -o $2
}
# Direct Download using wget configured for shitty connections
dd() {
    ~d && wget -t 0 --no-check-certificate -c --retry-connrefused $1 -O $2
}

ddch() {
    ~d && wget -t 0 --no-check-certificate -c --retry-connrefused $1 -O $2'.crdownload'

    mv $2'.crdownload' $2
}
# wget -t 0 --no-check-certificate -c --retry-connrefused  -O 'he.mp4' --user-agent="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0"

helene() {
    DEY="${1%%.mp4*}.mp4"
    echo $DEY
    DEY="${DEY##*/}"
    echo $DEY
    #helene https://files-na-b1.nextstream.org/get/0000/e48491b1108d3918ffe3c9980d20565bc6a85660ee1fde128c0eec122e0ec0cb\?file\=AnimePahe_Mini_Yuri_-_03_720p_AtlasSubbed.mp4\&token\=AwYH6XfcPViORFmxBYUwrQ\&expires\=1605146943
#https://files-na-b1.nextstream.org/get/0000/e48491b1108d3918ffe3c9980d20565bc6a85660ee1fde128c0eec122e0ec0cb?file=AnimePahe_Mini_Yuri_-_03_720p_AtlasSubbed.mp4
#e48491b1108d3918ffe3c9980d20565bc6a85660ee1fde128c0eec122e0ec0cb?file=AnimePahe_Mini_Yuri_-_03_720p_AtlasSubbed.mp4
# ten cuidado ron los espacios de los links que no son de animepahe(https://files-na-)
#https://s4.mp4upload.com:282/d/qgxysgaoz3b4quuo2kvqqoysc5l6w4uivjbhxbbro5xkt3msaqx7kfat/jojos-bizarre-adventure_22.mp4

}

# timer
timer() {
    sleep $1 && mpv --no-audio '/home/trabajo/Music/Muziko/The Sound of Silence (Original Version from 1964).mp4'
}
rest() {
    ist
    for i in 1 2 3 4; do
        timer 20m
        echo $i
    done
    timer 1s
    rest
}

# param str file type
# param int quality 0-100

towebp() {
    setopt nullglob

    for file in *.$1; do
        if [ -f $file ]; then
            cwebp -q $2 "$file" -m 6 -o "out-${file%.*}.webp" -short
            rm "./$file"
        fi
    done
}
#code duplicated in usr local bin recursive towebp and nose que
tolosslesswebp() {
    setopt nullglob

    for file in *.png; do
        if [ -f $file ]; then
            cwebp -lossless "$file" -m 6 -o "${file%.*}.webp" -short
            rm "./$file"
        fi
    done
}
recursivewebpforusedcars() {
    setopt nullglob


    for d in ./*; do
        if [ -d "$d" ]; then
            cd "$d"
            towebp jpg 70
            cd ..
        fi
    done
}

burnsub() {
    ffmpeg -i $1 -vf "subtitles=sub.ass" -c:v libx265 output.mkv
}
# Burn subs and increase speed
burnsubwithmorespeed() {
    ffmpeg -i $1 -y -filter_complex "[0:v]setpts=0.95*PTS,subtitles=sub_output.ass[v];[0:a]atempo=1.05[a]" -map "[v]" -map "[a]" -c:v libx265 -c:a aac -b:a 128k output.mkv
}



# extract video
# param str file extension, eg mp4
# param str audio extension, eg m4a
#ffmpeg -i 1.mkv -map 0:2 -vn -acodec copy -vcodec copy 3.mkv
#ffmpeg -i 1.mkv -map 0:s:6 1.ass

byevideo() {
    for file in *.$1; do
        ffmpeg -i "$file" -vn -acodec copy -vcodec copy "${file%.*}.$2"
    done
}
# extract audio
# param str file extension, eg mp4
# param str video extension, eg m4a
byeaudio() {
    for file in *.$1; do
        ffmpeg -i "$file" -an -acodec copy -vcodec copy "${file%.*}.$2"
    done
}
liststreams() {
    ffprobe -show_entries stream=index,codec_type:stream_tags=language -of compact $1 2>&1 | { while read line; do if $(echo "$line" | grep -q -i "stream #"); then echo "$line"; fi; done; while read -d $'\x0D' line; do if $(echo "$line" | grep -q "time="); then echo "$line" | awk '{ printf "%s\r", $8 }'; fi; done; }

}
# mixes video with audio, both files needs the same name except for video needs v at the end and a for audio
# param str file name, eg 'Love Live OP'
# param str file extension for video, eg webm
# param str file extension for audio, eg m4a
# param str file extension for output viedo, eg mkv
# outputs file with same filename + o + . + third parm
mixvideo() {
    ffmpeg -i "${1%.*}.f$2" -i "${1%.*}.f$3" -acodec copy -vcodec copy "${1%.*}.$4"
}
mixvideos() {
    for file in *; do
        FILENAME="${file%.*}"
        ffmpeg -i "${FILENAME%.*}.f$1" -i "${FILENAME%.*}.f$2" -acodec copy -n -vcodec copy "${FILENAME%.*}.$3"
    done
}
mix-youtube-dl-videos() {
    for file in *; do
        FILENAME="${file%.*}"
        find . -name -type f "${FILENAME%.*}*"
        ffmpeg -i "${FILENAME%.*}" -i "${FILENAME%.*}" -acodec copy -n -vcodec copy "${FILENAME%.*}.$3"
        mv "${FILENAME%.*}" "n/${FILENAME%.*}"
        mv "${FILENAME%.*}" "n/${FILENAME%.*}"
    done
}
mv-youtube-dl-videos() {
    for file in *; do
        FILENAME="${file%.*}"
        mv "${FILENAME%.*}.f134.$1" "n/${FILENAME%.*}.f134.$1"
        mv "${FILENAME%.*}.f251.$2" "n/${FILENAME%.*}.f251.$2"
    done
}
mixsubtitle() {
    for file in *.mkv; do
        ffmpeg -i "$file" -f srt -i "${file%.*}.en-US.vtt" \
        -map 0:0 -map 0:1 -map 1:0 -c:v copy -c:a copy \
        -metadata:s:s:0 language=eng \
        -c:s srt output/"$file"
    done
}
mixsubtitles() {
    for file in *.mkv; do
        ffmpeg -i "$file" -f srt -i "${file%.*}.en.vtt" -i "${file%.*}.es-auto.vtt" \
        -map 0:0 -map 0:1 -map 1:0 -map 2:0 -c:v copy -c:a copy \
        -metadata:s:s:0 language=eng -metadata:s:s:1 language='spa-auto' \
        -c:s srt -c:s srt output/"$file"
    done
}

fixvideos() {
    for file in *; do
        ffmpeg -i "$file" -c copy -bsf:a aac_adtstoasc "../$file"
    done
}

chvideocontainer() {
    for file in *.$1; do
        ffmpeg -i "$file" -acodec copy -vcodec copy "${file%.*}.$2"
    done
}

# param str codec recomended use av1 or libx265 if you feel nostalgic
toh265() {
    for i in *; do
        ffmpeg -n -loglevel error -i "$i" -vcodec $1 -crf 28 -b:v 0 -preset slower -tune film "cc${i}"
    done
}

# cut video
# ffmpeg -i inp.mkv -ss 00:00:05 -to 00:02:18 -c copy outputo1.mkv

# reduce resolution
# ffmpeg -y -i "output1.mkv" -s 720x480 -c:a copy "outputsmol1.mkv" 

# crop resolution
# ffmpeg -i "inputo.mkv" -filter:v "crop=out_w:out_h:x:y" out1.mkv

# burn subs
# ffmpeg -y -i "outputfin.mp4" -vf "subtitles='sub.ass'" -c:v libx264 "outputsub.mp4"

# Concatenate files end genterete e prewiew
# ffmpeg -f concat -safe 0 -i list -c copy outputf2.mkv
# ffmpeg -i outputf2.mkv -vn -acodec copy -vcodec copy outputf2e.mkv

ccv() {
    for i in *; do
        ffmpeg -n -loglevel error -i "$i" -vcodec libx265 -crf 28 "cc${i}"
    done
}

#for dir in ls -R; do mkdir $dir; done

croptocircle() {
    full=$1
    half=$(( full/2 ))
    convert -size "$1"x"$1" xc:Black -fill White -draw "circle $half $half $half 1" -alpha Copy mask.png

    for f in $(ls *.jpg)
    do
      convert $f -gravity Center mask.png -compose CopyOpacity -composite -trim ${f}_output.png
    done
}

# extrect every four seconds e freme es png

# ffmpeg -i lol.mp4 -r 0.25 output_%04d.png

backup() {
    for file in /media/trabajo/back/*; do
        cp $file /media/trabajo/Trensporte/
    done
}

# Laravel aliases
alias pl="php artisan"
alias pls="php artisan serve"
alias plt="php artisan test"
