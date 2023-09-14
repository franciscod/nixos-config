grab:
	cp /etc/nixos/configuration.nix .

apply:
	sudo cp configuration.nix /etc/nixos/configuration.nix
	sudo nixos-rebuild switch

