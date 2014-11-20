ulimit -u 1024
ulimit -n 1024
#source ~/.fresh/build/shell.sh

# Environment ----------------------------------------------
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

export EDITOR=vim
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'
export LESS='-RJ'

# zsh options ----------------------------------------------
#source /usr/local/opt/zshdb/share/zshdb/dbg-trace.sh

autoload -U add-zsh-hook

unalias run-help
autoload -U run-help
HELPDIR=$HELPDIR:/usr/local/share/zsh/help

# zsh modules
zmodload zsh/regex
zmodload zsh/pcre
zmodload zsh/complist

# zsh options
setopt AUTO_PUSHD
setopt complete_in_word
setopt path_dirs
setopt nobeep
setopt nohup
setopt listtypes

export DISABLE_AUTO_UPDATE=true

export ZSH_TMUX_AUTOCONNECT=false
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false

if [[ -z "$SSH_TTY" ]]; then
  export SSH_ENVIRONMENT="${HOME}/.ssh/.environment"
  if [[ -f ${SSH_ENVIRONMENT} ]]; then
    eval `cat ${SSH_ENVIRONMENT}`
    `env | grep SSH >! /Users/jwilkins/.ssh/zshdebug`
    export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
    export SSH_AGENT_PID=$SSH_AGENT_PID
    # if agent process is running and socket is present use existing auth session
    if [[ -n $SSH_AGENT_PID ]] && [[ 0 -lt $SSH_AGENT_PID ]] && 
       [[ ! `ps p $SSH_AGENT_PID > /dev/null` ]]; then
    else
      export SSH_ASKPASS=/usr/libexec/ssh-askpass
      export SSH_AUTH_SOCK="${HOME}/.ssh/.auth_socket"
      if [[ -S "$SSH_AUTH_SOCK" ]]; then
        rm  "$SSH_AUTH_SOCK"
      fi;
      ssh-agent -a $SSH_AUTH_SOCK -s | grep -v 'echo Agent' >! $SSH_ENVIRONMENT
      echo $SSH_AGENT_PID >! "$HOME/.ssh/.auth_pid"
      ssh-add ~/.ssh/satoshi_blockstream
    fi
  fi
fi


# Antigen --------------------------------------------------
export ANTIGEN="$HOME/.antigen/"

if [[ ! -d $ANTIGEN ]]; then
  git clone https://github.com/zsh-users/antigen.git $ANTIGEN
fi


source $ANTIGEN/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/fizsh
antigen bundle zsh-users/zaw
antigen bundle colored-man
antigen bundle fasd
antigen bundle tmux
#antigen bundle chruby
#antigen bundle ssh-agent

#antigen bundle pyenv
#
#antigen bundle bendemaree/zsh-vibrantink
#antigen bundle hchbaw/auto-fu.zsh
antigen bundle jimeh/tmuxifier
antigen bundle jimhester/per-directory-history
antigen bundle nojhan/liquidprompt
antigen bundle bling/vim-airline

# OS specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
  antigen bundle brew
  antigen bundle brew-cask
  antigen bundle osx
elif [[ $CURRENT_OS == 'Linux' ]]; then
  # None so far...
  if [[ $DISTRO == 'Centos' ]]; then
    antigen bundle centos
  elif [[ $DISTRO == 'Ubuntu' ]]; then
    antigen bundle ubuntu
  fi
fi

# syntax highlighting
# Use zcompiled version instead
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

#antigen bundle last-working-dir # gives errors on cd
##  Lokaltog/powerline powerline/bindings/zsh
##antigen-theme Lokaltog/powerline powerline
##antigen-theme bling/vim-airline
##antigen-theme jeremyFreeAgent/oh-my-zsh-powerline-theme powerline

if [[ $CURRENT_OS == 'OS X' ]]; then
  export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home'
fi

# colorization -------
# ccze and grc colorize unix tools output
if $(which grc &>/dev/null); then
  export COLORIZER=`which grc`
  if [[ "$TERM" != "dumb" ]] && [[ -n $COLORIZER ]]; then
    alias colourify="$COLORIZER -es --colour=auto" # for grc
    #function colourify { `$@` | $COLORIZER -A }
    #alias colourify="$COLORIZER -A " # for ccze
    alias colourify=colourify
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
  fi
fi
# OSX/Homebrew
if [[ $(uname) == Darwin ]] && which brew > /dev/null; then
  # use homebrew coreutils instead of osx ones
  export PATH="`brew --prefix`/opt/coreutils/libexec/gnubin:${PATH}"
  export MANPATH="`brew --prefix`/opt/coreutils/libexec/gnuman:${MANPATH}"
  export PKG_CONFIG_PATH=/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG_PATH
  #alias ls="/Users/jwilkins/bin/ls -aCh --color=always -G --time-style='+%Y%m%d %H:%M:%S'"
  #export DOCKER_HOST=tcp://192.168.11.180:4243
  #export MAGIC=/usr/local/Cellar/libmagic/5.18/share/misc/magic.mgc
  # The next line updates PATH for the Google Cloud SDK.
  source /Users/jwilkins/forest/google-cloud-sdk/path.zsh.inc

  # # The next line enables bash completion for gcloud.
  source /Users/jwilkins/forest/google-cloud-sdk/completion.zsh.inc

fi

[[ -f $HOME/.secrets ]] && source $HOME/.secrets
[[ -f $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

alias git=hub
alias l='ls -alh'
alias v='vim -p '

## use oh my zsh plugins instead
## virtualenv/virtualenvwrapper ---------
##export WORKON_HOME="$HOME/.pyvenv"
##source /usr/local/bin/virtualenvwrapper.sh

if [[ -z `which direnv > /dev/null` ]]; then 
  mkdir -p ~/bin
  (cd ~/bin;
  wget http://gobuild3.qiniudn.com/github.com/zimbatm/direnv/branch-v-master/direnv-linux-amd64.tar.gz;
  tar zxf direnv-linux-amd64.tar.gz  )
fi
eval "$(direnv hook zsh)"; 


function mcd(){ mkdir -p $1 && cd $1 }

bindkey -v
bindkey "^L" redisplay
bindkey "^R" history-incremental-search-backward
bindkey "^N" vi-down-line-or-history

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

bindkey "^B" backward-word
bindkey "^W" forward-word

# color ls, auto pagination if page is longer than screen
if [[ -x /usr/local/bin/gls ]]; then
ll() {
  /usr/local/bin/gls -aCh --color=always $* -- | less -JREX
}
fi

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/opt/bro/bin"
export KEYTIMEOUT=1

unsetopt IGNORE_EOF

# zle-line-init () {auto-fu-init;}; zle -N zle-line-init

#source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-hchbaw-SLASH-auto-fu.zsh.git/auto-fu.zsh
#{ . ~/.zsh_autofu/auto-fu; auto-fu-install; }
#zstyle ':auto-fu:highlight' input bold
#zstyle ':auto-fu:highlight' completion fg=black,bold
#zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
#zstyle ':auto-fu:var' postdisplay $'\nautofu:'
#zstyle ':auto-fu:var' track-keymap-skip opp
#zle-line-init () {auto-fu-init;}; zle -N zle-line-init
#zle -N zle-keymap-select auto-fu-zle-keymap-select

set_terminal_tab_title() { print -Pn "\e]1;$1:q\a" }
indicate_tmux_session_in_terminal() {
  set_terminal_tab_title "$(tmux display-message -p '#S:#I:#P')"
}
precmd_functions=($precmd_functions indicate_tmux_session_in_terminal)

#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

#source /Users/jwilkins/.nix-profile/etc/profile.d/nix.sh
export VS_HOME=$HOME/vs    # or other directory
. $HOME/.vs/bootstrap.sh
