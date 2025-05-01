return {
	"cdelledonne/vim-cmake",
	config = function()
vim.keymap.set("n", "<leader>cc", ":!cmake -G Ninja -S . -B build -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug && cmake --build build --config Debug<cr>", {})
vim.keymap.set("n", "<leader>cx", ":!ninja clean<cr>", {})
vim.keymap.set("n", "<leader>cr", ":!cmake -G Ninja -S . -B build -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release<cr>", {})
	end,
}
