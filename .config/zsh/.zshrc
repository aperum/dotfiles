#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

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

setopt EXTENDED_GLOB
# Unbind flow control and use push-line instead
unsetopt FLOW_CONTROL

# HISTSIZE=5000
# SAVEHIST=5000
# HISTFILE=${ZDOTDIR:-~}/.zsh_history
# DIRSTACKSIZE=20

# Stay compatible to sh and IFS
setopt  SH_WORD_SPLIT

# Allow comments on command line
setopt INTERACTIVE_COMMENTS

# Enable zmv
autoload zmv


# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

autoload -Uz compinit && compinit

# ---[ Completition system ]-------------------------------------------
# zstyle ':completion:*' menu select
# # Persistent rehash
# zstyle ':completion:*' rehash true
#
# See: https://thevaluable.dev/zsh-completion-guide-examples/
#
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' verbose yes

zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' menu select

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort change reverse

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ---[ Utility section ]-------------------------------------------------
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

_update_xterm_title() {
  print -Pn "\e]0;zsh\a"
}
add-zsh-hook precmd _update_xterm_title

# ---[ Terminal settings ]---------------------------------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# ---[ Misc & Includes ]-----------------------------------------------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(accept-line)

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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source /home/aperum/.config/broot/launcher/bash/br
