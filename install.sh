#!/bin/zsh
# Enlaza los dotfiles en su sitio. Lo que ya exista se guarda como <archivo>.backup-<fecha>.
# Uso: ./install.sh            -> solo enlaces
#      ./install.sh --brew     -> además instala los paquetes del Brewfile
set -e
DOT=${0:A:h}
STAMP=$(date +%Y%m%d-%H%M%S)

link() {  # link <origen en el repo> <destino>
  local src=$DOT/$1 dst=$2
  mkdir -p ${dst:h}
  if [[ -L $dst && ${dst:A} == ${src:A} ]]; then
    echo "ok      $dst"; return
  fi
  if [[ -e $dst || -L $dst ]]; then
    mv $dst $dst.backup-$STAMP
    echo "backup  $dst -> $dst.backup-$STAMP"
  fi
  ln -s $src $dst
  echo "enlace  $dst -> $src"
}

if [[ $1 == --brew ]]; then
  command -v brew >/dev/null || { echo "Instala Homebrew primero: https://brew.sh"; exit 1; }
  brew bundle --file=$DOT/Brewfile
fi

# Homebrew deja algunas carpetas con escritura para el grupo y compinit las marca como inseguras
if command -v brew >/dev/null; then
  for d in $(brew --prefix)/share $(brew --prefix)/share/zsh $(brew --prefix)/share/zsh/site-functions; do
    [[ -d $d ]] && chmod go-w $d
  done
  echo "permisos de $(brew --prefix)/share corregidos"
fi

# oh-my-zsh y los plugins de fuera (como ML4W); el .zshrc es el de este repo, no el que trae oh-my-zsh
clone() {  # clone <repo> <destino>
  [[ -d $2 ]] && { echo "ok      $2"; return }
  git clone -q --depth 1 $1 $2 && echo "clonado $2"
}
clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

link zsh/.zshrc                 ~/.zshrc
link kitty/kitty.conf           ~/.config/kitty/kitty.conf
link kitty/lainos.conf          ~/.config/kitty/lainos.conf
link starship/starship.toml     ~/.config/starship.toml
link fastfetch/config.jsonc     ~/.config/fastfetch/config.jsonc
link fastfetch/logo.txt         ~/.config/fastfetch/logo.txt
link glain/gifs                 ~/.config/glain/gifs
link bin/lainfetch              ~/.local/bin/lainfetch
link bin/kitty-boot             ~/.local/bin/kitty-boot

# El LaunchAgent lleva rutas absolutas, así que se genera con el $HOME de este Mac.
plist=~/Library/LaunchAgents/com.crpd.kitty-boot.plist
new=$(sed "s#__HOME__#$HOME#g" $DOT/launchagents/com.crpd.kitty-boot.plist)
if [[ ! -f $plist || $(<$plist) != $new ]]; then
  mkdir -p ${plist:h}
  [[ -f $plist ]] && cp $plist $plist.backup-$STAMP
  print -r -- $new > $plist
  launchctl bootout gui/$UID $plist 2>/dev/null || true
  launchctl bootstrap gui/$UID $plist
  echo "agente  $plist"
else
  echo "ok      $plist"
fi

echo "\nListo. Abre una ventana nueva de kitty para ver los cambios."
