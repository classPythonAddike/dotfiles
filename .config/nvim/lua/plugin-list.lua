local M = {}

function M.PluginList()
	return {
		"wbthomason/packer.nvim",

		"glepnir/dashboard-nvim",

		"rcarriga/nvim-notify",
		"justinmk/vim-sneak",

		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
		"onsails/lspkind-nvim",

		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		"hrsh7th/nvim-cmp",

		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',

		'EdenEast/nightfox.nvim',

		{
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup {
					layout = {
						height = { min = 4, max = 30 },
						width = { min = 30, max = 40 }
					},
					window = {
						border = "single",
					}
				}
			end
		},

		{
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
		},

		{
			"romgrk/barbar.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		},
		{
			"hoob3rt/lualine.nvim",
		},
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		},
		
		'roxma/nvim-yarp',
		'roxma/vim-hug-neovim-rpc',

		{
			"gelguy/wilder.nvim",
			run = ":UpdateRemotePlugins",
			event = "VimEnter",
			config = function()
				vim.cmd([[
					call wilder#enable_cmdline_enter()
					set wildcharm=<Tab>
					cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
					cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

					" only / and ? are enabled by default
					call wilder#set_option('modes', ['/', '?', ':'])
				]])
			end,
		},
		{
			"terrortylor/nvim-comment",
			cmd = "CommentToggle",
			config = function()
				require("nvim_comment").setup({
					marker_padding = true,
					comment_empty = false,
				})
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
			cmd = "Telescope",
		},

		{
			"jiangmiao/auto-pairs",
			ft = { "python", "lua", "vue", "svelte", "go", "vim", "css" },
		},

		{
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			-- event = "InsertEnter",
			config = function()
				require("gitsigns").setup()
			end,
		},

		{
			"akinsho/nvim-toggleterm.lua",
			cmd = { "TermExec", "ToggleTerm" },
			config = function()
				require("toggleterm").setup({
					hide_numbers = false,
					start_in_insert = true,
					persist_size = true,
					shell = "/bin/bash",
					direction = "float",
					close_on_exit = true,

					float_opts = {
						border = "curved",
						width = 110,
						height = 20,
						winblend = 0,
					},
					highlights = {
						background = "Normal",
						border = "Normal"
					}
				})
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			ft = { "svelte", "vue", "html", "css", "javascript" },
			config = function()
				local color_options = {
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
				}

				require("colorizer").setup({
					html = color_options,
					css = color_options,
					vue = color_options,
					svelte = color_options,
				})
			end,
		},
	}
end

function M.InstallPlugins(use)
	for _, plugin in ipairs(M.PluginList()) do
		use(plugin)
	end
end

return M
