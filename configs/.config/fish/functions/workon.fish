function workon
  if test "$argv[1]" != ""
    source "$HOME/.venv/$argv[1]/bin/activate.fish"
  end
end
