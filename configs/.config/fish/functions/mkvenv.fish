function mkvenv
  if test "$argv[1]" != ""
    python3 -m venv "$HOME/.venv/$argv[1]"
  end
end
