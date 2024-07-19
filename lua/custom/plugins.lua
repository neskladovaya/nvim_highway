local plugins = {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
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
  -- {
  --   "kdheepak/lazygit.nvim",
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  {
    "Julian/lean.nvim",
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      -- you also will likely want nvim-cmp or some completion engine
    },
    opts = {
      -- Enable the Lean language server(s)?
      --
      -- false to disable, otherwise should be a table of options to pass to `leanls`
      --
      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#leanls for details.
      -- In particular ensure you have followed instructions setting up a callback
      -- for `LspAttach` which sets your key bindings!
      lsp = {
            init_options = {
              -- See Lean.Lsp.InitializationOptions for details and further options.
              -- Time (in milliseconds) which must pass since latest edit until elaboration begins.
              -- Lower values may make editing feel faster at the cost of higher CPU usage.
              -- Note that lean.nvim changes the Lean default for this value!
              editDelay = 0,
              -- Whether to signal that widgets are supported.
              hasWidgets = true,
            }
      },

        -- Abbreviation support
        abbreviations = {
          -- Enable expanding of unicode abbreviations?
          enable = true,
          -- additional abbreviations:
          extra = {
            -- Add a \wknight abbreviation to insert ♘
            --
            -- Note that the backslash is implied, and that you of
            -- course may also use a snippet engine directly to do
            -- this if so desired.
            wknight = '♘',
          },
          -- Change if you don't like the backslash
          -- (comma is a popular choice on French keyboards)
          leader = '\\',
        },

        -- Enable suggested mappings?
        --
        -- false by default, true to enable
        mappings = true,

        -- Infoview support
        infoview = {
          -- Automatically open an infoview on entering a Lean buffer?
          -- Should be a function that will be called anytime a new Lean file
          -- is opened. Return true to open an infoview, otherwise false.
          -- Setting this to `true` is the same as `function() return true end`,
          -- i.e. autoopen for any Lean file, or setting it to `false` is the
          -- same as `function() return false end`, i.e. never autoopen.
          autoopen = true,

          -- Set infoview windows' starting dimensions.
          -- Windows are opened horizontally or vertically depending on spacing.
          width = 50,
          height = 20,

          -- Put the infoview on the top or bottom when horizontal?
          -- top | bottom
          horizontal_position = "bottom",

          -- Always open the infoview window in a separate tabpage.
          -- Might be useful if you are using a screen reader and don't want too
          -- many dynamic updates in the terminal at the same time.
          -- Note that `height` and `width` will be ignored in this case.
          separate_tab = false,

          -- Show indicators for pin locations when entering an infoview window?
          -- always | never | auto (= only when there are multiple pins)
          indicators = "auto",
        },
     },
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
  }
}
return plugins
