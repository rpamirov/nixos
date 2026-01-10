{ config, lib, ... }:
{
  plugins.snacks = {
    settings = {
      bufdelete.enabled = true;
    };
  };

  keymaps = lib.mkIf config.plugins.snacks.settings.bufdelete.enabled [
    {
      mode = "n";
      key = "<leader>bc";
      action = ''<cmd>lua Snacks.bufdelete.other()<cr>'';
      options.desc = "Close all buffers but current";
    }
    {
      mode = "n";
      key = "<leader>bC";
      action = ''<cmd>lua Snacks.bufdelete.all()<cr>'';
      options.desc = "Close all buffers";
    }
    {
      mode = "n";
      key = "<C-x>";
      action = "<cmd>lua Snacks.bufdelete.delete()<cr>";
      options.desc = "Close buffer";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>lua Snacks.bufdelete()<cr>";
      options.desc = "Close current buffer";
    }
    {
      mode = "n";
      key = "<leader>bD";
      action = "<cmd>lua Snacks.bufdelete.bigger()<cr>";
      options.desc = "Close buffer and its split";
    }
  ];
}
