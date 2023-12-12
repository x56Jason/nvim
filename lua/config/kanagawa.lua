require('kanagawa').setup({
    colors = {
        palette = {
            sumiInk3 = "#000000", -- wave theme background
            waveRed = "#e2a478", -- wave theme 'PreProc' highlight group
            dragonBlack3 = "#000000", -- dragon theme background
            oldWhite = "#a9b1d6",
--            fujiWhite = "#c0caf5",
        },
        theme = {
            all = {
                ui = { bg_gutter = "none" }
            }
        }
    },
    overrides = function(color)
        local theme = require('kanagawa')._CURRENT_THEME
        if theme ~= "wave" then
            return {}
        end
        return {
            ["@lsp.type.comment"] = { fg = color.palette.fujiGray }, -- Comment
        }
    end,
})
