vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')

local select_opts = {behavior = cmp.SelectBehavior.Insert}

cmp.setup {
	performance = {
		debounce = 150,
		throttle = 60,
		max_view_entries = 30,
	},
	completion = {
		autocomplete = false,  -- manual trigger only with <C-Space>
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 3, max_item_count = 30 },
		{ name = "path" },
	},
	mapping = {
		['<C-o>'] = cmp.mapping.complete(),
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),

		['<C-B>'] = cmp.mapping.scroll_docs(-4),
		['<C-F>'] = cmp.mapping.scroll_docs(4),

		['<C-E>'] = cmp.mapping.abort(),

		['<C-Y>'] = cmp.mapping.confirm({select = true}),
		['<CR>'] = cmp.mapping.confirm({select = false}),

		['<C-P>'] = cmp.mapping.select_prev_item(select_opts),
		['<C-N>'] = cmp.mapping.select_next_item(select_opts),

		['<Tab>'] = cmp.mapping.select_next_item(select_opts),
		['<S-Tab>'] = cmp.mapping.select_prev_item(select_opts),
	},
}

