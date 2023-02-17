function sshreg
  eval (ssh-agent -c)
  set -l keys (file ~/.ssh/* | grep 'private key' | awk -F':' '{print $1}')
  echo $keys
  ssh-add $keys
end
