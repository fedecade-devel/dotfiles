# Basics!
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
[ -e $HOME/bin -a -d $HOME/bin ] && export PATH=$HOME/bin:$PATH

# Enbeded Command Aliases
alias ls='ls -lp'
alias lsa='ls -alp'
alias lsh='ls -alp | grep " \."'
alias lsf='ls | grep -v "/$"'
alias lss='/bin/ls'
alias sudo='sudo -E '

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

# autoload -Uz history-search-end
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -v "^P" history-beginning-search-backward-end
bindkey -v "^N" history-beginning-search-forward-end

# Key Bind
bindkey -v
zle-line-init() { zle -K vicmd; } ; zle -N zle-line-init # set initial mode to command mode
bindkey -v '^j' vi-cmd-mode


# Terminal
export TERM=xterm-256color
autoload colors
colors

# Git
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
	local st branch color
	STY=LANG=en_US.UTF-8 vcs_info
	st=`git status 2> /dev/null`
	if [[ -z $st ]]; then return; fi
	branch="$vcs_info_msg_0_"
	if [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]}
	elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]}
	elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]}
	else color=${fg[cyan]}
	fi
	echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}

# Prompt
# local p_cdir="%B%F{cyan}[%~]%f%b"$'\n'
# local p_info="%n@%m"
# local p_mark="%B%F{ref}%(!,#,>)%f%b"
# PROMPT="$p_cdir$p_info $p_mark"
PROMPT='%B%F{green}[%~]%f `vcs_echo`
%(?.%(!,#,>).%F{red}%(!,#,>)%f)%b '

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
alias zcp='noglob zmv -W -C'

# Homebrew
if [ -x "`which brew 2>/dev/null`" ]; then
  [ -z "`echo $PATH | grep $(brew --prefix)/bin`" ] && export PATH="$(brew --prefix)/bin":$PATH
fi

# Ruby
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# if [ -x "`which rbenv 2>/dev/null`" ]; then 
  # eval "$(rbenv init - zsh)"
# fi
# eval "$(rbenv init - zsh)"

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
    export EDITOR=`which vim 2>/dev/null`
    export GIT_EDITOR=$EDITOR
    ;;
  freebsd*)
    ;;
  *)
    ;;
esac

# phpenv
if [ -x "`which phpenv 2>/dev/null`" ]; then
	eval "$(phpenv init - zsh)"
fi

#typeset -U PATH
#setopt extendedglob nomatch

# divenv
eval "$(direnv hook zsh)"

# ssh-agent
echo -n 'ssh-agent:'
source ~/.ssh-agent-info
ssh-add -l >&/dev/null
if [[ $? -eq 2 ]]; then
  echo -n 'ssh-agent: restart...'
  ssh-agent > ~/.ssh-agent-info
  source ~/.ssh-agent-info
fi
if ssh-add -l >&/dev/null; then
  echo "ssh-agent: Identity is already stored."
else
  ssh-add
fi
