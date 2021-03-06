local plugins = {}

local fn = vim.fn

local local_plugin_dir = vim.env.HOME .. "/Projects/plugins"

local uv = vim.loop

--- Prioritise the local plugins but download if they are not exist locally
local function localized(plugin, local_path)
  local _, name = unpack(vim.split(plugin, "%/"))
  local_path = local_path or local_plugin_dir .. "/" .. name
  if not uv.fs_stat(local_path) then
    return plugin
  end
  return local_path
end

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  print "packer not found. bootstrapping..."
  fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd "packadd packer.nvim"

local packer = require "packer"

local rocks = require "packer.luarocks"
rocks.install_commands()

local plugin_table = {

  { "wbthomason/packer.nvim", opt = true },

  "kvrohit/substrata.nvim",
  "elvessousa/sobrio",
  "cseelus/vim-colors-lucid",
  "jacoborus/tender.vim",
  "rakr/vim-two-firewatch",
  "kyazdani42/blue-moon",
  "cseelus/vim-colors-tone",
  "seesleestak/duo-mini",
  "AhmedAbdulrahman/aylin.vim",
  "fenetikm/falcon",
  { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } },
  "shaunsingh/nord.nvim",
  "NTBBloodbath/doom-one.nvim",
  "marko-cerovac/material.nvim",
  "tomasiser/vim-code-dark",
  "bluz71/vim-moonfly-colors",
  "tanvirtin/monokai.nvim",
  "navarasu/onedark.nvim",
  "ishan9299/nvim-solarized-lua",
  "elianiva/icy.nvim",
  "elianiva/gruvy.nvim",
  { "catppuccin/nvim", as = "catppuccin" },
  { "rose-pine/neovim", as = "rose-pine" },
  { "embark-theme/vim", as = "embark" },
  "doums/darcula",
  { "frenzyexists/aquarium-vim" },
  "Mangeshrex/uwu.vim",

  "NoahTheDuke/vim-just",
  "freitass/todo.txt-vim",
  "rafcamlet/nvim-luapad",
  "shaeinst/roshnivim-cs",
  "rebelot/kanagawa.nvim",

  { "bfredl/nvim-luadev" },
  {
    "tjdevries/vim-inyoface",
    cmd = "Inyoface",
    config = function()
      vim.cmd "command! Inyoface call inyoface#toggle_comments()"
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup()
    end,
  },
  "ThePrimeagen/harpoon",
  {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = "Trouble",
    config = function()
      require("trouble").setup {
        fold_open = "???",
        fold_closed = "???",
        action_keys = {
          -- map to {} to remove a mapping, for example:
          -- close = {},
          jump = { "<cr>" },
          open_split = { "<c-s>" },
          hover = "<C-k>",
        },
        use_lsp_diagnostic_signs = true,
      }
    end,
  },
  "p00f/nvim-ts-rainbow",
  {
    "mfussenegger/nvim-jdtls",
  },
  {
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
  },
  {
    "m-demare/hlargs.nvim",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  "nanotee/luv-vimdocs",
  "milisims/nvim-luaref",
  {
    "famiu/nvim-reload",
    cmd = "Reload",
    config = function()
      require "nvim-reload"
    end,
  },
  {
    "szw/vim-maximizer",
    setup = function()
      vim.g.maximizer_set_default_mapping = 0
      vim.api.nvim_set_keymap("n", "<leader>m", "<Cmd>MaximizerToggle<CR>", { noremap = true })
    end,
    cmd = "MaximizerToggle",
  },
  "TimUntersberger/neogit",
  {
    -- Easy text exchange operator for Vim
    "tommcdo/vim-exchange",
    config = function()
      -- Starting with 'g' is more conveninent and vimish
      vim.api.nvim_set_keymap("n", "gx", "<Plug>(Exchange)", {})
      vim.api.nvim_set_keymap("x", "gx", "<Plug>(Exchange)", {})
      vim.api.nvim_set_keymap("n", "gxc", "<Plug>(ExchangeClear)", {})
      vim.api.nvim_set_keymap("n", "gxx", "<Plug>(ExchangeLine)", {})
      -- 'gX' should be like 'C' or 'D'
      vim.api.nvim_set_keymap("n", "gX", "gx$", {})
    end,
  },
  "lukas-reineke/indent-blankline.nvim",
  "sindrets/diffview.nvim",
  {
    -- Put text from string without yank the previous text
    "vim-scripts/ReplaceWithRegister",
    config = function()
      -- 'gR' should be like 'C' or 'D'
      vim.api.nvim_set_keymap("n", "gR", "gr$", {})
    end,
  },
  "monkoose/matchparen.nvim",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "blackCauldron7/surround.nvim",
    config = function()
      require("surround").setup { mappings_style = "surround" }
    end,
  },
  {
    "junegunn/vim-easy-align",
    disable = false,
    config = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
    end,
  },
  "kana/vim-textobj-user",
  "kana/vim-textobj-entire",
  "kana/vim-textobj-indent",
  "glts/vim-textobj-comment",
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },
  {
    "nvim-treesitter/playground",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    "windwp/nvim-ts-autotag",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  "RRethy/vim-illuminate",
  {
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  },
  {
    "windwp/nvim-autopairs",
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup {
        max_width = 60,
      }
    end,
  },
  "tpope/vim-repeat",
  "tpope/vim-eunuch",
  "jose-elias-alvarez/null-ls.nvim",
  {
    "L3MON4D3/LuaSnip",
    requires = "rafamadriz/friendly-snippets",
  },
  "ekickx/clipboard-image.nvim",
  {
    "hkupty/iron.nvim",
    disable = true,
    setup = function()
      vim.g.iron_map_defaults = 0
      vim.g.iron_map_extended = 0
      vim.api.nvim_set_keymap("n", "<leader>i", "<Cmd>IronFocus<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>I", "<Cmd>IronReplHere<CR>", { noremap = true })
    end,
    config = function()
      local iron = require "iron"
      iron.core.add_repl_definitions {
        python = { ipy = { command = { "ipython" } } },
        clojure = {
          lein_connect = { command = { "lein", "repl", ":connect" } },
        },
        haskell = { ghci = { command = { "ghci" } } },
        lua = { lua = { command = { "luajit" } } },
        java = { jshell = { command = { "jshell" } } },
      }
      iron.core.set_config {
        preferred = { python = "ipython", clojure = "lein" },
      }
    end,
    cmd = { "IronReplHere", "IronRepl", "IronFocus" },
  },
  {
    "jghauser/mkdir.nvim",
    config = function()
      require "mkdir"
    end,
  },
  "nvim-lua/plenary.nvim",
  "vim-test/vim-test",
  {
    "rcarriga/vim-ultest",
    requires = { "vim-test/vim-test" },
    run = ":UpdateRemotePlugins",
  },
  {
    "nvim-lua/telescope.nvim",
    disable = false,
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-packer.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
      "jvgrootveld/telescope-zoxide",
      "dhruvmanila/telescope-bookmarks.nvim",
      "mrjones2014/tldr.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },
  { "nvim-pack/nvim-spectre", requires = "nvim-lua/plenary.nvim" },
  { "tweekmonster/startuptime.vim", cmd = "StartupTime" },
  {
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
  },
  { "arkav/lualine-lsp-progress", requires = "nvim-lualine/lualine.nvim" },
  {
    "ironhouzi/starlite-nvim",
    keys = { "*", "g*", "#", "g#" },
    setup = function()
      local nnoremap = require("nacro.utils.map").nnoremap
      local function starlite_func(func)
        return function()
          require("starlite")[func]()
        end
      end
      nnoremap("*", starlite_func "star")
      nnoremap("g*", starlite_func "g_star")
      nnoremap("#", starlite_func "hash")
      nnoremap("g#", starlite_func "g_hash")
    end,
  },
  {
    "petobens/poet-v",
    cmd = "PoetvActivate",
  },
  {
    "plasticboy/vim-markdown",
    config = function()
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  },
  {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  "tami5/sqlite.lua",
  {
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
  },
  "renerocksai/telekasten.nvim",
  {
    "famiu/bufdelete.nvim",
    setup = function()
      vim.g.bclose_no_plugin_maps = 1
      vim.api.nvim_set_keymap("n", "<leader>x", "<Cmd>Bdelete<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>X", "<Cmd>Bdelete!<CR>", { noremap = true })
    end,
    cmd = { "Bdelete", "Bwipeout" },
  },
  "natecraddock/workspaces.nvim",
  "mfussenegger/nvim-dap",
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    requires = "mfussenegger/nvim-dap",
  },
  { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" },
  { "leoluz/nvim-dap-go", requires = "mfussenegger/nvim-dap" },
  {
    "nvim-telescope/telescope-dap.nvim",
    requires = { "nvim-lua/telescope.nvim", "mfussenegger/nvim-dap" },
  },
  {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
  },
  "tpope/vim-scriptease",
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  {
    "hrsh7th/nvim-cmp",
    requires = {
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
  },
  "norcalli/nvim-colorizer.lua",
  {
    "junegunn/gv.vim",
    requires = "tpope/vim-fugitive",
    cmd = "GV",
  },
  {
    "mbbill/undotree",
    setup = function()
      vim.g.undotree_WindowLayout = 3
    end,
    cmd = "UndotreeToggle",
  },
  { "dmitmel/cmp-digraphs", requires = "hrsh7th/nvim-cmp" },
  "ray-x/lsp_signature.nvim",
  {
    localized "nacro90/numb.nvim",
    disable = false,
    event = "CmdlineEnter",
    config = function()
      require("numb").setup()
    end,
  },
  localized "nacro90/omen.nvim",
  {
    localized "nacro90/turkishmode.nvim",
    config = function()
      vim.cmd [[command! DeasciifyBuffer lua require('turkishmode').deasciify_buffer()]]
    end,
    cmd = "DeasciifyBuffer",
  },
  "neovim/nvim-lspconfig",
}

function plugins.setup()
  local num_cpus = #vim.loop.cpu_info()
  packer.startup {
    function()
      for _, value in ipairs(plugin_table) do
        packer.use(value)
      end
    end,
    config = {
      max_jobs = num_cpus,
      display = {
        open_fn = function()
          return require("packer.util").float { border = "single" }
        end,
      },
    },
  }
end

return plugins
