{ config, pkgs, ... }:
let
  RTMP_PORT = 2463;
in
{
    imports = [
        ./hardware-configuration.nix
        ((builtins.fetchGit {
          url = "https://github.com/symphorien/nixseparatedebuginfod.git";
          rev = "466110a37e11a33a3551b44d9da5e323a8924cfa";
        }) + "/module.nix")
    ];
    services.nixseparatedebuginfod.enable = true;

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

        START_CHARGE_THRESH_BAT0 = 83;
        STOP_CHARGE_THRESH_BAT0  = 89;

        START_CHARGE_THRESH_BAT1 = 83;
        STOP_CHARGE_THRESH_BAT1  = 89;
      };
    };
    networking.hostName = "tatskrow";

    time.timeZone = "America/Buenos_Aires";
    i18n.defaultLocale = "en_US.UTF-8";

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

    # alsa
    # sound.enable = true;

    # pulse 
    hardware.pulseaudio.enable = true;

    # TODO: how to get pipewire + xfce pulse plugin? or something that handles volume media keys
    # # pipewire
    # # rtkit is optional but recommended
    # security.rtkit.enable = true;
    # services.pipewire = {
    #   enable = true;
    #   alsa.enable = true;
    #   alsa.support32Bit = true;
    #   pulse.enable = true;
    #   # If you want to use JACK applications, uncomment this
    #   #jack.enable = true;
    # };

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

    services.flatpak.enable = true;
    
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    fonts.fonts = with pkgs; [
        iosevka
        terminus_font_ttf
    ];

    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    users.users.fd = {
        useDefaultShell = true;
        isNormalUser = true;  # home and stuff, not isSystemuser
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
            age
            alacritty
            dmenu
            entr
            fd
            fx
            fzf
            ghc
            gimp
            git
            git-absorb
            gnumake
            goaccess
            graphviz
            helix
            jq
            libyaml
            man-pages
            mono
            mpv
            ncdu
            nnn
            nq
            obs-studio
            p7zip
            pandoc
            passage
            pdfslicer
            peek
            podman-compose
            psmisc
            python3
            qbittorrent
            ranger
            ripgrep
            ruby
            rwc
            snooze
            subdl
            syncthing
            texlive.combined.scheme-tetex
            tig
            tigervnc
            tree
            vncdo
            w3m
            xarchiver
            xclip
            xdotool
            xe
            # xfce.xfce4-pulseaudio-plugin  # xfce.nix looks for pulse to include this
            xonotic
            xorg.xkill
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
              runScript = "fish"; 
              extraOutputsToInstall = ["dev"]; }))
        chromium
        file
        firefox
        fish
        htop
        moreutils
        nix-direnv
        nix-index
        tmux
        qrencode
        unclutter
        unzip
        vim-full
        wget
        zip
    ];

    environment.variables = {
      EDITOR = "vim";
      MOZ_USE_XINPUT2 = "1";
    };

    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };

    services.nginx = {
      enable = true;
      additionalModules = [ pkgs.nginxModules.rtmp ];
      appendConfig = ''
        rtmp {
          server {
            listen ${builtins.toString RTMP_PORT};
            chunk_size 4096;

            application cine {
              live on;
              record off;
            }
          }
        } 
      '';
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 8000 RTMP_PORT ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # (to /run/current-system/configuration.nix)
    system.copySystemConfiguration = true;

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

}

