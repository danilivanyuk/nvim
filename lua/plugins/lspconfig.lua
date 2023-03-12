return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.option
    diagnostics = {
      underline = true,
      update_in_insert = true,
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
    },
  },
  servers = {
    tsserver = {
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    },
  },
  setup = {
    tsserver = function(_, opts)
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.name == "tsserver" then
          vim.keymap.set(
            "n",
            "<leader>co",
            "<cmd>TypescriptOrganizeImports<CR>",
            { buffer = buffer, desc = "Organize Imports" }
          )
        end
      end)
      require("typescript").setup({ server = opts })
      return true
    end,
  },
}
