apply: copy rebuild
upgrade: update apply
full: upgrade cleanup

copy:
	sudo cp configuration.nix /etc/nixos/configuration.nix

rebuild:
	sudo nixos-rebuild switch

grab:
	cp /etc/nixos/configuration.nix .

update:
	sudo nix-channel --update

clean: cleanup
gc: cleanup
cleanup:
	sudo nix-collect-garbage --delete-older-than 14d

iso:
	NIXPKGS_ALLOW_UNFREE=1 nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix

channel-distupgrade:
	sudo nix-channel --add https://channels.nixos.org/nixos-24.11 nixos
