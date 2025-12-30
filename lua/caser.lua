local caser = {}

local map = require "nacro.utils.map"
local nnoremap = map.nnoremap

local vim = vim
local api = vim.api
local cmd = vim.cmd

local function tokenize(str, delim_pattern)
  local tokens = vim.split(str, delim_pattern or "[-_%s]")
  local extended_tokens = {}
  for _, token in ipairs(tokens) do
    for match in string.gmatch(token, "%w%u*%l*%d*") do
      local upper_part = string.match(match, "%u+")
      local lower_part = string.match(match, "%l+")
      local number_part = string.match(match, "%d+")

      local merged = false
      if upper_part then
        if #upper_part > 1 or not lower_part then
          extended_tokens[#extended_tokens + 1] = string.lower(upper_part)
        elseif lower_part then
          extended_tokens[#extended_tokens + 1] = string.lower(upper_part) .. lower_part
          merged = true
        end
      end
      if lower_part and not merged then
        extended_tokens[#extended_tokens + 1] = lower_part
      end
      if number_part then
        extended_tokens[#extended_tokens + 1] = number_part
      end
    end
  end
  return extended_tokens
end

local function snakify(tokens, all_caps)
  if all_caps then
    tokens = vim.tbl_map(function(str)
      return string.upper(str)
    end, tokens)
  end
  return table.concat(tokens, "_")
end

local function kebabify(tokens)
  return table.concat(tokens, "-")
end

local function pascalify(tokens)
  tokens = vim.tbl_map(function(str)
    return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
  end, tokens)
  return table.concat(tokens)
end

local function camelify(tokens)
  local pascalified = pascalify(tokens)
  return string.lower(string.sub(pascalified, 1, 1)) .. string.sub(pascalified, 2)
end

function caser.snakify(str, all_caps)
  return snakify(tokenize(str), all_caps)
end

function caser.kebabify(str)
  return kebabify(tokenize(str))
end

function caser.pascalify(str)
  return pascalify(tokenize(str))
end

function caser.camelify(str)
  return camelify(tokenize(str))
end

local case_types = {
  snake = "snake_case",
  kebab = "kebab-case",
  pascal = "PascalCase",
  camel = "camelCase",
  constant = "CONSTANT_CASE",
}

local function get_visual_selection()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local start_col = start_pos[3]
  local end_col = end_pos[3]

  if start_line ~= end_line then
    return nil
  end

  local line = vim.fn.getline(start_line)
  return string.sub(line, start_col, end_col)
end

local function replace_visual_selection(text)
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local start_col = start_pos[3]
  local end_col = end_pos[3]

  if start_line ~= end_line then
    return
  end

  local line = vim.fn.getline(start_line)
  local new_line = string.sub(line, 1, start_col - 1) .. text .. string.sub(line, end_col + 1)
  vim.fn.setline(start_line, new_line)
end

local function get_word_under_cursor()
  return vim.fn.expand "<cword>"
end

local function replace_word_under_cursor(text)
  local pos = vim.fn.getpos "."
  vim.cmd("normal! ciw" .. text)
  vim.fn.setpos(".", pos)
end

local function transform_text(case_type, visual_mode)
  local text
  if visual_mode then
    text = get_visual_selection()
  else
    text = get_word_under_cursor()
  end

  if not text or text == "" then
    vim.notify("No text to transform", vim.log.levels.WARN)
    return
  end

  local transformed
  if case_type == "snake" then
    transformed = caser.snakify(text, false)
  elseif case_type == "kebab" then
    transformed = caser.kebabify(text)
  elseif case_type == "pascal" then
    transformed = caser.pascalify(text)
  elseif case_type == "camel" then
    transformed = caser.camelify(text)
  elseif case_type == "constant" then
    transformed = caser.snakify(text, true)
  else
    vim.notify("Unknown case type: " .. case_type, vim.log.levels.ERROR)
    return
  end

  if visual_mode then
    replace_visual_selection(transformed)
  else
    replace_word_under_cursor(transformed)
  end
end

function caser.to_snake()
  transform_text("snake", false)
end

function caser.to_kebab()
  transform_text("kebab", false)
end

function caser.to_pascal()
  transform_text("pascal", false)
end

function caser.to_camel()
  transform_text("camel", false)
end

function caser.to_constant()
  transform_text("constant", false)
end

function caser.visual_to_snake()
  transform_text("snake", true)
end

function caser.visual_to_kebab()
  transform_text("kebab", true)
end

function caser.visual_to_pascal()
  transform_text("pascal", true)
end

function caser.visual_to_camel()
  transform_text("camel", true)
end

function caser.visual_to_constant()
  transform_text("constant", true)
end

function caser.command(opts)
  local case_type = opts.args
  if not case_types[case_type] then
    vim.notify("Unknown case type. Available: snake, kebab, pascal, camel, constant", vim.log.levels.ERROR)
    return
  end
  transform_text(case_type, false)
end

_G.CaserCompletionItems = function()
  return vim.tbl_keys(case_types)
end

cmd [[
  command! -nargs=1 -complete=customlist,v:lua.CaserCompletionItems Caser lua require("caser").command({args = <q-args>})
]]

function caser.setup()
  -- Normal mode mappings (work on word under cursor)
  nnoremap("<leader>cs", caser.to_snake, { desc = "Convert to snake_case" })
  nnoremap("<leader>ck", caser.to_kebab, { desc = "Convert to kebab-case" })
  nnoremap("<leader>cp", caser.to_pascal, { desc = "Convert to PascalCase" })
  nnoremap("<leader>cc", caser.to_camel, { desc = "Convert to camelCase" })
  nnoremap("<leader>cC", caser.to_constant, { desc = "Convert to CONSTANT_CASE" })

  -- Visual mode mappings (work on selection)
  vim.keymap.set("v", "<leader>cs", function()
    caser.visual_to_snake()
  end, { desc = "Convert to snake_case" })
  vim.keymap.set("v", "<leader>ck", function()
    caser.visual_to_kebab()
  end, { desc = "Convert to kebab-case" })
  vim.keymap.set("v", "<leader>cp", function()
    caser.visual_to_pascal()
  end, { desc = "Convert to PascalCase" })
  vim.keymap.set("v", "<leader>cc", function()
    caser.visual_to_camel()
  end, { desc = "Convert to camelCase" })
  vim.keymap.set("v", "<leader>cC", function()
    caser.visual_to_constant()
  end, { desc = "Convert to CONSTANT_CASE" })
end

return caser
