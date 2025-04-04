{ config, pkgs, ... }: {

### This file is for favorite software

 # Install programs.
  programs.firefox.enable = false;
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  #programs.java.enable = true;  ## Only needed for Oracle setup, not Open
  #programs.virtualbox.enable = true;
  programs.rog-control-center.enable = true;
  services.jellyfin.enable = true;
  #networking.firewall.enable = false;
  # Enable virtualbox.
  #virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  programs.git.config = {
    enable = true;
    userName = "Meekrat34";
    userEmail = "dhebard@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Enable the Oracle Extension Pack.
  nixpkgs.config.virtualbox.enableExtensionPack = true;

environment.variables.LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [libxkbcommon];


environment.systemPackages = with pkgs; [

 # Needed tools
    wget
    btop
    ncdu
    mc
    blueman
    git
    pciutils
    nix-diff
    lshw
    cabextract
    unzip
    curl
    neofetch
    gparted
    mesa-demos
    mkvtoolnix
    #opensnitch
    zathura
    heroic
    syncthing
    nmap
    ipscan
    warp-terminal

    # Game related
    pkgs.prismlauncher # Minecraft
    lutris            # Star Citizen


 # Useful apps
    wine
    timeshift
    libreoffice
    gimp
    varia
    virtualbox
    ksystemlog
    home-manager
    firefox
    jdk
    smartmontools
    yt-dlp
    vlc
    tartube-yt-dlp
    testdisk
    nvtopPackages.full
    emacs
    sublime
    alacritty
    amp

    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg



  ];

  }
