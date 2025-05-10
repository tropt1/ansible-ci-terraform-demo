FROM nginx:alpine

RUN mkdir -p /etc/nginx/ssl \
    && chown -R nginx:nginx /etc/nginx/ssl \
    && chmod -R 755 /etc/nginx/ssl

COPY ./ssl /etc/nginx/ssl

RUN chmod 644 /etc/nginx/ssl/nginx-selfsigned.crt \
    && chmod 644 /etc/nginx/ssl/nginx-selfsigned.key

COPY nginx.conf /etc/nginx/nginx.conf

COPY html /usr/share/nginx/html

EXPOSE 80 443
