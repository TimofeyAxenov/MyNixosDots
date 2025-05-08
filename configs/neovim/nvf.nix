{config, pkgs, ...}:

{
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        statusline.lualine.enable = true;
        keymaps = [
          {
            key = "<A-Up>";
            mode = "n";
            silent = true;
            action = ":wincmd k<CR>";
          }
          {
            key = "<A-Down>";
            mode = "n";
            silent = true;
            action = ":wincmd j<CR>";
          }
          {
            key = "<A-Left>";
            mode = "n";
            silent = true;
            action = ":wincmd h<CR>";
          }
          {
            key = "<A-Right>";
            mode = "n";
            silent = true;
            action = ":wincmd l<CR>";
          }
          {
            key = "<Tab>";
            mode = "n";
            silent = true;
            action = ":bNext<CR>";
          }
          {
            key = "<S-Tab>";
            mode = "n";
            silent = true;
            action = ":bprevious<CR>";
          }
        ];
        languages = {
          enableLSP = true;
          nix.enable = true;
          python.enable = true;
          clang.enable = true;
        };
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        telescope.enable = true;
        lazy.plugins = {
          "autoclose.nvim" = {
            package = pkgs.vimPlugins.autoclose-nvim;
            setupModule = "autoclose";
          };
          "mini.icons" = {
            package = pkgs.vimPlugins.mini-icons;
            setupModule = "mini.icons";
          };
          "oil.nvim" = {
            package = pkgs.vimPlugins.oil-nvim;
            setupModule = "oil";
            keys = [
              {
                mode = "n";
                key = "-";
                action = "<cmd>Oil<CR>";
              }
            ];
          };
          "nvim-web-devicons" = {
            package = pkgs.vimPlugins.nvim-web-devicons;
            setupModule = "nvim-web-devicons";
          };
          "bufferline.nvim" = {
            package = pkgs.vimPlugins.bufferline-nvim;
            setupModule = "bufferline";
          };
          "toggleterm.nvim" = {
            package = pkgs.vimPlugins.toggleterm-nvim;
            setupModule = "toggleterm";
            setupOpts = {
              version = "*";
              config = true;
            };
          };
        };
      };
      vim.autocomplete.nvim-cmp = {
        enable = true;
        mappings = {
          confirm = "<CR>";
          complete = "<C-Space>";
          next = "<C-Down>";
          previous = "<C-Up>";
          close = "<C-Esc>";
        };
      };
    };
  };
}


