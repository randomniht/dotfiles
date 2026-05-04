return {
  -- Цветовая схема
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Файловый менеджер
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" } },
    opts = {},
  },

  -- Статусная строка
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {},
  },

  -- Treesitter (подсветка) — с отложенной настройкой и проверкой
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",   -- загружается после того, как редактор стал отзывчивым
    config = function()
      -- Небольшая задержка, чтобы плагин точно успел загрузиться
      vim.defer_fn(function()
        local ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if ok then
          treesitter.setup({
            ensure_installed = { "python", "rust" },
            highlight = { enable = true },
          })
        else
          vim.notify("Treesitter not loaded yet, run :TSInstall", vim.log.levels.WARN)
        end
      end, 100)
    end,
  },

  -- Mason (установка LSP серверов)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "pyright", "rust_analyzer" },
      automatic_installation = true,
    },
  },

  -- LSP config (новый API без предупреждений)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    ft = { "python", "rust" },
    config = function()
      -- Включаем серверы через vim.lsp
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt" },
      })
      vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        root_markers = { "Cargo.toml" },
      })
      vim.lsp.enable("pyright", "rust_analyzer")
    end,
  },

  -- Автодополнение
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local ok, err = pcall(require, "user.cmp")
      if not ok then
        vim.notify("user.cmp not found: " .. err, vim.log.levels.WARN)
      end
    end,
  },

  -- Автоматические скобки
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
    end,
  },
}
