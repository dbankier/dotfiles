# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="db"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/X11/bin:/Users/david/bin:/usr/local/scala/bin:/usr/local/grails/bin:/Users/david/android-sdk-mac_86/tools:/Users/david/android-sdk-mac_86/platform-tools

alias minify='find . | grep ".js" | grep -v ".lib" | grep -v ".json" | xargs -I{} java -jar ~/Javascript/yuicompressor-2.4.2/build/yuicompressor-2.4.2.jar --preserve-semi -o {} {}'
alias jsgrep='find . -type f | grep \.js | xargs grep'
alias scgrep='find . -type f | grep \.scala | xargs grep'

export CLICOLOR=1
alias ll='ls -l'

#ftp
alias ftp-start='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias ftp-stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

#pg
alias pg-start='pg_ctl -D ~/Library/Application\ Support/Postgres/var -l server.log start'
alias pg-stop='pg_ctl -D ~/Library/Application\ Support/Postgres/var stop -s -m fast'

alias :q=exit
alias :qa='tmux kill-session'

alias doc2md='textutil -convert html file.doc -stdout | pandoc -f html -t markdown -o file.md'

# Java versions switcher (OSX)
alias java_ls='/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d_\d\d" | cut -d , -f 1 | colrm 1 4 | grep -v Home'

function java_use() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
  export PATH=$JAVA_HOME/bin:$PATH
  java -version
}

java_use 1.6


#vim key bindings
bindkey -v
export EDITOR='vim'

# for pipe2eval vim plugin
export PIP2EVAL_TMP_FILE_PATH=/tmp/shms

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# for nvm
source ~/.nvm/nvm.sh

# for ImageMagick
export MAGICK_HOME="$HOME/ImageMagick-6.8.6"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH=/Users/david/ImageMagick-6.8.6/lib

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
