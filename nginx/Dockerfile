FROM nginx:latest

# Создаем директорию для SSL внутри образа
RUN mkdir -p /etc/nginx/ssl

# Копируем файлы конфигурации и статики
ADD ./index.html /var/www/html/index.html
ADD ./nginx-conf/nginx.conf /etc/nginx/conf.d/default.conf

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]