function grepfs
  grep --exclude-dir=proc --exclude-dir=sys --exclude-dir=dev -rn $argv 
end
