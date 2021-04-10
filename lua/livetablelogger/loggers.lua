
local state = require'livetablelogger/state'
local log = require'livetablelogger/log'
local renderer = require'livetablelogger/renderer'
local window = require'livetablelogger/window'

--local actions = require'livetablelogger/actions'

local utils = require'livetablelogger/utils'
local get_default = utils.get_default
local ternary = utils.ternary



loggers = {}
Logger = {}
Logger.__index = Logger




function Logger:new(name, t)
--lo('Logger NEW Called:')
--lo(t)

debuginfo = debug.getinfo(2)


attrs = {}
attrs.name = name
attrs.debuginfo = debuginfo

debuginfo.source =
debuginfo.source:gsub('@', '')

local target
if debuginfo.namewhat ~= 'local' then
target = string.format('%s_%s_%s', 'g', name, debuginfo.source)
else
target = string.format('%s_%s_%s_%s', 'l', debuginfo.name, name, debuginfo.source)
end

attrs.target = target

local store = t or {}



mt = {
__index = function (self, k, v) 
lo('tablelog: __index trig')
--lo(self)

  -- update view only if current table is present in view
 --      local table_target = find_table_target_from_table()
 --    if table_target ~= false then 
 -- lo('__index RENDERER update display trig')
 --   renderer.update_display(table_target)
 -- end


-- lo(getmetatable(store).__index())
local value = store[k]
if type(value) == 'table' then
  return setmetatable(store[k], mt)
  else

  -- keep for metatables
 -- if not store[k] and getmetatable(store) then
 --          state.instances[fullname]:check_orig_metatable('__index')
 --    elseif store[k] then
 --      return store[k] 
 --      end
return store[k]
    end


  end,
__newindex = function(self, k, v) 
lo('tablelog__newindex trig')
--lo(self) 
lo(store)
store[k] = v 

    --  state.instances[fullname]
    -- update view only if current table is present in view
 --        local table_target = find_table_target_from_table()
 --    if table_target ~= false then 
 -- lo('__new index RENDERER update display trig')
 --   renderer.update_display(table_target)
 -- end


     end,  
     __tostring = function(self)
        return vim.inspect(store)
     end,
     __call = function(self, ...)
       lo('call trig')


-- for assert for length:

-- max_i = select("#",...) 
-- for i = 1, max_i, 1 do 
-- k = select(i,...)
-- v = select(i+1,...)


-- call = state.instances[fullname].[k]
-- call(v)

-- i+2
-- end

-- call actions to function map
local actions = {
open = { 'window', 'open' },
freeze = { 'renderer', 'freeze' }
}

--lo(self)
--lo(state.instances)

window.open({
view1 = {
  target = tostring(state.instances[target].attrs.target)
}
})



end
}





local function iter(a, i)
      i = i + 1
      local v = a[i]
      if v then
        return i, v
      end
    end








 local tablelog_env2 = {
  pairs = function(outside_t) 
    lo('pairs trig')
    if outside_t == return_obj then
    return next, store, nil
  else
    return next, outside_t, nil
  end
  end,

ipairs = function(outside_t)
  if outside_t == return_obj then
  lo('ipairs trig')
      return iter, store, 0

    else
    return iter, outside_t, 0
    end
    end,

  setmetatable = function(outside_t, mtorig)

   log.log('after i setmetatable trig from HOOK:')
 if outside_t == return_obj then 
  setmetatable(store, mtorig)
end
    end,
    getmetatable = function(outside_t)
 if outside_t == return_obj then 
    getmetatable(store) 
 end 
    end
 }



setmetatable(tablelog_env2, { __index = getfenv(2)})
setfenv(2, tablelog_env2)



















state.instances[target] = setmetatable({ 
  attrs = attrs, 
  store = t or {},
 proxy = setmetatable({}, mt) 
}, self)

if debuginfo.source == '/home/f1/.config/nvim/init.lua' then
  lo('debuginfo trig')
_G[name] = state.instances[target].proxy
end


return state.instances[target].proxy

end















function Logger:check_orig_metatable(k, what)
-- k = k
-- what = what
-- local type = type(getmetatable(store).[what]) 
-- local exists = utils.if_nil(function() return getmetatable(store).[what][k] end, false, true) -- condition, was nil, was not nil


-- local choose = {

-- }

-- index returns
--if getmetatable(store).[what][k] == k then return getmetatable(store).__index[k] end
--  return getmetatable(store).__index(self, k, v)


end






function loggers(name, t)
lo('loggers triggg')
--dump(Logger)
--Logger(t)
return Logger:new(name, t)
end

return loggers

