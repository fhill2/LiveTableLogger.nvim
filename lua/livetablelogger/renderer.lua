--local renderer = {}



local state = require'livetablelogger/state'
local inspect = require'livetablelogger/inspect'
local log = require'livetablelogger/log'
local Border = require'livetablelogger/border'

--local tablelog = require'livetablelogger/tablelog'
Renderer = {}
Renderer.__index = Renderer

function Renderer:new(win_self)
  opts = opts or {}
 -- win_self.obj_bufnr = vim.api.nvim_create_buf(false, true)
 --  vim.api.nvim_buf_set_option(win_self.obj_bufnr, 'filetype', 'lua')




-- create buffer
--if not self.obj_bufnr then 
 --Border._create_lines(opts.obj_opts, opts.obj_border_opts)
 
 --vim.api.nvim_buf_set_lines(obj_bufnr, 0, -1, false, contents)


-- if opts.log then
--   win_self.log_bufnr = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_buf_set_option(win_self.log_bufnr, 'filetype', 'lua')

-- end


return setmetatable(opts, Renderer)
end




function Renderer:render(win_self)
  local obj = {}
--lo('renderer refresh here')


local inspectobj = inspect.inspect(state.instances[win_self.target].store)
self.inspect_count = #inspectobj
vim.api.nvim_buf_set_lines(win_self.bufnr.obj_content, 0, -1, true, inspectobj) 




--- actual renderer above here
--vim.defer_fn(function()

--vim.api.nvim_buf_call(self.obj_bufnr, function()
-- remember window has to be open before, if you want to not automatically open window on run you have to set autocmd and find au that can load fold marker on win load
--vim.api.nvim_command([[exe "norm! gg=G"]])
--end)

--end, 1)

-- Border:new(win_self.obj_bufnr, win_self.obj_opts, win_self.obj_border_opts)
--if inspectobj 
window:refresh()

end







return Renderer

















-- old
 -- if vim.tbl_isempty(state.ui.disp1.target) == true then state.ui.disp1.target = state.instances[prev_fullname].store end
--log.log(state.ui.disp1.current_table)


-- SET TABLE to be rendered in buffer
-- local table_render_target
-- if vim.tbl_isempty(state.ui.disp1.target) == true then
-- --  lo('chose here')
-- table_render_target = prev_tbl_render_target
-- else
-- --  lo('chose here')
-- table_render_target = state.ui.disp1.target
-- end




--lo('got to buf set lines')
--lo(vim.in_fast_event())

--vim.schedule_wrap(function(table_render_target)
  --lo(table_render_target)
--  lo(state.ui.disp1.bufnr)





-- only render post startup after 1st buffer creation (vimenter fix)
-- local listed_bufs = vim.fn.getbufinfo({buflisted = 1})
-- log.log(#listed_bufs)
-- print(#listed_bufs)
-- if #listed_bufs == nil then return end



--local bufnr = vim.api.nvim_win_get_buf(state.ui.winnr)
--lo(store)


-- local store = inspect.inspect(store, { process = function(item, path)
-- lo(item)
-- lo(path)
-- return item
--- end })
--log.log('GOT HERE')


--log.log(store)


--local store = vim.split(tostring(store), '\n', true)
--print(type(store))
--lo(store)

--print(str:find('^[%s]*.*= function%(%)[%s]*'))

-- vim.schedule_wrap(function(store) 
-- print(_G)
-- lo(state.ui.bufnr)
-- lo(store)
-- print(store)
-- vim.defer_fn(function() 
-- lo('defer fn called buf set lines!!!')
--  -- vim.api.nvim_command([[echo "asdasdasd"]]) 
-- end, 1)



-- -- fold functions
-- local folds = {}
-- for k,v in ipairs(store) do
--   print(v)
-- if v:find('^[%s]*.*= function%(%)[%s]*') then
--   table.insert(folds, k)
-- end
-- end


--vim.api.nvim_buf_attach()
--vim.defer_fn(function()

--vim.api.nvim_command([[exe "norm! 3,7fo"]])
--vim.api.nvim_buf_set_option(state.ui.bufnr, 'foldmethod', 'marker')
--vim.api.nvim_buf_set_option(state.ui.bufnr, 'foldmarker', '--,--')
--vim.api.nvim_set_current_win(state.ui.winnr)

