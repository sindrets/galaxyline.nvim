stds.nvim = {
  globals = {
    vim = { fields = { "g" } },
    -- table = { fields = { "unpack" } },
    -- package = { fields = { "searchers" } },
  },
  read_globals = {
    "vim",
  },
}
std = "lua51+nvim"

-- Rerun tests only if their modification time changed
cache = true

ignore = {
	'631', -- max_line_length
	'122', -- setting read-only field
	'211', -- unused recursive function
	'432', -- shadowing upvalue argument
}

read_globals = {
	'vim',
}

-- vim: ft=lua
