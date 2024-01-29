function nsp --wraps='nix-shell -p' --description 'alias nsp=nix-shell -p'
  nix-shell -p $argv
        
end
