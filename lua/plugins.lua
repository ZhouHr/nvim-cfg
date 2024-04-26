local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   	-- LSP manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
    -- Add hooks to LSP to support Linter && Formatter
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			-- Note:
			--     the default search path for `require` is ~/.config/nvim/lua
			--     use a `.` as a path seperator
			--     the suffix `.lua` is not needed
			require("config.mason-null-ls")
		end,
	},
    -- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
    {
		"hrsh7th/nvim-cmp",
		dependencies = { "lspkind.nvim" },
		config = function()
			require("config.nvim-cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-buffer", dependencies = { "nvim-cmp" } }, -- buffer auto-completion
	{ "hrsh7th/cmp-path", dependencies = { "nvim-cmp" } }, -- path auto-completion
	{ "hrsh7th/cmp-cmdline", dependencies = { "nvim-cmp" } }, -- cmdline auto-completion
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
    -- colorscheme
    "tanvirtin/monokai.nvim",
    "EdenEast/nightfox.nvim",
    -- Autopairs: [], (), "", '', etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	},
    -- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("config.nvim-tree")
		end,
	},
})

