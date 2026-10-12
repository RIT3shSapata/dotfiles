local markdownlint_config = vim.fn.stdpath("config") .. "/markdownlint-cli2.yaml"

return {
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters = opts.linters or {}
			opts.linters["markdownlint-cli2"] = vim.tbl_deep_extend(
				"force",
				opts.linters["markdownlint-cli2"] or {},
				{ args = { "--config", markdownlint_config, "-" } }
			)
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts.formatters = opts.formatters or {}
			opts.formatters["markdownlint-cli2"] = vim.tbl_deep_extend(
				"force",
				opts.formatters["markdownlint-cli2"] or {},
				{ args = { "--fix", "--config", markdownlint_config, "$FILENAME" } }
			)
		end,
	},
}
