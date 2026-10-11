# aliases.sh

## Installation

Clone the repository:
```sh
git clone <repo>

cd <repo>
```

Check available installer scripts:
```sh
./install.sh --help
```

### Load Order

```sh
$HOME/.zshrc:
    - ~/.aliases/oh-my-zsh/config
        - $ZSH/oh-my-zsh.sh
    - ~/.aliases/aliases.niri.sh   # Wayland/niri specific (loaded on Wayland)
    - ~/.aliases/aliases.i3.sh     # X11/i3wm specific (loaded on X11)
    - ~/.aliases/aliases.sh        # Common aliases (works on both)
        - ~/.aliases/colors.sh
        - ~/.aliases/env.sh
    - ~/.aliases/aliases.utils.sh  # Utility functions
```

## File Structure

```
~/.aliases/
├── aliases.sh          # Common aliases (works on both Wayland and X11)
├── aliases.i3.sh       # i3wm/Xorg specific aliases
├── aliases.niri.sh     # niri/Wayland specific aliases
├── aliases.utils.sh    # Utility functions (fzf, bat, eza, etc.)
├── colors.sh           # Color definitions
├── env.sh              # Environment variables
├── i3/
│   ├── i3/config       # i3wm config
│   └── toggle-kbl.sh   # Keyboard layout toggle script
└── niri/
    ├── config.kdl      # niri config
    └── install.sh      # niri installation script
```

## Shorthands

### Package Management

| Command              | Action                                             |
| -------------------- | -------------------------------------------------- |
| `install`            | Install package via apt                            |
| `update`             | Update packages via apt                            |
| `uninstall`          | Uninstall package via apt                          |
| `find_package`       | Use fzf to navigate in package list (apt-cache)    |
| `alias_update`       | Updates the alias repository                       |
| `UPDATE`             | Update: aliases repo, ohmyzsh, OS packages         |
| `pkg_command`        | Show binaries installed by package                 |
| `command_comes_from` | Show package where binary comes from               |

### Navigation Shortcuts

| Command           | Action                                                        |
| ----------------- | ------------------------------------------------------------- |
| `aliases`         | Opens the `~/.aliases` directory.                             |
| `downloads`, `dl` | Goes to `~/Downloads` and lists files.                        |
| `workspace`, `ws` | Goes to `~/Projects/` and lists files.                        |
| `wd`              | Navigates to `$WORK_DIR` (defined in the environment).        |

### Config Files

| Command           | Action                                                  |
| ----------------- | ------------------------------------------------------- |
| `ac`              | Edits the main alias file (`aliases.sh`).               |
| `zc`              | Edits `.zshrc`.                                         |
| `ec`              | Edits the env variables file. `~/.aliases/env.sh`       |
| `vc`              | Edits `vimrc`.                                          |
| `ic`              | **i3wm only:** Edits `i3.conf` (`~/.aliases/i3/i3/config`). |
| `nc`              | **niri only:** Edits niri config (`~/.config/niri/config.kdl`). |

### Utilities and General Tools

| Command                     | Action                                                  |
| --------------------------- | ------------------------------------------------------- |
| `reload`                    | source `~/.zshrc` file                                  |
| `rank`                      | Counts and sorts duplicate lines.                       |
| `du_by_size`                | Shows directory/file sizes in the current folder.       |
| `weather`                   | Shows current weather using `wttr.in`.                  |
| `togglekbl`                 | **i3wm only:** Toggles keyboard layout using custom script. |
| `find_directory`, `cdf`     | Finds directories with `fzf` and navigates to them.     |
| `find_file`                 | Finds file with `fzf` and navigates to them.            |
| `ccd <dir>`                 | Enters `<dir>`, clears the terminal, and lists files.   |
| `mkcd <dir>`                | Creates and enters the directory if it doesn't exist.   |
| `cc <file>`                 | **Platform-specific:** Copies file contents to clipboard (xclip on X11, wl-copy on Wayland). |
| `calc`                      | Calculator using `bc`.                                  |
| `cat_csv`                   | Format and show csv file.                               |
| `str2md5`                   | Generates a md5 from string.                            |
| `hash_dir`                  | Calculate directory (recursive) hash.                   |
| `unixtimestamp2date`        | Format unix timestamp to iso 8601.                      |
| `ip_info <ip>`              | Shows IP information using `ipwho.is`.                  |
| `apex_info <domain>`        | Shows subdomains information using `crt.name`.          |
| `lorem <num>`               | **Platform-specific:** Copies Lorem Ipsum text to clipboard (xclip on X11, wl-copy on Wayland). |
| `explain <cmd>`             | Opens `explainshell.com` in `w3m`.                      |
| `help <cmd>`                | Uses `cheat.sh` to show command help.                   |
| `vim_card`                  | Displays the Vim cheat sheet.                           |
| `rememberme "msg" 5 minutes`| **Platform-specific:** Sends a notification after a delay using `at` (notify-send on both). |
| `cat_from_url`              | Uses wget or curl and output response.                  |


### Compression and Archives

| Command             | Action                                |
| ------------------- | ------------------------------------- |
| `pack <dir>`        | Creates a `.tar.gz` archive.          |
| `unpack <file>`     | Extracts a `.tar.gz` archive.         |
| `compress <dir>`    | Creates a `.tar.xz` archive.          |
| `uncompress <file>` | Extracts a `.tar.xz` archive.         |

### Downloads via aria2

| Command                   | Action                                |
| ------------------------- | ------------------------------------- |
| `download_magnet <link>`  | Downloads magnet links using aria2.   |
| `download_torrent <file>` | Downloads `.torrent` files using aria2.|

### Git

| Command                      | Action                                                                    |
| ---------------------------- | ------------------------------------------------------------------------- |
| `s`                          | Runs `git status -s`.                                                     |
| `d`                          | Runs `git diff`.                                                          |
| `u`                          | Updates repository using `fetch`, `pull`, and submodules.                 |
| `log`                        | Runs `git log --oneline`.                                                 |
| `git_update`                 | Hard resets to `FETCH_HEAD` and pulls latest changes (skips if uncommitted).|
| `git_clean_branches`         | Removes outdated local branches with confirmation.                        |
| `git_sync_branches`          | Syncs branches like `master`, `develop`, etc., with `origin`.             |
| `git_delete_branch <branch>` | Deletes both local and remote branches.                                  |

### Tmux

| Command                  | Action                                          |
| ------------------------ | ----------------------------------------------- |
| `tl`                     | list tmux sessions                              |
| `tmux_dev` <name> <path> | create a dev session                            |
| `tmux_copy_buffer`       | **Platform-specific:** put tmux buffer to clipboard (xclip on X11, wl-copy on Wayland) |
| `cli`                    | create or open a tmux session called cli        |

### Docker

| Command              | Action                                                        |
| -------------------- | ------------------------------------------------------------- |
| `dps`                | Lists containers with name, image, and ports.                 |
| `dpsw`               | Also shows the Docker Compose working directory.              |
| `dcu`                | Runs `docker compose up -d`.                                  |
| `dcub`               | Runs `docker compose up -d --build`.                          |
| `dcd`                | Runs `docker compose down --volumes`.                         |
| `dpsa`               | Runs `docker ps -a`.                                          |
| `di`                 | Lists Docker images.                                          |
| `dv`                 | Lists Docker volumes.                                         |
| `dsdf`               | Shows disk usage of Docker objects.                           |
| `docker_prune`       | Removes unused Docker objects.                                |
| `docker_images_size` | Lists images sorted by size.                                  |
| `docker_kill_all`    | Stops and removes all containers.                             |

### Containerized Tools

| Command            | Action                                                      |
| ------------------ | ----------------------------------------------------------- |
| `php`              | Runs PHP 8.3 CLI using Docker in the current directory.     |
| `composer`         | Runs Composer using Docker in the current directory.        |
| `trans`            | Uses Docker image of `translate-shell`.                     |
| `speedtest`        | Runs a speed test via Docker.                               |
| `simple_server`    | HTTP server with Python on port 9000.                       |
| `static_server`    | Nginx server for static files.                              |
| `php56_server`     | Apache server with PHP 5.6.                                 |
| `php71_server`     | PHP 7.1 server.                                             |
| `php72_server`     | PHP 7.2 server.                                             |
| `php80_server`     | PHP 8.0 server.                                             |
| `php82_server`     | PHP 8.2 server.                                             |
| `php80_dev_server` | PHP 8.0 development server.                                 |
| `php82_dev_server` | PHP 8.2 development server.                                 |
| `php84_dev_server` | PHP 8.4 development server.                                 |
| `aws`              | Runs Universal CLI for Amazon Web Services (utils)          |

---

## Wayland/niri Specific Aliases (aliases.niri.sh)

| Command              | Action                                                      |
| -------------------- | ----------------------------------------------------------- |
| `wl-copy` / `wl-paste` | Wayland clipboard commands                                |
| `cc <file>`          | Copy file to clipboard (uses wl-copy)                       |
| `lorem <num>`        | Lorem ipsum to clipboard (uses wl-copy)                     |
| `nc`                 | Edit niri config (`~/.config/niri/config.kdl`)              |
| `imv` / `iv`         | Wayland image viewer (replaces feh)                         |
| `screenshot`         | Region screenshot (grim + slurp)                            |
| `screenshot-full`    | Full screen screenshot                                      |
| `screenrecord`       | Region screen recording (wf-recorder)                       |
| `screenrecord-full`  | Full screen recording                                       |
| `launcher` / `fuzzel`| Application launcher                                        |
| `waybar`             | Status bar                                                  |
| `waybar-restart`     | Restart waybar                                              |
| `lock` / `swaylock`  | Screen lock                                                 |
| `notify-test`        | Test notifications                                          |
| `wlsunset`           | Color temperature (replaces redshift)                       |
| `wlr-randr`          | Output management (replaces xrandr)                         |
| `cliphist`           | Clipboard history manager                                   |
| `rememberme "msg" 5m`| Send notification after delay (uses notify-send + at)       |
| `tmux_copy_buffer`   | Copy tmux buffer to clipboard (uses wl-copy)                |

---

## i3wm/Xorg Specific Aliases (aliases.i3.sh)

| Command              | Action                                                      |
| -------------------- | ----------------------------------------------------------- |
| `togglekbl`          | Toggle keyboard layout                                      |
| `ic`                 | Edit i3 config (`~/.aliases/i3/i3/config`)                  |
| `mocp` / `moc`       | MOC music player (X11 only)                                 |
| `feh`                | Image viewer (X11 only)                                     |
| `xclip` / `xpaste`   | X11 clipboard                                               |
| `i3-reload`          | Reload i3 config                                            |
| `i3-restart`         | Restart i3                                                  |
| `picom-toggle`       | Toggle picom compositor                                     |
| `redshift-toggle`    | Toggle redshift                                             |
| `scrot` / `maim`     | Screenshot tools                                            |
| `cc <file>`          | Copy file to clipboard (uses xclip)                         |
| `lorem <num>`        | Lorem ipsum to clipboard (uses xclip)                       |
| `rememberme "msg" 5m`| Send notification after delay (uses notify-send + at)       |
| `tmux_copy_buffer`   | Copy tmux buffer to clipboard (uses xclip)                  |

---

## Best Practices

### check format
```sh
shfmt -d -i 2 <file>
```

if is not valid, format using:
```sh
shfmt -i 2 -w <file>
```

### check script
```sh
shellcheck -e SC2028,SC2148 <file>
```

