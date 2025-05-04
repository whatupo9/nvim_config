return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			dap.adapters.codelldb = {
				type = "executable",
				command = "C:/Users/camer/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb.exe",
				name = "codelldb",
				initCommands = {
					"process handle -s false -n false -p true 0x4000001f",
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.getcwd()
							.. "/bin/debug/"
							.. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"):gsub(" ", "_")
							.. ".exe"
					end,
					cwd = "${workspaceFolder}",
					runInTerminal = false,

					-- Add this to tell nvim-dap to ignore the exit code
					ignore_exit_codes = { 1 },
				},
			}

			dap.set_log_level("DEBUG")

			-- Breakpoints
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints)

			-- Debugging controls
			vim.keymap.set("n", "<leader>dr", dap.continue) -- Start/Continue debugging
			vim.keymap.set("n", "<leader>do", dap.step_over) -- Step over
			vim.keymap.set("n", "<leader>di", dap.step_into) -- Step into
			vim.keymap.set("n", "<leader>dO", dap.step_out) -- Step out
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "■",
					},
				},
			})
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
		end,
	},
}
