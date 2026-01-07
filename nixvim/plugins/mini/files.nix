{ config, lib, ... }:
{
  plugins.mini-files.enable = true;
  keymaps = lib.mkIf config.plugins."mini-files".enable [
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>lua MiniFiles.open()<CR>";
      options.desc = "File explorer (mini.files)";
    }
  ];
}

