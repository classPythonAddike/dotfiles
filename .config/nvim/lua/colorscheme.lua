vim.opt.termguicolors = true

vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_disable_background = true

require("nord").set()

vim.cmd [[ colorscheme nord ]]

function FileSize()
    vim.cmd [[ let g:current_file_size = len(join(getline(1,'$'), "\n")) + 1 ]]
    return string.format("🔠 %s", vim.g.current_file_size)
end

require("lualine").setup {
	options = {
		theme = "nord"
	},
    sections = {
        lualine_x = { 'fileformat', 'filetype', FileSize }
    },
    extensions = { 'nvim-tree', 'toggleterm' }
}
