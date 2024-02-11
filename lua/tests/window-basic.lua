-- plenary border using only _create_lines. no window opening
--local Border = require'livetablelogger/border'




-- local border_opts = {
-- top = '─', 
-- left = '│', 
-- bot = '─', 
-- right = '│', 
-- topleft = '╭', 
-- topright = '╮', 
-- botright = '╯', 
-- botleft = '╰',
-- border_thickness = {
-- top = 1,
-- left = 1,
-- right = 1,
-- bot = 1
-- },
-- title = 'asd'
-- }


local popup_opts =  {
col = 0,
row = 0,
width = 50,
height = 10,
relative = 'win',
style = 'minimal',
anchor = 'NW',
title = 'asd',
win = vim.api.nvim_get_current_win(),
--border = 'single'
--border = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
--border = {{'', 'NormalFloat'}}
}
local bufnr = vim.api.nvim_create_buf(false, true)


vim.fn.popup_create({ bufnr , popup_opts })

vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {'1', '2', '3', '4', '5'})
local winnr = vim.api.nvim_open_win(bufnr, false, popup_opts)





--   vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")


--  local contents = Border._create_lines(popup_opts, border_opts)
--  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

-- popup_opts.row = popup_opts.row - 1
-- popup_opts.col = popup_opts.col - 1
-- popup_opts.width = popup_opts.width + 2
-- popup_opts.height = popup_opts.height + 2



--local border_winnr = Border:new(bufnr, winnr, popup_opts, border_win_opts)




-- old


-- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'}

-- local border_win_opts = {
-- top = '─', 
-- left = '│', 
-- bottom = '─', 
-- right = '│', 
-- topleft = '╭', 
-- topright = '╮', 
-- botright = '╯', 
-- botleft = '╰',
-- title = 'asd'
-- }

