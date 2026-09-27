if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "Dracula Official"

    if set -q ZELLIJ_SESSION_NAME; and docker container inspect "$ZELLIJ_SESSION_NAME" >/dev/null 2>&1
        set -l pane_dir_file "/tmp/zellij-$ZELLIJ_SESSION_NAME-"(zellij action current-tab-info -j | jq .tab_id)"-dir.txt"
        set -l target_dir (docker exec -e zellij_pane_dir="$pane_dir_file" -u ubuntu "$ZELLIJ_SESSION_NAME" \
          bash -c 'DIR="$(cat "$zellij_pane_dir" 2>/dev/null)"; [ -d "$DIR" ] && echo "$DIR" || echo "$HOME"')
        # If the Zellij session matches a container, jump into Docker
        exec docker exec -it -e COLUMNS=(tput cols) -e LINES=(tput lines) \
            -e TERM=$TERM -e zellij_pane_dir="$pane_dir_file" -w "$target_dir" -u ubuntu \
            --detach-keys="ctrl-@,ctrl-]" "$ZELLIJ_SESSION_NAME" fish
    end
end
