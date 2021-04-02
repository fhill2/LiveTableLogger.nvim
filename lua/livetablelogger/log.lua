local M = {}







function M.log(...)
  --  print('ran')
--print(arg)
-- for i, v in ipairs(arg) do
-- print(type(v))
-- --  tostring(v)
-- --  print(v)
-- end


local info = debug.getinfo(3, "Sl") or nil
--print(type(info))
--print(info)
if info == nil then 
info = debug.getinfo(2, 'Sl') or ''
end

local lineinfo = string.format('%s:%s', info.short_src, info.currentline) 
-- info.short_src .. ":" .. info.currentline



local msg = vim.tbl_map(function(input)    
--print()
if type(input) == nil then
input = 'nil'

elseif type(input) == 'table' then
-- f: this need to not be local for it to work
input = vim.inspect(input)

elseif type(input) == 'string' then
end
return input

end, {...})




local msg = table.concat(msg, ' ')

     local fp = io.open('/home/f1/.local/share/nvim/logs/nvim.log', "a")
  local str = string.format("[%s] %s: %s \n",
      os.date(), lineinfo, msg)
      fp:write(str)


      fp:close()
end



return M
