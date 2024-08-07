-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Set background transparency
vim.cmd([[
    augroup TransparentBackground
        autocmd!
        autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
        autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
        autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none
        autocmd ColorScheme * highlight Folded ctermbg=none guibg=none
        autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none
    augroup END
]])

-- Apply the transparent background settings to your color scheme
vim.api.nvim_command("colorscheme tokyonight") -- Replace 'your_color_scheme' with the name of your color scheme
