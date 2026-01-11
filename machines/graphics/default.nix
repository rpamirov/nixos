{ config, lib, pkgs, ... }:

{
  # Minimal graphics setup for machines without NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];
}
