# aliases.sh

## Installation

Clone the repository to `~/.aliases`:
```sh
git clone <repo> ~/.aliases
```

Bootstrap the `shpkg` command:
```sh
cd ~/.aliases
./shpkg install shpkg
```

This creates the symlink `/usr/local/bin/shpkg -> ~/.aliases/shpkg` using `sudo`.
If the state already marks `shpkg` as installed but the symlink is missing, repair it with:
```sh
cd ~/.aliases
./shpkg install --force shpkg
```

After that, `shpkg` can be executed from any directory:
```sh
cd /tmp
shpkg list
```

### Load Order

```sh
$HOME/.zshrc:
    - ~/.aliases/packages/omz/config
        - $ZSH/oh-my-zsh.sh
    - ~/.aliases/aliases.sh        # Common aliases (works on both)
        - ~/.aliases/colors.sh
        - ~/.aliases/env.sh
    - ~/.aliases/aliases.utils.sh  # Utility functions
    - ~/.aliases/aliases.niri.sh   # Wayland/niri specific (loaded on Wayland)
    - ~/.aliases/aliases.i3.sh     # X11/i3wm specific (loaded on X11)
```

## Package Manager (`shpkg`)

| Command | Description |
|---------|-------------|
| `shpkg install <pkg> [<pkg>...]` | Install one or more packages or groups, skipping installed ones |
| `shpkg install --force <pkg> [<pkg>...]` | Reinstall packages even if already recorded as installed |
| `shpkg list` | List available packages and groups with their installation status |
| `shpkg info <pkg>` | Show package type, status, directory, README and uninstall availability |
| `shpkg --help` | Show usage information |

Installed packages are recorded in `${XDG_STATE_HOME:-$HOME/.local/state}/shpkg/installed`.
`shpkg install` checks this list and skips packages already marked as installed.
Use `--force` (or `-f`) to reinstall them.

`shpkg` discovers packages and groups from the repository:

```text
packages/<name>/install.sh   # package
groups/<name>/install.sh     # group
```

A package or group may also provide `uninstall.sh` and `README.md`. The
`README.md` first heading/line is used as the description in `shpkg list`.

### Interactive Groups

Installing a group opens a `dialog` checklist with all items preselected.
Use space to toggle an item and select `Install` to proceed. Nested groups,
such as `utils` inside `env-i3wm`, appear as a single selectable item.

If stdin/stdout is not a terminal, all items are installed without opening
the checklist. Cancelling the dialog or selecting nothing aborts the
installation without recording the group.

After a partial selection, the group is recorded as installed. Reopen the
checklist later with:
```sh
shpkg install --force env-i3wm
```

If `dialog` is not available, its package is installed automatically before
the checklist is shown.

### Repository Layout

```text
packages/     Individual installable components and their assets
groups/       Compositions that install multiple packages
aliases*.sh   Shared shell aliases/functions loaded by bash/zsh
shpkg         Package manager entrypoint
```

Use `shpkg list` as the authoritative list of packages and groups.

### Usage Examples

**Full i3wm desktop environment:**
```sh
shpkg install env-i3wm
```

**Full niri/Wayland desktop environment:**
```sh
shpkg install env-niri
```

**Headless/server environment:**
```sh
shpkg install aliases vim mail docker
```

**Lightweight install (no GUI):**
```sh
shpkg install light
```

**Install individual packages:**
```sh
shpkg install niri
shpkg install dnsglobe
```

**Reinstall packages already recorded as installed:**
```sh
shpkg install --force niri dnsglobe
```

## Shorthands

### Package Management

| Command | Action |
|---------|--------|
| `install` | Install package via apt |
| `update` | Update packages via apt (includes autoremove) |
| `uninstall` | Uninstall package via apt |
| `find_package` | Use fzf to search packages (apt-cache search) |
| `alias_update` | Updates the alias repository |
| `UPDATE` | Update: aliases repo, ohmyzsh, OS packages |
| `pkg_command` | Show binaries installed by package |
| `command_comes_from` | Show package where binary comes from |

### Navigation Shortcuts

| Command | Action |
|---------|--------|
| `aliases` | Opens the `~/.aliases` directory |
| `downloads`, `dl` | Goes to `~/Downloads` and lists files |
| `workspace`, `ws` | Goes to `~/Projects/` and lists files |
| `wd` | Navigates to `$WORK_DIR` (defined in environment) |

### Config Files

| Command | Action |
|---------|--------|
| `ac` | Edits the main alias file (`~/.aliases/aliases.sh`) |
| `zc` | Edits `.zshrc` |
| `ec` | Edits the env variables file (`~/.aliases/env.sh`) |
| `vc` / `vimconfig` | Edits vim config (`~/.aliases/packages/vim/vimrc`) |
| `nc` | **niri only:** Edits niri config (`~/.config/niri/config.kdl`) |
| `ic` | **i3wm only:** Edits i3 config (`~/.aliases/packages/i3wm/i3/config`) |

### Utilities and General Tools

| Command | Action |
|---------|--------|
| `reload` | Source `~/.zshrc` file |
| `rank` | Counts and sorts duplicate lines (`sort \| uniq -c \| sort -nr`) |
| `du_by_size` | Shows directory/file sizes in current folder (`du -sh ./* \| sort -rh`) |
| `weather` | Shows current weather using `wttr.in` |
| `find_directory`, `cdf` | Finds directories with `fzf` and navigates to them |
| `find_file` | Finds file with `fzf` and preview (batcat), outputs path |
| `ccd <dir>` | Enters `<dir>`, clears terminal, and lists files |
| `mkcd <dir>` | Creates and enters directory if it doesn't exist |
| `calc` | Calculator using `bc` (scale=2) |
| `cat_csv` | Format and show CSV file (supports `--separator`) |
| `str2md5` | Generates MD5 hash from string |
| `hash_dir` | Calculate directory (recursive) SHA256 hash |
| `unixtimestamp2date` | Format unix timestamp to ISO 8601 |
| `ip_info <ip>` | Shows IP information using `ipwho.is` |
| `apex_info <domain>` | Shows subdomains using `crt.name` |
| `explain <cmd>` | Uses AI (Groq) to explain a command |
| `help <cmd>` | Uses `cheat.sh` to show command help |
| `vim_card` | Displays the Vim cheat sheet |
| `rememberme "msg" 5 minutes` | Sends notification after delay using `at` + `notify-send` |
| `cat_from_url` | Uses wget or curl and outputs response |
| `restore_permissions <dir>` | Restore permissions (dirs 755, files 644) |
| `pack <dir>` | Creates a `.tar.gz` archive with timestamp |
| `unpack <file>` | Extracts a `.tar.gz` archive |
| `compress <dir>` | Creates a `.tar.xz` archive with timestamp |
| `uncompress <file>` | Extracts a `.tar.xz` archive |

### Git

| Command | Action |
|---------|--------|
| `s` | Runs `git status -s` |
| `d` | Runs `git diff` |
| `u` | Updates repository using `fetch`, `pull`, and submodules |
| `log` | Runs `git log --oneline` |
| `git_update` | Hard resets to `FETCH_HEAD` and pulls latest (skips if uncommitted) |
| `git_clean_branches` | Removes outdated local branches with confirmation |
| `git_sync_branches` | Syncs branches (default: master, develop) with `origin` |
| `git_delete_branch <branch>` | Deletes both local and remote branches |

### Tmux

| Command | Action |
|---------|--------|
| `tl` | List tmux sessions |
| `tmux_dev <name> <path>` | Create a dev session with editor, docker, git |
| `tmux_copy_buffer` | **Platform-specific:** put tmux buffer to clipboard |
| `cli` | Create or open a tmux session called `cli` |

### Docker

| Command | Action |
|---------|--------|
| `dcu` | Runs `docker compose up -d` |
| `dcub` | Runs `docker compose up -d --build` |
| `dcd` | Runs `docker compose down --volumes` |
| `dpsa` | Runs `docker ps -a` |
| `di` | Lists Docker images |
| `dv` | Lists Docker volumes |
| `dsdf` | Shows disk usage of Docker objects (`docker system df`) |
| `docker_prune` | Removes unused Docker objects (`docker system prune`) |
| `docker_images_size` | Lists images sorted by size |
| `docker_kill_all` | Stops and removes all containers |
| `dps` | Lists containers with name, image, and ports |
| `dpsw` | Also shows Docker Compose working directory |

### Containerized Tools

| Command | Action |
|---------|--------|
| `php` | Runs PHP 8.4 CLI using Docker in current directory |
| `composer` | Runs Composer using Docker in current directory |
| `trans` | Uses Docker image of `translate-shell` |
| `speedtest` | Runs a speed test via Docker |
| `psysh` | Runs PsySH REPL via Docker |
| `simple_server` | HTTP server with Python on port 9000 |
| `static_server` | Nginx server for static files |
| `php56_server` | Apache server with PHP 5.6 |
| `php71_server` | PHP 7.1 server |
| `php72_server` | PHP 7.2 server |
| `php80_server` | PHP 8.0 server |
| `php82_server` | PHP 8.2 server |
| `php80_dev_server` | PHP 8.0 development server |
| `php82_dev_server` | PHP 8.2 development server |
| `php84_dev_server` | PHP 8.4 development server |
| `aws` | Runs AWS CLI via Docker (mounts ~/.aws and pwd) |

### Downloads via aria2

| Command | Action |
|---------|--------|
| `download_magnet <link>` | Downloads magnet links using aria2 |
| `download_torrent <file>` | Downloads `.torrent` files using aria2 |

---

## Utility Aliases (aliases.utils.sh)

These are loaded separately and provide modern replacements for classical tools:

| Command | Action |
|---------|--------|
| `dict` | `sdcv` (StarDict console dictionary) |
| `fd` | Find directory with fzf and cd |
| `calendar` | Dialog-based calendar |
| `aws` | Docker-based AWS CLI (also defined in aliases.sh) |

### Additional Features in aliases.utils.sh

- **FZF History Widget** (Ctrl+R): Enhanced history search with deduplication
- **Improved less settings**: Better colors for man pages and less output
- **AI Functions** (require API keys):
  - `ai` - Groq API (model: openai/gpt-oss-20b)
  - `gemini` - Google Gemini API (model: gemini-2.0-flash)
  - `explain <cmd>` - Explain a command using Groq API

---

## Wayland/niri Specific Aliases (aliases.niri.sh)

Loaded automatically when running on Wayland.

| Command | Action |
|---------|--------|
| `nc` | Edit niri config (`~/.config/niri/config.kdl`) |
| `cc <file>` | Copy file to clipboard (uses `wl-copy`) |
| `lorem <num>` | Lorem ipsum to clipboard (uses `wl-copy`, default 3 sentences) |
| `rememberme "msg" 5m` | Send notification after delay (uses `notify-send` + `at`) |
| `tmux_copy_buffer` | Copy tmux buffer to clipboard (uses `wl-copy`) |

---

## i3wm/Xorg Specific Aliases (aliases.i3.sh)

Loaded automatically when running on X11.

| Command | Action |
|---------|--------|
| `togglekbl` | Toggle keyboard layout (`~/.aliases/packages/i3wm/toggle-kbl.sh`) |
| `ic` | Edit i3 config (`~/.aliases/packages/i3wm/i3/config`) |
| `ik` | Show i3 keybindings in a rofi overlay (`~/.aliases/packages/i3wm/keybinds.sh`) |
| `cc <file>` | Copy file to clipboard (uses `xclip`) |
| `lorem <num>` | Lorem ipsum to clipboard (uses `xclip`, default 3 sentences) |
| `rememberme "msg" 5m` | Send notification after delay (uses `notify-send` + `at`) |
| `tmux_copy_buffer` | Copy tmux buffer to clipboard (uses `xclip`) |

### i3wm keybindings overlay

`Super+Shift+/` (or `ik`) opens a searchable list generated directly from
`~/.aliases/packages/i3wm/i3/config`, equivalent to niri's `Mod+Shift+/` hotkey overlay.

---

## Niri/Wayland Configuration

The niri installation includes a complete desktop configuration:

- **niri**: Window manager configuration with themes, keybinds, layouts, rules
- **waybar**: Status bar with multiple themes
- **fuzzel**: Application launcher with multiple themes
- **mako**: Notification daemon
- **swaybg/swaylock**: Wallpaper and lock screen
- **Themes**: catppuccin_mocha, deep_blue, hardcore, monochrome, nord, vt220

### Theme Switching

```sh
# Switch niri theme
~/.aliases/packages/niri/set_theme.sh --catppuccin_mocha
~/.aliases/packages/niri/set_theme.sh --deep_blue
# etc.
```

### Niri Install Script

The `packages/niri/install.sh` script:
- Downloads and installs niri from a pre-built Debian package (tested on Debian 13/Trixie)
- Verifies all required binaries are installed
- Checks graphics device availability (`/dev/dri`)
- Provides next steps for starting the session

---

## Best Practices

### Check format
```sh
shfmt -d -i 2 <file>
```

If not valid, format using:
```sh
shfmt -i 2 -w <file>
```

### Check script
```sh
shellcheck -e SC2028,SC2148 <file>
```