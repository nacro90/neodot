require "nacro.options"
require "nacro.keymaps"

local nlazy = require "nacro.lazy"
nlazy.bootstrap()
nlazy.setup()

require("nacro.commands").setup()
require("nacro.autocmds").setup()
require("nacro.lsp").setup()

require("nacro.terminal").setup()
require("nacro.howdoi").setup()
require("nacro.neovide").setup_if_neovide()
require("nacro.buffer").setup()
