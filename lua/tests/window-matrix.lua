


local reset = false

if reset then
vim.g.winnr1 = nil
vim.g.winnr2 = nil
return
end


popup_custom_opts = {
layout = 'vertical',
pin = 'bottom',
}




local function isPin(colrow, pin)
-- col row = true if col, false if row
if pin == nil then return false end
if pin == 'top' then return colrow and true or false end 
if pin == 'right' then return colrow and true or false end 
if pin == 'bottom' then return colrow and true or false end 
if pin == 'left' then return colrow and true or false end 

-- if layout == 'top' and colrow = 'col' then 
-- elseif layout == 'top' and colrow = 'row' then
-- elseif layout == 'right' and colrow = 'row' then 
-- elseif layout == 'right' and colrow = 'row' then 
-- elseif layout == 'bottom' and colrow = 'row' then 
-- elseif layout == 'bottom' and colrow = 'row' then 
-- elseif layout == 'left' and colrow = 'row' then 
-- elseif layout == 'left' and colrow = 'row' then 

end


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


print(isPin(true, popup_custom_opts.pin))
print(isPin(false, popup_custom_opts.pin))

-- vertical test
local popup_opts = {
   relative = 'editor',
  col = isPin(true, popup_custom_opts.pin) and vim.o.columns or vim.o.columns * 0.5,
  height = vim.o.lines * 0.3,
  row = isPin(false, popup_custom_opts.pin) and vim.o.lines or vim.o.lines * 0.5,
  width = vim.o.columns * 0.8,
 anchor = 'NW' -- anchor NW because vim.o.lines is 0-1 top-bottom1 vim.o.columns is o-1 left-right
} 






local obj_opts = {}
local log_opts = {}


-- apply pin
if popup_custom_opts.pin ~= nil then 
  if popup_custom_opts.pin == 'btm' or popup_custom_opts.pin == 'bottom' then

  end
end



if popup_custom_opts.layout == 'horizontal' then
obj_opts = {
 col = math.floor(popup_opts.col),
 row = math.floor(popup_opts.row),
 width = math.floor(popup_opts.width / 2),
 height = math.floor(popup_opts.height)
}

log_opts = {
col = math.floor(popup_opts.col + popup_opts.width / 2),
row = math.floor(popup_opts.row),
width = math.floor(popup_opts.width / 2),
height = math.floor(popup_opts.height)
}





elseif popup_custom_opts.layout == 'vertical' then
obj_opts = {
 col = math.floor(popup_opts.col),
 row = math.floor(popup_opts.row),
 width = math.floor(popup_opts.width / 2),
 height = math.floor(popup_opts.height)
}

log_opts = {
col = math.floor(popup_opts.col + popup_opts.width / 2),
row = math.floor(popup_opts.row),
width = math.floor(popup_opts.width / 2),
height = math.floor(popup_opts.height)
}

end


-- pin

-- if popup_custom_opts.layout == 'horizontal' then

-- else popup_custom_opts.layout == 'vertical' then

-- end





local obj_opts = vim.tbl_deep_extend('keep', obj_opts, popup_opts)
local log_opts = vim.tbl_deep_extend('keep', log_opts, popup_opts)



--if vim.g.winnr1 == nil and vim.g.winnr2 == nil then
 local bufnr1 = vim.api.nvim_create_buf(false, true)
 local bufnr2 = vim.api.nvim_create_buf(false, true)


--- ======= generate buf content start ======
local bufnr1content = {}
local bufnr2content = {}

--local line_amount = 10
for i=1, 10 do
  table.insert(bufnr1content, tostring(i))
  table.insert(bufnr2content, tostring(i))
  i=i+1
  --  print(v)
end

--dump(bufnr1content)
--- ======= generate buf content end =======


local bufnr1count = vim.tbl_count(bufnr1content)
local bufnr2count = vim.tbl_count(bufnr2content)

-- bufnr after win creation, need winnr to resize dependant on info
vim.api.nvim_buf_set_lines(bufnr1, 0, -1, true, bufnr1content)
 vim.api.nvim_buf_set_lines(bufnr2, 0, -1, true, bufnr2content)

if vim.g.winnr1 == nil and vim.g.winnr2 == nil then
vim.g.winnr1 = vim.api.nvim_open_win(bufnr1, false, obj_opts)
vim.g.winnr2 = vim.api.nvim_open_win(bufnr2, false, log_opts)
 end

--local function resize_window()
local prevwin = vim.api.nvim_get_current_win()
vim.api.nvim_set_current_win(vim.g.winnr1)
vim.api.nvim_win_set_config(vim.g.winnr1, obj_opts)
vim.api.nvim_set_current_win(vim.g.winnr2)
vim.api.nvim_win_set_config(vim.g.winnr2, log_opts)
vim.api.nvim_set_current_win(prevwin)
--end

--resize_window()

--- old
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
