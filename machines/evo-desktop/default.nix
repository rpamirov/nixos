{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../common/packages-evocargo.nix
    ../graphics/nvidia-common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "rpamirov-nixos";
}
