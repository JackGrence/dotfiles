alias sshreg='eval $( ssh-agent -s ) && ssh-add ~/.ssh/github'
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias starttmux='eval "$(curl -sL https://gist.githubusercontent.com/JackGrence/8c1407442faf21aa58fe5ea37cdfb566/raw/f2688e6e696e535a43a109755da7b3478aca2b25/starttmux.sh)"'
alias hideps='PROMPT_COMMAND=""; PS1="\e[92m$ \e[0m"'
alias unhideps='PROMPT_COMMAND="_update_ps1;"'
