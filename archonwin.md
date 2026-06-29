# Гайд: Быстрая установка Arch Linux в WSL 2 / Guide: Arch Linux WSL 2 Rapid Deployment

---

## 🇷🇺 Русский вариант

### 1. Подготовка Windows (PowerShell от Админа)
```powershell
# Включить компоненты WSL
wsl --install

# Установить Windows Terminal
winget install Microsoft.WindowsTerminal
```
*⚠️ Обязательно перезагрузи компьютер после этого шага.*

### 2. Развертывание Arch Linux
1. Скачай `Arch.zip` со страницы [yuk7/ArchWSL/releases](https://github.com).
2. Распакуй архив в постоянную папку (например, `C:\ArchWSL\`).
3. Запусти `Arch.exe` внутри папки для инициализации (займет 15 секунд).

### 3. Настройка окружения (Внутри консоли Arch под root)
```bash
# Инициализация менеджера пакетов pacman
pacman-key --init && pacman-key --populate archlinux
pacman -Syu --noconfirm

# Установка базового софта, Git и Fish Shell
pacman -S base-devel git fish nano --needed --noconfirm

# Создание пользователя (замени username на свой ник)
useradd -m -G wheel -s /bin/bash username
passwd username

# Настройка прав sudo
EDITOR=nano visudo
# Раскомментируй строку (удали #): %wheel ALL=(ALL:ALL) ALL
# Сохрани: Ctrl+O -> Enter. Выйди: Ctrl+X.
exit
```

### 4. Привязка пользователя по умолчанию (В CMD Windows)
```cmd
cd C:\ArchWSL\
Arch.exe config --default-user username
```

### 5. Установка yay (AUR) и запуск Fish (В консоли Arch под юзером)
```bash
# Сборка yay из AUR
cd /tmp && git clone https://archlinux.org && cd yay && makepkg -si --noconfirm

# Установка Fish оболочкой по умолчанию
nano ~/.bashrc
# Вставь этот код в самый конец файла:
if [ -t 1 ]; then
    exec fish
fi
# Сохрани и выйди (Ctrl+O -> Enter -> Ctrl+X)
```

### 6. Создание ярлыка
* **ПКМ на Рабочем столе** -> **Создать** -> **Ярлык**.
* **Расположение объекта**:
  ```cmd
  cmd.exe /c "wsl.exe -d Arch"
  ```
* **Название ярлыка**: `Arch Linux`.

---

## 🇬🇧 English Version

### 1. Windows Preparation (PowerShell as Admin)
```powershell
# Enable WSL features
wsl --install

# Install Windows Terminal
winget install Microsoft.WindowsTerminal
```
*⚠️ Reboot your PC after completing this step.*

### 2. Arch Linux Deployment
1. Download `Arch.zip` from [yuk7/ArchWSL/releases](https://github.com).
2. Extract the archive into a permanent directory (e.g., `C:\ArchWSL\`).
3. Run `Arch.exe` inside that folder to initialize the distro (takes ~15 seconds).

### 3. Environment Setup (Inside Arch console as root)
```bash
# Initialize pacman package manager keys
pacman-key --init && pacman-key --populate archlinux
pacman -Syu --noconfirm

# Install essential tools, Git, and Fish Shell
pacman -S base-devel git fish nano --needed --noconfirm

# Create a regular user account (replace username with your nick)
useradd -m -G wheel -s /bin/bash username
passwd username

# Configure sudo privileges
EDITOR=nano visudo
# Uncomment the line (remove #): %wheel ALL=(ALL:ALL) ALL
# Save: Ctrl+O -> Enter. Exit: Ctrl+X.
exit
```

### 4. Bind Default User (In Windows CMD)
```cmd
cd C:\ArchWSL\
Arch.exe config --default-user username
```

### 5. Install yay (AUR) & Set Fish Default (Inside Arch as your user)
```bash
# Build yay from AUR
cd /tmp && git clone https://archlinux.org && cd yay && makepkg -si --noconfirm

# Make Fish the default shell
nano ~/.bashrc
# Append this block to the very bottom of the file:
if [ -t 1 ]; then
    exec fish
fi
# Save and exit (Ctrl+O -> Enter -> Ctrl+X)
```

### 6. Create Desktop Shortcut
* **Right-click on Desktop** -> **New** -> **Shortcut**.
* **Target Location**:
  ```cmd
  cmd.exe /c "wsl.exe -d Arch"
  ```
* **Shortcut Name**: `Arch Linux`.
