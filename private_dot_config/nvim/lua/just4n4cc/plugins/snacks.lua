return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = {
			enabled = true,
			animate = {
				enabled = false,
			},
			scope = {
				enabled = false, -- enable highlighting the current scope
			},
		},
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		-- quickfile = { enabled = true },
		-- scope = { enabled = true },
		-- scroll = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
	keys = {
		-- Top Pickers & Explorer
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files", },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<C-f>", function() Snacks.explorer() end, desc = "Toggle explorer", },
		{ "<leader>gb", function() Snacks.gitbrowse.open() end, desc = "Git Browse", mode = { "n", "v" }, },
		{ "<leader>n", function() Snacks.notifier.show_history() end, desc = "Show notification history", mode = { "n", "v" }, },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },
	},
}
