vim.cmd [[
	let mapleader = "\<Space>"
	set timeoutlen=300
]]

local wk = require("which-key")

wk.register(
	{
		t = {
			name = "+Tabs",
			h = { "<cmd>bfirst<CR>", "First Tab" },
			j = { "<cmd>bprevious<CR>", "Previous Tab" },
			k = { "<cmd>bnext<CR>", "Next Tab" },
			l = { "<cmd>blast<CR>", "Last Tab" },
			q = { "<cmd>BufferClose<CR>", "Close Tab" }
		},

		r = {
			name = "+Run Code",
			r = { "<cmd>lua Run()<CR>", "Run Project" },
			b = { "<cmd>lua Build()<CR>", "Compile Project" }
		},

		l = {
			name = "+LSP",
			c = { "<cmd>CommentToggle<CR>", "Toggle a comment" },
			a = { "<cmd>CodeActionMenu<CR>", "Show Code Action Menu" }
		},

		f = {
			name = "+File Explorer",
			e = { "<cmd>NvimTreeFocus<CR>", "Focus File Explorer" },
			t = { "<cmd>Telescope file_browser<CR>", "Open Telescope File Explorer" }
		},
        d = {
            name = "+Duck",
            d = { "<cmd>lua require('duck').hatch()<CR>", "Hatch Duck" },
            k = { "<cmd>lua require('duck').cook()<CR>", "Cook Duck" }
        },
        c = {
            name = "+Code",
            c = { '<cmd>let<Space>@/=""<CR>', "Clear Find Results" }
        }
	},
	{
		prefix = "<leader>"
	}
)

vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-A>", "<Esc> ggVG", { noremap = true })

function Build()
	local ft = vim.bo.filetype

	if ft == "go" then
		vim.cmd(":TermExec cmd='go build .'")
	else
		vim.cmd(":echom \"No build configurations set for filetype '" .. ft .. "'!\"")
	end
end

function Run()
	local ft = vim.bo.filetype

	if ft == "go" then
		vim.cmd(":TermExec cmd='go run .'")
	elseif ft == "python" then
		vim.cmd(":TermExec cmd='python %'")
	elseif ft == "ruby" then
		vim.cmd(":TermExec cmd='ruby %'")
	else
		vim.cmd(":echom \"No run configurations set for filetype '" .. ft .. "'!\"")
	end
end
