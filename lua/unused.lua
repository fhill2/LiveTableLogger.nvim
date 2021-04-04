--function M.config
-- local config = require'livetablelogger.config'.config

-- local mt = {}
-- iterpath = 'fstate'

-- -- local function logfilter(key, value, iterpath)
-- -- -- returns true IF FOUND in whitelist
-- --   for k, v in pairs(fstate.log.whitelist) do
-- --     if iterpath:find(v) ~= nil then
-- --     return true
-- --     end
-- --   end
-- -- return false
-- -- end


-- -- function mt.__tostring(self) -- has 1 argument only
-- -- return vim.inspect(self['proxy'])
-- -- end


-- function mt.__index(self, key)
-- if tostring(self['proxy']) == tostring(rawget(fstate, 'proxy')) then 
-- lo('__index trig')
-- print('index trig')
-- iterpath = 'fstate'
-- end

--  iterpath = iterpath .. '.' .. key
--   local value = self.proxy[key]
  
--   if type(value) == 'table' then
--  -- f: trigerred when a key is accessed, for tables
--  -- f: trigerred when a key is set, for tables and values
--     return setmetatable({proxy=value}, mt)
--   else
--   -- gets trigerred when a key is accessed, BUT ONLY for variables not tables
--   -- DOESNT get triggered when a key is set, for tables and values
-- return value
--   end
-- end


-- function mt.__newindex(self, key, value)
-- iterpath = iterpath .. '.' .. key
-- lo('__newindex trig')
-- print('newindex trig')

-- -- local log_mode = rawget(fstate, 'proxy').log.mode or 'error'
-- -- if log_mode == 'whitelist' then
-- -- local log_filter = logfilter(key, value, iterpath) -- dont need self
-- -- if log_filter == true then
-- -- l(key, '=',  value)
-- -- end

-- -- elseif log_mode == 'all' then
-- -- l(key, '=',  value)
-- -- elseif log_mode == 'off' then
-- -- elseif log_mode == 'error' then
-- -- lo('CANT GET RAWGET FSTATE')
-- -- end


--  iterpath = 'fstate'
-- self.proxy[key] = value

-- end



-- local mt2 = {}

-- function mt2.__call()


-- function M.setproxy(t)
-- lo('setproxy trig')
-- lo(mt)
--   new_t = { proxy = t }
--   setmetatable(new_t, mt)
--  -- lo(new_t)
--   return new_t
-- end

-- globals
-- function M.start_log(t)
-- setproxy(t)
-- return 'log started on table'
-- end

--fstate = setproxy(fstate)





-- function pairs()
-- lo('pairs ran')
--   return
-- end

-- local function create_instance ()
--     local t = {}
--     my_instances[#my_instances + 1] = t
--     return t
-- end

