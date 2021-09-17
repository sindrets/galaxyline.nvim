local buffer = {}

local buf_icon = {
  help = "  ",
  defx = "  ",
  nerdtree = "  ",
  denite = "  ",
  ["vim-plug"] = "  ",
  vista = " 識",
  vista_kind = "  ",
  dbui = "  ",
  NeogitStatus = "  ",
  NvimTree = "  ",
}

buffer.get_buffer_type_icon = function()
  return buf_icon[vim.bo.filetype]
end

buffer.get_buffer_filetype = function()
  return vim.bo.filetype:upper()
end

-- get buffer number
buffer.get_buffer_number = function()
  local buffers = {}
  for _, val in ipairs(vim.fn.range(1, vim.fn.bufnr("$"))) do
    if vim.fn.bufexists(val) == 1 and vim.fn.buflisted(val) == 1 then
      table.insert(buffers, val)
    end
  end

  for idx, nr in ipairs(buffers) do
    if nr == vim.fn.bufnr("") then
      return idx
    end
  end
end

return buffer
