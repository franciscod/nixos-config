switch (uname)
case Linux
  function open --wraps=xdg-open --description 'alias open=xdg-open'
    xdg-open $argv
  end
end
