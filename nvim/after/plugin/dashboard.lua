local db = require "dashboard"

function split(val, separtor)
	objProp = { }
	index = 0

	for value in string.gmatch(val, separtor) do 
		objProp[index] = value
    index = index + 1
	end

	return objProp
end

function search()
	local options = {
		cwd = "~/Documents/projects/",
		path_display = function(opts, path)
			return string.format("%s", split(path, '[^/]+')[1])
    end,
		attach_mappings = function(_, map)
			map("i", "<CR>", function(prompt_bufnr)
				local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
      	local filename = split(entry[1], '[^/]+')
				local dir = filename[1]
				
				vim.cmd(":cd ~/Documents/projects/" .. dir)
				vim.cmd(":Explore ~/Documents/projects/" .. dir)
			end)
			return true
		end
	}	
	
	require("telescope.builtin").find_files(options) 
end


db.custom_header = {
	"",
	"",
	"",
	"",
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"",
	"",
	"",
}

db.custom_center = {
	{
		icon = "  ",
		desc = "Explore projects          ",
		action = search,
	},
	{
		icon = " ",
		desc = "New File            ",
		action = "DashboardNewFile",
		shortcut = "SPC o",
	},
	{
		icon = " ",
		desc = "Find File           ",
		action = "Telescope find_files",
		shortcut = "SPC f",
	},	
	{
		icon = " ",
		desc = "Configure Neovim    ",
		action = "edit ~/.config/nvim/lua/init.lua",
		shortcut = "SPC v",
	},
	{
		icon = " ",
		desc = "Exit Neovim              ",
		action = "quit",
	},
}
