vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "rose-pine/neovim", name = "rose-pine" }

    use ( 'nvim-treesitter/nvim-treesitter', { run =  ':TSUpdate'})

    use ( "nvim-treesitter/playground")
    use ( "ThePrimeagen/harpoon")

    use ("mbbill/undotree")
    use ("tpope/vim-fugitive")

    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/nvim-cmp'}
    use {'VonHeikemen/lsp-zero.nvim' }

    use {'mfussenegger/nvim-dap'}

    use { "nvim-neotest/nvim-nio" }
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

end)
