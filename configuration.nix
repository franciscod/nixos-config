{ config, pkgs, ... }:
let
  RTMP_PORT = 2463;
in
{
    imports = [
        ./hardware-configuration.nix

    #     ((builtins.fetchGit {
    #       url = "https://github.com/symphorien/nixseparatedebuginfod.git";
    #       rev = "466110a37e11a33a3551b44d9da5e323a8924cfa";
    #     }) + "/module.nix")

    ];

    # services.nixseparatedebuginfod.enable = true;

    nix.settings.experimental-features = [ "nix-command" ];
    nix.settings.auto-optimise-store = true;

    boot.kernelPackages = pkgs.linuxPackages_zen;
    # boot.kernelPackages = pkgs.linuxPackages-rt;

    boot.kernelParams = [ "modprobe.blacklist=dvb_usb_rtl28xxu" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 7;
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
    # hardware.pulseaudio.enable = true;

    # pipewire
    # rtkit is optional but recommended
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.xserver.libinput.enable = true;

    services.xserver.desktopManager.xfce.enable = true;

    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "fd";
    services.xserver.displayManager.defaultSession = "xfce";
    services.xserver.displayManager.lightdm.enable = true;

    services.unclutter.enable = true;
    services.unclutter.timeout = 5;

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    hardware.rtl-sdr.enable = true;
    services.udev.packages = [ pkgs.rtl-sdr ];

    services.tailscale.enable = true;
    services.avahi.enable = true;

    services.flatpak.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    fonts.packages = with pkgs; [
        iosevka
        terminus_font_ttf
    ];

    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    users.users.fd = {
        useDefaultShell = true;
        isNormalUser = true;  # home and stuff, not isSystemuser
        extraGroups = [ "wheel" "dialout" "plugdev" ];
        packages = with pkgs; [
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
        acpi
        age
        alacritty
        audacity
        avalonia-ilspy
        chromium
        clang
        clang-tools # for clangd
        csdr
        cubicsdr
        cmake
        croc
        delta
        difftastic
        dmenu
        dotnet-sdk
        # dotnet-sdk-6
        dump1090
        entr
        fd
        file
        firefox
        fish
        fx
        fzf
        ghc
        gimp
        git
        git-absorb
        gnumake
        gnumeric
        goaccess
        graphviz
        gqrx
        helix
        htop
        jq
        libyaml
        lldb
        man-pages
        meson
        mono
        moreutils
        mpv
        ncdu
        neovim
        ninja
        nix-direnv
        nix-index
        nodejs
        nq
        obs-studio
        p7zip
        pandoc
        passage
        pavucontrol
        pdfslicer
        peek
        pkg-config
        podman-compose
        psmisc
        python3
        qbittorrent
        qrencode
        ranger
        ripgrep
        rtl_433
        rtl-sdr
        ruby
        rwc
        snooze
        syncthing
        texlive.combined.scheme-tetex
        tig
        tigervnc
        tmux
        tree
        unclutter
        unzip
        urh
        usbutils
        vim-full
        # vncdo
        w3m
        wireguard-tools
        wget
        xarchiver
        xclip
        xdotool
        xe
        xfce.xfce4-pulseaudio-plugin
        xonotic
        xorg.xkill
        yt-dlp
        zathura
        zig
        zip
        zls
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

    system.userActivationScripts = {
      rfkillUnblockWlan = {
        text = ''
        rfkill block bluetooth
        '';
        deps = [];
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

