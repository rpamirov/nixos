{ pkgs, ... }:
{
  enableMan = false;
  imports = [
    ./settings.nix
    ./plugins
  ];

  extraPackages = with pkgs; [
    ripgrep
    lazygit
    fzf
    fd
  ];
}
