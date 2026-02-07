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
    - ~/.aliases/aliases.sh
        - ~/.aliases/env.sh
    - ~/.aliases/oh-my-zsh/config
        - $ZSH/oh-my-zsh.sh
    - ~/.aliases/aliases.utils.sh
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
| `ac`              | Edits the alias files.                                  |
| `zc`              | Edits `.zshrc`.                                         |
| `ic`              | Edits `i3.conf`.                                        |
| `ec`              | Edits the env variables file. `~/.aliases/env.sh`       |
| `vc`              | Edits `vimrc`.                                          |

### Utilities and General Tools

| Command                     | Action                                                  |
| --------------------------- | ------------------------------------------------------- |
| `reload`                    | source `~/.zshrc` file                                  |
| `rank`                      | Counts and sorts duplicate lines.                       |
| `du_by_size`                | Shows directory/file sizes in the current folder.       |
| `weather`                   | Shows current weather using `wttr.in`.                  |
| `togglekbl`                 | Toggles keyboard layout using a custom script.          |
| `find_directory`, `cdf`     | Finds directories with `fzf` and navigates to them.     |
| `find_file`                 | Finds file with `fzf` and navigates to them.            |
| `ccd <dir>`                 | Enters `<dir>`, clears the terminal, and lists files.   |
| `mkcd <dir>`                | Creates and enters the directory if it doesn’t exist.   |
| `cc <file>`                 | Copies file contents to the clipboard.                  |
| `calc`                      | Calculator using `bc`.                                  |
| `str2md5`                   | Generates a md5 from string.                            |
| `ip_info <ip>`              | Shows IP information using `ipwho.is`.                  |
| `lorem <num>`               | Copies Lorem Ipsum text (5 sentences) to the clipboard. |
| `explain <cmd>`             | Opens `explainshell.com` in `w3m`.                      |
| `help <cmd>`                | Uses `cheat.sh` to show command help.                   |
| `vim_card`                  | Displays the Vim cheat sheet.                           |
| `rememberme "msg" 5 minutes`| Sends a notification after a delay using `at`.          |
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
| `tmux_copy_buffer`       | put tmux buffer to clipboard                    |
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


