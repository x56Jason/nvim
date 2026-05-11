require("nvim-treesitter.install").prefer_git = true

require"nvim-treesitter.config".setup {
    ensure_installed = {
        "c", "cpp", "lua", "vim", "vimdoc", "dockerfile", "bash",
    },
    ignore_install = {},
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
    indent = {
        enable = true,
        disable = { "c", "cpp" },
    },
}
