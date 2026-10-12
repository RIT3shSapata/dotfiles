return {
	{
		"vim-test/vim-test",

		dependencies = {
			-- Sends test commands to a tmux pane.
			"preservim/vimux",
		},

		-- Configure vim-test before the plugin loads.
		init = function()
      -- Run tests in a tmux pane.
      vim.g["test#strategy"] = "vimux"

      -- Pass -v to Go's gotest runner so every test and log is shown.
      vim.g["test#go#gotest#options"] = "-v"

      -- Keep the test output visible instead of clearing the pane.
			vim.g["test#preserve_screen"] = 1

			-- Optional: make the tmux test pane 30% high.
			vim.g.VimuxHeight = 30
		end,

		keys = {
			{
				"<leader>tn",
				"<cmd>TestNearest<CR>",
				desc = "Run nearest test",
			},
			{
				"<leader>tf",
				"<cmd>TestFile<CR>",
				desc = "Run tests in current file",
			},
			{
				"<leader>ta",
				"<cmd>TestSuite<CR>",
				desc = "Run entire test suite",
			},
			{
				"<leader>tl",
				"<cmd>TestLast<CR>",
				desc = "Run last test",
			},
		},
	},
}
