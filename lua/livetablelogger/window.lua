local window = {}

local popup = require('popup')
local state = require'livetablelogger/state'
local log = require'livetablelogger/log'

local utils = require'livetablelogger/utils'
local get_default = utils.get_default
local ternary = utils.ternary

local config = require'livetablelogger/config'
local border = require'plenary/window/border'

--lo(renderer)

-- local function switch_view_target(view, target)
-- end



local function apply_pin(colrow, popup_opts, popup_custom_opts)
 
if popup_custom_opts.pin == nil then return false end

local max_col, max_row = popup_custom_opts.max_col, popup_custom_opts.max_row
local width, height = popup_opts.width, popup_opts.height

local choose_pin = {
top = ternary(colrow,false,1), 
topright = ternary(colrow, max_col - width, 1),
right =  ternary(colrow, max_col - width,false), 
bottomright = ternary(colrow, max_col - width, max_row - height),
bottom = ternary(colrow,false, max_row - height), -- -1 for statusline
bottomleft = ternary(colrow, 1, max_row - height), -- -1 for statusline
left = ternary(colrow,1,false), 
topleft = ternary(colrow, 1, 1)
}
return choose_pin[popup_custom_opts.pin]
end





  
function window.open(opts)
local renderer = require'livetablelogger/renderer'



-- ============================================= OPTS =================================================
opts = opts or {}

--- test for multiple windows
-- for k,v in pairs(opts) do
-- if k:find('^view[%d]*') ~= nil then 
-- local view = k
local view = 'view1'
if not state.ui[view] then state.ui[view] = {} end
-- create view in state array






local popup_custom_opts = {
layout = get_default(opts[view].layout, 'horizontal'),
pin = get_default(opts[view].pin, 'bottom'),
log = get_default(opts[view].log, true),
grow = get_default(opts[view].grow, true),
grow_side = get_default(opts[view].grow_size, 'smart'),
}

local popup_opts = {
  col = get_default(opts[view].x, 0.4),
  row = get_default(opts[view].y, 0.4),
  width = get_default(opts[view].width, 40),
  height = get_default(opts[view].height, 40),
  relative = get_default(opts[view].relative, 'win'),
  anchor = 'NW',
 } 


-- decide max_col, max_row dependant on win or global, for pin
if popup_opts.relative == 'win' then
local cwin_max_col = vim.api.nvim_call_function('winwidth', {0})
local cwin_max_row = vim.api.nvim_call_function('winheight', {0})
popup_opts.win = vim.api.nvim_get_current_win()
popup_custom_opts.max_col = cwin_max_col
popup_custom_opts.max_row = cwin_max_row
else
popup_custom_opts.max_col = vim.o.columns
popup_custom_opts.max_row = vim.o.lines
end

popup_opts.col = apply_pin(true, popup_opts, popup_custom_opts) or popup_custom_opts.max_col * popup_opts.col
popup_opts.row = apply_pin(false, popup_opts, popup_custom_opts) or popup_custom_opts.max_row * popup_opts.row

lo(state.ui)
lo(opts[view].target)
state.ui[view].target = 'asd'
state.ui[view].target = opts[view].target


-- makes sure buffers are created if they dont exist


if state.ui[view].obj.bufnr == nil then
state.ui[view].obj.bufnr = renderer.create_buf(view, 'obj')
end

if state.ui[view].log.bufnr == nil and popup_custom_opts.log then
state.ui[view].log.bufnr = renderer.create_buf(view, 'log')
end



renderer.update_display(view)

-- local popup_opts = get_default(opts[view].popup_opts, config.view.popup_opts)
-- local target = get_default(opts[view].target, config.view.target)
-- state.ui[view] = { target = target, popup_opts = popup_opts }
-- -- if view is already target, dont do anything



-- renderer.update_display(view)
-- window.open_single_window(view, popup_opts)








--  local bufnr1 = vim.api.nvim_create_buf(false, true)


-- --- ======= generate buf content start ======
-- local bufnr1content = {}
-- for i=1, 10 do
--   table.insert(bufnr1content, tostring(i))
--   i=i+1  --  print(v)
-- end

-- local bufnr1count = vim.tbl_count(bufnr1content)
-- vim.api.nvim_buf_set_lines(bufnr1, 0, -1, true, bufnr1content)






local function create_window(popup_opts, popup_custom_opts, objlog)

local popup_opts = vim.deepcopy(popup_opts) -- important
--lo('popup_opts start of create window: ')
--lo(popup_opts)
local round = function(n) return math.floor(n + 0.5) end


local layout_bool
if popup_custom_opts.layout == 'horizontal' then layout_bool = true elseif popup_custom_opts.layout == 'vertical' then layout_bool = false end
--local objlog
--if objlog == 'obj' then objlog = true elseif objlog == 'log' then objlog = false end 

popup_opts.col = math.floor(ternary(objlog, ternary(layout_bool, popup_opts.col, popup_opts.col ), ternary(layout_bool, popup_opts.col + popup_opts.width / 2, popup_opts.col)))
popup_opts.row = math.floor(ternary(objlog, ternary(layout_bool, popup_opts.row , popup_opts.row), ternary(layout_bool, popup_opts.row, popup_opts.row + popup_opts.height / 2)))
popup_opts.width = math.floor(ternary(objlog,ternary(layout_bool, popup_opts.width / 2, popup_opts.width),ternary(layout_bool, popup_opts.width / 2 , popup_opts.width)))
popup_opts.height = math.floor(ternary(objlog, ternary(layout_bool, popup_opts.height , popup_opts.height / 2 ), ternary(layout_bool, popup_opts.height, popup_opts.height /2)))




--lo('before window creation')
--lo(popup_opts)

local winnr = vim.api.nvim_open_win(bufnr1, false, popup_opts)
--local winnr = border:new(bufnr1, winnr, popup_opts)

-- create border
--  obj.bufnr = vim.api.nvim_create_buf(false, true)
--   assert(obj.bufnr, "Failed to create border buffer")
--   vim.api.nvim_buf_set_option(obj.bufnr, "bufhidden", "wipe")

-- local border_lines = border._create_lines(popup_opts, border_opts)


--   obj.contents = Border._create_lines(content_win_options, border_win_options)
--   vim.api.nvim_buf_set_lines(obj.bufnr, 0, -1, false, obj.contents)

--   local thickness = border_win_options.border_thickness

--  vim.api.nvim_buf_set_lines(bufnr1.content, 0, -1, false, obj.contents)




return winnr, popup_opts


end



--if vim.g.winnr1 == nil and vim.g.winnr2 == nil then

state.ui[view].obj.winnr, state.ui[view].obj.opts = create_window(popup_opts, popup_custom_opts, true)

if popup_custom_opts.log then
state.ui[view].log.winnr, state.ui[view].log.opts = create_window(popup_opts, popup_custom_opts, false)
end



























-- -- for each view in opts, switch target and open window
-- for k,v in pairs(opts) do
-- if k:find('^view[%d]*') ~= nil then 
-- local view = k


-- local popup_opts = get_default(opts[view].popup_opts, config.view.popup_opts)
-- local target = get_default(opts[view].target, config.view.target)
-- state.ui[view] = { target = target, popup_opts = popup_opts }
-- -- if view is already target, dont do anything


-- if state.ui[view].target ~= v then 
-- local target = state.instances[target].store
-- state.ui[view].target = target
-- end

-- renderer.update_display(view)
-- window.open_single_window(view, popup_opts)


end

--end -- for loop

--end





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



-- if state.ui[view].target ~= v then 
-- local target = state.instances[target].store
-- state.ui[view].target = target
-- end






--lo('cwin is: ') 
--lo(cwin)
--vim.api.nvim_open_win(0, false, cwin)

--start_popup_opts.max_col = ternary(is_window_scoped(start_popup_opts, popup_custom_opts), cwin.max_col, vim.o.columns -1)
--start_popup_opts.max_row = ternary(is_window_scoped(start_popup_opts, popup_custom_opts), cwin.max_row , vim.o.lines)


-- function window.open_single_window(view, popup_opts)




-- local popup_opts = {
--  -- border = {},
-- --  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- relative = 'editor',
--   col = math.floor(vim.o.columns * 0.1),
--  -- enter = false,
--   height = math.floor(vim.o.lines * 0.3),
--   row = math.floor(vim.o.lines * 0.9),
-- --  minheight = 50,
--  -- title = "LiveTableLogger",
--   width = math.floor(vim.o.columns * 0.8),
--  anchor = 'SW'
-- } 
-- lo(view)


-- lo(state.ui[view].bufnr)
-- if state.ui[view].bufnr == nil then print('buf not created yet') return end

-- local winnr = vim.api.nvim_open_win(state.ui[view].bufnr, false, popup_opts)
-- state.ui[view].winnr = winnr
-- end

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

