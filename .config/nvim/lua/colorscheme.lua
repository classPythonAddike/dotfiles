vim.opt.termguicolors = true

vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_disable_background = true

require("nord").set()

vim.cmd [[ colorscheme nord ]]

require("lualine").setup {
	options = {
		theme = "nord"
	}
}
