if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "Dracula Official"

    if set -q ZELLIJ_CONTAINER_TARGET
        set -l target_dir (docker exec coding-agent-$ZELLIJ_CONTAINER_TARGET cat /tmp/zellij_current_pane_dir.txt 2>/dev/null; or echo "/tmp")
        # If a Zellij layout set a container target, bypass the host and jump into Docker
        exec docker exec -it -e COLUMNS=(tput cols) -e LINES=(tput lines) \
            -w "$target_dir" -u ubuntu coding-agent-$ZELLIJ_CONTAINER_TARGET fish
    end
end
