vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber", pattern = "*" })

vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert', pattern = '*' })
vim.api.nvim_create_autocmd('TermOpen', {
   command = 'set nonumber | set norelativenumber'
})

