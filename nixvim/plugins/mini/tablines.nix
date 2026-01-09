{ config, lib, ... }:
{
  plugins.mini-tabline.enable = true;

  keymaps = lib.mkIf config.plugins.mini-tabline.enable [
    # Next / previous tab
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>tabnext<CR>";
      options.desc = "Next tab";
    }
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>tabprevious<CR>";
      options.desc = "Previous tab";
    }

    # Alternative (Vim-style)
    {
      mode = "n";
      key = "]t";
      action = "<cmd>tabnext<CR>";
      options.desc = "Next tab";
    }
    {
      mode = "n";
      key = "[t";
      action = "<cmd>tabprevious<CR>";
      options.desc = "Previous tab";
    }
  ];
}
