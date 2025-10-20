function grepsrc
  grep --exclude=tags --exclude-dir=build -rn $argv
end
