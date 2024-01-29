function makenix --wraps=nix-build\ -E\ \'with\ import\ \<nixpkgs\>\ \{\}\;\ callPackage\ ./default.nix\ \{\}\' --description alias\ makenix=nix-build\ -E\ \'with\ import\ \<nixpkgs\>\ \{\}\;\ callPackage\ ./default.nix\ \{\}\'
  nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}' $argv
        
end
