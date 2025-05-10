#!/usr/bin/env bash
openssl req -x509 -nodes -days 365 \
    -subj "/C=US/ST=State/L=City/O=Org/OU=Unit/CN=localhost" \
    -newkey rsa:2048 \
    -keyout ssl/nginx-selfsigned.key \
    -out ssl/nginx-selfsigned.crt
