local reloader = {}

local function lua_file_to_module(file, prefix)
   if prefix then file = file:gsub(prefix, '') end
   return file:gsub('%.lua$', ''):gsub('/', '.')
end

function reloader.reload(vimrc, config_path)
   config_path = config_path or vim.fn.stdpath('config') .. '/lua/'
   local lua_files = vim.split(vim.fn.glob(config_path .. '**/*.lua'), '\n')
   local modules = vim.tbl_map(function(file)
      return lua_file_to_module(file, config_path)
   end, lua_files)

   for _, module in pairs(modules) do package.loaded[module] = nil end

   require(vimrc or 'vimrc')
end

return reloader

