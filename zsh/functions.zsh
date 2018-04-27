function extract {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function zcalc     () { print $((       ans = ${1:-ans} ))   }
function zcalch    () { print $(( [#16] ans = ${1:-ans} ))   }
function zcalcd    () { print $(( [#10] ans = ${1:-ans} ))   }
function zcalco    () { print $(( [#8]  ans = ${1:-ans} ))   }
function zcalcb    () { print $(( [#2]  ans = ${1:-ans} ))   }
function zcalcasc  () { print $(( [#16] ans = ##${1:-ans} )) }

function monthjot  () { jot -w "%02d" $* }
function epoch     () { perl -e "print scalar(localtime($1)) . \"\n\"" }
function rot13     () { echo $1 | tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" }
function pingflood () { sudo ping -i 0.05 -c 100 -q $1 }
function wcat      () { wget -q -O - "$*" }

function hex       () { jot -w %0x 256 0 | tr '[:lower:]' '[:upper:]' }

function tz {
    echo -n "  Chicago: "
    TZ=America/Chicago date

    echo -n " New York: "
    TZ=America/New_York date

    echo -n "   Brazil: "
    TZ=America/Sao_Paulo date

    echo -n "      UTC: "
    TZ=Etc/UTC date

    echo -n "   London: "
    TZ=Europe/London date

    echo -n "Frankfurt: "
    TZ=Europe/Berlin date

    echo -n "Stockholm: "
    TZ=Europe/Stockholm date

    echo -n "   Zurich: "
    TZ=Europe/Zurich date

    echo -n "Singapore: "
    TZ=Asia/Singapore date

    echo -n "    Tokyo: "
    TZ=Asia/Tokyo date
}

function man {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

function cflastrun {
    awk -F '[:,]' -v time=$(date +%s) \
        'END {printf "%d minutes ago (took %d seconds)\n", (time - $1) / 60, $2 - $1}' \
        /var/cfengine/promise_summary.log
}

function sslexpire {
	openssl s_client -connect $1:443 2> /dev/null < /dev/null | openssl x509 -noout -dates
}
