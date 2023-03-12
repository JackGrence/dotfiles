function rmvenv
  if test "$argv[1]" != ""
    rm -rf "$HOME/.venv/$argv[1]"
  end
end
