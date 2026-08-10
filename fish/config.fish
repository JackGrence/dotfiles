if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "Dracula Official"

    if set -q ZELLIJ_CONTAINER_TARGET
        set -l target_dir (docker exec -u ubuntu coding-agent-$ZELLIJ_CONTAINER_TARGET \
          bash -c 'DIR="`cat /tmp/zellij_current_pane_dir.txt 2>/dev/null`"; [ -d "$DIR" ] && echo $DIR || echo $HOME')
        # If a Zellij layout set a container target, bypass the host and jump into Docker
        exec docker exec -it -e COLUMNS=(tput cols) -e LINES=(tput lines) \
            -e TERM=$TERM -w "$target_dir" -u ubuntu \
            --detach-keys="ctrl-@,ctrl-]" coding-agent-$ZELLIJ_CONTAINER_TARGET fish
    end
end
