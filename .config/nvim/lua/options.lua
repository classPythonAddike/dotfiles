vim.cmd("filetype plugin on")
vim.cmd("syntax on")
vim.cmd("filetype indent off")
vim.cmd("set omnifunc=syntaxcomplete#Complete")
vim.cmd("let $NVIM_TUI_ENABLE_TRUE_COLOR=1")

vim.opt.clipboard = "unnamedplus"
vim.completeopt = { "menuone", "noselect" }
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smarttab = false
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.cmdheight = 1
vim.opt.termguicolors = true

vim.cmd([[
	command! W :w " Sometimes I type :W instead of :w
	command! Q :q
	command! Wq :wq

	set clipboard=unnamedplus

    nnoremap <expr> <Down> v:count ? 'j' : 'gj'
    nnoremap <expr> <Up> v:count ? 'k' : 'gk'
]])

vim.g.python_host_prog = "/usr/bin/python3"
