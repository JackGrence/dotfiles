function hideps
  function fish_prompt
    echo '$ '
  end
  function fish_right_prompt
    echo ''
  end
end

function unhideps
  source ~/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish
  source ~/.local/share/omf/themes/bobthefish/functions/fish_right_prompt.fish
end
