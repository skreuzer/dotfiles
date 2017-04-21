autoload -U colors && colors

source $HOME/.zsh/alias.zsh
source $HOME/.zsh/functions.zsh
for extra in private appid;
do
    test -f $HOME/.zsh/$extra.zsh && source $HOME/.zsh/$extra.zsh
done

export HISTFILE=~/.history
export HISTSIZE=1000
export SAVEHIST=1000

setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space

setopt SHARE_HISTORY
setopt APPEND_HISTORY

setopt autocd extendedglob nomatch
unsetopt beep notify

export HOSTNAME=`hostname -s`
export CLICOLOR=1

# vi editing
bindkey -v

if [ x$WINDOW != x ]; then
    export PS1="%m[$WINDOW]:%~%# "
fi

export VISUAL=vim
export EDITOR=$VISUAL
export SVN_EDITOR=$VISUAL

export CLICOLOR=1

setopt AUTO_LIST
setopt NUMERIC_GLOB_SORT
setopt PRINT_EXIT_VALUE
export LANG=en_US.UTF-8

setopt prompt_subst

PROMPT=$'%{$reset_color%}%B%{$fg[green]%}%n%b@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%}\n%{$fg[yellow]%}$ %{$reset_color%}'

if [ -f /etc/debian_version ]; then
    export DISTRO="Debian"
    export DISTRO_VERSION=$(< /etc/debian_version)
    export DISTRO_VERSION_MAJOR=$(/usr/bin/cut -d\. -f 1 < /etc/debian_version)
fi

case $DISTRO in
    Debian)
        case $DISTRO_VERSION_MAJOR in
            7)
                alias fmake=freebsd-make
                ;;
        esac
esac

case $TERM in
    xterm*)
        precmd () { print -Pn "\e]0;%m:%~\a" }
        ;;
    screen*)
        printf %bk%s%b%b \\033 "${HOSTNAME}" \\033 \\0134
        ;;
esac

case `uname` in
    FreeBSD)
        export PATH=/usr/local/bin:/usr/local/sbin:$PATH
        case `uname -p` in
            amd64)
                if [ -f "$HOME/lib/stderred.so" ]; then
                    export LD_PRELOAD="$HOME/lib/stderred.so"
                fi
                ;;
            armv6)
                ;;
        esac

        export LSCOLORS=ExBxgxdxCxegedabagacad
        alias ls='/bin/ls -G'
        alias poudriere='sudo poudriere'
        alias arch="sysctl hw | egrep -i 'machine|model|ncpu|physmem'"
        alias top='top -aSHz'

        if [ -x /usr/local/bin/colordiff ]; then
            alias diff=/usr/local/bin/colordiff
            function cvsdiff () { cvs diff $@ | colordiff | less -R; }
            function svndiff () { svn diff $@ | colordiff | less -R; }
        fi
        ;;

    Darwin)
        export PATH=/usr/local/bin:/usr/local/sbin:$PATH
        ;;
    Linux)
        export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/cfengine/bin
        ;;
esac

export PATH=$(echo -n $HOME/bin:$PATH | awk -v RS=: -v ORS=: '!arr[$0]++')
