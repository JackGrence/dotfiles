# for fish user
# create sss.fish with:
# function sss
#   lazy_cmd sss $argv[1]
# end
# create ccc.fish with:
# function ccc
#   lazy_cmd ccc $argv[1]
# end

function lazy_cmd
  if not test -e ~/lazy_cmd.py
    wget https://gist.githubusercontent.com/JackGrence/43e03fe9354d05bd276afea073ea4683/raw/lazy_cmd.py -O ~/lazy_cmd.py
  end
  if not test -e ~/lazy_cmd.toml
    wget https://gist.githubusercontent.com/JackGrence/43e03fe9354d05bd276afea073ea4683/raw/lazy_cmd.toml -O ~/lazy_cmd.toml
  end
  if test "$argv[2]" = ""
    python3 ~/lazy_cmd.py ~/lazy_cmd.toml $argv[1]
  else
    set -l cmd (python3 ~/lazy_cmd.py ~/lazy_cmd.toml $argv)
    eval $cmd
  end
end