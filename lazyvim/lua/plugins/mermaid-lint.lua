return {
	{
		"mfussenegger/nvim-lint",
		ft = { "mermaid" },
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.mermaid = { "maid" }

			opts.linters = opts.linters or {}
			opts.linters.maid = {
				cmd = "npx",
				args = {
					"--yes",
					"@probelabs/maid",
					"--format",
					"json",
					"-",
				},
				stdin = true,
				append_fname = false,
				stream = "stdout",
				ignore_exitcode = true,
				parser = function(output)
					local ok, result = pcall(vim.json.decode, output)
					if not ok or type(result) ~= "table" then
						return {}
					end

					local diagnostics = {}
					for _, severity_group in ipairs({
						{ items = result.errors or {}, severity = vim.diagnostic.severity.ERROR },
						{ items = result.warnings or {}, severity = vim.diagnostic.severity.WARN },
					}) do
						for _, item in ipairs(severity_group.items) do
							table.insert(diagnostics, {
								lnum = math.max((item.line or 1) - 1, 0),
								col = math.max((item.column or 1) - 1, 0),
								severity = severity_group.severity,
								message = (item.code and (item.code .. ": ") or "") .. (item.message or "Mermaid validation issue"),
								source = "maid",
							})
						end
					end
					return diagnostics
				end,
			}
		end,
	},
}
