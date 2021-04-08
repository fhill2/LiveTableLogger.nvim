cwin = {}
yx = vim.api.nvim_call_function('win_screenpos', {0}) 
cwin_col, cwin_row = yx[2], yx[1]
cwin_width = vim.api.nvim_call_function('winwidth', {0})
cwin_height = vim.api.nvim_call_function('winheight', {0})

cwin = {
col = cwin_col,
row = cwin_row,
width = cwin_width,
height = cwin_height,
--max_col = cwin_row + cwin_width,
--max_row = cwin_col + cwin_height,
relative = 'editor',
anchor = 'NW'
}


vim.api.nvim_open_win(0, false, cwin)

