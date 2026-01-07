{ lib, config, ... }:
{
  imports = [
    ./hipatterns.nix
    ./files.nix
    ./move.nix
    ./splitjoin.nix
    ./snippets.nix
  ];

  plugins = {
    mini.enable = true;
    mini-ai.enable = true;
    mini-basics.enable = true;
    mini-bracketed.enable = true;
    mini-snippets.enable = true;

    mini-comment = {
      enable = true;
    };

    mini-icons = {
      enable = true;
      mockDevIcons = true;
    };
  };
}
