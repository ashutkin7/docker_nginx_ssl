#!/bin/bash
set -e

echo "Regenerating self-signed SSL certificate..."

# Пересоздание сертификата в папке certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ./certs/nginx.key -out ./certs/nginx.crt \
    -subj "/C=RU/ST=Perm/L=Perm/O=DevOps/OU=Renewal/CN=localhost"

echo "Sending reload command to Nginx inside nginx-cont container..."

# Команда перечитывания конфигурации и сертификатов внутри контейнера
docker exec nginx-cont nginx -s reload

echo "Certificates successfully updated and Nginx reloaded!"