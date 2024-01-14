#!/usr/bin/env bash

if [ "$(pgrep tmux)" ] && [ "$RES_SAVE_PATH" ]; then
	$RES_SAVE_PATH quiet
fi
