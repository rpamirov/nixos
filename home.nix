{ config, pkgs, ... }:
let
  statusbar = import ./dotfiles/zellij/statusbar.nix { inherit pkgs config; };
  layout = import ./dotfiles/zellij/layout.nix { inherit statusbar; };
in
{
  home.username = "rpamirov";
  home.homeDirectory = "/home/rpamirov";
  home.stateVersion = "25.11"; # Do not change carelessly.
  home.packages = with pkgs; [
    nordzy-cursor-theme
  ];
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
  #SHELL
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      eval "$(starship init zsh)"
      # Ignore heavy / useless dirs for completion
      zstyle ':completion:*' ignored-patterns \
        '.git' \
        '.direnv' \
        '.cache' \
        '.local' \
        '.nix-profile' \
        '.nix-defexpr' \
        '.nix-channels' \
        'node_modules' \
        'result' \
        'dist' \
        'build'
      # FZF: ignore nix + system trash
      export FZF_DEFAULT_COMMAND="
        fd --type f --hidden --follow \
        --exclude .git \
        --exclude .cache \
        --exclude .local \
        --exclude .nix-profile \
        --exclude .nix-defexpr \
        --exclude .nix-channels \
        --exclude node_modules \
        --exclude result
      "
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="fd --type d --hidden --follow \
        --exclude .git \
        --exclude .cache \
        --exclude .local \
        --exclude .nix-profile \
        --exclude .nix-defexpr \
        --exclude .nix-channels \
        --exclude node_modules \
        --exclude result"
      export FZF_DEFAULT_OPTS="
        --preview 'bat --style=numbers --color=always --line-range :300 {}'
        --preview-window=right:60%:wrap
      "
    '';
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
    };
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
      }
    ];
    shellAliases = {
      zj = "zellij $@";
      y = "yazi $@";
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
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

  programs.nixvim = {
    enable = true;
    imports = [
      ./nixvim
    ];
  };
  programs.zen-browser.enable = true;

  #CONFIGS
  xdg.configFile."wofi/style.css".source = ./dotfiles/wofi/style.css;
  xdg.configFile."hypr".source = ./dotfiles/hypr;
  xdg.configFile."kitty".source = ./dotfiles/kitty;
  xdg.configFile."waybar".source = ./dotfiles/waybar;
  xdg.configFile."starship.toml".source = ./dotfiles/starship.toml;
  xdg.configFile."rg".source = ./dotfiles/rg;
  xdg.configFile."tmux/tmux.conf".source = ./dotfiles/tmux/tmux.conf;
  xdg.configFile."zellij/config.kdl".source = ./dotfiles/zellij/config.kdl;
  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source =
    ./dotfiles/zellij/plugins/autolock.wasm;
  xdg.configFile."zellij/layouts/default.kdl".text = layout;
}
