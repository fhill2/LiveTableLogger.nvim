








--local livetablelogger = {}

local logger = require'livetablelogger/loggers'

local state = require 'livetablelogger/state'
local window = require'livetablelogger/window'



-- local function enable()
-- local ltlmt = debug.getinfo(getmetatable(require'livetablelogger'.doubletable({})).__index) or {}
-- local ltlmt_linenr = ltlmt.linedefined
-- local ltlmt_src = ltlmt.source


-- --print(_G)
-- --dopairs = 'hi123'

-- dopairs = function(t)

-- if vim.tbl_isempty(t) then
--       local isindex = vim.is_callable(debug.getmetatable(t).__index)

--     if isindex == false then return next, t, nil end
--    local mt = debug.getinfo(debug.getmetatable(t).__index)
--    local mt_linenr = mt.linedefined
--    local mt_src = mt.source
--     if mt_src == ltlmt_src and mt_linenr == ltlmt_linenr then lo('matchedddd') end
-- end

-- return next, t, nil
-- end


-- print('livetablelogger enabled')


-- return 
-- end

-- local function log()
-- lo('log called')

-- end




return {
  state = state,
  open = window.open,
  focus = window.focus,
  log = logger
}

---- lATEST

