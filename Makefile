apply:
	sudo cp configuration.nix /etc/nixos/configuration.nix
	sudo nixos-rebuild switch

grab:
	cp /etc/nixos/configuration.nix .

update:
	sudo nix-channel --update

cleanup:
	sudo nix-collect-garbage --delete-older-than 14d

iso:
	NIXPKGS_ALLOW_UNFREE=1 nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
