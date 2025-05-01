--Configure tab settings
vim.cmd("set noexpandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

--Fix colour scheme
vim.cmd("set termguicolors")

--Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

--Disable mouse to reinforce keybind learning
vim.opt.mouse = ""

--Change where a file opens when the screen is split
vim.opt.splitright = true
vim.opt.splitbelow = true

--Configure leader character
vim.g.mapleader = " "

--Switch buffers
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {})
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", {})

--Paste in visual mode without yanking selection
vim.keymap.set("v", "<leader>p", '"_dP', {})

--Change in visual mode without yanking selection
vim.keymap.set("v", "<leader>c", '"_c', {})

--Delete in visual mode without yanking selection
vim.keymap.set("v", "<leader>d", '"_d', {})

--Paste system reg
vim.keymap.set("n", "<C-p>", '"+p', {})

--Open buffer menu
vim.keymap.set("n", "<leader>bb", ":Telescope buffers<CR>", {})

--Make a new line without entering insert mode
vim.keymap.set("n", "<Enter>", "o<Esc>", {})

--Add hover functionality for debugging
vim.keymap.set("n", "<leader>K", "<Plug>VimspectorBalloonEval", {})
vim.keymap.set("v", "<leader>k", "<Plug>VimspectorBalloonEval", {})

--Limit size of completion menu
vim.opt.pumheight = 10

-- Set fold method to manual and enable fold column
vim.opt.foldmethod = "manual"
vim.cmd("set foldcolumn=1")

-- Automatically save folds
vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*",
	callback = function()
		if vim.fn.bufname() ~= "" then
			vim.cmd("mkview")
		end
	end,
})

-- Automatically recover folds
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.bufname() ~= "" then
			vim.cmd("silent! loadview")
		end
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = ":",
	callback = function()
		if vim.v.event.cmdtype == ":" and vim.fn.getcmdline():match("^%s*s/") then
			vim.cmd("nohlsearch")
		end
	end,
})
