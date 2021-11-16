source ~/dotfiles/antigen.zsh
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle zsh-users/zsh-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

#History
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Customize to your needs...
export PATH=/Users/david/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/X11/bin:/usr/local/scala/bin::/Users/david/Android/tools:/Users/david/Android/platform-tools
export ANDROID_SDK="$HOME/Android"
export ANDROID_HOME="$HOME/Android"
export ANDROID_NDK="$HOME/android-ndk-r15c"
export ANDROID_PLATFORM="$ANDROID_SDK/platforms/android-23"
export GOOGLE_APIS="$ANDROID_SDK/add-ons/addon-google_apis-google-23"

# git alias
alias gst='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias glog='git log'
alias gac='git add . && git commit -m'

alias jsgrep='find . -type f | grep \.js | grep -v node_modules | grep -v bower_components | xargs grep'

alias tx="tmuxinator"

export CLICOLOR=1
alias ll='ls -l'
alias lc='colorls -A --sd'

alias vim='nvim'

#mongo
alias mongo-start='ulimit -n 1024 && mongod --config /usr/local/etc/mongod.conf &'

alias :q=exit
alias :qa='tmux kill-session'

alias tm=tmuxinator

remindme() { echo $* > ~/.remindme }

#vim key bindings
bindkey -v
export EDITOR='vim'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR=~/.nvm
# for nvm
function _install_nvm() {
  unset -f nvm npm node
  # Set up "nvm" could use "--no-use" to defer setup, but we are here to use it
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This sets up nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # nvm bash_completion
  "$@"
}

function nvm() {
    _install_nvm nvm "$@"
}

function npm() {
    _install_nvm npm "$@"
}

function node() {
    _install_nvm node "$@"
}

# for ImageMagick
export MAGICK_HOME="$HOME/ImageMagick-6.8.6"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH=/Users/david/ImageMagick-6.8.6/lib
export PATH="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support:$PATH"

# move/rename multiple files - http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
autoload -U zmv
alias mmv='noglob zmv -W'

# for fish-like history up search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export FZF_DEFAULT_COMMAND='ag -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

