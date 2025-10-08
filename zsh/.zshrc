#zmodload zsh/zprof

TERM=screen-256color 
setopt CORRECT

export EDITOR='nvim'
alias vim='nvim'
alias v='nvim'
export PATH=$PATH:$HOME/.local/share/bob/nvim-bin

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

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

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

#zprof

