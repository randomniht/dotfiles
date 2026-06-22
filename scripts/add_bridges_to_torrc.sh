# Сохрани как, например, add_bridges_to_torrc.sh
#!/bin/bash

TORRC="/etc/tor/torrc"
BRIDGES_FILE="$HOME/.local/share/onionhop/my_bridges.txt"

# Создаем временный файл для новых строк мостов
TMP_BRIDGES=$(mktemp)

echo "--- Добавление мостов из $BRIDGES_FILE в $TORRC ---"

# Удаляем старые строки мостов из torrc (будь осторожен!)
# Лучше сначала вручную закомментировать их, а потом запускать скрипт
sed -i '/^bridge / s/^/# /' "$TORRC" # Закомментировать все строки, начинающиеся с 'bridge '

echo "UseBridges 1" >> "$TMP_BRIDGES"
# Дополнительные параметры, если нужны (например, для obfs4)
# echo "ServerTransportPlugin obfs4 exec /usr/bin/obfs4proxy" >> "$TMP_BRIDGES"
# echo "ExtORPort auto" >> "$TMP_BRIDGES"

while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^bridge\ obfs4 ]]; then
        echo "$line" >> "$TMP_BRIDGES"
    fi
done < "$BRIDGES_FILE"

# Теперь добавляем эти строки в torrc
# Сначала лучше сделать бэкап torrc
sudo cp "$TORRC" "\(TORRC.bak_\)(date +%Y%m%d_%H%M%S)"
sudo tee -a "$TORRC" < "$TMP_BRIDGES" > /dev/null

echo "Мосты добавлены. Пожалуйста, проверьте $TORRC."
echo "Рекомендуется перезапустить Tor: sudo systemctl restart tor"

rm "$TMP_BRIDGES"
