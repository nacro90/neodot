-- nvim-treesitter 1.0+ configuration
-- New API: Plugin only manages parser installation
-- Highlight/indent/fold are handled via Neovim native vim.treesitter API

-- Languages where treesitter indent should be disabled (quirky behavior)
local INDENT_DISABLED = {
  yaml = true,
  python = true,
}

-- Filetypes to skip (special buffers, plugins)
local SKIP_FILETYPES = {
  oil = true,
  lazy = true,
  mason = true,
  ["neo-tree"] = true,
  NvimTree = true,
  TelescopePrompt = true,
  qf = true,
  help = true,
  [""] = true,
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    -- Install all stable parsers on plugin build/update
    require("nvim-treesitter").install("stable")
  end,
  event = { "BufReadPre", "BufNewFile" },
  cmd = {
    "TSInstall",
    "TSInstallFromGrammar",
    "TSUpdate",
    "TSUninstall",
    "TSLog",
  },
  config = function()
    -- Enable treesitter features via FileType autocmd
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
      callback = function(args)
        local bufnr = args.buf
        local ft = args.match

        -- Skip special buffer types (nofile, prompt, help, quickfix, etc.)
        -- This automatically handles most plugin buffers
        local buftype = vim.bo[bufnr].buftype
        if buftype ~= "" then
          return
        end

        -- Skip specific filetypes that slip through buftype check
        if SKIP_FILETYPES[ft] then
          return
        end

        -- Check if parser exists for this filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local ok = pcall(vim.treesitter.language.add, lang)
        if not ok then
          return
        end

        -- Enable treesitter highlighting (replaces regex syntax)
        -- Use pcall to handle edge cases gracefully
        pcall(vim.treesitter.start, bufnr, lang)

        -- Enable treesitter indentation (skip problematic languages)
        if not INDENT_DISABLED[ft] then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
