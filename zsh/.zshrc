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
zstyle ':completion:*' list-colors 'di=38;2;126;156;216' 'ln=38;2;149;127;184' 'ex=38;2;94;239;245'

# tolerancia a errores de tipeo al completar: 1 error cada 3 letras, máximo 3
# ("Dcouments" → Documents, "dowloads" → Downloads); las letras invertidas cuentan como 1 error
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX + 1) / 3 > 3 ? 3 : ($#PREFIX + $#SUFFIX + 1) / 3 )) numeric )'
# la lista aparece desde la 2ª letra (antes 3)
zstyle ':autocomplete:*' min-input 2

# encabezados de la lista en español, con los colores de lainOS
zstyle ':completion:*:descriptions' format '%F{#b79ce6}── %d ──%f'
zstyle ':completion:*:corrections'  format '%F{#e6c08f}── ¿quisiste decir? (%e) ──%f'
zstyle ':completion:*:messages'     format '%F{#86c7cf}%d%f'
zstyle ':completion:*:warnings'     format '%F{#e0828f}sin coincidencias para: %d%f'

# autocorrector de comandos al pulsar Enter ("gti status" → ¿git?)
setopt correct
SPROMPT=$'%F{#e6c08f}¿quisiste decir%f %F{#a3c9a8}%r%f %F{#e6c08f}en vez de%f %F{#e0828f}%R%f%F{#e6c08f}?%f %F{#6e6683}[y] sí  [n] no  [e] editar  [a] cancelar%f '

# sugerencias grises (acepta con →): del historial y, si no hay, de lo que se puede completar
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
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
