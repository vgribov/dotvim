local keymap = vim.keymap

-- Clear current search highlighting
keymap.set("n", "<esc>", vim.cmd.nohlsearch, { silent = true })

-- Automatically close matching pairs
keymap.set("i", "{", "{}<left>")
keymap.set("i", "(", "()<left>")
keymap.set("i", "[", "[]<left>")
keymap.set("i", "'", "''<left>")
keymap.set("i", '"', '""<left>')

-- Movements while typing
keymap.set("i", "<c-l>", "<right>")
keymap.set("i", "<c-h>", "<left>")
keymap.set("i", "<c-j>", "<c-o>o")
keymap.set("i", "<c-k>", "<c-o>O")
keymap.set("i", "<c-e>", "<c-o>E<right>")
keymap.set("i", "<c-b>", "<c-o>B")

-- Center the screen while typing
keymap.set("i", "<c-z>", "<c-o>zz")

-- Make it easier to edit .vimrc
keymap.set("n", "<leader>ev", ":edit   $MYVIMRC<cr>", { silent = true })
keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>", { silent = true })

-- Terminal mappings
keymap.set("n", "<leader>tr", ":15split<cr>:terminal<cr>", { silent = true })
keymap.set("t", "<Esc>", "<C-\\><C-n>") -- exit to normal mode by ESC

-- Resize window in steps of 5
keymap.set("n", "<c-w>>", ":vertical resize +5<cr>")
keymap.set("n", "<c-w><", ":vertical resize -5<cr>")
keymap.set("n", "<c-w>+", ":resize +5<cr>")
keymap.set("n", "<c-w>-", ":resize -5<cr>")

-- Maximize window
keymap.set("n", "<c-w>z", "<C-W>|<C-W>_")
