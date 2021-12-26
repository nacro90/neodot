local kafka = {}

local Job = require "plenary.job"

local nnoremap = require("nacro.utils.map").nnoremap

local vim = vim
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local uv = vim.loop

function kafka.send_buffer_to_topic()
  local bufnr = api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
  local payload = table.concat(lines):gsub("%s+", "")

  local topic = fn.input "Topic: "

  local function on_exit(_, return_val)
    assert(return_val == 0, "Some error happened!")
    cmd(("echom 'Event produced to %s'"):format(topic))
  end

  local job = Job:new {
    command = "kafka-console-producer",
    args = { "--topic", topic, "--bootstrap-server", "localhost:9092" },
    cwd = uv.cwd(),
    writer = payload,
    on_exit = on_exit,
  }
  job:start()
end

return kafka
