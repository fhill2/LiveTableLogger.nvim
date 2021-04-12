local popup = require('popup')


local popup_opts = {
border = {},
borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
col = 10,
enter = false,
height = 88,
line = 11,
--minheight = 88,
title = 'Results',
width = 118
}

local winnr = popup.create('', popup_opts)
local bufnr = vim.api.nvim_win_get_buf(winnr)

vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {'asd', 'a test'})
