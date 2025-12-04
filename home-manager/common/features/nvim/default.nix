{
  pkgs,
  inputs,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";

  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;

      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      telescope = {
        mappings = {
          liveGrep = "<leader>fw";
        };
        extensions = [
          {
            name = "fzf";
            packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
            setup = {fzf = {fuzzy = true;};};
          }
        ];
      };

      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      spellcheck = {
        enable = true;
      };

      lsp = {
        enable = true;

        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = false;
        lspsaga.enable = false;
        trouble.enable = true;
        otter-nvim.enable = true;

        nvim-docs-view.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        markdown.enable = true;

        rust = {
          enable = true;
          crates.enable = true;
          lsp.package = pkgs.rust-analyzer;
          lsp.opts = ''
            ['rust-analyzer'] = {
              cargo = {
                allFeature = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                    enable = true,
                },
              },
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                },
              },
              files = {
                excludeDirs = {
                    ".direnv",
                    ".git",
                    ".github",
                    ".gitlab",
                    "bin",
                    "node_modules",
                    "target",
                    "venv",
                    ".venv",
                },
              },
            },
          '';
        };
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
      };

      statusline = {
        lualine = {
          enable = true;
        };
      };

      theme = {
        enable = true;
        name = "onedark";
        transparent = false;
      };

      autopairs.nvim-autopairs.enable = true;

      autocomplete = {
        blink-cmp.enable = true;
      };

      snippets.luasnip.enable = true;

      filetree = {
        neo-tree = {
          enable = true;
        };
      };

      tabline = {
        nvimBufferline.enable = true;
      };

      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      notify = {
        nvim-notify.enable = true;
      };

      utility = {
        diffview-nvim.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = true;
        };
      };

      notes = {
        todo-comments.enable = true;
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false; # the theme looks terrible with catppuccin
        illuminate.enable = true;
        smartcolumn = {
          enable = false;
          #   setupOpts.custom_colorcolumn = {
          #     # this is a freeform module, it's `buftype = int;` for configuring column position
          #     nix = "110";
          #     ruby = "120";
          #     java = "130";
          #     go = ["90" "130"];
          #   };
        };
        fastaction.enable = true;
      };

      assistant = {
        chatgpt.enable = false;
        copilot = {
          enable = true;
        };
        codecompanion-nvim.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence = {
        neocord.enable = false;
      };

      extraPlugins = {
        astrotheme = {
          package = pkgs.vimPlugins.astrotheme;
          setup = ''
            require("astrotheme").setup {
            	palette = "astrodark"
            }
            vim.cmd.colorscheme("astrodark")
          '';
        };
      };
    };
  };

  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.unstable.neovim-unwrapped;
  #   plugins = with pkgs; [
  #     vimPlugins.nvim-treesitter
  #     vimPlugins.nvim-treesitter.withAllGrammars
  #   ];
  # };
  #
  # home.packages = with pkgs; [
  #   unzip
  #   gnumake
  #   gcc
  #   rustc
  #   cargo
  #   python3
  #   php
  #   phpPackages.composer
  #   stylua
  #   luajitPackages.luarocks-nix
  #   alejandra
  #   deadnix
  #   statix
  # ];

  # xdg.configFile = {
  #   "nvim".source = inputs.neovim-config.outPath;
  #   # "nvim".source = builtins.fetchGit {
  #   #   url = "https://github.com/sjcobb2022/lazy.git";
  #   #   rev = "57839624ad511af7ac2ef18990c82dfc7e0912db";
  #   # };
  # };
}
