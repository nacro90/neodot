local autocmd = {}

---@alias Event '"BufAdd"' | '"BufDelete"' | '"BufEnter"' | '"BufFilePost"' | '"BufFilePre"' | '"BufHidden"' | '"BufLeave"' | '"BufModifiedSet"' | '"BufNew"' | '"BufNewFile"' | '"BufRead"' | '"BufReadPost"' | '"BufReadCmd"' | '"BufReadPre"' | '"BufUnload"' | '"BufWinEnter"' | '"BufWinLeave"' | '"BufWipeout"' | '"BufWrite"' | '"BufWritePre"' | '"BufWriteCmd"' | '"BufWritePost"' | '"ChanInfo"' | '"ChanOpen"' | '"CmdUndefined"' | '"CmdlineChanged"' | '"CmdlineEnter"' | '"CmdlineLeave"' | '"CmdwinEnter"' | '"CmdwinLeave"' | '"ColorScheme"' | '"ColorSchemePre"' | '"CompleteChanged"' | '"CompleteDonePre"' | '"CompleteDone"' | '"CursorHold"' | '"CursorHoldI"' | '"CursorMoved"' | '"CursorMovedI"' | '"DiffUpdated"' | '"DirChanged"' | '"FileAppendCmd"' | '"FileAppendPost"' | '"FileAppendPre"' | '"FileChangedRO"' | '"ExitPre"' | '"FileChangedShell"' | '"FileChangedShellPost"' | '"FileReadCmd"' | '"FileReadPost"' | '"FileReadPre"' | '"FileType"' | '"FileWriteCmd"' | '"FileWritePost"' | '"FileWritePre"' | '"FilterReadPost"' | '"FilterReadPre"' | '"FilterWritePost"' | '"FilterWritePre"' | '"FocusGained"' | '"FocusLost"' | '"FuncUndefined"' | '"UIEnter"' | '"UILeave"' | '"InsertChange"' | '"InsertCharPre"' | '"TextYankPost"' | '"InsertEnter"' | '"InsertLeavePre"' | '"InsertLeave"' | '"MenuPopup"' | '"OptionSet"' | '"QuickFixCmdPre"' | '"QuickFixCmdPost"' | '"QuitPre"' | '"RemoteReply"' | '"SessionLoadPost"' | '"ShellCmdPost"' | '"Signal"' | '"ShellFilterPost"' | '"SourcePre"' | '"SourcePost"' | '"SourceCmd"' | '"SpellFileMissing"' | '"StdinReadPost"' | '"StdinReadPre"' | '"SwapExists"' | '"Syntax"' | '"TabEnter"' | '"TabLeave"' | '"TabNew"' | '"TabNewEntered"' | '"TabClosed"' | '"TermOpen"' | '"TermEnter"' | '"TermLeave"' | '"TermClose"' | '"TermResponse"' | '"TextChanged"' | '"TextChangedI"' | '"TextChangedP"' | '"User"' | '"UserGettingBored"' | '"VimEnter"' | '"VimLeave"' | '"VimLeavePre"' | '"VimResized"' | '"VimResume"' | '"VimSuspend"' | '"WinClosed"' | '"WinEnter"' | '"WinLeave"' | '"WinNew"' | '"WinScrolled"'

---@class Autocmd
---@field public events Event[]
---@field public patterns string[]
---@field public cmd string|function
---@field public is_once boolean|nil
---@field public buffer integer|boolean|nil

local cmd = vim.cmd

---@type function()
autocmd.callbacks = {}

---@param aucmd Autocmd
local function create_autocmd_str(aucmd)
  local events_str = table.concat(aucmd.events, ",")
  local patterns_str = table.concat(aucmd.patterns, ",")
  local once_str = aucmd.is_once and "++once" or ""
  local cmd_str = aucmd.cmd
  local buffer_str = ""
  if aucmd.buffer then
    if type(aucmd.buffer) == "number" then
      buffer_str = ("<buffer=%d"):format(aucmd.buffer)
    else
      buffer_str = "<buffer>"
    end
  end
  if type(aucmd.cmd) == "function" then
    local callback_index = #autocmd.callbacks + 1
    autocmd.callbacks[callback_index] = aucmd.cmd
    cmd_str = "lua require('nacro.utils.autocmd').callbacks[" .. callback_index .. "]()"
  end
  return ("autocmd! %s %s %s %s %s"):format(events_str, buffer_str, patterns_str, once_str, cmd_str)
end

---@param name string @name of augroup
---@param autocmds Autocmd[]
function autocmd.augroup(name, autocmds)
  local augroup_str = [[
    augroup %s
      autocmd!
      %s
    augroup END
  ]]
  augroup_str:format(name, autocmds)
end

return autocmd
