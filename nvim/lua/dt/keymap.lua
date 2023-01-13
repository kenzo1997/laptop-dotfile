local remap = require("dt.remap")
local dap = require('dap')
local tsb = require('telescope.builtin')
local session = require('dt.session')

local nnoremap = remap.nnoremap
local tnoremap = remap.tnoremap

nnoremap('<leader>f', function() require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') }) end)
nnoremap('<leader>ff', ':Telescope find_files<CR>')

nnoremap('<leader>gc', ':Telescope git_commits<cr>')
nnoremap('<leader>gb', ':Telescope git_branches<cr>')
nnoremap('<leader>gs', ':Telescope git_status<cr>')
nnoremap('<leader>gf', ':Telescope git_files<cr>')

nnoremap('<C-s>', ':w<CR>')
nnoremap('<C-S-s>', ':wq<CR>')
nnoremap('<C-q>', ':q!<CR>')
nnoremap('<C-S-q>', ':qa!<CR>')

nnoremap('<C-H>', '<C-W><C-H>')
nnoremap('<C-J>', '<C-W><C-J>')
nnoremap('<C-K>', '<C-W><C-K>')
nnoremap('<C-L>', '<C-W><C-L>')

nnoremap('<S-H>', ':tabp<cr>')
nnoremap('<S-L>', ':tabn<cr>')

nnoremap('<leader>st', ':split term://zsh | resize -6<cr>')
nnoremap('<leader>vt', ':vsplit term://zsh<cr>')

nnoremap('<leader>n', ':!touch ')
nnoremap('<leader>nd', ':!mkdir ./')

nnoremap('<leader>[', ':vsplit<CR>:vertical resize -40<CR>:Explore .<CR>')

nnoremap('<CR>', ':let @/=""<CR>')

tnoremap('<Esc>', '<C-\\><C-n>')
tnoremap('<leader>ch', '~/scripts/cht.sh<cr>')
tnoremap('<leader>dp', 'postgres<cr>')
tnoremap('<leader>dd', 'sudo ~/scripts/dockerHelper.sh<cr>')

--------

vim.cmd([[
	nmap <silent> gd <Plug>(coc-definition)
	autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
]])

nnoremap('<S-f>', session.search)
nnoremap('<C-f>', function() require('telescope.builtin').find_files( { cwd = './../' }) end)

nnoremap('<leader>ss', session.set)

