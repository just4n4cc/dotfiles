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
		dashboard = {
			enabled = true,
			sections = {
				{
					-- pane = 2,
					section = "terminal",
					cmd = "chafa ~/Pictures/sticker.webp --format symbols --symbols vhalf --size 35x35 --stretch; sleep .1",
					height = 35,
					-- height = 35,
					width = 40,
					-- padding = 5,
				},
				-- {
				-- 	height = 40,
				-- 	{ section = "keys", gap = 1, padding = 1 },
				-- 	{
				-- 		section = "startup",
				-- 		align = "bottom"
				-- 	},
				-- },
			},
		},
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
		gitbrowse = {
			what = "file",
			urlpatterns = {
				["git.hi-tech.org"] = {
				  branch = "/-/tree/{branch}",
				  file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
				  permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
				  commit = "/-/commit/{commit}",
				},
			},
		},
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
		{ "<M-f>", function() Snacks.explorer() end, desc = "Toggle explorer", },
		{ "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" }, },
		-- { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" }, },
		{ "<leader>n", function() Snacks.notifier.show_history() end, desc = "Show notification history", mode = { "n", "v" }, },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },
	},
}
