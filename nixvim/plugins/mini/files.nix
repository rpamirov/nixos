{ config, lib, ... }:
{
  plugins.mini-files = {
    enable = true;

    settings = {
      options = {
        use_as_default_explorer = false;
        permanent_delete = true;
      };
    };
  };

  extraConfigLua = ''
    -- Disable netrw completely for directory arguments
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("DirectoryPicker", { clear = true }),
      callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
          -- Schedule to ensure UI is ready
          vim.schedule(function()
            -- Store directory buffer to close later
            local dir_buf = vim.api.nvim_get_current_buf()
            
            -- Open picker
            require("snacks.picker").files({ cwd = arg })
            
            -- Set up autocommand to close directory buffer when picker opens
            local close_augroup = vim.api.nvim_create_augroup("CloseDirBuf", { clear = true })
            
            vim.api.nvim_create_autocmd("BufEnter", {
              group = close_augroup,
              buffer = dir_buf,
              once = true,
              callback = function()
                vim.defer_fn(function()
                  if vim.api.nvim_buf_is_valid(dir_buf) then
                    vim.api.nvim_buf_delete(dir_buf, { force = true })
                  end
                  vim.api.nvim_del_augroup_by_id(close_augroup)
                end, 50)
              end,
            })
          end)
        end
      end,
    })
  '';
  keymaps = lib.mkIf config.plugins."mini-files".enable [
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>lua MiniFiles.open()<CR>";
      options.desc = "File explorer (mini.files)";
    }
  ];
}
