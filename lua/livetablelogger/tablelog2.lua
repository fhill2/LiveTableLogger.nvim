


local state = require'livetablelogger/state'
local log = require'livetablelogger/log'
local renderer = require'livetablelogger/renderer'


--==============================================================================

function tablelog2(name, t)

-- setfenv to wrap pairs & ipairs as 5.1 has no __pairs metamethod
-- local tablelog_env = { 
--   pairs = function(t) 
--     return next, store, nil
--   end,

-- ipairs = function(a)
--       return iter, store, 0
--     end,

--  }
--setmetatable(tablelog_env, {__index = getfenv(2)})
 -- local tablelog_env = {


 -- }


 --setmetatable(tablelog_env, { __index = _G })
 --lo(debug.getinfo(setmetatable))


   setfenv(1, _G)


-- setfenv(2, tablelog_env)


--  log.log('==== NEW SETUP ====')
  log.log('IN TABLELOG2!')
log.log(debug.getinfo(2))
log.log(debug.getinfo(1))

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
local value = store[k]
if type(value) == 'table' then
  return setmetatable(store[k], mt)
  else
        return store[k] 
      end

  end,
__newindex = function(self, k, v) 
  log.log('tablelog__newindex trig')
 -- log.log(self)
  --log.log(k)
 -- log.log(v)
    store[k] = v
    
  -- renderer.update_display(store, fullname)
      

    return store 
  end,
  __tostring = function(self, k, v)

  --  log.log('tablelog: to string trig')
  log.log('to string called')
    return vim.inspect(store)
    end,
    __call = function(self, k, v)
   log.log('call trig')
    end
 -- setmetatable = function(mtorig) 
 --    --setmetatable()
 --    log.log('setmetatable trig')
 -- --   log.log(getmetatable(store))
 --    -- print('tablelog: setmetatable failed')
 --   end,


   -- __mode = 'kv',
    -- __gc = function()
    --   log.log('gc ran')
      
    -- end

    

}

local function iter(a, i)
      i = i + 1
      local v = a[i]
      if v then
        return i, v
      end
    end

return setmetatable({}, mt)

end



return tablelog2

