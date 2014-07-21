# Basics
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
[ -e $HOME/bin -a -d $HOME/bin ] && export PATH=$HOME/bin:$PATH

# Enbeded Command Aliases
alias ls='ls -lp'
alias lsa='ls -alp'
alias lsh='ls -alp | grep " \."'

# Completion
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
setopt autocd auto_pushd pushd_ignore_dups correct complete_aliases print_eight_bit 
zstyle ':completion:*:sudo:*' command-path /usr/local/sib /usr/local/bin /usr/sbin /usr/bin /sbin /bin
  
# Histories
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

setopt hist_ignore_all_dups hist_ignore_dups hist_save_no_dups appendhistory #share_history

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Key Bind
bindkey -v
zle-line-init() { zle -K vicmd; } ; zle -N zle-line-init # set initial mode to command mode


# Terminal
export TERM=xterm-256color
autoload colors
colors

# Prompt
local p_cdir="%B%F{cyan}[%~]%f%b"$'\n'
local p_info="%n@%m"
local p_mark="%B%F{ref}%(!,#,>)%f%b"
PROMPT="$p_cdir$p_info $p_mark "

# tmux
if [ -x "`which tmux 2>/dev/null`" ]; then
  if [ -z "$TMUX" -a -z "$STY" -a -x "`which tmuxx 2>/dev/null`" ]; then
    if type tmuxx>/dev/null 2>&1; then
      tmuxx
    else
      if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
        tmux attach && echo 'tmux attached session '
      else
        tmux new-session && echo 'tmux created new session'
      fi
    fi
  fi

  precmd() {
   if [ -n "$TMUX" ]; then
     tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD"
     tmux refresh-client -S
   fi
  }
fi

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

# Homebrew
if [ -x "`which brew 2>/dev/null`" ]; then
  [ -z "`echo $PATH | grep $(brew --prefix)/bin`" ] && export PATH="$(brew --prefix)/bin":$PATH
fi

# Ruby
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if [ -x "`which rbenv 2>/dev/null`" ]; then 
  eval "$(rbenv init -)"
fi

# Host depend environment
[ -f ~/.zshrc.`hostname -s` ] && source ~/.zshrc.`hostname -s`

case ${OSTYPE} in
  darwin*)
    export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
    export GIT_EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    ;;
  linux*)
    [ -x "`which vim 2>/dev/null`" ] && alias vi=`which vim 2>/dev/null`
    export EDITOR=vi
    export GIT_EDITOR=vi
    ;;
  freebsd*)
    ;;
  *)
    ;;
esac

#typeset -U PATH
#setopt extendedglob nomatch
