# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The configuration follows a modular structure with organized plugin configurations and filetype-specific customizations. It's optimized for professional development across Go, Dart/Flutter, TypeScript, Python, Lua, and other languages.

## Architecture

### Core Entry Points
- `init.lua` - Minimal orchestrator that loads modules in sequence:
  1. `nacro.options` - Editor settings
  2. `nacro.keymaps` - Base keymappings
  3. `nacro.lazy` - Bootstrap and setup lazy.nvim
  4. `nacro.commands` - Custom commands
  5. `nacro.autocmds` - Autocommands
  6. `nacro.lsp` - LSP keymaps and diagnostic config
  7. Feature modules (terminal, howdoi, neovide, buffer)

### Directory Structure
- `lua/nacro/` - Core Lua modules
  - `plugins/` - Plugin configurations, each plugin gets its own file
  - `dap/` - Debug Adapter Protocol modules (restart, picker, launch_config)
  - `colorscheme/` - Colorscheme tweaks (nordic, substrata, codedark, sobrio)
  - `snippet/` - Language-specific snippets (go, lua, dart, markdown, common, todo, telekasten)
  - `utils/` - Utility modules (command, highlight, map)
- `ftplugin/` - Filetype-specific configurations (mix of .lua and .vim)
- `after/` - After-runtime configurations
- `snippets/` - SnipMate format snippets (go, norg)
- `spell/` - Spell files (en, tr)
- `stylua.toml` - Lua formatter configuration

### Plugin Management
The configuration uses lazy.nvim with:
- Lazy loading via `keys`, `cmd`, `event`, and `ft` triggers
- Dev plugins stored in `~/Projects` (see `lua/nacro/lazy.lua`)
- Main plugin list in `lua/nacro/plugins/init.lua`
- Individual plugin configs in separate files
- Disabled built-ins via `rtp.disabled_plugins`: gzip, netrw, tar, tohtml, tutor, zip

### Key Architectural Patterns

**Plugin Configuration Pattern:**
Each plugin gets its own file in `lua/nacro/plugins/` that returns a lazy.nvim spec table:
```lua
return {
  "plugin/name",
  event = "VeryLazy",    -- or keys, cmd, ft
  config = function() ... end,
  keys = { ... },
  dependencies = { ... },
}
```

**Colorscheme Tweaks:**
The colorscheme system (`lua/nacro/colorscheme/init.lua`) supports per-colorscheme customizations.

**Module Loading:**
The `nacro.module.saferequire()` function provides safe module loading with error handling.

## Language Server Configuration

LSP uses Neovim 0.11+ native API in `lua/nacro/plugins/lspconfig.lua`:
- `vim.lsp.config(name, cfg)` and `vim.lsp.enable(name)` for server setup
- LSP keymaps and diagnostic config are in `lua/nacro/lsp.lua`

Configured LSP servers: lua_ls, gopls, ts_ls, dartls, pyright, bashls, hls, clangd, jdtls, phpactor, yamlls, dockerls, zls, flow, svelte, kotlin_language_server.

### Language-Specific LSP Settings

**Go (gopls):**
- Completion: `completeUnimported: true`, `usePlaceholders: false`
- Inlay hints: compositeLiteralFields, compositeLiteralTypes, rangeVariableTypes, constantValues
- Custom delve debugger path: `/home/nacro90/.gvm/pkgsets/go1.23.6/global/bin/dlv`

**TypeScript/JavaScript (ts_ls):**
- Comprehensive inlay hints for enums, return types, parameters, properties, variables

**Lua (lua_ls):**
- Runtime: LuaJIT with Neovim-specific configuration
- Vim global and Neovim runtime library available

## Debugging (DAP)

Configuration in `lua/nacro/plugins/nvim-dap.lua` with custom modules in `lua/nacro/dap/`:

### DAP Modules
- `lua/nacro/dap/restart.lua` - Smart restart with rebuild support
- `lua/nacro/dap/picker.lua` - Telescope-based configuration picker
- `lua/nacro/dap/launch_config.lua` - Loads `.nvim/dap.lua` or `.vscode/launch.json`

### Features
- Smart continue: picks config if no session, continues if active
- Smart restart: terminate + rebuild + restart in one action
- Telescope picker for debug configurations
- Process attach picker for Go processes
- Persistent breakpoints across sessions
- Auto-open DAP UI on debug start

### DAP Key Mappings
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Clear all breakpoints
- `<leader>dd` - Smart continue (start/continue)
- `<leader>dr` - Smart restart (rebuild)
- `<leader>dR` - Run last config
- `<leader>dp` - Pick configuration (Telescope)
- `<leader>da` - Attach to process
- `<leader>dq` - Terminate
- `<leader>de` - Open REPL
- `<leader>dn` / `<leader>dN` - Step over / Step back
- `<leader>di` / `<leader>do` - Step into / Step out
- `<leader>du` - Toggle UI
- `<leader>dB` - List breakpoints (Telescope)
- `<leader>dt` / `<leader>dT` - Debug test at cursor / Debug last test (Go)
- `K` - Evaluate expression (in debug mode)
- `]b` / `[b` - Next/previous breakpoint

## Key Mappings Philosophy

Leader key is `<Space>`.

### Core LSP Mappings (lsp.lua)
- `gd` - Go to definition
- `<C-k>` - Hover documentation
- `<C-j>` - Diagnostic float
- `<leader>a` - Code actions
- `[d` / `]d` - Navigate diagnostics (uses `vim.diagnostic.jump`)
- `<C-q>` - Signature help
- `gD` - Type definition
- `gl` - Format buffer

### Navigation & Editing (keymaps.lua)
- `j` / `k` - Visual line navigation (gj/gk)
- `^` - Visual line first char (g^)
- `'` - Go to exact mark (backtick)
- `zz` - Center and move to first non-blank
- `<C-e>` / `<C-y>` - Scroll 3 lines
- `<C-w>N` - Open buffer in new Kitty window

### Toggle Options (yo* prefix)
- `yon` - Line numbers
- `yor` - Relative numbers
- `yow` - Word wrap
- `yoc` - Cursor line
- `yos` - Spell check

### Text Operations
- `gr*` - Substitute operators (via substitute.nvim)
- `gx*` - Exchange operators
- `[p` / `]p` - Paste above/below with newline
- `il` / `al` - Inner/around entire line
- `ae` / `ie` - Entire buffer text object

### Terminal Mode
- `<Esc>` - Exit terminal mode
- `<C-w>` - Window commands (navigation, splits, etc.)
- `<C-Space><C-m>` - New tab with terminal

### Window & Tab Management
- `<C-w>n` / `<C-w><C-n>` - Vertical split new window
- `<leader>R` - Smart splits resize mode
- `<leader>>` / `<leader><` - Move tab right/left

## Custom Modules

- `nacro.commands` - Custom commands (LuaHas, RemoveTrailingWhitespace, RenameBuffer, etc.)
- `nacro.autocmds` - Autocommands (highlight yank, jump to last position)
- `nacro.lsp` - LSP keymaps and diagnostic configuration
- `nacro.terminal` - Terminal setup with keymaps
- `nacro.buffer` - Buffer management (`:CleanSlate`)
- `nacro.howdoi` - Stack Overflow integration
- `nacro.kitty` - Kitty terminal integration
- `nacro.neovide` - Neovide GUI-specific settings (font, linespace=10)
- `nacro.todo` - Todo file management with priorities and dates
- `nacro.os` - OS detection (Linux/macOS)
- `nacro.functions` - Utility functions
- `nacro.module` - Safe require wrapper

## Special Commands

Custom user commands (defined in `nacro.commands`):
- `:LuaHas <module>` - Check if a Lua module exists
- `:RemoveTrailingWhitespace` - Clean up trailing spaces
- `:RenameBuffer [name]` - Rename current buffer
- `:TimestampToDatetime <timestamp>` - Convert Unix timestamp to datetime
- `:Howdoi <query>` - Stack Overflow lookup
- `:Deasciify` - Turkish character conversion
- `:CleanSlate` - Delete all buffers
- `:W`, `:Q`, `:Wq`, `:WQ` - Common typo fixes

## Editor Settings

Key settings (from `lua/nacro/options.lua`):
- Leader: `<Space>`
- Line numbers: relative + absolute
- Indentation: 4 spaces, expandtab, smartindent
- Search: ignorecase + smartcase, live substitute preview
- Signcolumn: auto:2
- Undofile: persistent undo enabled
- Swapfile: disabled
- timeoutlen: 500ms
- updatetime: 500ms

## Notes for AI Assistants

- **Modular init.lua**: Don't add code to init.lua directly. Use the appropriate module:
  - Commands → `lua/nacro/commands.lua`
  - Autocommands → `lua/nacro/autocmds.lua`
  - LSP keymaps → `lua/nacro/lsp.lua`
  - Base keymaps → `lua/nacro/keymaps.lua`
  - Options → `lua/nacro/options.lua`
- When editing plugin configurations, find the appropriate file in `lua/nacro/plugins/`
- For LSP server changes, modify the `configs` table in `lspconfig.lua`
- New plugins should be added as separate files in `lua/nacro/plugins/`
- The config uses lazy loading extensively - check `keys`, `cmd`, `event`, and `ft` fields
- DAP uses custom modules in `lua/nacro/dap/` for smart restart and config picking
- Custom delve path for Go: `/home/nacro90/.gvm/pkgsets/go1.23.6/global/bin/dlv`
- substitute.nvim removes Neovim 0.11 default `gr*` LSP mappings in its `init` hook
- This configuration includes Turkish language support
