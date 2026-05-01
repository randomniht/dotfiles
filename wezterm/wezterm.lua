-- ~/.config/wezterm/wezterm.lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Внешний вид: убираем всё лишнее, делаем строго и минималистично
config.color_scheme = "Catppuccin Macchiato"                   -- Цветовая схема минималистичная
config.window_background_opacity = 1.0                -- Убираем прозрачность
config.window_decorations = "RESIZE"                  -- Убираем заголовок окна, оставляем рамку
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 } -- Убираем отступы
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 15.0

-- Настройка вкладок (tab bar): простая и строгая
config.enable_tab_bar = true
config.use_fancy_tab_bar = false                      -- Отключаем скругления и тени
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true               -- Включаем номер вкладки

-- Настройка статус-строки
config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
    local date = wezterm.strftime("%Y-%m-%d %H:%M")
    window:set_right_status("  " .. date .. "  ")
end)

-- Основные хоткеи
config.keys = {
    { key = "t", mods = "CTRL", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
    { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "CTRL", action = wezterm.action.ActivateTab(4) },
    { key = "6", mods = "CTRL", action = wezterm.action.ActivateTab(5) },
    { key = "7", mods = "CTRL", action = wezterm.action.ActivateTab(6) },
    { key = "8", mods = "CTRL", action = wezterm.action.ActivateTab(7) },
    { key = "9", mods = "CTRL", action = wezterm.action.ActivateTab(8) },
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.ShowTabNavigator },
}

-- [Опционально] Управление макетом окон при старте
-- Этот код отслеживает все новые окна и разворачивает их при первом получении фокуса
local maximized_windows = {} -- Таблица "уже максимизировано"
wezterm.on("window-focus-changed", function(window, pane)
    -- Получаем ID окна, которое только что получило фокус
    local window_id = window:window_id()

    -- Если это окно мы ещё не разворачили
    if not maximized_windows[window_id] then
        -- Помечаем его как "уже максимизированное"
        maximized_windows[window_id] = true
        -- Разворачиваем окно
        window:maximize()
    end
end)
return config
