# dotfiles · lainOS (macOS)

Configuración de terminal para macOS con temática de *Serial Experiments Lain*: kitty translúcido, prompt de starship y fastfetch con un GIF de Lain animado al lado.

## Qué incluye

| Carpeta | Va a | Qué es |
|---|---|---|
| `zsh/.zshrc` | `~/.zshrc` | autocompletado, sugerencias, historial, starship y fastfetch al abrir |
| `kitty/` | `~/.config/kitty/` | `kitty.conf` (fuente, opacidad 0.75, blur) + tema `lainos.conf` |
| `starship/starship.toml` | `~/.config/starship.toml` | prompt |
| `fastfetch/` | `~/.config/fastfetch/` | módulos y logo ASCII (para terminales que no son kitty) |
| `glain/gifs/` | `~/.config/glain/gifs/` | GIFs de Lain con fondo transparente (de [fauux.neocities.org](https://fauux.neocities.org/)) |
| `bin/lainfetch` | `~/.local/bin/` | fastfetch + un GIF al azar, animado por kitty sin bloquear el prompt |
| `bin/kitty-boot` | `~/.local/bin/` | abre kitty centrado al iniciar sesión |
| `launchagents/` | `~/Library/LaunchAgents/` | lanza `kitty-boot` al iniciar sesión |
| `Brewfile` | — | paquetes de Homebrew |

## Instalación

```sh
git clone https://github.com/<tu-usuario>/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh --brew   # instala paquetes y enlaza todo
```

`install.sh` crea enlaces simbólicos desde tu `$HOME` a este repo, así que lo que edites en `~/.config/...` queda en el repo. Si ya existe un archivo, lo guarda como `<archivo>.backup-<fecha>`. Puedes ejecutarlo las veces que quieras.

## GIFs

Para añadir o quitar GIFs, mete o borra archivos en `glain/gifs/`. `lainfetch` elige uno al azar en cada ventana nueva de kitty.
