local translate = {}

local Job = require "plenary.job"

local command = require "nacro.utils.command"

local fn = vim.fn

local TRANSLATION_PAIRS = {
  { "en", "tr" },
  { "tr", "en" },
}

function translate.setup()
  command("Translate", function(arg)
    translate.interactive(arg and arg ~= "" and arg)
  end, {
    nargs = "?",
  })
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
  assert(fn.executable "translate" == 1, "`translate` executable does not exists on path")

  if text then
    trigger_pair_selection(text)
  else
    vim.ui.input({ prompt = "Translate: " }, trigger_pair_selection)
  end
end

function translate.translate(text, from, to)
  local job = Job:new {
    command = "translate",
    args = {
      "-s",
      from,
      "-t",
      to,
      text,
    },
  }
  job:sync()
  return table.concat(job:result(), "\n")
end

return translate
