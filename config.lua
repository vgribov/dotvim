vim.cmd.filetype({
    "plugin",      -- use file type plugins
    "indent",      -- use indent files
    "on"           -- enable filetype detection
})

-- Treat .m files as ObjC-files
vim.g.filetype_m = "objc" 

vim.cmd.colorscheme("Tomorrow-Night-Eighties")

-- Highligting settings
vim.cmd.highlight({"VertSplit", "guibg=bg", "ctermbg=bg"})

-- Default text width
vim.opt.textwidth   = 80
vim.opt.colorcolumn = "+1"

-- Don't create swap files
vim.opt.swapfile = false

-- Have some logic when indenting
vim.opt.wrap       = false
vim.opt.tabstop    = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab  = true

-- Settings for diff mode
vim.opt.diffopt = {
    "filler",  -- show filler lines
    "vertical" -- use vertical splits
}

-- Folding options
vim.opt.foldmethod = "marker" -- markers are used to specify folds
vim.opt.foldlevel  = 0        -- close all folds

-- Insert mode completion
vim.opt.completeopt = {
    "menu",     -- use a popup menu to show possible completions
    "noinsert", -- do not insert any text until the user selects a match
    "noselect"  -- do not select a match in the menu
}

-- Split windows
vim.opt.splitbelow  = true  -- split bellow
vim.opt.equalalways = false -- clise without resizing other windows

-- Show indention guides
vim.opt.listchars = {
    tab   = "| ",
    trail = "-",
    nbsp  = "+"
}
vim.opt.list = true
