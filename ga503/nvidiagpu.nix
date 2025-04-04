{ config, pkgs, ... }: {
# Enable Discrete

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
      };
  };


  hardware.graphics = {
    enable = true;
    };

  # Load nvidia driver for Xorg and Wayland
  #services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
  
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    #package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #  version = "570.86.16"; # use new 570 drivers
    #  sha256_64bit = "sha256-RWPqS7ZUJH9JEAWlfHLGdqrNlavhaR1xMyzs8lJhy9U=";
    #  openSha256 = "sha256-DuVNA63+pJ8IB7Tw2gM4HbwlOh1bcDg2AN2mbEU9VPE=";
    #  settingsSha256 = "sha256-9rtqh64TyhDF5fFAYiWl3oDHzKJqyOW3abpcf2iNRT8=";
    #  usePersistenced = false;
    #};



    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #package = config.boot.kernelPackages.nvidiaPackages.stable;
  #package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Fixes a glitch
    #nvidiaPersistenced = true;

    # Required for amdgpu and nvidia gpu paired
    # Modesetting is required.
    modesetting.enable = true;



  prime = {

    # Make sure to use the correct Bus ID values for your system!
    # sync.enable = true; # cannot use with offload enabled
    amdgpuBusId = "PCI:7:0:0";
    nvidiaBusId = "PCI:1:0:0";

    };
};
}
