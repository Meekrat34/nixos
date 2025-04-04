# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }: let
    nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");

in {

  # Imported nix configuration files need to be listed here
    imports = [
      ./hardware-configuration.nix          # Main import for hardware
      <nixos-hardware/asus/zephyrus/ga503>  # Include settings for this laptop
      ./ga503/nvidiagpu.nix                   # For Nvidia GPU
      ./apps.nix                            # This is for applications
     # nix-gaming.nixosModules.<modulename>  # Have not picked one yet, but preped in case.
    ];



  # end of imports

  # SC stuff
  ##
  ##	Need to make seperate nix files for individual games like this
  ##	 Keep this config for system stuff
  
      nix.settings = {
          substituters = ["https://nix-citizen.cachix.org"];
          trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
      };





  # Enable bluetooth
      services.blueman.enable = true;
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.Policy.AutoEnable = "true";
      };

  # Enable appimage support
      programs.appimage.enable = true;
      programs.appimage.binfmt = true;


  # Limit Generations
    nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };

  # Boot settings.

      boot = {
	blacklistedKernelModules = [ "nouveau" ];
        #blacklistedKernelModules = [ "nouveau" "nvidia_drm" "nvidia_modeset" "nvidia" ];
        loader.systemd-boot.enable = true;
        crashDump.enable = true;
        loader.efi.canTouchEfiVariables = true;
        loader.systemd-boot.consoleMode = "2";
        kernelPackages = pkgs.linuxPackages_6_12;     # Use linux kernel 6.11.*
                                                      # ( nvidia driver did not rebuild with 6.13 )
        #kernelPackages = pkgs.linuxPackages_latest;

      kernel.sysctl = {
        "vm.max_map_count" = 16777216;
        "fs.file-max" = 524288;
        };
      };

      #boot.extra_boot_scripts = ''
      #  nix-store-gc --check
      #'';


  # Networking Stuff
    networking.hostName = "Ganymede";
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 443 8096 ];



  # Set your time zone.
    time.timeZone = "America/Chicago";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

  # Enable the X11 windowing system. You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

  # Enable 3D Graphics ###################################### 3d Graphics Section ##############
  # Placed in ../ga503/nvidiagpu.nix

  # Enable the KDE Plasma Desktop Environment.
    
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true; # lxqt

    #services.xserver.displayManager.gdm.enable = true;
    #services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

  # Enable CUPS to print documents.
    services.printing.enable = true;

  # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      };

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.dave = {
      isNormalUser = true;
      description = "Dave";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      #  thunderbird
      ];
    };

  # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

### ENVRONMENT ####



  # install packages
  environment.systemPackages = [ # or home.packages
    nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen

  ];





#};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

# *********** DO NOT CHANGE THE NUMBER BELOW HERE  ****************
  system.stateVersion = "24.11"; # Did you read the comment?

}
