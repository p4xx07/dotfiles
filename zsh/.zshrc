#zmodload zsh/zprof
#START=$EPOCHREALTIMESTART

TERM=tmux-256color 
setopt CORRECT

bindkey -v
# allow vv to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

#weather
alias weather='curl wttr.in'

#eza aliases
alias ls='eza $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree $eza_params'
alias tree='eza --tree $eza_params'
alias re-source='source ~/.zshrc'

alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

#. "$HOME/.atuin/bin/env"
#eval "$(atuin init zsh)"

# yazi cd on quit
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
                zle reset-prompt
	fi
	rm -f -- "$tmp"
}

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export PATH="$(go env GOPATH)/bin:$PATH"
export EDITOR='hx'
export PATH=$PATH:$HOME/.local/share/bob/nvim-bin
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/flutter/bin:$PATH"

# personal aliases, not tracked by git
[[ -f ~/.zsh_aliases.local ]] && source ~/.zsh_aliases.local

#zprof
#print "zshrc load: $(printf %.3f $(( EPOCHREALTIME - START )))s"
