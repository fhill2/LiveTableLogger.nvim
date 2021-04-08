
lo('====== RUN AGAIN =======')

local reset = false

if reset then
vim.g.winnr1 = nil
vim.g.winnr2 = nil
return
end


popup_custom_opts = {
layout = 'vertical',
pin = 'topright',
log = true,
scope = 'window'
}

local function is_window_scoped(popup_custom_opts) if scope == 'window' then return true elseif scope == 'editor' then return false end


local function ternary(condition, if_true, if_false)
  if condition then return if_true else return if_false end
end



local function apply_pin(colrow, pin, width, height)
if pin == nil then return false end



local choose_pin = {
top = ternary(colrow,false,1), 
topright = ternary(colrow, columns - width, 1),
right =  ternary(colrow,columns - width,false), 
bottomright =ternary(colrow, columns - width, lines - height),
bottom = ternary(colrow,false, lines - height), -- -1 for statusline
bottomleft = ternary(colrow, 1, lines - height), -- -1 for statusline
left = ternary(colrow,1,false), 
topleft = ternary(colrow, 1, 1)
}



-- if pin == 'top' then return end 
-- if pin == 'right' then returnend 
-- if pin == 'bottom' then return end 
-- if pin == 'left' then return end 

return choose_pin[pin]
end






local width = 40
local height = 40

-- horizontal test
-- local col = is_pin(true, popup_custom_opts.pin, width, height) or vim.o.columns * 0.5
-- local row = is_pin(false, popup_custom_opts.pin, width, height) or vim.o.lines * 0.5

-- vertical test
local col = apply_pin(true, popup_custom_opts.pin, width, height) or vim.o.columns * 0.4
local row = apply_pin(false, popup_custom_opts.pin, width, height) or vim.o.lines * 0.4

-- local columns = ternary(, , vim.o.columns)
-- local lines = ternary(, , vim.o.lines) - vim.o.cmdheight - 1


local relative = 'editor'
local anchor = 'NW'-- is_pin_anchor(popup_custom_opts.pin) -- anchor NW because vim.o.lines is 0-1 top-bottom1 vim.o.columns is o-1 left-right

-- transformation values for pin
local popup_opts = {
  col = col,
  row = row,
  width = width,
  height = height,
  relative = relative,
  anchor = anchor
} 


lo('popup_opts at start is: ')
lo(popup_opts)

--print(is_pin(true, popup_custom_opts.pin, width, height))
--print(is_pin(false, popup_custom_opts.pin, width, height))

local function create_window(popup_opts, popup_custom_opts, objlog)
local popup_opts = vim.deepcopy(popup_opts) -- important
lo('popup_opts start of create window: ')
lo(popup_opts)
local round = function(n) return math.floor(n + 0.5) end


local layout_bool
if popup_custom_opts.layout == 'horizontal' then layout_bool = true elseif popup_custom_opts.layout == 'vertical' then layout_bool = false end
--local objlog
--if objlog == 'obj' then objlog = true elseif objlog == 'log' then objlog = false end 

popup_opts.col = math.ceil(ternary(objlog, ternary(layout_bool, popup_opts.col, popup_opts.col ), ternary(layout_bool, popup_opts.col + popup_opts.width / 2, popup_opts.col)))
popup_opts.row = math.ceil(ternary(objlog, ternary(layout_bool, popup_opts.row , popup_opts.row), ternary(layout_bool, popup_opts.row, popup_opts.row + popup_opts.height / 2)))
popup_opts.width = math.ceil(ternary(objlog,ternary(layout_bool, popup_opts.width / 2, popup_opts.width),ternary(layout_bool, popup_opts.width / 2 , popup_opts.width)))
popup_opts.height = math.ceil(ternary(objlog, ternary(layout_bool, popup_opts.height , popup_opts.height / 2 ), ternary(layout_bool, popup_opts.height, popup_opts.height /2)))



 local bufnr1 = vim.api.nvim_create_buf(false, true)


--- ======= generate buf content start ======
local bufnr1content = {}
for i=1, 10 do
  table.insert(bufnr1content, tostring(i))
  i=i+1  --  print(v)
end

local bufnr1count = vim.tbl_count(bufnr1content)
vim.api.nvim_buf_set_lines(bufnr1, 0, -1, true, bufnr1content)

return vim.api.nvim_open_win(bufnr1, false, popup_opts), popup_opts

end



--if vim.g.winnr1 == nil and vim.g.winnr2 == nil then
if popup_custom_opts.log then 
lo('picked 2 windows')
vim.g.winnr1, obj_opts = create_window(popup_opts, popup_custom_opts, true)
vim.g.winnr2, log_opts = create_window(popup_opts, popup_custom_opts, false)
lo('obj opts')
lo(obj_opts)
lo('log_opts')
lo(log_opts)

else
vim.g.winnr1, obj_opts = create_window(popup_opts, popup_custom_opts, true)
end
--end

-- bufnr after win creation, need winnr to resize dependant on info

-- if vim.g.winnr1 == nil and vim.g.winnr2 == nil then
-- vim.g.winnr1 = vim.api.nvim_open_win(bufnr1, false, obj_opts)
-- vim.g.winnr2 = vim.api.nvim_open_win(bufnr2, false, log_opts)
--  end
--local function resize_window()
local prevwin = vim.api.nvim_get_current_win()

if vim.g.winnr1 ~= nil then
vim.api.nvim_set_current_win(vim.g.winnr1)
vim.api.nvim_win_set_config(vim.g.winnr1, obj_opts)
end

if vim.g.winnr2 ~= nil then
vim.api.nvim_set_current_win(vim.g.winnr2)
vim.api.nvim_win_set_config(vim.g.winnr2, log_opts)
end


vim.api.nvim_set_current_win(prevwin)







-- old


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
