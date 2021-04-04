

--local tablelog = {}

local state = require'livetablelogger/state'
local log = require'livetablelogger/log'
local renderer = require'livetablelogger/renderer'

function tablelog(t)

collectgarbage()
debuginfo = debug.getinfo(2)
--dump(debuginfo)
attrs = {}
attrs.src = debuginfo.source
attrs.linenr = debuginfo.currentline
attrs.pointer = tostring(t)
attrs.debuginfo = debuginfo
attrs.debuginfo = tostring(debuginfo.func)
--attrs.name = name

state.instances[attrs.pointer] = { attrs = attrs, t = t or {} }
  local store = t or {}



local mt = {
__index = function (self, k, v) 
  log.log('tablelog: __index trig')
        return store[k] 
  end,
__newindex = function(self, k, v) 
  log.log('__nexindex trig')
  -- log.log(self)
  -- log.log(k)
  -- log.log(v)
  --  log.log('tablelog: __newindex trig') 
    store[k] = v
    
  ---- renderer.render(store)
      

    return store 
  end,
  __tostring = function(self, k, v)

  --  log.log('tablelog: to string trig')
  -----  return vim.inspect(store)
    end,

   -- __mode = 'kv',
    __gc = function()
      log.log('gc ran')
      
    end

    

}


local function iter(a, i)
      i = i + 1
      local v = a[i]
      if v then
        return i, v
      end
    end



-- setfenv to wrap pairs & ipairs as 5.1 has no __pairs metamethod
local tablelog_env = { 
  pairs = function(t) 
    return next, store, nil
  end,
    

ipairs = function(a)
      return iter, store, 0
    end,

  -- setmetatable = function(mtorig) 
  --   --lo('setmetatable trig') 
  --  -- _G.setmetatable(store, mtorig)
  --   print('tablelog: setmetatable failed')
  --  end
}
--print(_G)
  setmetatable(tablelog_env, {__index = getfenv(2)})
--setmetatable(tablelog_env, )
     setfenv(1, getfenv(2))

log.log('LTL RETURNED')
return setmetatable({}, mt)
end



return tablelog
