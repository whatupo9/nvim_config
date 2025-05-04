return {
	"ThePrimeagen/harpoon",
	config = function()
		vim.keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", {})
		vim.keymap.set("n", "<C-h>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
		vim.keymap.set("n", "<C-r>", "<cmd>lua require('harpoon.ui').nav_next()<CR>", {})
		vim.keymap.set("n", "<C-e>", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", {})
		vim.keymap.set("n", "<C-j>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", {})
		vim.keymap.set("n", "<C-k>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", {})
		vim.keymap.set("n", "<C-l>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", {})
		vim.keymap.set("n", "<C-;>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", {})
	end
}
