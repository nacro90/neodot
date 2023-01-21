return {
  "samjwill/nvim-unception",
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Move",
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
    lazy = false,
    priority = 1000,
    config = function()
      require("nacro.colorscheme").setup "tokyonight"
    end,
  },
  {
    "lewpoly/sherbet.nvim",
    lazy = true,
  },
  {
    "ramojus/mellifluous.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = true,
    lazy = true,
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
    "NTBBloodbath/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "plasticboy/vim-markdown",
    ft = "markdown",
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
  --
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "p00f/nvim-ts-rainbow",
  {
    "m-demare/hlargs.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "svelte",
    },
    config = true,
  },
  "monkoose/matchparen.nvim",

  -- LSP
  {
    "folke/lsp-trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    cmd = "Trouble",
    module = false,
    config = function()
      require("trouble").setup {
        fold_open = "▰",
        fold_closed = "▪",
        action_keys = {
          -- map to {} to remove a mapping, for example:
          -- close = {},
          jump = { "<cr>" },
          open_split = { "<c-s>" },
          hover = "<C-k>",
        },
        use_diagnostic_signs = true,
      }
    end,
  },
  "jose-elias-alvarez/null-ls.nvim",
  "ray-x/lsp_signature.nvim",
  "neovim/nvim-lspconfig",

  "natecraddock/workspaces.nvim",

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
    keys = { "gc" },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    config = true,
    keys = { { "ys" }, { "yS" } },
    version = "*",
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)" },
      { "ga", "<Plug>(EasyAlign)", mode = "x" },
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
  "ironhouzi/starlite-nvim",

  -- ui
  {
    "szw/vim-maximizer",
    init = function()
      vim.g.maximizer_set_default_mapping = 0
      vim.api.nvim_set_keymap("n", "<leader>m", "<Cmd>MaximizerToggle<CR>", { noremap = true })
    end,
    cmd = "MaximizerToggle",
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure {}
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
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
  "lukas-reineke/indent-blankline.nvim",

  -- testing

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-emoji",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
    },
    event = "InsertEnter",
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

  -- debug
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },

  -- additional helpdocs
  "nanotee/luv-vimdocs",
  "milisims/nvim-luaref",

  -- mine
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = true,
  },
  {
    dir = "~/Projects/plugins/turkishmode.nvim",
    config = function()
      vim.cmd [[command! DeasciifyBuffer lua require('turkishmode').deasciify_buffer()]]
    end,
    cmd = "DeasciifyBuffer",
  },
}
