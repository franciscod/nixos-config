{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [ "nix-command" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "America/Buenos_Aires";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "tatskrow";
    networking.networkmanager.enable = true;

    services.xserver.enable = true;
    services.xserver.layout = "us";
    services.xserver.xkbVariant = "altgr-intl";

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    services.xserver.libinput.enable = true;

    services.xserver.desktopManager.xfce.enable = true;

    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "fd";
    services.xserver.displayManager.defaultSession = "xfce";
    services.xserver.displayManager.lightdm.enable = true;

    users.users.fd = {
        isNormalUser = true; # TODO: ???
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
            # TODO: user vs sys packages?
            alacritty
            fd
            firefox
            git
            gnumake
            helix
            ncdu
            ranger
            ripgrep
            tig
            tree
            w3m
        ];
    };

    environment.systemPackages = with pkgs; [
        nix-index
        vim 
        wget
        tmux
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # TODO: Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # TODO: ???
    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

}

