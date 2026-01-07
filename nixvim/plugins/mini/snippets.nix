{ config, lib, ... }:
{
  plugins.mini-snippets = {
    enable = true;
    fromVscode = [
      "friendly-snippets"
    ];
  };
}
