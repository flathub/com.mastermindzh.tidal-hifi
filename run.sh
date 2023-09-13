#!/bin/sh
# Discord RPC
for i in {0..9}; do
    test -S $XDG_RUNTIME_DIR/discord-ipc-$i || ln -sf {app/com.discordapp.Discord,$XDG_RUNTIME_DIR}/discord-ipc-$i;
done

declare -a EXTRA_FLAGS=()

# Display Socket
if [[ $XDG_SESSION_TYPE == "wayland" ]]
then
    WAYLAND_SOCKET=${WAYLAND_DISPLAY:-"wayland-0"}

    if [[ -e "$XDG_RUNTIME_DIR/${WAYLAND_SOCKET}" ]]
    then
        echo "Wayland socket is available, running natively on Wayland."
        echo "To disable, remove the --socket=wayland permission."
        EXTRA_FLAGS+=(--ozone-platform=wayland)
    else
        echo "Wayland socket not available, running through Xwayland."
    fi
    if [[ -c /dev/nvidia0 ]]
    then
        echo "Using NVIDIA on Wayland, applying workaround"
        EXTRA_FLAGS+=(--disable-gpu-sandbox)
    fi

fi

cd /app/lib/tidal-hifi
exec TMPDIR=$XDG_CACHE_HOME zypak-wrapper ./tidal-hifi "${EXTRA_FLAGS[@]}" "$@"
