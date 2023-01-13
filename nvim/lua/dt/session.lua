local S = {}
local curentSession = ''
local t = vim.fn.expand("%:p:h")   
local path = '~/.config/nvim/sessions/'

function split(val, separtor)
	objProp = { }
	index = 0

	for value in string.gmatch(val, separtor) do 
		objProp[index] = value
    index = index + 1
	end

	return objProp
end

function S.set()
	local v = split(t, "[^/]+")
	local response = os.execute( "cd " .. path .. v[4] )

	if response ~= 0 then
		vim.cmd(':!mkdir ' .. path .. v[4])
	end

	curentSession = v[5]
	vim.cmd(':mksession! ' .. path .. v[4] .. '/' .. v[5] .. ".vim")	
end

function S.search()
	local opts = {
		attach_mappings = function(_, map)
			map("i", "<CR>", function(prompt_bufnr)
	
			-- filename is available at entry[1]
			local entry = require("telescope.actions.state").get_selected_entry()
			require("telescope.actions").close(prompt_bufnr)	
			local filename = entry[1]
		
			local s = split(filename, '[^/]+')

			if curentSession ~= '' then
				vim.cmd(':mksession!' .. path .. s[1] .. '/' .. curentSession)
			end

			vim.cmd(':source ' .. path .. s[1] .. '/' .. s[2])
			curentSession = s[2]
		end)
	return true
	end,
	}
	
	local v = split(t, "[^/]+")
	if(table.getn(v) > 3) then
		opts.cwd = path .. v[4]
	else
		opts.cwd = path
	end
	require("telescope.builtin").find_files(opts) 
end

return S
