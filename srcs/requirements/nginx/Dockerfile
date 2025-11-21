FROM alpine:3.19

RUN apk update && apk add --no-cache \
    nginx \
    openssl

# Dossiers nécessaires
RUN mkdir -p /etc/nginx/ssl /var/www/html

# Copier SSL
COPY ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY ssl/nginx.key /etc/nginx/ssl/nginx.key

# Copier les configs Nginx
COPY config/default.conf /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
