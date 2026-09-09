# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export PROFILING_MODE=0
if [ $PROFILING_MODE -ne 0 ]; then
    zmodload zsh/zprof
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins with turbo mode for faster startup
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light jeffreytse/zsh-vi-mode

# Add in snippets with turbo mode
zinit ice wait lucid
zinit snippet OMZL::git.zsh

zinit ice wait lucid
zinit snippet OMZP::git

zinit ice wait lucid
zinit snippet OMZP::alias-finder

zinit ice wait lucid
zinit snippet OMZP::aws

zinit ice wait lucid
zinit snippet OMZP::kubectl

zinit ice wait lucid
zinit snippet OMZP::kubectx

# Load completions - optimized to run once per day
autoload -Uz compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n $zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zinit cdreplay -q

# Keybindings
# bindkey 'L' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias vi='nvim'
alias c='clear'

# Go Path
export PATH=${PATH}:`go env GOPATH`/bin

# tmuxifier setup
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"

# posting setup
export PATH="$HOME/.local/bin/:$PATH"

# Shell integrations - defer to not block instant prompt
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v tmuxifier &> /dev/null; then
  eval "$(tmuxifier init -)"
fi

# ghostty version 1.14 does not implement OSC52, due to this the export to curl in posting does not work
# ghostty issue discussion: https://github.com/ghostty-org/ghostty/discussions/7590 (issue fixed in main, yet to be released)
# posting issue discussion: https://github.com/darrenburns/posting/issues/237, workaround mentioned in the isssue thread
# TODO: upgrade ghostty 1.20 when Available
alias posting="TERM_PROGRAM=Apple_Terminal posting"

# export PATH="$HOME/scripts/:$PATH"
#
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
if [ $PROFILING_MODE -ne 0 ]; then
  zprof
fi

# git shortcuts
git() {
  # interactive checkout
  if [[ $1 == "checkout" && $# -eq 1 ]]; then
    command git checkout $(command git branch --sort=-committerdate | fzf)
  # interactive stash
  elif [[ $1 == "stash" && $2 == "pop" && $# -eq 2 ]]; then
    command git stash pop $(command git stash list | fzf | cut -d: -f1)
  else
    command git "$@"
  fi
}


glast() {
  local count=${1:-20}
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local remote_branch="origin/${current_branch}"

  if ! git rev-parse --verify "$remote_branch" >/dev/null 2>&1; then
    remote_branch="origin/main"
  fi

  local unpushed=$(git log "$remote_branch"..HEAD --pretty=format:"%h" 2>/dev/null | paste -sd'|')

  git log -n "$count" --pretty=format:"%h %an %s" | awk -v u="$unpushed" '
    BEGIN { split(u, a, "|"); for (i in a) hashes[a[i]] = 1 }
    { color = ($1 in hashes) ? 31 : 33; printf "\033[0;%dm%s\033[0m\n", color, $0 }
  '
}


export GOTOOLCHAIN=auto
