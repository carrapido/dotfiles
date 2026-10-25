export PATH="$HOME/.local/bin:$PATH"

# ─── oh-my-zsh, como ML4W ───
# Tab abre el menú (flechas para moverte), → acepta la sugerencia gris, Ctrl+R busca en el historial con fzf
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""                     # el prompt lo pone starship
ZSH_DISABLE_COMPFIX=true         # sin aviso de "insecure directories"
zstyle ':omz:update' mode disabled
FPATH="/opt/homebrew/share/zsh-completions:/opt/homebrew/share/zsh/site-functions:$FPATH"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# los de ML4W menos archlinux (aquí es macOS) y zsh-syntax-highlighting (fast-syntax-highlighting ya lo hace):
# sudo: Esc Esc añade sudo · copybuffer: Ctrl+O copia la línea · copyfile <archivo>: copia su contenido
# web-search: google <texto> · dirhistory: Alt+←/→ (solo si kitty usa Option como Alt; no activado para no perder @ # [ en teclado español)
plugins=(
  git
  sudo
  web-search
  zsh-autosuggestions
  fast-syntax-highlighting
  copyfile
  copybuffer
  dirhistory
)
source $ZSH/oh-my-zsh.sh

# Ctrl+R: buscador del historial con fzf, con colores de lainOS
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --border rounded \
  --color bg+:#2a2636,fg+:#ece6f5,hl:#b79ce6,hl+:#cbb4f2,pointer:#86c7cf,prompt:#b79ce6,border:#6e6683,info:#6e6683"
source <(fzf --zsh)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#727169'
zstyle ':completion:*' list-colors 'di=38;2;126;156;216' 'ln=38;2;149;127;184' 'ex=38;2;94;239;245'

# Tab también corrige errores de tipeo ("Dcouments" → Documents): 1 error cada 3 letras, máximo 3
zstyle ':completion:*' completer _complete _correct _approximate
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX + 1) / 3 > 3 ? 3 : ($#PREFIX + $#SUFFIX + 1) / 3 )) numeric )'

# encabezados del menú en español, con los colores de lainOS
zstyle ':completion:*:descriptions' format '%F{#b79ce6}── %d ──%f'
zstyle ':completion:*:corrections'  format '%F{#e6c08f}── ¿quisiste decir? (%e) ──%f'
zstyle ':completion:*:messages'     format '%F{#86c7cf}%d%f'
zstyle ':completion:*:warnings'     format '%F{#e0828f}sin coincidencias para: %d%f'
zstyle ':completion:*' group-name ''

# autocorrector de comandos al pulsar Enter ("gti status" → ¿git?)
setopt correct
SPROMPT=$'%F{#e6c08f}¿quisiste decir%f %F{#a3c9a8}%r%f %F{#e6c08f}en vez de%f %F{#e0828f}%R%f%F{#e6c08f}?%f %F{#6e6683}[y] sí  [n] no  [e] editar  [a] cancelar%f '

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
