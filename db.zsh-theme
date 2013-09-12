tiver() {
  curr=`tiversion`
  if [[ -n $curr ]]; then
    echo " ("$curr")"
  fi
}


PROMPT='$fg_bold[blue][ $fg[red]%t $fg_bold[blue]| $fg[red]%~ $(git_prompt_info)$fg[cyan]$(tiver)$fg_bold[blue] ]$reset_color
 $ '
# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[green]("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"
