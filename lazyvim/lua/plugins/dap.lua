return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		require("dap-go").setup()
		require("dapui").setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
		vim.keymap.set("n", "<Leader>dT", dap.terminate, { desc = "terminate debugger" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "continue/start debugger" })
		vim.keymap.set("n", "<Leader>dd", dap.disconnect, { desc = "disconnect debugger" })
		vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "step over" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "step into" })
		vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "step out" })
		vim.keymap.set("n", "<Leader>dp", dap.pause, { desc = "pause" })
		vim.keymap.set("n", "<Leader>dR", dap.restart_frame, { desc = "restart frame" })
	end,
}
