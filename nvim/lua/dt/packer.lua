return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'vim-airline/vim-airline'
  use 'ap/vim-css-color'
  use 'habamax/vim-godot'
  use 'glepnir/dashboard-nvim'
  use 'jiangmiao/auto-pairs'
	use 'dylanaraps/wal.vim'
	use 'alvan/vim-closetag'
	use 'mattn/emmet-vim'
	use 'sheerun/vim-polyglot'
  use { 'neoclide/coc.nvim', branch = 'release'}
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }	
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

end)
