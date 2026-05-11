require("nvim-treesitter.install").prefer_git = true

require"nvim-treesitter.config".setup {
    ensure_installed = {
        "c", "cpp", "lua", "vim", "vimdoc", "dockerfile", "bash",
--	"cmake", "html",
--	"javascript", "json", "lua",
--	"yaml", "markdown"
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- disable treesitter highlight on files larger than 100KB
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>"
        }
    },
    indent = {
        enable = true,
        disable = { "c", "cpp" },
    },
    autopairs = {{enable = true}},
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["ib"] = "@block.inner",
                ["ab"] = "@block.outer",
                ["ir"] = "@parameter.inner",
                ["ar"] = "@parameter.outer"
            }
        }
    },
}
