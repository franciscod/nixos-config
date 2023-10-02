{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [ "nix-command" ];
    nix.settings.auto-optimise-store = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "America/Buenos_Aires";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "tatskrow";
    networking.networkmanager.enable = true;

    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

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

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    # hardware.bluetooth.enable = true;
    # services.blueman.enable = true;

    services.tailscale.enable = true;
    services.avahi.enable = true;

    fonts.fonts = with pkgs; [
        iosevka
        terminus_font_ttf
    ];

    users.users.fd = {
        isNormalUser = true;  # home and stuff, not isSystemuser
        extraGroups = [ "wheel" ];
        shell = pkgs.fish;
        packages = with pkgs; [
            age
            alacritty
            chromium
            fd
            firefox
            fzf
            git
            gnumake
            helix
            man-pages
            mpv
            ncdu
            nnn
            passage
            podman-compose
            python3
            qrencode
            ranger
            ripgrep
            syncthing
            tig
            tigervnc
            tree
            unclutter
            vncdo
            w3m
            xarchiver
            zathura
        ];
    };

    environment.shells = [ pkgs.fish ];
    environment.systemPackages = with pkgs; [
        (let base = pkgs.appimageTools.defaultFhsEnvArgs; in 
            pkgs.buildFHSUserEnv (base // {
              name = "fhs";
              targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [pkgs.pkg-config]; 
              profile = "export FHS=1"; 
              runScript = "fish"; 
              extraOutputsToInstall = ["dev"]; }))
        file
        htop
        moreutils
        nix-direnv
        nix-index
        tmux
        unzip
        vim 
        wget
        zip
    ];
    environment.variables.EDITOR = "vim";

    programs.fish = {
      enable = true;
      shellAliases = {
	ip = "ip -c";
      };
    };
	
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # (to /run/current-system/configuration.nix)
    system.copySystemConfiguration = true;

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

}

