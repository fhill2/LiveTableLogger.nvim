local popup_opts =  {
col = 1,
row = 1,
width = 40,
height = 40,
relative = 'win',
win = 0,
anchor = 'NE',
}

vim.api.nvim_open_win(vim.api.nvim_create_buf(false, false), false, popup_opts)
