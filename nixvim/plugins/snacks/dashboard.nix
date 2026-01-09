{ config, lib, ... }:
{
  plugins.snacks = {
    settings = {
      dashboard = {
        enabled = true;
        lazy = false;
        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
        ];
      };
    };
  };
}
