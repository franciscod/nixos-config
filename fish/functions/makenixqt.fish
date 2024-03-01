function makenixqt --wraps=nix-build\ -E\ \'with\ import\ \<nixpkgs\>\ \{\}\;\ libsForQt5.callPackage\ ./default.nix\ \{\}\' --description alias\ makenixqt=nix-build\ -E\ \'with\ import\ \<nixpkgs\>\ \{\}\;\ libsForQt5.callPackage\ ./default.nix\ \{\}\'
  nix-build -E 'with import <nixpkgs> {}; libsForQt5.callPackage ./default.nix {}' $argv
        
end
