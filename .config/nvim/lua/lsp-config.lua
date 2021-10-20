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

	formatting = {
		format = require("lspkind").cmp_format({with_text = true, maxwidth = 50})
	}
})

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	}

    -- (optional) Customize the options passed to the server
    if server.name == "tsserver" then
		opts.settings = {
			Lua = {
				diagnostics = { globals = { "vim" } }
			}
		}
    end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
