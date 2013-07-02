# My Dotfiles

It's a terminal thing. You really want to know?

## Prerequisites

I used these to kick start

 * [Janus](https://github.com/carlhuda/janus)
   `curl -Lo- https://bit.ly/janus-bootstrap | bash`
 * [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
   `curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`
 * [tmux](http://tmux.sourceforge.net/)
   can be installed: `brew install tmux`
 * [tmuxinator](https://github.com/aziz/tmuxinator)
   `gem install tmuxinator`

## Install

 * clone the repo so the contents end up in `~/dotfiles`
 * install the submodules: `cd ~/dotfiles && git submodule update --init`
 * run the install script: `chmod +x install.sh && ./install.sh`

## Other bits

I haven't included the tmuxinator config as they are (private) project
specific. The `tmux.conf` is not very interesting and put together by
googling. My zsh theme is a modification of an existing one, but I don't
remember which.

The battery script is basically taken from
https://github.com/Goles/Battery with minor tweaks and removing spark
usage.

