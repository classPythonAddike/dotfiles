local M = {}

function M.PluginList()
	return {
		"wbthomason/packer.nvim",

		"glepnir/dashboard-nvim",

		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
		"onsails/lspkind-nvim",

		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		"hrsh7th/nvim-cmp",

		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
	
		'kosayoda/nvim-lightbulb',
		
		"hoob3rt/lualine.nvim",
		
		'shaunsingh/nord.nvim',

		{
			"justinmk/vim-sneak",
			event = "InsertEnter"
		},
        
        {
            'tamton-aquib/duck.nvim',
            config = function()
                require("duck").setup {
                    character = "🦆",
                    winblend = 0,
                    speed = 1,
                    width = 2
                }
                
                vim.api.nvim_set_keymap('n', '<leader>dd', ':lua require("duck").hatch()<CR>', {noremap=true})
                vim.api.nvim_set_keymap('n', '<leader>dk', ':lua require("duck").cook()<CR>', {noremap=true})
            end
        },

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
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
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
			ft = { "python", "lua", "vue", "svelte", "go", "vim", "css", "json", "lua" },
		},

		{
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			event = "InsertEnter",
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
			ft = { "svelte", "vue", "html", "css", "javascript", "python", "go", "lua" },
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

                vim.cmd [[ :ColorizerAttachToBuffer ]]
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
