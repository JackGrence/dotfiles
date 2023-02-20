if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ------------- pyenv -------------

pyenv init - | source


# Restart your shell for the changes to take effect.

status --is-interactive; and pyenv virtualenv-init - | source
