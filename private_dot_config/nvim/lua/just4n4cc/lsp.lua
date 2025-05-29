--

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc, mode)
			mode = mode or 'n'
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
		end

		local opts = {buffer = event.buf}

		map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
		map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
		-- map('gd', function() vim.lsp.buf.hover() end, 'Display information')
		map('K', function() vim.lsp.buf.hover() end, 'Display information')
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
		-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
		-- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		-- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
		-- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

		-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
		---@param client vim.lsp.Client
		---@param method vim.lsp.protocol.Method
		---@param bufnr? integer some lsp support methods only in specific files
		---@return boolean
		local function client_supports_method(client, method, bufnr)
		  if vim.fn.has 'nvim-0.11' == 1 then
			return client:supports_method(method, bufnr)
		  else
			return client.supports_method(method, { bufnr = bufnr })
		  end
		end

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd('LspDetach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map('<leader>th', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
			end, '[T]oggle Inlay [H]ints')
		end

		-- Autocompletion
		-- local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- if client:supports_method('textDocument/completion') then
		--   vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
		-- end

		-- Inlay hints (ghost text)
		-- if client:supports_method('textDocument/inlayHint') then
		--      vim.lsp.inlay_hint.enable(true, {bufnr = args.buf})
		--    end
  end,
})

-- Tab complete
-----------------------------------------------
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess:append('c')

local function tab_complete()
  if vim.fn.pumvisible() == 1 then
    -- navigate to next item in completion menu
    return '<Down>'
  end

  local c = vim.fn.col('.') - 1
  local is_whitespace = c == 0 or vim.fn.getline('.'):sub(c, c):match('%s')

  if is_whitespace then
    -- insert tab
    return '<Tab>'
  end

  local lsp_completion = vim.bo.omnifunc == 'v:lua.vim.lsp.omnifunc'

  if lsp_completion then
    -- trigger lsp code completion
    return '<C-x><C-o>'
  end

  -- suggest words in current buffer
  return '<C-x><C-n>'
end

local function tab_prev()
  if vim.fn.pumvisible() == 1 then
    -- navigate to previous item in completion menu
    return '<Up>'
  end

  -- insert tab
  return '<Tab>'
end

vim.keymap.set('i', '<Tab>', tab_complete, {expr = true})
vim.keymap.set('i', '<S-Tab>', tab_prev, {expr = true})
-----------------------------------------------
---

