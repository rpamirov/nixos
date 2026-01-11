{ lib, ... }:
{
  plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        mode = "buffers";
        diagnostics = "nvim_lsp";
        separator_style = "slant";
        show_buffer_close_icons = false;
        show_close_icon = false;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "L";
      action = "<cmd>execute 'bnext ' .. v:count1<CR>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "H";
      action = "<cmd>execute 'bprevious ' .. v:count1<CR>";
      options.desc = "Previous buffer";
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>execute 'bnext ' .. v:count1<CR>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>execute 'bprevious ' .. v:count1<CR>";
      options.desc = "Previous buffer";
    }
  ];
}
