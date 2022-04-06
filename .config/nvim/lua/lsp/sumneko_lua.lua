-- sumneko-lua-language-server settings
--

-- local plugins_path = vim.fn.stdpath("data") .. "/dein/repos/github.com"

local settings = {
  Lua = {
    runtime = { version = "LuaJIT", path = vim.fn.split(package.path, ";") },
    diagnostics = {
      enable = true,
      globals = {
        "vim",
        "use",
        "describe",
        "it",
        "assert",
        "before_each",
        "after_each",

        -- AwesomeWM
        "awesome",
        "client",
        "keygrabber",
        "mouse",
        "screen",
      },
    },
    workspace = {
      maxPreload = 2000, -- 1000,
      preloadFileSize = 1000, -- 150,
      library = {
        [vim.fn.stdpath("config") .. "/lua"] = true,
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        -- [plugins_path .. "/nvim-lua/plenary.nvim"] = true,
        -- -- [plugins_path] = true,
      },
    },
    telemetry = {
      enable = false,
    },
  },
}

local function config(server_config)
  server_config.settings = settings

  -- -- See https://github.com/folke/lua-dev.nvim
  -- return require("lua-dev").setup({
  --   lspconfig = server_config,
  --   library = {
  --     vimruntime = true, -- runtime path
  --     types = true, -- full signature, docs and completion
  --     plugins = false,
  --   },
  -- })

  return server_config
end

return {
  config = config,
}
