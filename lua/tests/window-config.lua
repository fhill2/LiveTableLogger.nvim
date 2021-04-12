-- local ltl = require'livetablelogger'

local state = require'livetablelogger/state'
-- local window = require'livetablelogger/window'
-- --local window = require'livetablelogger/window'
-- local picker = require'telescope/pickers'
-- --window.open()

-- require'livetablelogger'.open({
-- view1 = {
-- target = 'g_fstate_/home/f1/.config/nvim/init.lua' 
-- }
-- })


--dump(picker)
--dump(window)

--dump(state)

lo('============== NEW RUN ============')
local ltl= require'livetablelogger'.log




x = ltl('x', {a=1,b=2})
x('open', 'again')



y = x.a
x.c = 25

--dump(x)
--dump(state)




