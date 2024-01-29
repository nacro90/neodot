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
    "williamboman/mason.nvim",
    config = true,
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
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("nacro.neorg").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "plasticboy/vim-markdown",
    ft = "markdown",
    enabled = false,
    init = function()
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    enabled = false,
    keys = {
      {
        "<leader>ez",
        function()
          require("telekasten").find_notes()
        end,
      },
      {
        "<leader>eZ",
        function()
          require("telekasten").new_note()
        end,
      },
    },
    config = function()
      require("telekasten").setup {
        home = vim.env.HOME .. "/Zettels",
        image_subdir = "static",
        follow_creates_nonexisting = false,
        dailies_create_nonexisting = false,
        weeklies_create_nonexisting = false,
        image_link_style = "wiki",
        sort = "modified",
        tag_notation = "yaml-bare",
      }
    end,
  },

  "monkoose/matchparen.nvim",

  -- editing
  {
    "tommcdo/vim-exchange",
    keys = {
      { "gx", "<Plug>(Exchange)" },
      { "gx", "<Plug>(Exchange)", mode = "x" },
      { "gxc", "<Plug>(ExchangeClear)" },
      { "gxx", "<Plug>(ExchangeLine)" },
      { "gX", "gx$", remap = true },
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
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "v", "n" } },
    },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    config = true,
    keys = { { "ys" }, { "yS" }, { "cs" }, { "cS" }, { "ds" }, { "dS" }, { "S" } },
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
    "lcheylus/overlength.nvim",
    ft = { "go", "java" },
    cmd = { "OverlengthEnable", "OverlengthToggle" },
    config = function()
      require("overlength").setup {
        enabled = false,
        disable_ft = { "qf", "help", "man", "packer", "NvimTree", "Telescope", "WhichKey", "lazy" },
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
    "barrett-ruth/telescope-http.nvim",
    config = function()
      require("telescope").load_extension "http"
    end,
    lazy = true,
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

  -- git
  {
    "tpope/vim-fugitive",
    keys = { { "<leader>G", "<Cmd>vertical Git<CR>" } },
    cmd = "Git",
  },
  {
    "junegunn/gv.vim",
    dependencies = { "tpope/vim-fugitive" },
    cmd = "GV",
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
    config = function()
      require("toggleterm").setup {
        open_mapping = "<C-t>",
        insert_mappings = false,
      }
    end,
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
    config = true,
  },
  {
    "lukas-reineke/headlines.nvim",
    opts = {},
  },
  {
    "ekickx/clipboard-image.nvim",
    config = true,
    opts = {
      markdown = {
        img_dir = "static",
      },
    },
  },
  {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    opts = {}, -- automatically calls `require("lazydocker").setup()`
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
