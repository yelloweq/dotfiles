# Zinit plugin manager for zsh
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not installed
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname "$ZINIT_HOME")"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


source "${ZINIT_HOME}/zinit.zsh"

# zinit plugins
zinit light starship/starship
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

zinit ice as"command" from"gh-r" \
          atclone="./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull="%atclone" src="init.zsh"

# FZF installation via Zinit
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice from"gh-r" as"program" pick"zoxide" 
zinit light ajeetdsouza/zoxide

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -Uz compinit
compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)" 

# Aliases
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias art='sail php artisan'
alias a='php artisan'
alias vim='nvim'


# Paths
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH=$PATH:"/usr/local/go/bin"
export PATH=$PATH:"$GOPATH/bin"
export PATH=$PATH:"~/.local/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
