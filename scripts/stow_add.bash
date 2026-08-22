#!/usr/bin/env bash

# Получаем имя приложения
APP="${1}"

if [ -z "$APP" ]; then
    read -p "Введите название программы (например, foot): " APP
fi

# Находим абсолютный путь к папке с дотфайлами
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

# Проверяем, существует ли папка в дотфайлах
if [ ! -d "$DOTFILES_DIR/$APP" ]; then
    echo "Ошибка: Папка '$APP' не найдена в $DOTFILES_DIR!"
    exit 1
fi

# Динамически собираем путь через whoami
CURRENT_USER=$(whoami)
TARGET_DIR="/home/$CURRENT_USER/.config/$APP"

echo "=== Синхронизация $APP (Абсолютные пути через $CURRENT_USER) ==="
echo "1. Удаление старой директории: $TARGET_DIR"
rm -rf "$TARGET_DIR"

echo "2. Создание чистой директории..."
mkdir -p "$TARGET_DIR"

echo "3. Создание абсолютных симлинков..."
# Линкуем каждый файл напрямую по его полному системному пути
for file in "$DOTFILES_DIR/$APP"/*; do
    [ -e "$file" ] || continue
    filename=$(basename "$file")
    ln -sv "$file" "$TARGET_DIR/$filename"
done

echo "Готово! Абсолютные настройки для $APP успешно применены."
