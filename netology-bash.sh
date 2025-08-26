#!/bin/bash

REPO_URL="https://github.com/Garrick005/shvirtd-example-python.git"
PROJECT_NAME="netology-test-http"
INSTALL_DIR="/opt/$PROJECT_NAME"

echo "Клонируем репозиторий в $INSTALL_DIR..."
sudo git clone "$REPO_URL" "$INSTALL_DIR" || { echo "Ошибка при клонировании репозитория."; exit 1; }

cd "$INSTALL_DIR" || { echo "Не удалось перейти в каталог $INSTALL_DIR."; exit 1; }

echo "Запускаем проект через docker-compose..."
if [ -f compose.yaml ]; then
    sudo docker compose up -d || sudo docker-compose up -d
    echo "Проект успешно запущен!"
else
    echo "Файл compose.yaml не найден в $INSTALL_DIR"
    exit 1
fi
