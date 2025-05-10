FROM nginx:alpine

RUN mkdir -p /etc/nginx/ssl

COPY ssl/nginx-selfsigned.crt /etc/nginx/ssl/
COPY ssl/nginx-selfsigned.key /etc/nginx/ssl/

COPY nginx.conf /etc/nginx/nginx.conf

COPY html /usr/share/nginx/html

EXPOSE 80 443
