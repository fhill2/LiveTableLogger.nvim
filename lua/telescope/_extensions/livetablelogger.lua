
local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  error('This plugins requires nvim-telescope/telescope.nvim')
end



local actions       = require('telescope.actions')
local action_state  = require('telescope.actions.state')
local finders       = require('telescope.finders')
local pickers       = require('telescope.pickers')
local previewers    = require('telescope.previewers')
local entry_display = require('telescope.pickers.entry_display')
local sorters = require "telescope.sorters"
local conf = require('telescope.config').values

local state = require'livetablelogger/state'



local tstate = {

}


local livetablelogger = function(opts)

lo('ltl ran!!')
for k, v in pairs(state.instances) do
lo(v)
end

--tstate.picker = 

end



return telescope.register_extension {exports = {livetablelogger = livetablelogger}}

