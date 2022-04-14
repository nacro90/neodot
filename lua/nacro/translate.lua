local translate = {}

local Job = require "plenary.job"

local fn = vim.fn
local api = vim.api

local TRANS_CMD = "trans"

local TRANSLATION_PAIRS = {
  { "en", "tr" },
  { "tr", "en" },
  { "en", "en" },
}

function translate.setup()
  api.nvim_create_user_command("Translate", function(keys)
    local arg = keys.args
    translate.interactive(arg and arg ~= "" and arg)
  end, { nargs = "?" })
end

local function render_translation_pairs()
  return vim.tbl_map(function(pair)
    return pair[1] .. " -> " .. pair[2]
  end, TRANSLATION_PAIRS)
end

local function create_select_callback(text)
  return function(_, idx)
    local from, to = unpack(TRANSLATION_PAIRS[idx])
    local translation = translate.translate(text, from, to)
    print(translation)
  end
end

local function trigger_pair_selection(inp)
  vim.ui.select(
    render_translation_pairs(),
    { prompt = "Select Language Pair" },
    create_select_callback(inp)
  )
end

function translate.interactive(text)
  assert(fn.executable(TRANS_CMD) == 1, "`" .. TRANS_CMD .. "` executable does not exists on path")

  if text then
    trigger_pair_selection(text)
  else
    vim.ui.input({ prompt = "Translate: " }, trigger_pair_selection)
  end
end

function translate.translate(text, from, to)
  local job = Job:new {
    command = TRANS_CMD,
    args = {
      "--no-ansi",
      "-from",
      from,
      "-to",
      to,
      text,
    },
  }
  job:sync()
  return table.concat(job:result(), "\n")
end

return translate
