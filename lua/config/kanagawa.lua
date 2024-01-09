require('kanagawa').setup({
    colors = {
        palette = {
            fujiWhite = "#a6a69c",
            sumiInk3 = "#000000", -- wave theme background
            waveRed = "#e2a478", -- wave theme 'PreProc' highlight group
            dragonBlack3 = "#000000", -- dragon theme background
            carpYellow = "#c5c9c5",
            surimiOrange = "#e2a478",
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
