{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../common/packages-evocargo.nix
    ../graphics/default.nix
    ./hardware-configuration.nix
  ];

  boot.loader.efi.efiSysMountPoint = "/boot";
  networking.hostName = "thinkpad-nixos";
}
