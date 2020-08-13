# internet statistics
alias ist='vnstat -i enxfcde56ff0106'
# onegai | Execute the previous command as sudo
alias onegai='echo sudo $(fc -ln -1) ; sudo $(fc -ln -1)'
# baka | Version control [baka pull master, baka push master]
alias baka='git'

alias d10="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]'"
alias d7="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"
alias d4="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"
alias d3="~d && youtube-dl -R 'infinite' -f '18/bestvideo[height<=360]+bestaudio/best[height<=360]'"
alias d2="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=240]+bestaudio/best[height<=240]'"
alias d1="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=144]+bestaudio/best[height<=144]'"
alias mp4d3="~d && youtube-dl -R 'infinite' -f '18/bestvideo[ext=mp4][height<=360]+worstaudio[ext=m4a]/best=[ext=mp4][height<=360]'"
alias mp4d2="~d && youtube-dl -R 'infinite' -f 'bestvideo[ext=mp4][height<=240]+worstaudio[ext=m4a]/best=[ext=mp4][height<=240]'"
alias mp4d1="~d && youtube-dl -R 'infinite' -f 'bestvideo[ext=mp4][height<=144]+worstaudio[ext=m4a]/best=[ext=mp4][height<=144]'"

alias dv7="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"
alias dv4="~d && youtube-dl -R 'infinite' -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"

# Laravel aliases
alias pl="php artisan"
alias pls="php artisan serve"
alias plt="php artisan test"
