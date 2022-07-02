local module = {}

---saferequire safely loads the the modules and operates with them
---@param mod string #module that is tried to be loaded
---@param cb function #callback function to be called if the module can be loaded
function module.saferequire(mod, cb)
  local exists, loaded = pcall(require, mod)
  if not exists then
    vim.api.nvim_err_writeln("safe require can not find the module: " .. mod)
    return
  end
  cb(loaded)
end

return module
