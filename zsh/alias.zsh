alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'
alias ipsort="sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4"
alias sl='ls'
alias pi='echo "scale=39;4*a(1)" | bc -l'
alias dotfiles='cd $(dirname $(readlink ~/.vimrc))'
alias 1gigfile='dd if=/dev/random of=1gigfile bs=$(( 1024 * 1024 )) count=1000'
alias ccat='pygmentize'
