#!/usr/bin/env bash

# ====================CONFIG THIS =============================== #
export COLOR_01="#401200"           # Black
export COLOR_02="#FF3600"           # Red
export COLOR_03="#FF3600"           # Green
export COLOR_04="#FF3600"           # Yellow
export COLOR_05="#FF3600"           # Blue
export COLOR_06="#FF3600"           # Magenta
export COLOR_07="#FF3600"           # Cyan
export COLOR_08="#FF3600"           # Light gray

export COLOR_09="#FF3600"           # Dark gray
export COLOR_10="#FF3600"           # Light Red
export COLOR_11="#FF3600"           # Light Green
export COLOR_12="#FF3600"           # Light Yellow
export COLOR_13="#FF3600"           # Light Blue
export COLOR_14="#FF3600"           # Light Magenta
export COLOR_15="#FF3600"           # Light Cyan
export COLOR_16="#FF3600"           # White

export BACKGROUND_COLOR="#2B0C00"   # Background Color
export FOREGROUND_COLOR="#FF3600"   # Foreground Color (text)
export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor color
export PROFILE_NAME="prod (mono-red)"
# =============================================================== #







# =============================================================== #
# | Apply Colors
# ===============================================================|#
SCRIPT_PATH="${SCRIPT_PATH:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
PARENT_PATH="$(dirname "${SCRIPT_PATH}")"

bash "${SCRIPT_PATH}/apply-colors.sh"

