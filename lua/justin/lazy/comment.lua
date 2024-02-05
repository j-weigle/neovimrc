return {
	"numToStr/Comment.nvim",
	config = function()
		--require("Comment").setup()
		local cApi = require("Comment.api")
		vim.keymap.set("n", "<C-_>", function()
			cApi.toggle.linewise.current()
		end, { desc = "Toggle Comment" })
		vim.keymap.set(
			"v",
			"<C-_>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			{ desc = "Toggle Comment" }
		)
	end,
}
