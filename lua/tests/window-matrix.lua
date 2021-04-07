


local reset = false

if reset then
vim.g.winnr1 = nil
vim.g.winnr2 = nil
return
end






local function matrix(popup_opts)
layout = 'horizontal'


local obj_opts = {}
local log_opts = {}

if layout == 'horizontal' then
obj_opts = {
 col = popup_opts.col,
 row = popup_opts.row,
 width = math.floor(popup_opts.width / 2),
 height = popup_opts.height 
}



log_opts = {
col = math.floor(popup_opts.col + popup_opts.width / 2),
row = popup_opts.row,
width = math.floor(popup_opts.width / 2),
height = popup_opts.height
}

elseif layout == 'vertical' then

end



return { obj_opts = obj_opts, log_opts = log_opts }
end




local popup_opts = {
   relative = 'editor',
  col = math.floor(vim.o.columns * 0.1),
  height = math.floor(vim.o.lines * 0.3),
  row = math.floor(vim.o.lines * 0.9),
  width = math.floor(vim.o.columns * 0.8),
 anchor = 'SW'
} 

-- input only necessary keys to matrix and merge with other popup_opts keys after function return
local window_opts = matrix({
col = vim.deepcopy(popup_opts.col),
row = vim.deepcopy(popup_opts.row),
width = vim.deepcopy(popup_opts.width),
height = vim.deepcopy(popup_opts.height)
})

obj_opts = window_opts.obj_opts
log_opts = window_opts.log_opts

local obj_opts = vim.tbl_deep_extend('keep', obj_opts, popup_opts)
local log_opts = vim.tbl_deep_extend('keep', log_opts, popup_opts)


-- dump(popup_opts)
-- dump(obj_opts)
-- dump(log_opts)





--if vim.g.winnr1 == nil and vim.g.winnr2 == nil then
 local bufnr1 = vim.api.nvim_create_buf(false, true)
 local bufnr2 = vim.api.nvim_create_buf(false, true)

local bufnr1content = { 'win1' }
local bufnr2content = { 'win2' }

local bufnr1count = vim.tbl_count(bufnr1content)
local bufnr2count = vim.tbl_count(bufnr2content)

-- bufnr after win creation, need winnr to resize dependant on info
vim.api.nvim_buf_set_lines(bufnr1, 0, -1, true, bufnr1content)
 vim.api.nvim_buf_set_lines(bufnr2, 0, -1, true, bufnr2content)


vim.g.winnr1 = vim.api.nvim_open_win(bufnr1, false, obj_opts)
vim.g.winnr2 = vim.api.nvim_open_win(bufnr2, false, log_opts)
 

--end

--lo(vim.g.winnr1)
--lo(vim.g.winnr2)
local function resize_window()
local prevwin = vim.api.nvim_get_current_win()
vim.api.nvim_set_current_win(vim.g.winnr1)
vim.api.nvim_win_set_config(vim.g.winnr1, obj_opts)
vim.api.nvim_set_current_win(vim.g.winnr2)
vim.api.nvim_win_set_config(vim.g.winnr2, log_opts)
vim.api.nvim_set_current_win(prevwin)
end



--- old





-- local obj_opts = {
--   relative = 'editor',
--   col = math.floor(vim.o.columns * 0.1),
--   height = math.floor(vim.o.lines * 0.3),
--   row = math.floor(vim.o.lines * 0.9),
--   width = math.floor(vim.o.columns * 0.8),
--  anchor = 'SW'
-- } 

-- local log_opts = {
--    relative = 'editor',
--   col = math.floor(vim.o.columns * 0.1),
--   height = math.floor(vim.o.lines * 0.3),
--   row = math.floor(vim.o.lines * 0.9),
--   width = math.floor(vim.o.columns * 0.8),
--  anchor = 'SW'
-- } 
