require("core.options")
require("core.keymaps")
require("core.snippets")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Function to require all modules in the plugins folder
local function load_plugins()
	local plugin_files = vim.fn.globpath("~/.config/nvim/lua/plugins", "*.lua", false, true)
	local plugins = {}

	for _, file in ipairs(plugin_files) do
		local plugin_name = file:match("lua/plugins/(.+)%.lua$")
		if plugin_name then
			table.insert(plugins, require("plugins." .. plugin_name))
		end
	end

	return plugins
end

-- Set up lazy.nvim with the dynamically loaded plugins
require("lazy").setup(load_plugins())
