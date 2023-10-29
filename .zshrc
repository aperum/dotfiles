# ---[ System settings ]------------------------------------------------
#limit -s coredumpsize 0
#umask 0027

LOCAL_PATH=${HOME}/.zsh.local
CUSTOM_PATH=${HOME}/.zsh.custom

# source ${CUSTOM_PATH}/prompt.zsh

# ---[ ZSH Options ]----------------------------------------------------
ZHAVE_COLORS=0
autoload -U colors zsh/terminfo && colors && ZHAVE_COLORS=1

# Job Control
setopt   CHECK_JOBS NO_HUP AUTO_CONTINUE

# History
setopt  EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt  HIST_EXPIRE_DUPS_FIRST
#setopt  SHARE_HISTORY
setopt  HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS

setopt COMBINING_CHARS

# Unbind flow control and use push-line instead
unsetopt FLOW_CONTROL

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh/.zsh_history
DIRSTACKSIZE=20

# Stay compatible to sh and IFS
setopt  SH_WORD_SPLIT

# Allow comments on command line
setopt INTERACTIVE_COMMENTS

# Enable zmv
autoload zmv

# Prompt
#export PS1=$'%{\e[1;36m%}(%{\e[1;37m%}%n%{\e[36m%}@%{\e[1;37m%}%m%{\e[36m%}) %{\e[0m%}%/%{\e[1;36m%}>%{\e[1;37m%} '

# ---[ Environment ]---------------------------------------------------
#export LANG=de_DE.UTF-8
#export LC_CTYPE=en_US.UTF-8
#export LC_ALL=
#export LC_MESSAGES=en_US.UTF-8
#export LC_COLLATE=C   # No UTF8 collate in FBSD <11
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"

if [ -f /usr/local/bin/nvim ]; then
    export EDITOR=nvim
elif [ -f /usr/local/bin/vim ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# No core dumps littering our space
ulimit -c 0

# Do not overwrite the SSH_AUTH_SOCK in sudo sessions
#if [[ "${USER}" != "root" ]]; then
#    export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
#fi

# BSD ls colors
export LSCOLORS=ExGxCxDxCxEgEdAbAgAcAd

# ---[ GO Section ]----------------------------------------------------
export GOPATH=$HOME/go

# ---[ ENV Section ]---------------------------------------------------
export EDITOR="nvim"

# ---[ Pager section ]-------------------------------------------------

# ---[ Alias Section ]-------------------------------------------------
alias cat="bat"
alias cd..='cd ..'
alias confcat='egrep -v "#|^$"'
alias cp='nocorrect cp'       # no spelling correction on cp
alias grep='grep --color=auto'
alias less='less -R'
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias mv='nocorrect mv'       # no spelling correction on mv
alias ncgrep="grep -Ev '^#|^$'"
alias ssh='TERM=xterm-256color ssh'
alias nscp='scp -o StrictHostKeyChecking=no'
alias nssh='TERM=xterm-256color ssh -o StrictHostKeyChecking=no'
alias pstree='pstree -g 3'
alias sdig='dig +short'
alias sgrep='find . -path "*/.svn" -prune -o -print0 | xargs -0 grep'
alias tma='tmux attach-session'
alias tml='tmux list-session'
alias uipssh='pssh -i -t 1600 -l root -o output -e output -O "StrictHostKeyChecking=no"'
alias wetter='curl http://wttr\.in/"Karlsruhe"'
alias pwgen='pwgen -s1 16'
alias gpa='gopass adesso'
alias gss='git status'
alias ga='git add'
alias v='nvim'
# alias ls="ls --color=auto"
alias ls="lsd"
alias l="ls"
alias ll="ls -al"
alias pacrm="pacman -Rns"
alias pacadd="pacman -S"
alias pacfind="pacman -Ss"

# ---[ Path settings ]-------------------------------------------------

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.local/bin:$GOPATH/bin:$HOME/golang/bin:$HOME/bin:$HOME/.gem/ruby/2.4/bin

# ---[ Virtualenv ]----------------------------------------------------
#export PROJECT_HOME=${HOME}/virtenvs

# ---[ VIM Mode  ]-----------------------------------------------------
bindkey -v

# ---[ Plugins ]-------------------------------------------------------
declare -A ZINIT
export ZINIT[BIN_DIR]=${HOME}/.zsh/zinit
export ZINIT[HOME_DIR]=${CUSTOM_PATH}/zinit
if [[ -d "/shareddata/zshrepos" ]]; then
    export ZINIT[PLUGINS_DIR]=/shareddata/zshrepos
fi

# Download zinit plugin manager if missing.
if [[ ! -f ${ZINIT[BIN_DIR]}/zinit.zsh ]]; then
  git clone https://github.com/zdharma-continuum/zinit ~/.zsh/zinit
fi

# Load zinit and plugins
source ${ZINIT[BIN_DIR]}/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet OMZ::plugins/dirhistory/dirhistory.plugin.zsh
zinit snippet OMZ::plugins/golang/golang.plugin.zsh
zinit snippet OMZ::plugins/urltools/urltools.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
#zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh

zinit light b4b4r07/enhancd

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-history-substring-search

#zinit ice wait atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait atload"_zsh_autosuggest_start" lucid
zinit light zsh-users/zsh-autosuggestions

# zinit light marlonrichert/zsh-autocomplete

# ---[ Local configs ]-------------------------------------------------
# Source local host config
for custom_file in ${CUSTOM_PATH}/*.conf(N); do
    source "${custom_file}"
done

# ---[ Key bindings ]--------------------------------------------------
#bindkey "^R" history-incremental-search-backward

# ---[ Shell functions ]-----------------------------------------------
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility

take() {
  mkdir -p $@ && cd ${@:$#}
}

# ---[ Modules ]-------------------------------------------------------
fpath=(${LOCAL_PATH}/custom-completions $fpath)
autoload -U zargs
zmodload zsh/complist
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -ap zsh/mapfile mapfile

# ---[ Completition system ]-------------------------------------------
zstyle ':completion:*' menu select
# Persistent rehash
zstyle ':completion:*' rehash true

# ---[ Terminal settings ]---------------------------------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# # Finally, make sure the terminal is in application mode, when zle is
# # active. Only then are the values from $terminfo valid.
# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#     function zle-line-init () {
#         printf '%s' "${terminfo[smkx]}"
#     }
#     function zle-line-finish () {
#         printf '%s' "${terminfo[rmkx]}"
#     }
#     zle -N zle-line-init
#     zle -N zle-line-finish
# fi

# ---[ Tmux section ]-------------------------------------------------
_update_ssh_agent() {
    local var
    var=$(tmux show-environment |grep '^SSH_AUTH_SOCK=')
    if [ "$?" -eq 0 ]; then
        eval "$var"
    fi
}
if [[ -n "$TMUX" ]]; then
    add-zsh-hook precmd _update_ssh_agent
fi

# ---[ Misc & Includes ]-----------------------------------------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

FAST_HIGHLIGHT_STYLES[comment]="fg=blue"

#eval `dircolors ${LOCAL_PATH}/dircolors`

# use push-line
bindkey '^q' push-line-or-edit

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

vim_ins_mode="-- INSERT --"
vim_cmd_mode="-- NORMAL --"
vim_mode=$vim_ins_mode

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Secure pasting
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# other ZSH_AUTOSUGGEST config goes here

# Then load url-quote-magic and bracketed-paste-magic as above
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Now the fix, setup these two hooks:
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic 
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# and finally, make sure zsh-autosuggestions does not interfere with it:
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Plugin: enhancd
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HYPHEN=1
export ENHANCD_DISABLE_HOME=1
export ENHANCD_ENABLE_DOUBLE_DOT=false
export ENHANCD_ENABLE_HOME=false
#export ENHANCD_FILTER="sk"

# Workaround for cd listing also files with enhancd
#compdef __enhancd::cd=cd

# FZF and Skim Config
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_DEFAULT_OPTS='--exact'

export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
export SKIM_DEFAULT_OPTIONS="--exact"

if [[ -e "${HOME}/.fzf.zsh" ]]; then
  source ~/.fzf.zsh
fi

if [[ -e "${HOME}/.config/broot/launcher/bash/br" ]]; then
  source ~/.config/broot/launcher/bash/br
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -e "${HOME}/.p10k.zsh" ]]; then
  source ~/.p10k.zsh
fi
