local state = {
  instances = {},
  ui = {}
}





-- local state_ui_mt = {}

-- state_ui_mt.__index = function(self, k ,v )
-- lo('state.ui __index trig')
-- lo('did it update 12345')
 
-- end


-- state_ui_mt.__newindex = function(self, k, v)
--   lo('state.ui __newindex trigger')
-- --  lo(self)
--  -- lo(key)
--  -- lo(value)
--   rawset(state.ui, k, v)

--end

--setmetatable(state.ui, state_ui_mt)

return state

-- old

-- ui = {
--   disp1 = {
--   target = {},
--   target_metadata = {},
--   target_linecount = 0,
--   },
--   disp2 = {
--   target = {}
--   }
  

--   }

-- state.getstate = function()
--   return State.instances[vim.api.nvim_get_current_buf()]
-- end

