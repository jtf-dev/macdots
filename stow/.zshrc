alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias brew-edit="nvim ~/dotfiles/Brewfile"
alias brew-build="brew bundle --file ~/dotfiles/Brewfile"

config() {
  case "$1" in
    nvim)
      nvim ~/dotfiles/stow/.config/nvim
      ;;
    starship)
      nvim ~/dotfiles/stow/.config/starship.toml
      ;;
    zshrc)
      nvim ~/.zshrc
      ;;
    *)
      echo "Unknown config option: $1"
      ;;
  esac
}

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

eval "$(starship init zsh)"
