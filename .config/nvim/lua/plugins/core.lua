return {
  {
    -- Completions
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },

  {
    -- Formatting
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        gdscript = { "gdscript-formatter" },
        python = { "ruff_format" },
      },
    },
  },

  {
    -- Linting
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
      },
    },
  },

  {
    -- LSP
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        gdscript = {
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        },
        jsonls = {},
        lua_ls = {},
        pyright = {},
        taplo = {},
        yamlls = {
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
        },
      },
    },
    setup = {
      gdscript = function(_, opts)
        require("lspconfig")["gdscript"].setup(opts)
      end,
    },
  },

  {
    -- Tools
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "codelldb",
        "debugpy",
        "gdscript-formatter",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "ruff",
        "shellcheck",
        "shfmt",
        "stylua",
        "taplo",
        "yaml-language-server",
        "yamllint",
      },
    },
  },

  {
    -- Snacks
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
    },
  },

  {
    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "gdscript",
        "html",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "odin",
        "python",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },

  {
    -- which-key
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>y", group = "yank", icon = "" },
      },
    },
  },
}
