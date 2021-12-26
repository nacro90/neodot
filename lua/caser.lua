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
  return string.upper(string.sub(pascalified, 1, 1)) .. string.sub(pascalified, 2)
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

function caser.command()
  print "kemal"
end

_G.CaserCompletionItems = function()
  return {
    "osman",
    "kemal",
  }
end

cmd [[
  function g:CaserCompleteItems(A, L, P)
    return ['osman', 'kemal']
  endfunction
  command! -complete=customlist,{->['osamn','emal']} Caser echom "kemal" 
]]

return caser
