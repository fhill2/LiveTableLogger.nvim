-- plenary border using only _create_lines. no window opening
local Border = require'livetablelogger/border'



local popup_opts =  {
col = 60,
row = 60,
width = 60,
height = 60,
relative = 'editor',
style = 'minimal',
anchor = 'NW',
}

local border_opts = {
top = '─', 
left = '│', 
bot = '─', 
right = '│', 
topleft = '╭', 
topright = '╮', 
botright = '╯', 
botleft = '╰',
border_thickness = {
top = 1,
left = 1,
right = 1,
bot = 1
},
title = 'asd'
}





local bufnr = vim.api.nvim_create_buf(false, true)





  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")


 local contents = Border._create_lines(popup_opts, border_opts)
 vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
 vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {'asd', 'some more'})

popup_opts.row = popup_opts.row - 1
popup_opts.col = popup_opts.col - 1
popup_opts.width = popup_opts.width + 2
popup_opts.height = popup_opts.height + 2

local winnr = vim.api.nvim_open_win(bufnr, false, popup_opts)


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

