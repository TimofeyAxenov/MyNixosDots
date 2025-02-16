{config, pkgs, ...}:
#let
#    nixvim = import (builtins.fetchGit {
#        url = "https://github.com/nix-community/nixvim";
#        # When using a different channel you can use `ref = "nixos-<version>"` to set it here
#    });
#in
{
#  imports = [
#    nixvim.nixosModules.nixvim
#  ];

  programs.nixvim = {
    enable = true;
    plugins = {
      render-markdown.enable = true;
      lsp = {
        enable = true;

	servers = {
	  marksman.enable = true;
	  gopls.enable = true;
	  pyright.enable = true;
	  nil_ls = {
	    enable = true;
	    settings.nix.flake.autoArchive = true;
	  };
	  yamlls.enable = true;
#	  sqls = {
#	    enable = true;
#	  };
	  protols = {
	    enable = true;
	    package = null;
	  };
	};
     };
     lsp-format.enable = true;
    cmp = {
     enable = true;
	autoEnableSources = false;
	settings = {
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
            '';
          };
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          sources = {
            __raw = ''
              cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
              -- { name = 'luasnip' },
              -- { name = 'ultisnips' },
              -- { name = 'snippy' },
            }, {
               { name = 'buffer' },
	       { name = 'path' }
            })
            '';
          };
	};
     };
     luasnip.enable = true;
     friendly-snippets.enable = true;
     cmp-nvim-lsp.enable = true;
#     cmp-dap.enable = true;
#     dap = {
#       enable = true;
#
#       extensions = {
#         dap-go = {
#	   enable = true;
#	   delve.path = "${pkgs.delve}/bin/dlv";
#	 };
#	 dap-python = {
#	   enable = true;
#	 };
#	 dap-ui = {
#	   enable = true;
#	   floating.mappings = {close = ["<ESC>" "q"];};
#	 };
#	 dap-virtual-text = {enable = true;};
#      };
#       signs = {
#        dapBreakpoint = {
#          text = "";
#          texthl = "DapBreakpoint";
#        };
#        dapBreakpointCondition = {
#          text = "";
#          texthl = "DapBreakpointCondition";
#        };
#        dapLogPoint = {
#          text = "";
#          texthl = "DapLogPoint";
#        };
#      };
#     };
      bufferline = {
        enable = true;
      };
      bufdelete = {
        enable = true;
      };
      telescope.enable = true;
      treesitter = {
        enable = true;
      };
      web-devicons.enable = true;
      oil.enable = true;
      toggleterm.enable = true;
      lualine.enable = true;
      autoclose.enable = true;
      alpha = {
        enable = true;

	theme = "dashboard";
      };
#      lazygit.enable = true;
      which-key = {
        enable = true;
      };
    };
    colorschemes.gruvbox.enable = true;
    keymaps = [
      {
        action = "<cmd>LazyGit<CR>";
	key = "<Space>g";
	options = {
	  desc = "Open LazyGit";
	};
      }
      {
        action = "<cmd>wincmd k<CR>";
	key = "<c-k>";
      }
      {
        action = "<cmd>wincmd h<CR>";
	key = "<c-h>";
      }
      {
        action = "<cmd>wincmd j<CR>";
	key = "<c-j>";
      }
      {
        action = "<cmd>wincmd l<CR>";
	key = "<c-l>";
      }
      {
        action = "<cmd>Oil<CR>";
	key = "-";
      }
      {
        action = "<cmd>bn<CR>";
	key = "<tab>";
      }
      {
        action = "<cmd>bp<CR>";
	key = "<S-tab>";
      }
      {
        action = "<cmd>Bwipeout<CR>";
	key = "<Space>c";
	options = {
	  desc = "Close Tab";
	};
      }
      {
        action = "<cmd>ToggleTerm<CR>";
	key = "<Space>t";
	options = {
	  desc = "Open Terminal";
	};
      }
    ];
    extraPlugins = with pkgs.vimPlugins; [
      cmp_luasnip
      telescope-dap-nvim
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
    ];
  };
}
