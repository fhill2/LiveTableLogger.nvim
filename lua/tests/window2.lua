
-- local bufnr = vim.api.nvim_create_buf(false, true)
-- local content = { 'a', 'b', 'c', 'd' }
-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)

local total_opts = {
--col = 25,
--row = 29,
width = 0.5,
height = 0.7,
relative = 'editor',
--win = 1002
}



-- local col_start_percentage = (1 - total_opts.width) /2
-- local row_start_percentage = (1 - total_opts.height) / 2

-- dump(row_start_percentage)


-- total_opts.height = math.floor(vim.o.lines * total_opts.height)
-- total_opts.width = math.floor(vim.o.columns * total_opts.width)
-- total_opts.col = math.floor(vim.o.columns * col_start_percentage)
-- total_opts.row = math.floor(vim.o.lines * row_start_percentage) 

--dump(total_opts)
--dump(col_start_percentage)
--dump(row_start_percentage)
-- vim.api.nvim_open_win(bufnr, false, total_opts)


local window = require'plenary/window/float'
-- dump(window)

window.percentage_range_window(0.5, 0.5)
--window.centered()


