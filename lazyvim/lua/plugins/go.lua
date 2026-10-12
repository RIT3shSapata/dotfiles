return {
	-- Configure the Neovim LSP client.
	{
		"neovim/nvim-lspconfig",

		opts = {
			-- Configure language servers by name.
			servers = {
				-- gopls is the official Go language server.
				gopls = {
					settings = {
						-- Settings passed directly to gopls.
						gopls = {
							-- Use gofumpt for stricter Go formatting.
							gofumpt = true,

							-- Enable staticcheck diagnostics.
							staticcheck = true,

							-- Report functions whose parameters are never used.
							analyses = {
								unusedparams = true,

								-- Detect variables that shadow other variables.
								shadow = true,
							},

							-- Insert placeholders when completing function calls.
							usePlaceholders = true,

							-- Complete symbols from packages not yet imported.
							completeUnimported = true,

							-- Enable semantic tokens for richer syntax highlighting.
							semanticTokens = true,
						},
					},
				},
			},
		},
	},

	-- Configure Mason to install Go development tools automatically.
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				-- Go language server for completion, diagnostics, navigation, etc.
				"gopls",

				-- Go debugger.
				"delve",

				-- Import formatting tool.
				"goimports",

				-- Stricter Go formatter.
				"gofumpt",
			},
		},
	},
}
