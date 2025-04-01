local M = {}

function M.save_as_and_open()
  local current_file = vim.fn.expand('%:p')
  local new_file = vim.fn.input("Save as: ", current_file)

  if new_file ~= "" and new_file ~= current_file then
    vim.cmd("w " .. vim.fn.fnameescape(new_file))
    vim.cmd("edit " .. vim.fn.fnameescape(new_file))
  elseif new_file ~= "" then
    print("New file name is the same as the current file.")
  end
end

return M

