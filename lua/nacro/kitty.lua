local kitty = {}

function kitty.buffer_to_new_window()
  vim.cmd("silent !kitty --detach nvim --cmd 'lua vim.g.unception_disable = true' " .. vim.fn.expand "%:p")
end

return kitty
