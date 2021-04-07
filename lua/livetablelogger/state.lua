local state = {
  instances = {},
  ui = {}
}



local state_ui_mt = {}
state_ui_mt.__newindex = function(self, k, v)
  lo('state.ui __newindex trig')
--  lo(self)
 -- lo(key)
 -- lo(value)
  rawset(state.ui, k, v)

end

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

setmetatable(state.ui, state_ui_mt)

return state


