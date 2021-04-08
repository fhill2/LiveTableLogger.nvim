
lo('====== RUN AGAIN =======')

local border = 'require plenary/window/border'
local reset = false

if reset then
vim.g.winnr1 = nil
vim.g.winnr2 = nil
return
end




--local function is_window_scoped(popup_opts, popup_custom_opts) if popup_opts.relative == 'win' then return true elseif popup_opts.relative == 'editor' then return false end end


local function ternary(condition, if_true, if_false)
  if condition then return if_true else return if_false end
end



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



local popup_custom_opts = {
layout = 'vertical',
pin = 'left',
log = true,
--scope = 'window',
grow = true,
grow_side = 'smart',
}

local start_popup_opts = {
col = 0.4,
row = 0.4,
width = 40,
height = 40,
relative = 'editor'
}

-- decide max_col, max_row dependant on win or global, for pin
if start_popup_opts.relative == 'win' then
local cwin_max_col = vim.api.nvim_call_function('winwidth', {0})
local cwin_max_row = vim.api.nvim_call_function('winheight', {0})
start_popup_opts.win = vim.api.nvim_get_current_win()
popup_custom_opts.max_col = cwin_max_col
popup_custom_opts.max_row = cwin_max_row
else
popup_custom_opts.max_col = vim.o.columns
popup_custom_opts.max_row = vim.o.lines
end





--lo('cwin is: ') 
--lo(cwin)
--vim.api.nvim_open_win(0, false, cwin)

--start_popup_opts.max_col = ternary(is_window_scoped(start_popup_opts, popup_custom_opts), cwin.max_col, vim.o.columns -1)
--start_popup_opts.max_row = ternary(is_window_scoped(start_popup_opts, popup_custom_opts), cwin.max_row , vim.o.lines)


-- vertical test
local col = apply_pin(true, start_popup_opts, popup_custom_opts) or popup_custom_opts.max_col * start_popup_opts.col
local row = apply_pin(false, start_popup_opts, popup_custom_opts) or popup_custom_opts.max_row * start_popup_opts.row

-- transformation values for pin
local popup_opts = {
  col = col,
  row = row,
  width = start_popup_opts.width,
  height = start_popup_opts.height,
  relative = start_popup_opts.relative,
  win = start_popup_opts.win,
  anchor = 'NW',
 } 

-- if popup_opts.relative == 'win' then
-- end
--lo('popup_opts at start is: ')
--lo(popup_opts)

--print(is_pin(true, popup_custom_opts.pin, width, height))
--print(is_pin(false, popup_custom_opts.pin, width, height))

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





 local bufnr1 = vim.api.nvim_create_buf(false, true)


--- ======= generate buf content start ======
local bufnr1content = {}
for i=1, 10 do
  table.insert(bufnr1content, tostring(i))
  i=i+1  --  print(v)
end

local bufnr1count = vim.tbl_count(bufnr1content)
vim.api.nvim_buf_set_lines(bufnr1, 0, -1, true, bufnr1content)


lo('before window creation')
lo(popup_opts)

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
if popup_custom_opts.log then 
vim.g.winnr1, obj_opts = create_window(popup_opts, popup_custom_opts, true, cwin)
vim.g.winnr2, log_opts = create_window(popup_opts, popup_custom_opts, false, cwin)
else
vim.g.winnr1, obj_opts = create_window(popup_opts, popup_custom_opts, true)
end


--obj_opts.height = 100
















vim.defer_fn(function()


local function choose_grow_side(popup_custom_opts)


end



local prevwin = vim.api.nvim_get_current_win()

if popup_custom_opts.grow == true and popup_custom_opts.grow_side == 'smart' then
popup_custom_opts.grow_side = choose_grow_side(popup_custom_opts)
end
lo('before move')
lo(obj_opts)
lo(log_opts)
if vim.g.winnr1 ~= nil then
vim.api.nvim_set_current_win(vim.g.winnr1)
vim.api.nvim_win_set_config(vim.g.winnr1, obj_opts)
end

if vim.g.winnr2 ~= nil then
vim.api.nvim_set_current_win(vim.g.winnr2)
vim.api.nvim_win_set_config(vim.g.winnr2, log_opts)
end


vim.api.nvim_set_current_win(prevwin)

end, 1000)




















-- old
--yx = vim.api.nvim_call_function('win_screenpos', {0}) 
--cwin_col, cwin_row = yx[2], yx[1]

-- cwin = {
-- --col = cwin_col,
-- --row = cwin_row,
-- width = cwin_width,
-- height = cwin_height,
-- max_col = cwin_row + cwin_width,
-- max_row = cwin_col + cwin_height,
-- }



--end
-- horizontal test
-- local col = is_pin(true, popup_custom_opts.pin, width, height) or vim.o.columns * 0.5
-- local row = is_pin(false, popup_custom_opts.pin, width, height) or vim.o.lines * 0.5
--lo(start_popup_opts)

-- bufnr after win creation, need winnr to resize dependant on info

-- if vim.g.winnr1 == nil and vim.g.winnr2 == nil then
-- vim.g.winnr1 = vim.api.nvim_open_win(bufnr1, false, obj_opts)
-- vim.g.winnr2 = vim.api.nvim_open_win(bufnr2, false, log_opts)
--  end
--local function resize_window()


-- horizontal test
--  local popup_opts = {
--    relative = 'editor',
--   col = vim.o.columns * 0.1,
--   height = vim.o.lines * 0.3,
--   row = vim.o.lines * 0.9,
--   width = vim.o.columns * 0.8,
--  anchor = 'sw'
-- }

--local function reverse_for_pin()

--end


--ternary(popup_custom_opts.log, create_single_window(popup_opts), create_single_window())



-- if popup_custom_opts.layout == 'horizontal' then
-- obj_opts = {
-- -- col = math.floor(popup_opts.col),
-- -- row = math.floor(popup_opts.row),
-- -- width = math.floor(popup_opts.width / 2),
-- -- height = math.floor(popup_opts.height)
-- }

-- log_opts = {
-- col = math.floor(popup_opts.col + popup_opts.width / 2),
-- row = math.floor(popup_opts.row),
-- width = math.floor(popup_opts.width / 2),
-- height = math.floor(popup_opts.height)
-- }





-- elseif popup_custom_opts.layout == 'vertical' then
-- obj_opts = {
-- -- col = math.floor(popup_opts.col),
-- -- row = math.floor(popup_opts.row),
-- -- width = math.floor(popup_opts.width),
-- -- height = math.floor(popup_opts.height / 2)
-- }

-- log_opts = {
-- col = math.floor(popup_opts.col),
-- row = math.floor(popup_opts.row + popup_opts.height / 2),
-- width = math.floor(popup_opts.width),
-- height = math.floor(popup_opts.height /2)
-- }

-- end



--local obj_opts = vim.tbl_deep_extend('keep', obj_opts, popup_opts)
--local log_opts = vim.tbl_deep_extend('keep', log_opts, popup_opts)



--if vim.g.winnr1 == nil and vim.g.winnr2 == nil then

--dump(bufnr1content)
--- ======= generate buf content end =======


--end

--resize_window()

--- old

-- if pin == 'top' then return ternary(colrow,true,false) end 
-- if pin == 'right' then return ternary(colrow,true,false) end 
-- if pin == 'bottom' then return ternary(colrow,false,vim.o.lines - height - vim.o.cmdheight) end 
-- if pin == 'left' then return ternary(colrow,true,false) end 

-- if layout == 'top' and colrow = 'col' then 
-- elseif layout == 'top' and colrow = 'row' then
-- elseif layout == 'right' and colrow = 'row' then 
-- elseif layout == 'right' and colrow = 'row' then 
-- elseif layout == 'bottom' and colrow = 'row' then 
-- elseif layout == 'bottom' and colrow = 'row' then 
-- elseif layout == 'left' and colrow = 'row' then 
-- elseif layout == 'left' and colrow = 'row' then 

-- -- reformat obj so nvim_open_win doesnt error on custom keys

-- local obj_opts = layout = obj_opts.layout,  
-- local log_opts = 
-- input only necessary keys to matrix and merge with other popup_opts keys after function return
-- local window_opts = matrix({
-- col = popup_opts.col,
-- row = popup_opts.row,
-- width = popup_opts.width,
-- height = popup_opts.height
-- })

--obj_opts = window_opts.obj_opts
--log_opts = window_opts.log_opts




-- dump(popup_opts)
-- dump(obj_opts)
-- dump(log_opts)





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
