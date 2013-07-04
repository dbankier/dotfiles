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
export PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin:/Users/dbankier/bin:/usr/local/scala/bin/:/usr/local/grails/bin:/Users/dbankier/android-sdk-mac_86/tools/:/Users/dbankier/android-sdk-mac_86/platform-tools/

alias minify='find . | grep ".js" | grep -v ".lib" | grep -v ".json" | xargs -I{} java -jar ~/Javascript/yuicompressor-2.4.2/build/yuicompressor-2.4.2.jar --preserve-semi -o {} {}'
alias git-update='for i in `git branch | sed 's/^.//'`; do git checkout $i ; git pull origin $i; done'
alias jsgrep='find . | grep \.js | xargs grep'
alias scgrep='find . | grep \.scala | xargs grep'

export CLICOLOR=1
alias ll='ls -l'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'

alias ftp-start='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias ftp-stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

alias :q=exit

#vim key bindings
bindkey -v
export EDITOR='vim'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
