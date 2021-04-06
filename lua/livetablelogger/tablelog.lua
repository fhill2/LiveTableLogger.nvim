


local state = require'livetablelogger/state'
local log = require'livetablelogger/log'
local renderer = require'livetablelogger/renderer'









local function hookit(arg1, arg2, arg3)

 local tablelog_env = {

--  pairs = function(t) 
--     return next, store, nil
--   end,

-- ipairs = function(a)
--       return iter, store, 0
--     end,
  
 setmetatable = function(t, mt, val3)
   log.log('after i setmetatable trig from HOOK:')
    log.log(val3)
-- return setmetatable(t, mt)
    end,
 }

--lo(arg1)
-- if debug.getinfo(2).source == '@/home/f1/.config/nvim/plugins-me/livetablelogger/lua/livetablelogger/tablelog.lua' then
-- lo(debug.getinfo(2).source)
-- end
--lo(arg2)
--lo(arg3)
if debug.getinfo(2).source:find('livetablelogger/tablelog.lua') ~= nil then
lo('HOOK FUNCTION TRIG')
lo(debug.getinfo(3))

setmetatable(tablelog_env, { __index = _G})
setfenv(3, tablelog_env)
debug.sethook()
end

end









function tablelog(name, t)
lo('tablelog trig')

  local tablelog_env = {

 pairs = function(t) 
    return next, store, nil
  end,

ipairs = function(a)
      return iter, store, 0
    end,
  
 setmetatable = function(t, mt, val3)
   log.log('after i setmetatable trig from TOP LEVEL:')
    log.log(val3)
-- return setmetatable(t, mt)
    end,
 }


 debug.sethook(hookit, 'r')
  --  getmetatable = function(mtorig)
  --     log.log('getmetatable trig')
  --   end

--if getfenv(1) ~= getfenv(2) then
-- setmetatable(tablelog_env, { __index = getfenv(2)}, 'top setmetatable 2')
--setfenv(2, tablelog_env)

 setmetatable(tablelog_env, { __index = _G}, 'top setmetatable 1')
  setfenv(1, tablelog_env)

 --end
-- setfenv(1, tablelog_env)



-- for setmetatable wrapper only


local ret = require'livetablelogger/tablelog2'(name, t)
--  setfenv(2, tablelog_env)

--lo(tostring(getfenv(1)))
--lo(tostring(getfenv(2)))

print(vim.inspect(ret))

--getfenv(2) = setfenv(2, tablelog_env)
--print('setmetatable return is:')
--print(vim.inspect(ret))
_G.fstate = ret
return ret
end


return tablelog




-- old

-- t.__index = function(self, k, v) 

--   log.log('tablelog: __index trig')
-- --  log.log(self)
-- --  log.log(k)
--  -- log.log(v)
-- local value = store[k]
-- if type(value) == 'table' then
--   return setmetatable(store[k], mt)
--   else
--         return store[k] 
--       end


-- end


-- t.__newindex = function(self, k, v)

--  log.log('tablelog__newindex trig')
--  -- log.log(self)
--   --log.log(k)
--  -- log.log(v)
--     store[k] = v
    
--   -- renderer.update_display(store, fullname)
      

--     return store 


-- end

-- t.__tostring = function(self, k, v) 
--  log.log('to string called')
--     return vim.inspect(store)


-- end

--return t



-- garbage collect
-- for k, v in pairs(state.instances) do
-- if v.debuginfo.src == debuginfo.src and v.debuginfo.
-- end

-- local proxy = t -- newproxy(true)
-- local proxy_metatable = getmetatable(proxy)
-- proxy_metatable = mt
-- print(proxy)


--setmetatable(t, mt)



--setmetatable(userdata, mt)
--local prox = newproxy()
--print('printing new prox')
--print(prox)

