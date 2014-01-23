#source ~/.fresh/build/shell.sh

# Antigen --------------------------------------------------
export ANTIGEN="$HOME/.antigen/"
[[ ! -d $ANTIGEN ]] && \
   git clone https://github.com/zsh-users/antigen.git $ANTIGEN

source $ANTIGEN/antigen.zsh
antigen use oh-my-zsh
#antigen bundle jimeh/tmuxifier
#antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle jimhester/per-directory-history
#antigen bundle colored-man
#antigen bundle last-working-dir
#antigen bundle tmux
##  nojhan/liquidprompt
#  #bling/vim-airline
##  Lokaltog/powerline powerline/bindings/zsh
##antigen-theme Lokaltog/powerline powerline
##antigen-theme bling/vim-airline
##antigen-theme jeremyFreeAgent/oh-my-zsh-powerline-theme powerline
antigen apply

source $HOME/.liquidprompt/liquidprompt

# zsh options ----------------------------------------------

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# zsh options
setopt AUTO_PUSHD
setopt complete_in_word
setopt path_dirs

# zsh modules
zmodload zsh/regex
zmodload zsh/pcre

# Environment ----------------------------------------------
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# use homebrew coreutils instead of osx ones
export PATH="`brew --prefix`/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="`brew --prefix`/opt/coreutils/libexec/gnuman:$MANPATH"

source $HOME/.secrets

# pyenv ------------------------------------------------------
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# virtualenv/virtualenvwrapper ---------
#export WORKON_HOME="$HOME/.pyvenv"
#source /usr/local/bin/virtualenvwrapper.sh

# chruby -------------------------------
#source /usr/local/opt/chruby/share/chruby/chruby.sh
#source /usr/local/opt/chruby/share/chruby/auto.sh
#chruby 2

#[[ -x tmuxifer ]] && eval "$(tmuxifier init -)"
# rbenv ---------------------------------
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

alias t='tmux -2'
alias tl='tmux ls'
alias ta='tmux a -t '
alias l='ls -alh'
alias v='vim -p '

