return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = function(fallback)
						local copilot = require("copilot.suggestion")
						if copilot.is_visible() then
							copilot.accept()
						elseif cmp.visible() then
							cmp.confirm({ select = true }) -- Accept and close dropdown
						else
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
						end
					end,

					["<Esc>"] = function(fallback)
						local copilot = require("copilot.suggestion")
						if copilot.is_visible() then
							copilot.dismiss()
							vim.schedule(function()
								if cmp.visible() then
									cmp.close() -- Close `nvim-cmp` dropdown to reset state
									cmp.complete() -- Reopen to refresh suggestions
								end
							end)
						else
							fallback()
						end
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			-- Disable Copilot for txt files
			vim.cmd([[autocmd FileType txt let g:copilot_enabled = 0]])

			require("copilot").setup({
				-- Add these lines for Node.js configuration
				copilot_node_command = vim.fn.has("win32") == 1 and "node.exe" or "node", -- Conditionally use node.exe on Windows
				server_opts_overrides = {
					trace = "verbose",
					debug = true,
				},
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 300,
					keymap = {
						accept = "<Tab>",
						accept_word = false,
						accept_line = "<C-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<Esc>",
					},
				},
				event_handlers = {
					["CopilotSuggestionOutOfCompletions"] = function()
						if not seen_out_of_completions then
							seen_out_of_completions = true
							vim.notify("Copilot: Out of completions", vim.log.levels.WARN)
						end
					end,
					["CopilotSuggestionReady"] = function()
						seen_out_of_completions = false -- Reset when new completions arrive
					end,
				},
				filetypes = {
					markdown = true,
					help = true,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
