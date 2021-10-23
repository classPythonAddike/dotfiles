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



function UpdateLightBulb()
require'nvim-lightbulb'.update_lightbulb {
    sign = {
        enabled = false,
    },
    float = {
        enabled = true,
        text = "💡",
        -- Available keys for window options:
        -- - height     of floating window
        -- - width      of floating window
        -- - wrap_at    character to wrap at for computing height
        -- - max_width  maximal width of floating window
        -- - max_height maximal height of floating window
        -- - pad_left   number of columns to pad contents at left
        -- - pad_right  number of columns to pad contents at right
        -- - pad_top    number of lines to pad contents at top
        -- - pad_bottom number of lines to pad contents at bottom
        -- - offset_x   x-axis offset of the floating window
        -- - offset_y   y-axis offset of the floating window
        -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
        -- - winblend   transparency of the window (0-100)
        win_opts = {},
    },
    virtual_text = {
        enabled = false,
    },
    status_text = {
        enabled = false,
    }
}
end

vim.cmd [[ autocmd CursorHold,CursorHoldI * lua UpdateLightBulb() ]]

