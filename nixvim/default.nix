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
  ];
}
