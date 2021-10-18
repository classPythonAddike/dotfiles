vim.cmd [[
	set completeopt=menu,menuone,noselect
]]

local cmp = require("cmp")

cmp.setup({

	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = "spell_check" },
		{ name = "luasnip" }
	},

	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true })
	},

	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
	},
})


local function setup_servers()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()
	for _, server in pairs(servers) do
		require("lspconfig")[server].setup({
			settings = {
				Lua = { diagnostics = { globals = { "vim" } } }
			},
			capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
		})
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

