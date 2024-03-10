return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		local lspconfig = require("lspconfig")

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"tsserver",
				"rust_analyzer",
				"volar",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["tsserver"] = function()
					lspconfig.tsserver.setup({
						capabilities = capabilities,
						init_options = {
							plugins = {
								{
									name = "@vue/typescript-plugin",
									location = ".",
									languages = { "typescript", "vue" },
								},
							},
						},
						filetypes = {
							"javascript",
							"typescript",
							"vue",
						},
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set("n", "<leader>lod", vim.diagnostic.open_float, { desc = "Open Diagnostics" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostics" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostics" })
		vim.keymap.set("n", "<leader>lsl", vim.diagnostic.setloclist, { desc = "Set Loclist Diagnostics" })

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }

				-- Go To's
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { table.unpack(opts), desc = "Go To Declaration" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { table.unpack(opts), desc = "Go To Definition" })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { table.unpack(opts), desc = "Go To References" })
				vim.keymap.set(
					"n",
					"go",
					vim.lsp.buf.type_definition,
					{ table.unpack(opts), desc = "Go To Type Definition" }
				)
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					{ table.unpack(opts), desc = "Go To Implementation" }
				)

				vim.keymap.set("n", "K", vim.lsp.buf.hover, { table.unpack(opts), desc = "Open LSP Info" })
				vim.keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					{ table.unpack(opts), desc = "LSP Signature Help" }
				)
				vim.keymap.set(
					"n",
					"<leader>lwa",
					vim.lsp.buf.add_workspace_folder,
					{ table.unpack(opts), desc = "LSP Add Workspace Folder" }
				)
				vim.keymap.set(
					"n",
					"<leader>lwr",
					vim.lsp.buf.remove_workspace_folder,
					{ table.unpack(opts), desc = "LSP Remove Workspace Folder" }
				)
				vim.keymap.set("n", "<leader>lwl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, { table.unpack(opts), desc = "LSP List Workspace Folders" })
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { table.unpack(opts), desc = "Rename References" })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>lca",
					vim.lsp.buf.code_action,
					{ table.unpack(opts), desc = "LSP Code Action" }
				)
				vim.keymap.set("n", "<leader>lfb", function()
					vim.lsp.buf.format({ async = true })
				end, { table.unpack(opts), desc = "LSP Format Buffer" })
			end,
		})
	end,
}
