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
    # Formatters
    stylua # Lua formatter
    nixfmt-rfc-style # Nix formatter
    # Linters
    shellcheck # Shell script linter
    # Debuggers
    gcc
  ];
}
