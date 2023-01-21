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
    keys = { "gc" },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    config = true,
    keys = { { "ys" }, { "yS" }, { "cs" }, { "cS" }, { "ds" }, { "dS" } },
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
    event = "CmdlineEnter",
    config = true,
  },
  {
    "nacro90/turkishmode.nvim",
    init = function()
      vim.api.nvim_create_user_command("Deasciify", function()
        require("turkishmode").deasciify_buffer()
      end, {})
    end,
    cmd = "Deasciify",
  },
}
