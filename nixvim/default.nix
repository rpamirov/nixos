{ pkgs, ... }:
{
  extraConfigLuaPre = ''
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  '';
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
