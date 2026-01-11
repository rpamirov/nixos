{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../common/packages-evocargo.nix
    ../graphics/default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "thinkpad-nixos";
}
