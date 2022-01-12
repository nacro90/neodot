--- Useful editor functions

local functions = {}

local vim = vim

--- Configure a filetype plugin file
function functions.configure_filetype(ft, is_after)
   if not ft then
      -- Show a prompt that is defaulting the current filetype
      ft = vim.fn.input {
         prompt = 'Configure filetype: ',
         default = vim.bo.filetype,
         cancelreturn = nil, -- return nil if cancelled
      }
   end
   -- If there is no selection and no valid ft argument, exit
   if not ft or ft == '' then return end
   -- Get nvim config directory
   local config = vim.fn.stdpath('config')
   if is_after then
      config = config .. '/after'
   end
   vim.cmd(("edit %s/ftplugin/%s.lua"):format(config, vim.trim(ft)))
end


--- Edit a file if it exists
function functions.strict_edit(file)
   if not file then return end
   if vim.fn.filereadable(file) == 1 then
      vim.cmd('edit '..file)
   else
      print(string.format('File %s does not exist!', file))
   end
end


--- Easy expand the path that contains current file
function functions.expand_percentage_if_in_command()
   if vim.fn.getcmdtype() == ':' then
      return vim.fn.expand('%:h') .. '/'
   else
      return '%%'
   end
end


return functions
