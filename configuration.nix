{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [ "nix-command" ];
    nix.settings.auto-optimise-store = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    powerManagement.enable = true;    # "stock NixOS power management tool"
    services.thermald.enable = true;  # "prevents overheating on intel cpus"
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PREF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;

        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PREF_POLICY_ON_BAT = "power";
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;
      };
    };

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
        packages = with pkgs; [
            age
            alacritty
            chromium
            entr
            fd
            firefox
            fzf
            ghc
            git
            git-absorb
            gnumake
            graphviz
            helix
            man-pages
            mpv
            ncdu
            nnn
            pandoc
            passage
            peek
            podman-compose
            psmisc
            python3
            qbittorrent
            qrencode
            ranger
            ripgrep
            syncthing
            texlive.combined.scheme-tetex
            tig
            tigervnc
            tree
            unclutter
            vncdo
            w3m
            xarchiver
            xclip
            yt-dlp
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
              runScript = "bash"; 
              extraOutputsToInstall = ["dev"]; }))
        file
        htop
        moreutils
        nix-direnv
        nix-index
        tmux
        unzip
        vim-full
        wget
        zip
    ];

    environment.variables.EDITOR = "vim";

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
    networking.firewall.allowedTCPPorts = [ 8000 ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # (to /run/current-system/configuration.nix)
    system.copySystemConfiguration = true;

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

}

