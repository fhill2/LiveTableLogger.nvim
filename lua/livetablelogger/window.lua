local window = {}

local popup = require('popup')
local state = require'livetablelogger/state'
local log = require'livetablelogger/log'

local utils = require'livetablelogger/utils'
local get_default = utils.get_default

local config = require'livetablelogger/config'

--lo(renderer)

-- local function switch_view_target(view, target)
-- end






function window.open(opts)
local renderer = require'livetablelogger/renderer'

opts = opts or {}
--opts.view1 = nil
--opts.view2 = { target = 'asd' }

-- for each view in opts, switch target and open window
for k,v in pairs(opts) do
if k:find('^view[%d]*') ~= nil then 
local view = k
--local view_index = k:gsub('view', '')
--local view_index = tonumber(view_index)
--lo(opts[current_view].popup_opts)
--lo(config.view.popup_opts)
local popup_opts = get_default(opts[view].popup_opts, config.view.popup_opts)
local target = get_default(opts[view].target, config.view.target)
state.ui[view] = { target = target, popup_opts = popup_opts }
-- if view is already target, dont do anything


if state.ui[view].target ~= v then 
local target = state.instances[target].store
state.ui[view].target = target
end

renderer.update_display(view)
window.open_single_window(view, popup_opts)


end -- if find

end -- for loop

end




function window.open_single_window(view, popup_opts)




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
lo(view)
lo(state.ui[view].bufnr)
if state.ui[view].bufnr == nil then print('buf not created yet') return end

local winnr = vim.api.nvim_open_win(state.ui[view].bufnr, false, popup_opts)
state.ui[view].winnr = winnr
end



function window.focus()
if vim.api.nvim_get_current_win() ~= state.ui.winnr then
state.disp1.prevwin = vim.api.nvim_get_current_win()
vim.api.nvim_set_current_win(state.ui.disp1.winnr)
else
vim.api.nvim_set_current_win(state.disp1.prevwin)
end


end

return window


--- old


-- old close
--vim.api.nvim_win_close(state.ui.disp1.winnr, false)
--state.ui.disp1.winnr = nil



-- set target
--local target = get_default(opts.target, 'g_fstate_/home/f1/.config/nvim/init.lua') 
-- if opts.target ~= nil then
-- lo(opts)
-- lo(opts.target)
-- switch_target('disp1', opts.target)
-- end


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

