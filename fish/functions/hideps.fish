function hideps
  function fish_prompt
    echo '$ '
  end
  function fish_right_prompt
    echo ''
  end
end

function unhideps
  fish_config prompt choose default
end
