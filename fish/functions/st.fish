function st
  read -lP "Please enter session name: " session

  if test -z $session
    set session (cat /dev/urandom | tr -dc 'a-z' | fold -w 3 | head -n 1)
  end

  if ! test -z $TMUX
    echo 'Already in tmux! Please detach current session.'
    return
  end

  echo 'Create session: '$session

  # set up tmux
  tmux start-server

  # create a new tmux session, starting vim from a saved session in the new window
  tmux new-session -d -s $session -n Develop

  # create a new window called Output
  tmux new-window -t $session -n Output

  # create a new window called Debug
  tmux new-window -t $session -n Debug

  # return to main vim window
  tmux select-window -t $session:1

  # Finished setup, attach to the tmux session!
  tmux attach-session -t $session 
end
