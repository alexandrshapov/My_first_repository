#!/bin/bash

echo "--- ПРОВЕРКА ИНФРАСТРУКТУРЫ EPAM ---"
date

# Проверяем Nginx
if curl -s --head  --request GET http://localhost:8081 | grep "200 OK" > /dev/null
then
    echo "✅ Сайт (Nginx): РАБОТАЕТ"
else
    echo "❌ Сайт (Nginx): ОШИБКА (недоступен на 8081)"
fi

# Проверяем Redis
if docker exec epam-redis redis-cli ping | grep "PONG" > /dev/null
then
    echo "✅ База (Redis): РАБОТАЕТ (PONG получен)"
else
    echo "❌ База (Redis): ОШИБКА (база молчит)"
fi

# Проверяем Монитор
if docker ps | grep "epam-monitor" | grep "Up" > /dev/null
then
    echo "✅ Монитор (Alpine): В СТРОЮ"
else
    echo "❌ Монитор (Alpine): УПАЛ"
fi

echo "------------------------------------"
