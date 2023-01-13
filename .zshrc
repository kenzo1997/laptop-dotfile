# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# aliases
alias l='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alh'

alias ld='ls -d */'
alias lld='ll -d */'

alias lf='ls -p | grep -v /'
alias llf='ll -p | grep -v /'

alias vim='nvim'
alias mkdir='mkdir -pv'
alias postgres='sudo -i -u postgres psql'
alias dot='cd ~/.config'
alias projects='cd ~/Documents/projects'
alias cls='clear'
alias jupiter='sudo docker run -p 8888:8888 jupyter/scipy-notebook:9e63909e0317'
alias jupiterTenser='sudo docker run -it -p 8888:8888 -p 6006:6006  jupyter/tensorflow-notebook'
alias untar='tar -xvzf'

source ~/.nvm/nvm.sh
nvm use 14.18.0
cat ~/.cache/wal/sequences
clear

