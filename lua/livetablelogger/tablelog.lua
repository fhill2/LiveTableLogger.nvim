


local state = require'livetablelogger/state'
local log = require'livetablelogger/log'
local renderer = require'livetablelogger/renderer'


--==============================================================================

function tablelog(name, t)
lo('fn trig')


local function iter(a, i)
      i = i + 1
      local v = a[i]
      if v then
        return i, v
      end
    end





debuginfo = debug.getinfo(2)


attrs = {}
attrs.name = name
attrs.debuginfo = debuginfo

debuginfo.source = debuginfo.source:gsub('@', '')

local fullname
if debuginfo.namewhat ~= 'local' then
fullname = string.format('%s_%s_%s', 'g', name, debuginfo.source)
else
fullname = string.format('%s_%s_%s_%s', 'l', debuginfo.name, name, debuginfo.source)
end

state.instances[fullname] = { attrs = attrs, store = t or {} }

local store = t or {}








local mt = {
__index = function (self, k, v) 
  log.log('tablelog: __index trig')
--  log.log(self)
--  log.log(k)
 -- log.log(v)

-- lo(getmetatable(store).__index())
local value = store[k]
if type(value) == 'table' then
  return setmetatable(store[k], mt)
  else

 if store[k] == nil then
    if getmetatable(store) ~= nil and type(getmetatable(store).__index) == 'table' then
--  if orig metatable exists and is a table
      -- then check if key in original metatable
          if getmetatable(store).__index[k] == k then return getmetatable(store).__index[k] end

 
       elseif getmetatable(store) ~= nil and type(getmetatable(store).__index) == 'function' then
   -- if orig metatable exists and is a function

    return getmetatable(store).__index(self, k, v)
  end
    elseif store[k] ~= nil then
      return store[k] 
      end
    end


  end,
__newindex = function(self, k, v) 
  log.log('tablelog__newindex trig')
 -- log.log(self)
  --log.log(k)
 -- log.log(v)
    if store[k] == nil then
    if getmetatable(store) ~= nil and type(getmetatable(store).__newindex) == 'table' then
--  if orig metatable exists and is a table
      -- then check if key in original metatable
          if getmetatable(store).__newindex[k] == k then return getmetatable(store).__newindex[k] end

 
       elseif getmetatable(store) ~= nil and type(getmetatable(store).__newindex) == 'function' then
   -- if orig metatable exists and is a function

    return getmetatable(store).__newindex(self, k, v)
  end
    elseif store[k] ~= nil then
      store[k] = v
       end


   renderer.update_display(store, fullname)
      

     end,  
     __call = function(self)
lo('call trig')
     end
}

local return_obj = setmetatable({}, mt)









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


--setfenv to wrap pairs & ipairs as 5.1 has no __pairs metamethod
-- local tablelog_env = { 
--   pairs = function(t) 

--     lo('pairs trig')
--     return next, store, nil
--   end,

-- ipairs = function(a)
--   lo('ipairs trig')
--       return iter, store, 0
--     end,

--   }

--    setmetatable(tablelog_env, {__index = getfenv(1)})
--  setfenv(1, tablelog_env)








if debuginfo.source == '/home/f1/.config/nvim/init.lua' then
_G[name] = setmetatable({}, mt)
end


return return_obj


end



return tablelog

