local window = {}

local popup = require('popup')
local state = require'livetablelogger/state'
local log = require'livetablelogger/log'


function window.open_close()
  log.log(state.ui)
if state.ui.bufnr == nil then print('buf not created yet') return end



if state.ui.winnr == nil then 

local popup_opts = {
 -- border = {},
--  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
relative = 'editor',
  col = math.floor(vim.o.columns * 0.1),
 -- enter = false,
  height = math.floor(vim.o.lines * 0.3),
  row = math.floor(vim.o.lines * 0.9),
--  minheight = 50,
 -- title = "LiveTableLogger",
  width = math.floor(vim.o.columns * 0.8),
 anchor = 'SW'
} 

--log.log('window opened')
--local winnr = popup.create('', popup_opts)

-- create floating window manually
local winnr = vim.api.nvim_open_win(state.ui.bufnr, false, popup_opts)
state.ui.winnr = winnr
else 
vim.api.nvim_win_close(state.ui.winnr, false)
state.ui.winnr = nil
end

end


function window.try()
local popup_opts = {
 -- border = {},
--  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
relative = 'editor',
  col = math.floor(vim.o.columns * 0.8),
 -- enter = false,
  height = math.floor(vim.o.lines * 0.8),
  row = math.floor(vim.o.lines * 0.1),
--  minheight = 50,
 -- title = "LiveTableLogger",
  width = math.floor(vim.o.columns * 0.1),
 anchor = 'SW'
} 
vim.api.nvim_win_set_config(state.ui.winnr, popup_opts)

end

function window.focus()
if vim.api.nvim_get_current_win() ~= state.ui.winnr then
state.prevwin = vim.api.nvim_get_current_win()
vim.api.nvim_set_current_win(state.ui.winnr)
else
vim.api.nvim_set_current_win(state.prevwin)
end


end

return window


--- old


-- local popup_opts = {
--   relative = 'editor',
--   width = 100,
--   height = 100,
--   line = 50,
--   col = 50,


-- }


-- vim.api.nvim_buf_call(bufnr, function()
-- vim.cmd([[augroup Format]])
-- vim.cmd([[au!]])
-- vim.cmd([[autocmd TextChanged,TextChangedI <buffer> lua require('livetablelogger/renderer').on_buf_write_post()]])
-- vim.cmd([[augroup END]])

--  -- vim.api.nvim_feedkeys('gg=G', 'n', true)
-- end)

-- self:puts('<', tv, ' ', self:getId(v), '>')

