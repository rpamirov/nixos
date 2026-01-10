{ config, lib, ... }:
{
  plugins.smart-splits.enable = true;
  # at_edge = "stop";

  keymaps = [
    # Move between splits
    {
      mode = "n";
      key = "<C-h>";
      action = lib.nixvim.mkRaw "require('smart-splits').move_cursor_left";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = lib.nixvim.mkRaw "require('smart-splits').move_cursor_down";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = lib.nixvim.mkRaw "require('smart-splits').move_cursor_up";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = lib.nixvim.mkRaw "require('smart-splits').move_cursor_right";
    }

    # Resize splits
    {
      mode = "n";
      key = "<A-h>";
      action = lib.nixvim.mkRaw "require('smart-splits').resize_left";
    }
    {
      mode = "n";
      key = "<A-j>";
      action = lib.nixvim.mkRaw "require('smart-splits').resize_down";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = lib.nixvim.mkRaw "require('smart-splits').resize_up";
    }
    {
      mode = "n";
      key = "<A-l>";
      action = lib.nixvim.mkRaw "require('smart-splits').resize_right";
    }
  ];
}
