{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # System settings
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
    extraGroups = [
      "wheel"
      "video"
    ];
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

  # ZED-editor
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    ruff
  ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  services.power-profiles-daemon.enable = true;
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.victor-mono
      paratype-pt-sans
      paratype-pt-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "PT Sans" ];
        serif = [ "PT Serif" ];
      };
    };
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
    zed-editor
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
}
