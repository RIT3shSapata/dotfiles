-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Treat standalone Mermaid diagrams as Mermaid buffers for linting.
vim.filetype.add({
	extension = {
		mmd = "mermaid",
		mermaid = "mermaid",
	},
})
