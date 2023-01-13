local lang_maps = {
  javascript = { exec = "npm start", test = "npm test" },
	python = { exec = "python3 %" },
	sh = { exec = "./%" },
  php = { exec = 'php %', test = "composer test", dev="php -S localhost:8080" },
	sol = { exec='', test='', dev='truffle develop' },
	html = {exec='', test='', dev='live-server .'}
}

for lang, data in pairs(lang_maps) do
	if data.build ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{ command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
		)
	end
	
  vim.api.nvim_create_autocmd(
		"FileType",
		{ command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
	)

	if data.dev ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{ command = "nnoremap <Leader>d :split<CR>:resize -10<CR>:terminal " .. data.dev .. "<CR>", pattern = lang }
		)
	end
  
  if data.test ~= nil then 
    vim.api.nvim_create_autocmd(
		  "FileType",
		  { command = "nnoremap <Leader>t :split<CR>:terminal " .. data.test .. "<CR> :resize -10", pattern = lang }
	  )
  end
end
