#!/usr/bin/env fish

# Получаем имя приложения
set APP $argv

if test -z "$APP"
    read -P "Введите название программы (например, foot): " APP
end

# Находим абсолютный путь к папке с дотфайлами
set DOTFILES_DIR (cd (dirname (status filename))/..; pwd)

# Проверяем, существует ли папка в дотфайлах
if not test -d "$DOTFILES_DIR/$APP"
    echo "Ошибка: Папка '$APP' не найдена в $DOTFILES_DIR!"
    exit 1
end

# Динамически собираем путь через whoami
set CURRENT_USER (whoami)
set TARGET_DIR "/home/$CURRENT_USER/.config/$APP"

echo "=== Синхронизация $APP (Абсолютные пути через $CURRENT_USER) ==="
echo "1. Удаление старой директории: $TARGET_DIR"
rm -rf "$TARGET_DIR"

echo "2. Создание чистой директории..."
mkdir -p "$TARGET_DIR"

echo "3. Создание абсолютных симлинков..."
# Цикл проходит по всем файлам внутри папки дотфайлов и линкует их напрямую
for file in $DOTFILES_DIR/$APP/*
    set filename (basename $file)
    ln -sv "$file" "$TARGET_DIR/$filename"
end

echo "Готово! Абсолютные настройки для $APP успешно применены."
