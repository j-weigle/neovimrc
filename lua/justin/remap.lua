vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "netrw" })

-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer" })
-- vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Prev Buffer" })

vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

vim.keymap.set("n", "<C-e>", "3<C-e>", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { desc = "Scroll Up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Half Page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Half Page" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Search Result" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank Rest of Line to Clipboard" })

-- paste without copying underlying text in visual mode only
-- x - visual, s - select, v - visual and select
vim.keymap.set("x", "<leader>p", [["_dp]], { desc = "Paste Without Yanking" })
vim.keymap.set("x", "<leader>P", [["_dP]], { desc = "Paste Before Cursor Without Yanking" })
-- vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste From Clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete Without Yanking" })

vim.keymap.set("n", "<leader>re", "<cmd> LspRestart<CR>", { desc = "Restart LSP" })

-- vim.keymap.set("n", "<leader>sv", "<cmd> vsplit<CR>", { desc = "Split Vertically" })
-- vim.keymap.set("n", "<leader>sh", "<cmd> split<CR>", { desc = "Split Horizontally" })

-- this is cool... actually keeping it for the silent = true
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
