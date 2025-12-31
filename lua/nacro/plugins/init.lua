return {
  {
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_enable_flavor_text = false
      vim.g.unception_open_buffer_in_new_tab = true
      vim.g.unception_block_while_host_edits = true
    end,
  },
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Move",
      "Chmod",
      "Mkdir",
      "Rename",
    },
  },

  -- colorschemes
  {
    "kvrohit/substrata.nvim",
    lazy = true,
  },
  {
    "tomasiser/vim-code-dark",
    lazy = true,
  },
  {
    "tanvirtin/monokai.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("nacro.colorscheme").setup "nordic"
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
  },

  -- filetype
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
  {
    "monkoose/matchparen.nvim",
    opts = {},
  },

  -- editing
  {
    "gbprod/substitute.nvim",
    opts = {},
    init = function()
      -- Remove Neovim 0.11 default global gr* mappings
      pcall(vim.keymap.del, "n", "gra")
      pcall(vim.keymap.del, "n", "gri")
      pcall(vim.keymap.del, "n", "grn")
      pcall(vim.keymap.del, "n", "grr")
      pcall(vim.keymap.del, "n", "grt")
      pcall(vim.keymap.del, "x", "gra")
    end,
    keys = {
      {
        "gr",
        function()
          require("substitute").operator()
        end,
      },
      {
        "gr",
        function()
          require("substitute").visual()
        end,
        mode = "x",
      },
      {
        "grr",
        function()
          require("substitute").line()
        end,
      },
      {
        "gR",
        function()
          require("substitute").eol()
        end,
      },
      {
        "gx",
        function()
          require("substitute.exchange").operator()
        end,
      },
      {
        "gx",
        function()
          require("substitute.exchange").visual()
        end,
        mode = "x",
      },
      {
        "gxx",
        function()
          require("substitute.exchange").line()
        end,
      },
      {
        "gX",
        function()
          require("substitute.exchange").eol()
        end,
      },
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = {
        "lua-curl",
        "nvim-nio",
        "mimetypes",
        "xml2lua",
        "magick",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "ys" },
      { "yS" },
      { "cs" },
      { "cS" },
      { "ds" },
      { "dS" },
      { "S", mode = { "v" } },
    },
  },
  {
    "kana/vim-textobj-entire",
    keys = {
      { "ae", mode = { "o", "x" } },
      { "ie", mode = { "o", "x" } },
    },
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "kana/vim-textobj-indent",
    event = "BufRead",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "glts/vim-textobj-comment",
    event = "BufRead",
    dependencies = { "kana/vim-textobj-user" },
  },
  "tpope/vim-repeat",
  {
    "github/copilot.vim",
    event = "InsertEnter",
    enabled = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap(
        "i",
        "<C-l>",
        'copilot#Accept("<CR>")',
        { silent = true, expr = true, replace_keycodes = false }
      )
      vim.api.nvim_set_keymap("i", "<M-]>", "<Plug>(copilot-next)", { silent = true })
      vim.api.nvim_set_keymap("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true })
    end,
  },

  -- ui
  {
    "szw/vim-maximizer",
    init = function()
      vim.g.maximizer_set_default_mapping = 0
    end,
    cmd = "MaximizerToggle",
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        user_default_options = {
          names = false,
        },
      }
    end,
  },
  {
    "jvgrootveld/telescope-zoxide",
    config = function()
      require("telescope").load_extension "zoxide"
    end,
    keys = {
      {
        "<leader>w",
        function()
          require("telescope").extensions.zoxide.list { layout_strategy = "center" }
        end,
      },
    },
    dependencies = "nvim-telescope/telescope.nvim",
  },
  {
    "edolphin-ydf/goimpl.nvim",
    config = function()
      require("telescope").load_extension "goimpl"
    end,
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<leader>R",
        function()
          require("smart-splits").start_resize_mode()
        end,
      },
    },
    config = function()
      require("smart-splits").setup {
        resize_mode = {
          silent = true,
          hooks = {
            on_enter = function()
              vim.notify "Entering resize mode"
            end,
          },
        },
        tmux_integration = false,
      }
    end,
  },

  -- filesystem
  {
    "mbbill/undotree",
    init = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_TreeReturnShape = "╲"
      vim.g.undotree_TreeSplitShape = "╱"
      vim.g.undotree_TreeVertShape = "│"
    end,
    cmd = "UndotreeToggle",
  },

  -- buffers
  {
    "famiu/bufdelete.nvim",
    init = function()
      vim.g.bclose_no_plugin_maps = 1
    end,
    keys = {
      { "<leader>x", "<Cmd>Bdelete<CR>" },
      { "<leader>X", "<Cmd>Bdelete!<CR>" },
    },
    cmd = { "Bdelete", "Bwipeout" },
  },

  -- additional helpdocs
  "nanotee/luv-vimdocs",
  "milisims/nvim-luaref",

  -- mine
  {
    "nacro90/numb.nvim",
    dev = true,
    event = "CmdlineEnter",
    config = true,
  },
  {
    "nacro90/turkishmode.nvim",
    dev = true,
    config = function()
      vim.api.nvim_create_user_command("Deasciify", function()
        require("turkishmode").deasciify_buffer()
      end, {})
    end,
    keys = {
      {
        "<leader>Tc",
        function()
          require("turkishmode").deasciify_clipboard()
        end,
      },
      {
        "`",
        function()
          require("turkishmode").toggle_current_char()
        end,
      },
    },
    cmd = "Deasciify",
  },
  {
    "akinsho/toggleterm.nvim",
    keys = { { "<C-t>" } },
    opts = {
      open_mapping = "<C-t>",
      insert_mappings = false,
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "n",
          "q",
          "<cmd>close<CR>",
          { noremap = true, silent = true }
        )
      end,
    },
  },
  {
    "chomosuke/term-edit.nvim",
    version = "1.*",
    event = "TermOpen",
    opts = {
      prompt_end = "[❮❯] ",
      feedkeys_delay = 100,
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
  },
  {
    "crnvl96/lazydocker.nvim",
    opts = {
      popup_window = {
        relative = "editor",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>l",
        function()
          require("lazydocker").open()
        end,
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    config = function()
      require("illuminate").configure {
        filetypes_denylist = {
          "markdown",
          "dirvish",
          "fugitive",
        },
      }
    end,
  },
  {
    "nvimdev/hlsearch.nvim",
    event = "BufRead",
    opts = {},
  },
  {
    "tpope/vim-sleuth",
    enabled = false,
    event = "BufRead",
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    ft = "markdown",
    main = "render-markdown",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "nvim-mini/mini.nvim",
    },
  },
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    opts = {},
    cmd = { "DistantInstall", "DistantLaunch" },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {},
  },
  {
    "kelly-lin/ranger.nvim",
    opts = {
      replace_netrw = true,
      enable_cmds = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {},
  },
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = "<C-l>",
        clear_suggestion = "<C-e>",
        accept_word = "<C-/>",
      },
    },
  },
}
