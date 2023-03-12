return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    { "<leader>sw", false },
    { "<leader>sG", false },
    { "<leader>sg", false },
    { "<leader><space>", false },
    { "<leader>,", false },
    -- change a keymap
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- add a keymap to browse plugin files
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
  },
}
