local M = {}

local clipboard_image = require "clipboard-image"

local function get_image_name()
  vim.fn.inputsave()
  local name = vim.fn.input "Image name: "
  vim.fn.inputrestore()

  if name == nil or name == "" then
    return os.date "%y-%m-%d-%H-%M-%S"
  end
  return name
end

local function insert_name_to_md_image(img)
  vim.cmd "normal! f["
  vim.cmd("normal! a" .. img.name)
end

function M.setup()
  clipboard_image.setup {
    default = {
      img_name = get_image_name,
    },
    markdown = {
      img_dir = "static",
      img_dir_txt = "static",
      img_handler = insert_name_to_md_image,
    },
  }
end

return M
