#!/bin/bash
i3-msg 'workspace 1; exec firefox --new-window https://app.todoist.com/app/today' && sleep 2
i3-msg 'workspace 2; exec kitty'
