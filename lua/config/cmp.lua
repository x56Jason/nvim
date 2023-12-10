vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippet"})

-- lspkind
local lspkind = require "lspkind"
lspkind.init()

local select_opts = {behavior = cmp.SelectBehavior.Insert}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "path" },
	},
	mapping = {
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),

		['<C-B>'] = cmp.mapping.scroll_docs(-4),
		['<C-F>'] = cmp.mapping.scroll_docs(4),

		['<C-E>'] = cmp.mapping.abort(),

		['<C-Y>'] = cmp.mapping.confirm({select = true}),
		['<CR>'] = cmp.mapping.confirm({select = false}),

		['<C-J>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),

		['<C-L>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {'i', 's'}),

		['<C-P>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			elseif luasnip.choice_active() then
				luasnip.change_choice(-1)
			else
				fallback()
			end
		end, {'i', 's'}),

		['<C-N>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif luasnip.choice_active() then
				luasnip.change_choice(1)
			else
				fallback()
			end
		end, {'i', 's'}),

		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			elseif luasnip.expandable() then
				luasnip.expand()
			else
				cmp.complete()
			end
		end, {'i', 's'}),

		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, {'i', 's'}),
	},
	experimental = {
		ghost_text = true,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	formatting = {
		format = lspkind.cmp_format {
			mode = 'symbol_text',
			maxwidth = 60,
			ellipsis_char = '...',
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[lsp]",
				path = "[path]",
				luasnip = "[snip]",
			}
		},
	},
}

