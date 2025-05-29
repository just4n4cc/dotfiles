return {
	'echasnovski/mini.nvim', version = false,
	config = function ()
		require('mini.pairs').setup()

		-- Completion
		-- require('mini.icons').setup()
		-- require('mini.snippets').setup()
		-- require('mini.completion').setup()
	end
}

