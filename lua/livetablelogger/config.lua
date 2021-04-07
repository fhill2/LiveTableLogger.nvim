local config = {}


config = {
log = {
  mode = 'all',
  whitelist = ''
},
view = {
popup_opts = {
 -- border = {},
--  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
relative = 'editor',
  col = math.floor(vim.o.columns * 0.1),
 -- enter = false,
  height = math.floor(vim.o.lines * 0.3),
  row = math.floor(vim.o.lines * 0.9),
--  minheight = 50,
 -- title = "LiveTableLogger",
  width = math.floor(vim.o.columns * 0.8),
 anchor = 'SW'
} 
}

}



return config
