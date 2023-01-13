local ts = require "telescope"

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_ignore_patterns = {".git/", "node_modules/", "target/", "venv/", "vendor/", "__pycache__/", "coverage", "build", "_build"},
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
  },
}

ts.setup(options)

-- ts.setup {
--	defaults = {
--		initial_mode = "insert",
--		hidden = true,
--		file_ignore_patterns = { ".git/", "node_modules/", "target/", "venv/", "vendor/", "__pycache__/", "coverage", "build", "_build"},
--	},
--	pickers = { find_files = { hidden = true } },
--}
