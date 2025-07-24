--basic vim settings
vim.g.mapleader=" "
vim.keymap.set("i", "jj", "<Esc>", {silent=true})
vim.o.number = true
vim.o.relativenumber = true

-- configuring lazy  package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {}
local plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }},
	{"nvim-treesitter/nvim-treesitter", build= ":TSUpdate"},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					visible = true,
				},
			},
		},
	}
}

require("lazy").setup(plugins, opts)
--require catppuccin
require("catppuccin").setup()

--set the colorscheme to it!
vim.cmd.colorscheme "catppuccin"

--telescope setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

--treesitter setup
local config = require("nvim-treesitter.configs")
config.setup({
	ensure_installed = {"lua", "javascript", "python", "go", "typescript", "toml", "bash"},
	highlight = { enable = true },
	indent = { enable = true }
})

--neotree setup
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
