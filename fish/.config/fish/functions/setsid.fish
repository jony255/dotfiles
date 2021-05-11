function setsid --wraps=asdf --description 'call setsid then exit the terminal'
  command setsid $argv && exit
end
