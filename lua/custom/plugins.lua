local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
      }
    }
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow"
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "thirtythreeforty/lessspace.vim",
    event = "VeryLazy",
  },
  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
      enable = true,
      max_width = 60,  -- The maximum width of the diagnostic messages
      max_height = 10, -- the maximum height per diagnostics
      severity_colors = {  -- The highlight groups to use for each diagnostic severity level
          error = "DiagnosticFloatingError",
          warning = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
      },
      format = function(diagnostic)
        return diagnostic.message
      end,
      gap_size = 1,
      scope = 'cursor', -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
      padding_top = 0,
      padding_right = 0,
      text_align = 'right', -- 'left', 'right'
      placement = 'top', -- 'top', 'inline'
      inline_padding_left = 0, -- the padding left when the placement is inline
      update_event = { 'DiagnosticChanged', 'BufReadPost' }, -- the event that updates the diagnostics cache
      toggle_event = { }, -- if InsertEnter, can toggle the diagnostics on inserts
      show_sign = false, -- set to true if you want to render the diagnostic sign before the diagnostic message
      render_event = { 'DiagnosticChanged', 'CursorMoved' },
      border_chars = {
        top_left = "┌",
        top_right = "┐",
        bottom_left = "└",
        bottom_right = "┘",
        horizontal = "─",
        vertical = "│"
      },
      show_borders = true,}
  },
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    opts = {
      width = 120, -- Width of the floating window
      height = 15, -- Height of the floating window
      border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}, -- Border characters of the floating window
      default_mappings = true, -- Bind default mappings
      debug = false, -- Print debug information
      opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
      resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
      post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
      post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
      references = { -- Configure the telescope UI for slowing the references cycling window.
        telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
      },
      -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
      focus_on_open = true, -- Focus the floating window when opening it.
      dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
      force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
      bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
      stack_floating_preview_windows = true, -- Whether to nest floating windows
      preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      zindex = 1, -- Starting zindex for the stack of floating windows
      }
  },
}

return plugins
