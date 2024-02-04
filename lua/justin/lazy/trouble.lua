return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup()

		vim.keymap.set("n", "<leader>eg", function()
			require("trouble").toggle()
		end)
		vim.keymap.set("n", "<leader>ew", function()
			require("trouble").toggle("workspace_diagnostics")
		end)
		vim.keymap.set("n", "<leader>er", function()
			require("trouble").toggle("document_diagnostics")
		end)
		vim.keymap.set("n", "<leader>ef", function()
			require("trouble").toggle("quickfix")
		end)
	end,
}
