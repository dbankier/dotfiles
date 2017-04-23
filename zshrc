source ~/dotfiles/antigen.zsh
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
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
export PATH=/home/david/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/X11/bin:/usr/local/scala/bin::/home/david/Android/tools:/home/david/Android/platform-tools
export ANDROID_SDK="$HOME/Android"
export ANDROID_NDK="$HOME/android-ndk-r9d"
export ANDROID_PLATFORM="$ANDROID_SDK/platforms/android-23"
export GOOGLE_APIS="$ANDROID_SDK/add-ons/addon-google_apis-google-23"

# git alias
alias gst='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias glog='git log'

alias jsgrep='find . -type f | grep \.js | grep -v node_modules | grep -v bower_components | xargs grep'

export CLICOLOR=1
alias ll='ls -l'

alias :q=exit
alias :qa='tmux kill-session'
alias vim='TERM=xterm-256color vim'


remindme() { echo $* > ~/.remindme }

#xming server
export DISPLAY=:0

#vim key bindings
bindkey -v
export EDITOR='vim'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# for nvm
# source ~/.nvm/nvm.sh
export PATH="$HOME/.nvm/versions/node/v6.3.1/bin:$PATH"

# for ImageMagick
export MAGICK_HOME="$HOME/ImageMagick-6.8.6"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH=/home/david/ImageMagick-6.8.6/lib
export PATH="$HOME/.nvm/versions/node/v6.2.0/bin:$PATH"

# move/rename multiple files - http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
autoload -U zmv
alias mmv='noglob zmv -W'

# originally based on - https://bitbucket.org/hannesr/fillbucket/src/241495090d75dddfe9842ef2c60df968190dccf4/fillbucket?at=master
function kickbucket() {
  echo "Username:"
  read username

  stty_orig=`stty -g`
  stty -echo        
  echo "Password:"
  read password
  stty $stty_orig  

  echo "Repository Name:"
  read repo
  curl --user $username:$password https://api.bitbucket.org/1.0/repositories/ --data name=$repo --data is_private='true'
  git remote add origin https://$username@bitbucket.org/$username/${repo// /-}.git
  git push -u origin --all
  git push -u origin --tags
}

#//export NVM_DIR="/home/david/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
