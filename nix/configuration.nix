# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # System settings 
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  time.timeZone = "Europe/Moscow";
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "caps:escape,grp:alt_shift_toggle";
  services.printing.enable = true;
  services.getty.autologinUser = "rpamirov";
  services.displayManager.autoLogin = {
    enable = true;
    user = "rpamirov";
  };

   # NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];
  hardware.graphics.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
    nvidiaSettings = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      # IMPORTANT: correct bus IDs
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
 
  # Sound.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  users.users.rpamirov = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  #Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

# for normal waybar work
  services.power-profiles-daemon.enable = true;
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.victor-mono
    ];
};

# System packages for all users
  environment.systemPackages = with pkgs; [
    tmux
    zellij
    jq
    vim
    bat
    git
    lazygit
    neovim
    wget
    kitty
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    brightnessctl
    telegram-desktop
    networkmanagerapplet
    swaynotificationcenter
    waybar
    wofi
    yazi
    fzf
    fd
    ripgrep
    nautilus
    viewnior
    nordic
    nwg-look
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Do NOT change this value
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
}
