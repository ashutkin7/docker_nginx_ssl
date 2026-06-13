#!/bin/bash
set -e

# Остановка и удаление старого контейнера, если он существует
docker stop nginx-cont 2>/dev/null || true
docker rm nginx-cont 2>/dev/null || true

# Генерация базовых самоподписанных сертификатов, если их еще нет
if [ ! -f ./certs/nginx.crt ]; then
    echo "Certificates not found. Generating initial certificates..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout ./certs/nginx.key -out ./certs/nginx.crt \
        -subj "/C=RU/ST=Perm/L=Perm/O=DevOps/OU=Education/CN=localhost"
fi

# Сборка Docker-образа
docker build -t devops/nginx-server ./nginx

# Запуск контейнера с пробросом портов и монтированием Volume для SSL
docker run -d \
    --name nginx-cont \
    -p 54321:80 \
    -p 54322:443 \
    -v "$(pwd)/certs:/etc/nginx/ssl" \
    --restart unless-stopped \
    devops/nginx-server

echo "Deployment successful!"
echo "HTTP available at http://127.0.0.1:54321"
echo "HTTPS available at https://127.0.0.1:54322"