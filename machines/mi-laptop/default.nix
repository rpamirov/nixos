{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../graphics/nvidia-common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "mi-nixos";
  hardware.nvidia = {
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      # IMPORTANT: These bus IDs are hardware-specific!
      # You might want to make them configurable
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
