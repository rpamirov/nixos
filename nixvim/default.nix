{ lib, ... }:

{
  config = {
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
    };
    colorschemes.nord = {
      enable = true;
      settings = {
        borders = true;
        contrast = true;
        disable_background = false;
      };
    };
    globals.mapleader = " ";
    plugins = {
      treesitter.enable = true;
      telescope.enable = true;
      web-devicons.enable = true;
      gitgutter.enable = true;
    };
    lsp = {
      enable = true;
      servers = {
        pyright.enable = true;
        nix.enable = true;
      };
    };
  };
}
