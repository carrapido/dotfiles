export PATH="$HOME/.local/bin:$PATH"

# ─── autocompletado ───
FPATH="/opt/homebrew/share/zsh-completions:/opt/homebrew/share/zsh/site-functions:$FPATH"
# menú de opciones en vivo mientras escribes (↑↓ para elegir, Tab para entrar al menú)
# se carga antes que compinit y ya lo llama él; lo clona install.sh (el paquete de brew viene incompleto)
if [[ -r ~/.local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]]; then
  # -i: sin pregunta de "insecure directories" (la responde la primera tecla y aborta el completado)
  zstyle ':autocomplete::compinit' arguments -i
  source ~/.local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
else
  autoload -Uz compinit && compinit -i
  zstyle ':completion:*' menu select
fi
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
