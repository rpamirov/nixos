{
  config,
  lib,
  ...
}:
{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps =
    let
      normal =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "n";
              inherit action key;
              options = attrs.options or { };
            }
          )
          (
            {
              "<Space>" = {
                action = "<NOP>";
              };

              # Esc to clear search results
              "<esc>" = {
                action = "<cmd>noh<CR>";
              };

              # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
              "<leader>y" = {
                action = "\"+y";
                options = {
                  desc = "Copy to system clipboard";
                };
              };

              # fix Y behaviour
              "Y" = {
                action = "y$";
              };

              # back and fourth between the two most recent files
              "<C-c>" = {
                action = "<cmd>b#<CR>";
              };

              # navigate to left/right window
              "<C-Left>" = {
                action = "<C-w>h";
                options = {
                  desc = "Left window";
                };
              };
              "<C-Right>" = {
                action = "<C-w>l";
                options = {
                  desc = "Right window";
                };
              };
              "<C-Down>" = {
                action = "<C-w>j";
                options = {
                  desc = "Up window";
                };
              };
              "<C-Up>" = {
                action = "<C-w>k";
                options = {
                  desc = "Down window";
                };
              };

              # navigate quickfix list
              "<C-[>" = {
                action = "<cmd>cnext<CR>";
              };
              "<C-]>" = {
                action = "<cmd>cprev<CR>";
              };

              # resize with arrows
              "<C-S-Up>" = {
                action = "<cmd>resize -2<CR>";
              };
              "<C-S-Down>" = {
                action = "<cmd>resize +2<CR>";
              };
              "<C-S-Left>" = {
                action = "<cmd>vertical resize +2<CR>";
              };
              "<C-S-Right>" = {
                action = "<cmd>vertical resize -2<CR>";
              };

              "<C-s>" = {
                action = "<Cmd>w<CR><esc>";
                options = {
                  desc = "Save";
                };
              };

              "<Down>" = {
                action = "v:count == 0 ? 'gj' : 'j'";
                options = {
                  desc = "Move cursor down";
                  expr = true;
                };
              };
              "<Up>" = {
                action = "v:count == 0 ? 'gk' : 'k'";
                options = {
                  desc = "Move cursor up";
                  expr = true;
                };
              };
              "<Leader>q" = {
                action = "<Cmd>confirm q<CR>";
                options = {
                  desc = "Quit";
                };
              };
              "<C-n>" = {
                action = "<Cmd>enew<CR>";
                options = {
                  desc = "New file";
                };
              };
              "<leader>ws" = {
                action = "<Cmd>w!<CR>";
                options = {
                  desc = "Force write";
                };
              };
              "<leader>Q" = {
                action = "<Cmd>q!<CR>";
                options = {
                  desc = "Force quit";
                };
              };
              "|" = {
                action = "<Cmd>vsplit<CR>";
                options = {
                  desc = "Vertical split";
                };
              };
              "-" = {
                action = "<Cmd>split<CR>";
                options = {
                  desc = "Horizontal split";
                };
              };
              "<leader>wd" = {
                action = "<C-W>c";
                options = {
                  desc = "Close current buffer";
                };
              };
            }
            // (lib.optionalAttrs
              (
                !(
                  config.plugins.snacks.enable
                  && lib.hasAttr "toggle" config.plugins.snacks.settings
                  && config.plugins.snacks.settings.toggle.enabled
                )
              )
              {
                "<leader>ud" = {
                  action.__raw = ''
                    function ()
                      vim.b.disable_diagnostics = not vim.b.disable_diagnostics
                      if vim.b.disable_diagnostics then
                        vim.diagnostic.disable(0)
                      else
                        vim.diagnostic.enable(0)
                      end
                      vim.notify(string.format("Buffer Diagnostics %s", tostring(not vim.b.disable_diagnostics), "info"))
                    end'';
                  options = {
                    desc = "Buffer Diagnostics toggle";
                  };
                };

                "<leader>uD" = {
                  action.__raw = ''
                    function ()
                      vim.g.disable_diagnostics = not vim.g.disable_diagnostics
                      if vim.g.disable_diagnostics then
                        vim.diagnostic.disable()
                      else
                        vim.diagnostic.enable()
                      end
                      vim.notify(string.format("Global Diagnostics %s", tostring(not vim.g.disable_diagnostics), "info"))
                    end'';
                  options = {
                    desc = "Global Diagnostics toggle";
                  };
                };

                "<leader>uS" = {
                  action.__raw = ''
                    function ()
                      if vim.g.spell_enabled then vim.cmd('setlocal nospell') end
                      if not vim.g.spell_enabled then vim.cmd('setlocal spell') end
                      vim.g.spell_enabled = not vim.g.spell_enabled
                      vim.notify(string.format("Spell %s", tostring(vim.g.spell_enabled), "info"))
                    end'';
                  options = {
                    desc = "Spell toggle";
                  };
                };

                "<leader>uw" = {
                  action.__raw = ''
                    function ()
                      vim.wo.wrap = not vim.wo.wrap
                      vim.notify(string.format("Wrap %s", tostring(vim.wo.wrap), "info"))
                    end'';
                  options = {
                    desc = "Word Wrap toggle";
                  };
                };
              }
            )
            // {
              # Autoformat toggles (no snacks equivalent, always available)
              "<leader>uf" = {
                action.__raw = ''
                  function ()
                    vim.cmd('FormatToggle!')
                    vim.notify(string.format("Buffer Autoformatting %s", tostring(not vim.b[0].disable_autoformat), "info"))
                  end'';
                options = {
                  desc = "Buffer Autoformatting toggle";
                };
              };

              "<leader>uF" = {
                action.__raw = ''
                  function ()
                    vim.cmd('FormatToggle')
                    vim.notify(string.format("Global Autoformatting %s", tostring(not vim.g.disable_autoformat), "info"))
                  end'';
                options = {
                  desc = "Global Autoformatting toggle";
                };
              };

              # Base diff keybinds - always available
              "<leader>gdd" = {
                action = "<cmd>diffthis<CR>";
                options = {
                  desc = "Add file to diff";
                };
              };
              "<leader>gdc" = {
                action = "<cmd>diffoff<CR>";
                options = {
                  desc = "Close diff mode";
                };
              };
              "<leader>gdC" = {
                action = "<cmd>diffoff!<CR>";
                options = {
                  desc = "Close diff mode (all windows)";
                };
              };
            }
            // (lib.optionalAttrs (!config.plugins.gitsigns.enable) {
              "<leader>gD" = {
                action.__raw = ''
                  function()
                    if vim.wo.diff then
                      vim.cmd('diffoff')
                    else
                      vim.cmd('diffthis')
                    end
                  end
                '';
                options = {
                  desc = "Toggle Diff (Primary)";
                };
              };
            })
            // (lib.optionalAttrs (!config.plugins.visual-whitespace.enable) {
              "<leader>uW" = {
                action.__raw = ''
                  function ()
                    if (not vim.g.whitespace_character_enabled) then
                      vim.cmd('set listchars=eol:¬,tab:>→,trail:~,extends:>,precedes:<,space:·')
                      vim.cmd('set list')
                    else
                      vim.cmd('set nolist')
                    end
                    vim.g.whitespace_character_enabled = not vim.g.whitespace_character_enabled
                    vim.notify(string.format("Showing white space characters %s", tostring(vim.g.whitespace_character_enabled), "info"))
                  end'';
                options = {
                  desc = "White space character toggle";
                };
              };
            })
            // (lib.optionalAttrs
              (
                !config.plugins.snacks.enable
                || (config.plugins.snacks.enable && config.plugins.snacks.settings.bufdelete.enabled)
              )
              {
                "<leader>wC" = {
                  action = "<cmd>%bd!<CR>";
                  options = {
                    desc = "Close all buffers";
                  };
                };
              }
            )
          );
      visual =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "v";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
            "<leader>y" = {
              action = "\"+y";
              options = {
                desc = "Copy to system clipboard";
              };
            };
            # Better indenting
            "<S-Tab>" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<Tab>" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };
            ">" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };

            # Move selected line/block in visual mode
            "K" = {
              action = "<cmd>m '<-2<CR>gv=gv<cr>";
            };
            "J" = {
              action = "<cmd>m '>+1<CR>gv=gv<cr>";
            };
          };

      insert =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "i";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Move selected line/block in insert mode
            "<C-Up>" = {
              action = "<C-o>gk";
            };
            "<C-Left>" = {
              action = "<Left>";
            };
            "<C-Right>" = {
              action = "<Right>";
            };
            "<C-Down>" = {
              action = "<C-o>gj";
            };
            # Select all lines in buffer
            "<C-a>" = {
              action = "<cmd> norm! ggVG<cr>";
            };
          };
    in
    lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);
}
