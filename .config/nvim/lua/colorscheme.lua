vim.opt.termguicolors = true

local nightfox = require('nightfox')

nightfox.setup {
	fox = "nordfox",
	transparent = true,
	terminal_colors = false,
	alt_nc = false,
	
	styles = {
		comments = "italic",
		keywords = "bold",
		functions = "italic"
	},
	
	inverse = {
		match_paren = false
	}
}

nightfox.load()

require("lualine").setup {
	options = {
		theme = "nightfox",
	},
}
