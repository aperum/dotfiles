local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	matching = {
		disallow_fuzzy_matching = true,
		disallow_fullfuzzy_matching = true,
		disallow_partial_fuzzy_matching = true,
		disallow_partial_matching = true,
		disallow_prefix_unmatching = false,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping({
			i = cmp.mapping.confirm({ select = false }),
			c = cmp.mapping.confirm({ select = false }),
		}),
		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = true,
		-- }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{
			name = "treesitter",
			entry_filter = function(entry, ctx)
				local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]

				return kind ~= "Text"
			end,
		},
		{ name = "luasnip" },
		{ name = "buffer" },
    { name = "nvim_lsp_signature_help" },
		-- { name = "path" },
		-- { name = "spell" },
		-- { name = "cmdline" },
	},
	formatting = {
		format = lspkind.cmp_format({}),
	},
	-- formatting = {
	-- 	format = lspkind.cmp_format({
	-- 		mode = "symbol_text",
	-- 		menu = {
	-- 			buffer = "[Buffer]",
	-- 			nvim_lsp = "[LSP]",
	-- 			luasnip = "[LuaSnip]",
	-- 			nvim_lua = "[Lua]",
	-- 			latex_symbols = "[Latex]",
	--        path = "[Path]",
	-- 		},
	-- 	}),
	-- },
	-- vim.cmd(
	--   [[ autocmd FileType lua lua require'cmp'.setup.buffer { sources = { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'buffer' }, { name = 'nvim_lua' }, }, } ]]
	-- ),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype("lua", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{
			name = "luasnip",
			options = {
				priority = 150,
			},
		},
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline({
		["<Down>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
		["<Up>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
	}),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline({
		["<Down>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
		["<Up>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
	}),
	sources = cmp.config.sources({
		{
			name = "path",
			option = {
				-- trailing_slash = false,
				label_trailing_slash = false,
			},
		},
	}, {
		{ name = "cmdline" },
	}),
})
