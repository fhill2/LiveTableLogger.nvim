local windows = {}

local popup = require('livetablelogger/popup')
local state = require'livetablelogger/state'
local log = require'livetablelogger/log'

local utils = require'livetablelogger/utils'
local get_default = utils.get_default
local ternary = utils.ternary

local config = require'livetablelogger/config'
local border = require'plenary/window/border'

local renderer = require'livetablelogger/renderer'

local Border = require'livetablelogger/border'


local Window = {}
Window.__index = Window









  
function Window:new(opts)

-- ============================================= OPTS =================================================
opts = opts or {}
-- otherwise obj & log padding get_defaults nil error
opts.obj_padding = opts.obj_padding or {}
opts.log_padding = opts.log_padding or {}
--opts.border = opts.border or {}
--opts.border.thickness = opts.border.thickness or {}
--- test for multiple windows
-- for k,v in pairs(opts) do
-- if k:find('^view[%d]*') ~= nil then 
-- local view = k
-- create view in state array



--local obj = {}

custom_opts = {
show_border = get_default(opts.show_border, true),
border_thickness = get_default(opts.border_thickness, { 1,1,1,1}),
borderchars = get_default(opts.borderchars, { '─', '│', '─', '│', '╭', '╮', '╯', '╰'}),
obj_border_title = get_default(opts.obj_title, 'obj'),
log_border_title = get_default(opts.log_title, 'log'),
x = get_default(opts.x, 0),
 y = get_default(opts.y, 0),
layout = get_default(opts.layout, 'vertical'),
pin = get_default(opts.pin, 'top'),
center = get_default(opts.center, true),
log = get_default(opts.log, true),
grow = get_default(opts.grow, true),
grow_side = get_default(opts.grow_size, 'smart'),
winblend = get_default(opts.winblend, 15 ),
split = get_default(opts.split, 0.5),
gap = get_default(opts.gap, 0),
}





if vim.tbl_islist(opts.obj_padding) then
custom_opts.obj_padding = { 
 get_default(opts.obj_padding.top, 1),
 get_default(opts.obj_padding.right, 1),
 get_default(opts.obj_padding.bottom, 1),
 get_default(opts.obj_padding.left, 1),
}
end

if vim.tbl_islist(opts.log_padding) then
custom_opts.log_padding = {
get_default(opts.log_padding.top, 1),
get_default(opts.log_padding.right, 1),
get_default(opts.log_padding.bottom, 1),
get_default(opts.log_padding.left, 1),
}
end

if not vim.tbl_islist(opts.obj_padding) then
custom_opts.obj_padding = { 
top = get_default(opts.obj_padding.top, 1),
right = get_default(opts.obj_padding.right, 1),
bottom = get_default(opts.obj_padding.bottom, 1),
left = get_default(opts.obj_padding.left, 1),
}
end


if not vim.tbl_islist(opts.log_padding) then
custom_opts.log_padding = {
top = get_default(opts.log_padding.top, 1),
right = get_default(opts.log_padding.right, 1),
bottom = get_default(opts.log_padding.bottom, 1),
left = get_default(opts.log_padding.left, 1),
}
end





-- VALIDATE BORDER OPTS snd save back to custom_opts

local border_default_thickness = {
  top = 1,
  right = 1,
  bot = 1,
  left = 1,
}
   local border_options = {}


  if custom_opts.show_border then
    if type(custom_opts.border_thickness) == 'boolean' or vim.tbl_isempty(custom_opts.border_thickness) then
      border_options.border_thickness = border_default_thickness
    elseif #custom_opts.border_thickness == 4 then
      border_options.border_thickness = {
        top = utils.bounded(custom_opts.border_thickness[1], 0, 1),
        right = utils.bounded(custom_opts.border_thickness[2], 0, 1),
        bot = utils.bounded(custom_opts.border_thickness[3], 0, 1),
        left = utils.bounded(custom_opts.border_thickness[4], 0, 1),
      }
    end
  end

    local b_top, b_right, b_bot, b_left, b_topleft, b_topright, b_botright, b_botleft
    if custom_opts.borderchars == nil then
      b_top , b_right , b_bot , b_left , b_topleft , b_topright , b_botright , b_botleft =
        "═" , "║"     , "═"   , "║"    , "╔"       , "╗"        , "╝"        , "╚"
    elseif #custom_opts.borderchars == 1 then
      local b_char = custom_opts.borderchars[1]
      b_top    , b_right , b_bot  , b_left , b_topleft , b_topright , b_botright , b_botleft =
        b_char , b_char  , b_char , b_char , b_char    , b_char     , b_char     , b_char
    elseif #custom_opts.borderchars == 2 then
      local b_char = custom_opts.borderchars[1]
      local c_char = custom_opts.borderchars[2]
      b_top    , b_right , b_bot  , b_left , b_topleft , b_topright , b_botright , b_botleft =
        b_char , b_char  , b_char , b_char , c_char    , c_char     , c_char     , c_char
    elseif #custom_opts.borderchars == 8 then
      b_top , b_right , b_bot , b_left , b_topleft , b_topright , b_botright , b_botleft = unpack(custom_opts.borderchars)
    else
      error(string.format('Not enough arguments for "borderchars"'))
    end

    border_options.top = b_top
    border_options.bot = b_bot
    border_options.right = b_right
    border_options.left = b_left
    border_options.topleft = b_topleft
    border_options.topright = b_topright
    border_options.botright = b_botright
    border_options.botleft = b_botleft


custom_opts.borderchars = border_options.borderchars
custom_opts.border_thickness = border_options.border_thickness

obj_border_opts = vim.tbl_extend('keep', border_options, { title = get_default(opts.obj_border_title, 'obj')})
log_border_opts = vim.tbl_extend('keep', border_options, { title = get_default(opts.log_border_title, 'log')})








total_opts = {
  width = get_default(opts.width, 0.9),
  height = get_default(opts.height, 0.3),
  relative = get_default(opts.relative, 'win'),
  anchor = 'NW',
 style = 'minimal'
 } 





assert(total_opts.width <= 1, 'LTL ERROR: view width 0 - 1 number supported only')
assert(total_opts.height <= 1, 'LTL ERROR: view height 0 - 1 number supported only')
assert(total_opts.width > 0, 'LTL ERROR: view width needs to be 0 - 1 number')
assert(total_opts.height > 0, 'LTL ERROR: view height needs to be 0 - 1 number')


-- decide max_col, max_row dependant on win or global, for pin
if total_opts.relative == 'win' then
local cwin_max_col = vim.api.nvim_call_function('winwidth', {0})
local cwin_max_row = vim.api.nvim_call_function('winheight', {0})
custom_opts.max_col = cwin_max_col
custom_opts.max_row = cwin_max_row
else
custom_opts.max_col = vim.o.columns
custom_opts.max_row = vim.o.lines
end


-- always center
local col_start_percentage = (1 - total_opts.width) /2
local row_start_percentage = (1 - total_opts.height) / 2

total_opts.height = math.floor(custom_opts.max_row * total_opts.height)
total_opts.width = math.floor(custom_opts.max_col * total_opts.width)
total_opts.col = custom_opts.max_col * col_start_percentage
total_opts.row = custom_opts.max_row * row_start_percentage



local function apply_pin(colrow, total_opts, custom_opts)
 
if custom_opts.pin == nil then return false end

local max_col, max_row = custom_opts.max_col, custom_opts.max_row
local width, height = total_opts.width, total_opts.height

local choose_pin = {
top = ternary(colrow,false,0), 
topright = ternary(colrow, max_col - width, 0),
right =  ternary(colrow, max_col - width,false), 
bottomright = ternary(colrow, max_col - width, max_row - height),
bottom = ternary(colrow,false, max_row - height), -- -1 for statusline
bottomleft = ternary(colrow, 0, max_row - height), -- -1 for statusline
left = ternary(colrow,0,false), 
topleft = ternary(colrow, 0, 0)
}
return choose_pin[custom_opts.pin]
end



-- then apply pin
total_opts.col = apply_pin(true, total_opts, custom_opts) or total_opts.col
total_opts.row = apply_pin(false, total_opts, custom_opts) or total_opts.row

--minus status bar
-- add this: if row & height = vim.o.lines then minus
-- if vim.o.laststatus ~= 0 then
-- total_opts.row = total_opts.row - 1
-- end


-- add offset
total_opts.col = total_opts.col - custom_opts.x
total_opts.row = total_opts.row + custom_opts.y





--lo(state.ui)
--lo(opts[view].target)
--state.ui[view].target = 'asd'
--state.ui.target = opts.target

local layout_bool
if custom_opts.layout == 'horizontal' then layout_bool = true elseif custom_opts.layout == 'vertical' then layout_bool = false end


-- create each individual window options
local function create_window_opts(total_opts, custom_opts, objlog, layout_bool)
local total_opts = vim.deepcopy(total_opts) -- important

-- function round(x)
--   return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
-- end

total_opts.col = math.floor(ternary(objlog, ternary(layout_bool, total_opts.col, total_opts.col ), ternary(layout_bool, total_opts.col + total_opts.width / 2, total_opts.col)))
total_opts.row = math.floor(ternary(objlog, ternary(layout_bool, total_opts.row , total_opts.row), ternary(layout_bool, total_opts.row, total_opts.row + total_opts.height / 2)))
total_opts.width = math.floor(ternary(objlog,ternary(layout_bool, total_opts.width / 2, total_opts.width),ternary(layout_bool, total_opts.width / 2 , total_opts.width)))
total_opts.height = math.floor(ternary(objlog, ternary(layout_bool, total_opts.height , total_opts.height / 2 ), ternary(layout_bool, total_opts.height, total_opts.height /2)))
return total_opts
end

obj_opts = create_window_opts(total_opts, custom_opts, true, layout_bool)
log_opts =  create_window_opts(total_opts, custom_opts, false, layout_bool)

local gap_bool
if custom_opts.gap > 0 then gap_bool = true else gap_bool = false end



-- add gap
if layout_bool and gap_bool then 
obj_opts.width = obj_opts.width - custom_opts.gap
elseif gap_bool then
obj_opts.height = obj_opts.height - custom_opts.gap
end



-- add split %
local distance = 0.5 - custom_opts.split

if custom_opts.layout == 'horizontal' then
local col_to_move = math.floor(total_opts.width * distance)
obj_opts.width = obj_opts.width - col_to_move
log_opts.col = log_opts.col - col_to_move
log_opts.width = log_opts.width + col_to_move
else
local row_to_move = math.floor(total_opts.height * distance)
obj_opts.height = obj_opts.height - row_to_move
log_opts.row = log_opts.row - row_to_move
log_opts.height = log_opts.height + row_to_move
end




local function apply_padding(win_opts, custom_opts, objorlog)
local objorlog_padding = custom_opts[objorlog .. '_padding']

local padding = {}
if not vim.tbl_islist(objorlog_padding) then
table.insert(padding, objorlog_padding.top)
table.insert(padding, objorlog_padding.right) 
table.insert(padding, objorlog_padding.bottom)
table.insert(padding, objorlog_padding.left)
else
padding = objorlog_padding
end

-- anchor decides if the padding side has to be moved or not
-- top
win_opts.row = win_opts.row + padding[1]
win_opts.height = win_opts.height - padding[1]
-- left
win_opts.col = win_opts.col + padding[2]
win_opts.width = win_opts.width - padding[2]
-- bottom
win_opts.height = win_opts.height - padding[3]
-- right
win_opts.width = win_opts.width - padding[4]

return win_opts
end



obj_opts = apply_padding(obj_opts, custom_opts, 'obj')
log_opts = apply_padding(log_opts, custom_opts, 'log')

-- add/convert into what popup create wants
-- obj_opts.minheight = obj_opts.height
-- log_opts.minheight = log_opts.height
--obj_opts.line = obj_opts.row
--log_opts.line = log_opts.row


--renderer = renderer:new() 

lo('window return')

return setmetatable({
target = opts.target,
obj_opts = obj_opts,
log_opts = log_opts,
obj_border_opts = obj_border_opts,
log_border_opts = log_border_opts,
custom_opts = custom_opts,
total_opts = total_opts
} , self)

-- not the same as values returned
-- renderer = renderer:new({ 
--   target = opts.target,
--   log = opts.log,
--   obj_border_opts = obj_border_opts,
--   log_border_opts = log_border_opts,
--   obj_opts = obj_opts,
--   log_opts = log_opts
--   })
--  }


end










function Window:open()
lo('window open')


self.total_opts.win = vim.api.nvim_get_current_win()
if self.total_opts.relative == 'win' then 
self.obj_opts.win = vim.api.nvim_get_current_win() end
if self.total_opts.relative == 'win' and self.log_opts then 
self.log_opts.win = vim.api.nvim_get_current_win() end





local function open_window(popup_opts, custom_opts, objorlog)

local border_opts = self[objorlog .. '_border_opts']



-- 1 create buf
local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_option(bufnr, 'filetype', 'lua')

self.bufnr[objorlog] = bufnr


-- 2 create win
local objorlog_winnr = vim.api.nvim_open_win(bufnr, false, popup_opts)
local border = Border:new(bufnr, objorlog_winnr, popup_opts, border_opts)


--local popup_winnr, border_opts = popup.create('', popup_opts)
self.winnr[objorlog .. '_win'] = objorlog_winnr
self.winnr[objorlog .. '_border'] = border.win_id
self.border = border
-- no need to return win_opts or border_opts as they are the same as constructor return to self

vim.api.nvim_win_set_option(winnr, 'winblend', 15)

vim.api.nvim_buf_call(bufnr, function()
vim.cmd('setlocal nocursorcolumn')
vim.api.nvim_command([[setlocal foldmarker=-->>>>,--<<<<]])
vim.cmd([[set foldmethod=marker]])
end)

lo('before renderer new')
--self.renderer = renderer:new(self) -- renderer new creates buffers as its one time 
lo('after renderer refresh')
-- apply border after contents in renderer refresh
-- here runs open win. 

end

self.bufnr = {}
self.winnr = {}

if self.custom_opts.log then
open_window(self.obj_opts, self.custom_opts,  'obj')
open_window(self.log_opts, self.custom_opts, 'log')
else
open_window(self.total_opts, self.custom_opts, 'obj')
end

lo(state.ui)



-- write contents onto newly created window/buffer
renderer:refresh(self)




lo('end of window open')
end





function Window:resize()

-- local resize = {
-- col = self.log_opts.col + 4
-- row = self.log_opts.row + 4
-- }

self.log_opts.col = self.log_opts.col + 4
self.log_opts.row = self.log_opts.row + 4
self.log_opts.title = nil


vim.api.nvim_win_set_config(self.winnr.obj_border, self.log_opts)

end












function windows.open(opts)
lo('===== NEW WINDOW RUN =====')
opts = opts or {}
local function parse_view_opts(opts)
views = {}
for k,v in pairs(opts or {}) do
if k:find('^view[%d]*') then table.insert(views, k) end
end
if vim.tbl_isempty(views) then return false else return views end
end



function target_exists(view, state)
  if not state.instances then return false end
  for k, v in pairs(state.instances) do
    if k == opts[view].target then return true end
  end
  return false 
end



view_in_keys = parse_view_opts(opts) or { 'view1' }


for _, view in ipairs(view_in_keys) do
-- error if key not found in instances
--assert(type(opts[view].target) == 'String', 'LTL ERROR: target must be string')
assert(target_exists(view, state), 'LTL ERROR: cant find target in active instances')

if not state.ui[view] then state.ui[view] = Window:new(opts[view] or {}) end
state.ui[view]:open()
end



end






function Window:focus()
if vim.api.nvim_get_current_win() ~= state.ui.winnr then
state.disp1.prevwin = vim.api.nvim_get_current_win()
vim.api.nvim_set_current_win(state.ui.disp1.winnr)
else
vim.api.nvim_set_current_win(state.disp1.prevwin)
end


end

windows._Window = Window

return windows




-- dont worry about yet
-- end


-- opts.border.borderchars = get_default(opts.border.borderchars, { '─', '│', '─', '│', '╭', '╮', '╯', '╰'})

-- opts.border.obj_border_opts = {
-- title = get_default(opts.border.obj_title, 'obj'),
-- border_thickness = { 
-- top = get_default(opts.border.thickness.top, 1),
-- right = get_default(opts.border.thickness.right, 1),
-- bot = get_default(opts.border.thickness.bot, 1),
-- left = get_default(opts.border.thickness.left, 1),
-- }
-- }

-- opts.border.log_border_opts = {
-- title = get_default(opts.border.log_title, 'log'),
-- border_thickness = { 
-- top = get_default(opts.border.thickness.top, 1),
-- right = get_default(opts.border.thickness.right, 1),
-- bot = get_default(opts.border.thickness.bot, 1),
-- left = get_default(opts.border.thickness.left, 1),
-- }
-- }

--   -- borderchars list to kv for plenary border
-- local borderchars_kv = {}
-- local titlechars = { 'top', 'left', 'bot', 'right', 'topleft', 'topright', 'botright', 'botleft' }
-- for i, v in ipairs(opts.border.borderchars) do
-- borderchars_kv[titlechars[i]] = v
-- end


-- obj_border_opts = vim.tbl_extend('keep', borderchars_kv, opts.border.obj_border_opts )
-- log_border_opts = vim.tbl_extend('keep', borderchars_kv,  opts.border.log_border_opts )


-- old window


-- local function apply_gap()
-- -- add padding
-- -- local function apply_padding_inner(obj_opts, log_opts, inner_bool, layout_bool)

--  end

-- local functon not_zero(padding_value)
-- assert(type)
-- if 
-- end


-- state.ui[view].obj.winnr, state.ui[view].obj.opts = create_window(popup_opts, popup_custom_opts, true)

-- if popup_custom_opts.log then
-- state.ui[view].log.winnr, state.ui[view].log.opts = create_window(popup_opts, popup_custom_opts, false)
-- end



-- function is_valid_key()
-- return false
-- end

--local obj_opts = apply_padding(obj_opts, custom_opts, 'obj')
--local log_opts = apply_padding(log_opts, custom_opts, 'log')

-- local inner_bool, outer_bool
-- if custom_opts.padding_inner > 0 then inner_bool = true else inner_bool = false end
-- if custom_opts.padding_outer > 0 then outer_bool = true else outer_bool = false end

-- print(inner_bool)

-- if inner_bool then
-- apply_padding_inner(, layout_bool)
-- end

-- obj_opts.height = obj_opts.height - 1
--  log_opts.height = log_opts.height - 1
--  obj_opts.width = obj_opts.width - 1
--  log_opts.width = log_opts.width - 1


-- local function apply_padding_inner(obj_opts, log_opts, inner_bool, layout_bool)

-- end

-- local inner_bool, outer_bool
-- if custom_opts.padding_inner > 0 then inner_bool = true else inner_bool = false end
-- if custom_opts.padding_outer > 0 then outer_bool = true else outer_bool = false end

-- print(inner_bool)

-- if inner_bool then
-- apply_padding_inner(, layout_bool)
-- end

-- obj_opts.height = obj_opts.height - 1
--  log_opts.height = log_opts.height - 1
--  obj_opts.width = obj_opts.width - 1
--  log_opts.width = log_opts.width - 1

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



----


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
--asd

-- vim.api.nvim_buf_call(bufnr, function()
-- vim.cmd([[augroup Format]])
-- vim.cmd([[au!]])
-- vim.cmd([[autocmd TextChanged,TextChangedI <buffer> lua require('livetablelogger/renderer').on_buf_write_post()]])
-- vim.cmd([[augroup END]])

--  -- vim.api.nvim_feedkeys('gg=G', 'n', true)
-- end)

-- self:puts('<', tv, ' ', self:getId(v), '>')

