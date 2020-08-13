# internet statistics
alias ist='vnstat -i enxfcde56ff0106'
# onegai | Execute the previous command as sudo
alias onegai='echo sudo $(fc -ln -1) ; sudo $(fc -ln -1)'
# baka | Version control [baka pull master, baka push master]
alias baka='git'
# This may overlap with other commands in your environment
alias g='git'
# download videos in 720p, 480p, 360p and 240p if availible
# --merge-output-format, may be I need this, TODO make a command to download low quality video and high quality audio
alias d7="cd ~/Downloads && youtube-dl -f 'bestvideo[height<=720]+bestaudio[ext=m4a]/best[height<=720]' $1"
alias d4="cd ~/Downloads && youtube-dl -f 'bestvideo[height<=480]+bestaudio[ext=m4a]/best[height<=480]' $1"
alias d3="cd ~/Downloads && youtube-dl -f 'bestvideo[height<=360]+bestaudio[ext=m4a]/best[height<=360]' $1"
alias mp4d3="cd ~/Downloads && youtube-dl -f 'bestvideo[ext=mp4][height<=360]+bestaudio[ext=m4a]/best=[ext=mp4][height<=360]' $1"
alias d2="cd ~/Downloads && youtube-dl -f 'bestvideo[height<=240]+bestaudio[ext=m4a]/best[height<=240]' $1"
alias dm7="cd ~/Music && youtube-dl -f 'bestvideo[height<=720]+bestaudio[ext=m4a]/best[height<=720]' $1"
alias dm4="cd ~/Music && youtube-dl -f 'bestvideo[height<=480]+bestaudio[ext=m4a]/best[height<=480]' $1"
alias dm3="cd ~/Music && youtube-dl -f 'bestvideo[height<=360]+bestaudio[ext=m4a]/best[height<=360]' $1"
alias dm2="cd ~/Music && youtube-dl -f 'bestvideo[height<=240]+bestaudio[ext=m4a]/best[height<=240]' $1"

# Laravel aliases
alias pl="php artisan"
alias pls="php artisan serve"
alias plt="php artisan test"
