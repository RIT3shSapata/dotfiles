-- venv-selector.nvim ships disabled unless telescope.nvim is present
-- (LazyVim.has("telescope.nvim")). This config uses snacks.picker instead,
-- so re-enable it unconditionally.
return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    cmd = "VenvSelect",
    enabled = true,
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
}
