-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move buffer left in buffer line
vim.keymap.set("n", "<leader>bh", "<CMD>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })

-- Move buffer right in buffer line
vim.keymap.set("n", "<leader>bl", "<CMD>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })

-- Trim trailing whitespace
vim.keymap.set("n", "<leader>ct", function()
  require("conform").format({
    formatters = { "trim_whitespace" },
    lsp_format = "never",
  })
end, { desc = "Trim Whitespace" })

-- Yank buffer absolute path
vim.keymap.set("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Yank Absolute Path" })

-- Yank buffer relative path (to cwd)
vim.keymap.set("n", "<leader>yr", function()
  vim.fn.setreg("+", vim.fn.fnamemodify(vim.fn.expand("%:p"), ":."))
end, { desc = "Yank Relative Path" })

-- Yank buffer filename
vim.keymap.set("n", "<leader>yn", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Yank Filename" })
