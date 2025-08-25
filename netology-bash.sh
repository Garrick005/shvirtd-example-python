#!/bin/bash

# === Настройки ===
REPO_URL="https://github.com/Garrick005/shvirtd-example-python.git"
PROJECT_NAME="netology-test-http"
INSTALL_DIR="/opt/$PROJECT_NAME"

# === Проверка зависимостей ===
command -v docker >/dev/null 2>&1 || { echo >&2 "❌ Docker не установлен. Установите его и повторите."; exit 1; }
command -v docker-compose >/dev/null 2>&1 || {
    echo "⚠️ docker-compose не найден, пытаемся использовать встроенный плагин..."
    docker compose version >/dev/null 2>&1 || { echo >&2 "❌ docker compose тоже не найден. Установите docker compose."; exit 1; }
}

# === Клонирование репозитория ===
echo "📥 Клонируем репозиторий в $INSTALL_DIR..."
sudo git clone "$REPO_URL" "$INSTALL_DIR" || { echo "❌ Ошибка при клонировании репозитория."; exit 1; }

# === Переход в каталог проекта ===
cd "$INSTALL_DIR" || { echo "❌ Не удалось перейти в каталог $INSTALL_DIR."; exit 1; }

# === Запуск проекта ===
echo "🚀 Запускаем проект через docker-compose..."
if [ -f compose.yaml ]; then
    sudo docker compose up -d || sudo docker-compose up -d
    echo "✅ Проект успешно запущен!"
else
    echo "❌ Файл compose.yaml не найден в $INSTALL_DIR"
    exit 1
fi
