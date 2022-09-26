#!/usr/bin/env bash

# ====================CONFIG THIS =============================== #
export COLOR_01="#000000"           # Black
export COLOR_02="#0BFF00"           # Red
export COLOR_03="#0BFF00"           # Green
export COLOR_04="#0BFF00"           # Yellow
export COLOR_05="#0BFF00"           # Blue
export COLOR_06="#0BFF00"           # Magenta
export COLOR_07="#0BFF00"           # Cyan
export COLOR_08="#0BFF00"           # Light gray

export COLOR_09="#0BFF00"           # Dark gray
export COLOR_10="#0BFF00"           # Light Red
export COLOR_11="#0BFF00"           # Light Green
export COLOR_12="#0BFF00"           # Light Yellow
export COLOR_13="#0BFF00"           # Light Blue
export COLOR_14="#0BFF00"           # Light Magenta
export COLOR_15="#0BFF00"           # Light Cyan
export COLOR_16="#0BFF00"           # White

export BACKGROUND_COLOR="#000000"   # Background Color
export FOREGROUND_COLOR="#0BFF00"   # Foreground Color (text)
export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor color
export PROFILE_NAME="oldSchool (mono-green)"
# =============================================================== #







# =============================================================== #
# | Apply Colors
# ===============================================================|#
SCRIPT_PATH="${SCRIPT_PATH:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
PARENT_PATH="$(dirname "${SCRIPT_PATH}")"

bash "${SCRIPT_PATH}/apply-colors.sh"

