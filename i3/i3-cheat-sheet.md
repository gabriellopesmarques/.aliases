# i3 Window Manager – Custom Keybindings Cheat Sheet

## Concept:
- **Super (Mod4)** is used for **launching programs, executing scripts, system actions (poweroff, change keyboard layout)**.
- **Alt (Mod1)** is used for **window, containers and workspaces management (focus, move, split, layout, etc.)**.

---

## Application Launchers
| Shortcut         | Action                                       |
|------------------|----------------------------------------------|
| `Super+Space`    | Launch `rofi` app launcher (`drun`)          |
| `Super+Return`   | Open terminal (`kitty`)                      |
| `Super+f`        | Launch Firefox                               |
| `Super+w`        | Launch Brave (incognito)                     |
| `Super+s`        | Google "I'm Feeling Lucky" search via Brave  |
| `Super+a`        | Search ChatGPT via Firefox                   |
| `Super+y`        | YouTube search via Brave                     |
| `Super+t`        | Google Translate via Brave                   |
| `Super+k`        | Toggle keyboard layout (`toggle-kbl.sh`)     |

---

## Window Management
| Shortcut                           | Action                         |
|------------------------------------|--------------------------------|
| `Alt+h/j/k/l`                      | Focus left/down/up/right       |
| `Alt+Shift+h/j/k/l`                | Move window left/down/up/right |
| `Alt+q`                            | Kill focused window            |
| `Alt+f`                            | Toggle fullscreen              |
| `Alt+Shift+Space`                  | Toggle floating                |
| `Alt+a`                            | Focus parent container         |
| `Alt+Tab`                          | Next workspace                 |
| `Alt+Shift+Tab`                    | Previous workspace             |

---

## Layout Control
| Shortcut     | Action                     |
|--------------|----------------------------|
| `Alt+v`      | Split vertically           | 
| `Alt+b`      | Split horizontally (bottom)|
| `Alt+s`      | Stacking layout            |
| `Alt+w`      | Tabbed layout              |
| `Alt+e`      | Toggle split layout        |

---

## Workspaces
| Shortcut          | Action                           |
|-------------------|----------------------------------|
| `Alt+{num}`       | Switch to workspace 1–10         |
| `Alt+Shift+{num}` | Move container to workspace 1–10 |

---

## Resize Mode
Enter resize mode:
- `Alt+r`

In Resize Mode:
| Shortcut     | Action                      |
|--------------|-----------------------------|
| `h/l`        | Shrink/grow width           |
| `j/k`        | Grow/shrink height          |
| `Return`     | Exit resize mode            |

---

## System Actions
| Shortcut             | Action                             |
|----------------------|------------------------------------|
| `Super+l`            | Lock screen (i3lock)               |
| `Print`              | Take screenshot (gnome-screenshot) |
| `Alt+Shift+c`        | Reload i3 config                   |
| `Alt+Shift+r`        | Restart i3 inplace                 |
| `Super+Escape`       | Exit i3                            |
| `Super+Shift+Escape` | Shutdown system                    |

