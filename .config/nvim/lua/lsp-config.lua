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
		{ name = "luasnip" },
		{ name = "buffer" }
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true })
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
	},
	formatting = {
		format = require("lspkind").cmp_format({with_text = true, maxwidth = 50})
	}
})

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(
	function(server)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
		
        server:setup {
            capabilities = capabilities
        }
		
       vim.cmd [[ do User LspAttachBuffers ]]
	end
)

