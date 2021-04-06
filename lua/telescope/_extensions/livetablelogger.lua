
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


local objs = {}
for k, v in pairs(state.instances) do
lo(v)
table.insert(objs, {

  name = k

})
end


local displayer = entry_display.create {
    separator = ' ',
    items = {{width = 100}} -- , {width = 20}, {remaining = true}},
  }

  local make_display = function(entry)
    return displayer {entry.value.name}
  end

  pickers.new(opts, {
prompt_title = 'LiveTableLogger',
finder = finders.new_table {
results = objs,
entry_maker = function(entry)
return {
value = entry,
display = make_display,
ordinal = entry.name

}
end
},
sorter = conf.generic_sorter(opts),
attach_mappings = function()


return true
end
}):find()






--tstate.picker = 

end



return telescope.register_extension {exports = {livetablelogger = livetablelogger}}

