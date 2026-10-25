export PATH="$HOME/.local/bin:$PATH"

# ─── autocompletado ───
FPATH="/opt/homebrew/share/zsh-completions:/opt/homebrew/share/zsh/site-functions:$FPATH"
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors 'di=38;2;126;156;216' 'ln=38;2;149;127;184' 'ex=38;2;94;239;245'

# sugerencias del historial (acepta con →)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#727169'

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_dups

# ─── prompt ───
eval "$(starship init zsh)"

# ─── fastfetch al abrir la terminal ───
# en kitty: lainfetch (fastfetch + GIF de Lain animado por kitty, no bloquea el prompt); en otras terminales: fastfetch normal
# (solo en la primera shell de cada ventana, no en subshells)
if [[ -o interactive && -z $FETCH_SHOWN ]]; then
  export FETCH_SHOWN=1
  if [[ -n $KITTY_WINDOW_ID ]] && command -v lainfetch >/dev/null; then
    lainfetch
  else
    fastfetch
  fi
fi
