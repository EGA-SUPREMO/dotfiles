# internet statistics
alias ist='vnstat -i enxfcde56ff0106'
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
    ~d && wget -t 0 --retry-connrefused $1 -O $2
}
ddc() {
    ~d && wget -t 0 -c --retry-connrefused $1 -O $2
}

# alarm
a() {
    sleep $1 && 
}
# for file in Ludo/*; do ./cwebp -q 95 "$file" -m 6 -o "${file%.*}.webp"; done

# param str folder name
# param int quality 0-100
towebp() {
    for file in *.{png,jpg,JPG}; do
        cwebp -q $2 "$file" -m 6 -o "${file%.*}.webp"
    done
}

# param str codec recomended use av1 or libx265 if you feel nostalgic
toh265() {
    for i in *; do
        ffmpeg -n -loglevel error -i "$i" -vcodec $1 -crf 28 -b:v 0 -preset slower -tune film "cc${i}"
    done
}

ccv() {
    for i in *; do
        ffmpeg -n -loglevel error -i "$i" -vcodec libx265 -crf 28 "cc${i}"
    done
}

#for dir in ls -R; do mkdir $dir; done


# Laravel aliases
alias pl="php artisan"
alias pls="php artisan serve"
alias plt="php artisan test"
