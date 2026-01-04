{ config, pkgs, ... }:

{
  home.username = "rpamirov";
  home.homeDirectory = "/home/rpamirov";
  home.stateVersion = "25.11"; # Do not change carelessly.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nordzy-cursor-theme
  ];
    # # Adds the 'hello' command to your environment. It prints a friendly
    # pkgs.hello
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  home.pointerCursor.enable = false;
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
    btw = "echo nixos by the way";
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ruslan Amirov";
        email = "ruslan.amirov@pm.me";
        };
      init.defaultBranch = "main";
      };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
  
    cursorTheme = {
      name = "Nordzy-cursors";
      size = 24;
      package = pkgs.nordzy-cursor-theme;
    };
  };

  xdg.configFile."wofi/style.css".source = ./dotfiles/wofi/style.css;
  xdg.configFile."hypr".source = ./dotfiles/hypr;
  xdg.configFile."kitty".source = ./dotfiles/kitty;
  xdg.configFile."waybar".source = ./dotfiles/waybar;
}
