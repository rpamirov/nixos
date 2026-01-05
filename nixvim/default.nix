{ lib, ... }:

{
  options = {
    number = true;
    relativenumber = true;
    expandtab = true;
    shiftwidth = 2;
  };

  globals.mapleader = " ";
  colorschemes.nord.enable = true;

  plugins = {
    treesitter.enable = true;
    telescope.enable = true;
    gitgutter.enable = true;
    lsp = {
      enable = true;
      servers = {
        pyright.enable = true;
      };
    };
  };
}

