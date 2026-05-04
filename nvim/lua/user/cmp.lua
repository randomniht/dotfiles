-- ~/.config/nvim/lua/user/cmp.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Подключаем коллекцию готовых сниппетов (friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

-- Настройка cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Иконки в меню (можно убрать, если не нравится)
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },

  -- Клавиши (главное: Tab для выбора)
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()          -- перейти к следующему пункту
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()        -- развернуть сниппет
      else
        fallback()                      -- обычный Tab
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()          -- предыдущий пункт
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter подтверждает выбор
    ["<C-Space>"] = cmp.mapping.complete(),            -- Ctrl+Space принудительно вызвать меню
  }),

  -- Источники подсказок
  sources = cmp.config.sources({
    { name = "nvim_lsp" },    -- LSP (pyright, rust-analyzer)
    { name = "luasnip" },     -- сниппеты
    { name = "buffer" },      -- из текста файла
    { name = "path" },        -- пути к файлам
  }),
})
