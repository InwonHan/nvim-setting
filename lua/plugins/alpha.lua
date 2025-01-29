return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local mocha = require("catppuccin.palettes").get_palette("mocha")

        -- Helper functions
        local function getLen(str, start_pos)
            local byte = string.byte(str, start_pos)
            if not byte then
                return nil
            end
            return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
        end

        local function colorize(header, header_color_map, colors)
            for letter, color in pairs(colors) do
                local color_name = "AlphaColor" .. letter
                vim.api.nvim_set_hl(0, color_name, color)
                colors[letter] = color_name
            end

            local colorized = {}

            for i, line in ipairs(header_color_map) do
                local colorized_line = {}
                local pos = 0

                for j = 1, #line do
                    local start = pos
                    pos = pos + getLen(header[i], start + 1)

                    local color_name = colors[line:sub(j, j)]
                    if color_name then
                        table.insert(colorized_line, { color_name, start, pos })
                    end
                end

                table.insert(colorized, colorized_line)
            end

            return colorized
        end

        -- Header and color map
        local header = {
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████                                   ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
            [[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
        }

        local color_map = {
            [[ WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWWWWWWWWWW ]],
            [[ RRRRWWWWWWWWWWWWWWWWRRRRRRRRRRRRRRRRWWWWWWWWWWWWWWWWBBPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBBWWWWWWWWWWWW ]],
            [[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPPPHHHHHHHHHHHHHHHHHHHHHHHHHHPPPPPPBBWWWWWWWWWW ]],
            [[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPHHHHHHHHHHHHFFHHHHFFHHHHHHHHHHPPPPBBWWWWWWWWWW ]],
            [[ OOOORRRRRRRRRRRRRRRROOOOOOOOOOOOOOOORRRRRRRRRRRRRRBBPPHHHHFFHHHHHHHHHHHHHHHHHHHHHHHHHHHHPPBBWWWWWWWWWW ]],
            [[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHHHBBBBHHHHFFHHHHPPBBWWBBBBWWWW ]],
            [[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMBBHHHHHHHHPPBBBBMMMMBBWW ]],
            [[ YYYYOOOOOOOOOOOOOOOOYYYYYYYYYYYYYYYYOOBBBBBBBBOOOOBBPPHHHHHHHHHHHHFFHHHHBBMMMMMMBBHHHHHHPPBBMMMMMMBBWW ]],
            [[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBMMMMBBBBOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMMMMMBBBBBBBBMMMMMMMMBBWW ]],
            [[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBBBMMMMBBBBBBPPHHHHHHFFHHHHHHHHHHBBMMMMMMMMMMMMMMMMMMMMMMMMBBWW ]],
            [[ GGGGYYYYYYYYYYYYYYYYGGGGGGGGGGGGGGGGYYYYBBBBMMMMBBBBPPHHHHHHHHHHHHHHFFBBMMMMMMMMMMMMMMMMMMMMMMMMMMMMBB ]],
            [[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBMMMMBBPPHHFFHHHHHHHHHHHHBBMMMMMMCCBBMMMMMMMMMMCCBBMMMMBB ]],
            [[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBBBBBPPHHHHHHHHHHHHHHHHBBMMMMMMBBBBMMMMMMBBMMBBBBMMMMBB ]],
            [[ UUUUGGGGGGGGGGGGGGGGUUUUUUUUUUUUUUUUGGGGGGGGGGGGBBBBPPHHHHHHHHHHFFHHHHBBMMRRRRMMMMMMMMMMMMMMMMMMRRRRBB ]],
            [[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPHHFFHHHHHHHHHHBBMMRRRRMMBBMMMMBBMMMMBBMMRRRRBB ]],
            [[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPPPHHHHHHHHHHHHHHBBMMMMMMBBBBBBBBBBBBBBMMMMBBWW ]],
            [[ VVVVUUUUUUUUUUUUUUUUVVVVVVVVVVVVVVVVUUUUUUUUUUUUBBBBBBPPPPPPPPPPPPPPPPPPPPBBMMMMMMMMMMMMMMMMMMMMBBWWWW ]],
            [[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMMMBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWW ]],
            [[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMBBBBWWBBMMMMBBWWWWWWWWWWBBMMMMBBWWBBMMMMBBWWWWWWWW ]],
            [[ WWWWVVVVVVVVVVVVVVVVWWWWWWWWWWWWWWWWVVVVVVVVVVBBBBBBBBWWWWBBBBBBWWWWWWWWWWWWWWBBBBBBWWWWBBBBWWWWWWWWWW ]],
        }
    
        local colors = {
            ["W"] = { fg = "#282D3F" },
            ["C"] = { fg = mocha.text },
            ["B"] = { fg = mocha.crust },
            ["R"] = { fg = mocha.red },
            ["O"] = { fg = mocha.peach },
            ["Y"] = { fg = mocha.yellow },
            ["G"] = { fg = mocha.green },
            ["U"] = { fg = mocha.blue },
            ["P"] = { fg = mocha.yellow },
            ["H"] = { fg = mocha.pink },
            ["F"] = { fg = mocha.red },
            ["M"] = { fg = mocha.overlay0 },
            ["V"] = { fg = mocha.lavender },
        }

        dashboard.section.header.val = header
        dashboard.section.header.opts = {
            hl = colorize(header, color_map, colors), -- This ensures colors are applied to the header
            position = "center", -- Center the header
        }

        -- Set menu items
        dashboard.section.buttons.val = {
            dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  > Find files", ":Telescope find_files<CR>"),
            dashboard.button("w", "󰷾  > Find Word", ":Telescope live_grep <CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("q", "  > Quit", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
    end,
}
