---@type map
local map = {}

---@class map_attrs
---@field public nowait boolean
---@field public silent boolean
---@field public script boolean
---@field public expr boolean
---@field public unique boolean
---@field public bufnr integer

---@class map
---@field public nnoremap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public vnoremap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public inoremap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public xnoremap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public tnoremap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public cnoremap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public nmap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public vmap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public imap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public xmap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field public tmap function(lhs:string, rhs:string, bufnr:integer|nil, attrs:map_attrs)
---@field private _callbacks function[]

local api = vim.api
local keymap = api.nvim_set_keymap
local bufkeymap = api.nvim_buf_set_keymap

---@type table<integer,function>
local callbacks = {}

---Call the callback of given index
---@param callback_index integer
---@return nil
function map.call(callback_index)
  callbacks[callback_index]()
end

---Insert lua function callback
---@param callback function @Function to be call as a callback
---@return integer @Index of inserted callback
local function insert_callback(callback)
  local callback_index = #callbacks + 1
  callbacks[callback_index] = callback
  return callback_index
end

---@param mode string @map mode
---@param noremap boolean
---@return function(lhs:string, rhs:string|function, bufnr:integer|nil)
local function create_mapper_func(mode, noremap)
  return function(lhs, rhs, bufnr, attrs)
    local action = rhs
    if type(rhs) == "function" then
      local callback_index = insert_callback(rhs)
      action = ("<Cmd>lua require('nacro.utils.map').call(%d)<CR>"):format(callback_index)
    end

    local final_attrs = { noremap = noremap }
    if attrs then
      vim.tbl_extend("force", final_attrs, attrs)
    end

    bufnr = bufnr or final_attrs.bufnr
    if bufnr then
      bufkeymap(bufnr, mode, lhs, action, final_attrs)
    else
      keymap(mode, lhs, action, final_attrs)
    end
  end
end

local modes = { "n", "i", "v", "!", "x", "t", "c" }

for _, mode in ipairs(modes) do
  map[mode .. "noremap"] = create_mapper_func(mode, true)
  map[mode .. "map"] = create_mapper_func(mode, false)
end

return map
