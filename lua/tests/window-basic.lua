local popup_opts =  {
col = vim.o.columns,
row = vim.o.lines,
width = 40,
height = 40,
relative = 'editor',
--win = 0,
anchor = 'NW',
}

vim.api.nvim_open_win(vim.api.nvim_create_buf(false, false), false, popup_opts)
