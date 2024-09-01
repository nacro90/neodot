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
    priority = 1000,
    config = function()
      require("nacro.colorscheme").setup "nordic"
    end,
  },

  -- filetype
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
  {
    "freitass/todo.txt-vim",
    ft = "todo",
  },
  {
    "arnarg/todotxt.nvim",
    opts = {
      todo_file = "~/Organizers/todo.txt",
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("nacro.neorg").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "monkoose/matchparen.nvim",

  -- editing
  {
    "tommcdo/vim-exchange",
    keys = {
      { "gx",  "<Plug>(Exchange)" },
      { "gx",  "<Plug>(Exchange)",     mode = "x" },
      { "gxc", "<Plug>(ExchangeClear)" },
      { "gxx", "<Plug>(ExchangeLine)" },
      { "gX",  "gx$",                  remap = true },
    },
  },
  {
    "vim-scripts/ReplaceWithRegister",
    keys = {
      { "gr" },
      { "gR", "gr$", remap = true },
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
    config = true,
    keys = {
      { "ys" },
      { "yS" },
      { "cs" },
      { "cS" },
      { "ds" },
      { "dS" },
      { "S", mode = { "v" } },
    },
    version = "*",
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "x", "n" } },
    },
  },
  {
    "kana/vim-textobj-entire",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "kana/vim-textobj-indent",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "glts/vim-textobj-comment",
    dependencies = { "kana/vim-textobj-user" },
  },
  "tpope/vim-repeat",

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
        "<leader>c",
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
    "chentoast/marks.nvim",
    keys = {
      { "]m" },
      { "[m" },
      { "m" },
      { "dm" },
    },
    config = function()
      require("marks").setup {
        mappings = {
          next = "]m",
          prev = "[m",
          delete_line = "dmm",
          delete_buffer = "dmae",
        },
      }
    end,
  },
  {
    "chomosuke/term-edit.nvim",
    version = "1.*",
    lazy = false,
    config = function()
      require("term-edit").setup {
        prompt_end = "[❮❯] ",
        feedkeys_delay = 100,
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "ekickx/clipboard-image.nvim",
    opts = {
      markdown = {
        img_dir = "static",
      },
    },
  },
  {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    opts = {
      popup_window = {
        relative = "editor",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>l", "<Cmd>LazyDocker<CR>" },
    },
  },
  {
    "folke/todo-comments.nvim",
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
    event = "BufRead",
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {
      preset = "obsidian",
      heading = {
        sign = false,
        left_pad = 1,
      },
      bullet = {
        icons = { "•", "◦", "⁃" },
        left_pad = 1,
        right_pad = 1,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "3rd/image.nvim",
    opts = {},
  },
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant"):setup()
    end,
  },
}
