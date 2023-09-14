grab:
	cp /etc/nixos/configuration.nix .

apply:
	sudo configuration.nix /etc/nixos/configuration.nix
	sudo nixos-rebuild switch

