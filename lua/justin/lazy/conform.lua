return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
			},
		})

		vim.keymap.set("n", "<leader>af", function()
			require("conform").format()
		end, {})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
