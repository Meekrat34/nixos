disabledModules = [
    "services/hardware/supergfxd.nix"
    "services/hardware/asusd.nix"
  ];

  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/hardware/supergfxd.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/services/hardware/asusd.nix"
  ];

  services.asusd = {
    # ...
    package = pkgs.unstable.asusctl;
  };
