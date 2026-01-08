{ pkgs, ... }:
{
  enableMan = false;
  imports = [
    ./settings.nix
    ./keymaps.nix
    ./plugins
  ];

  extraPackages = with pkgs; [
    ripgrep
    lazygit
    fzf
    fd
    gh
    wordnet # blinc completion
    stylua # Lua formatter
    nixfmt-rfc-style # Nix formatter
    shellcheck # Shell script linter
    gcc
  ];
}
