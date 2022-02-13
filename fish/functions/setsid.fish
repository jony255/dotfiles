function setsid --wraps=setsid --description 'call setsid then exit the terminal'
  command setsid $argv && exit
end
