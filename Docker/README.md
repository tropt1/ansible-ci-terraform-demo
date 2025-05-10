# 🚀 Задание 2: HTTPS Nginx в Docker 🔒

## 📋 Описание  
Проект собирает в Docker веб‑сервер Nginx, который:  
- 🔐 Отдаёт статическую HTML‑страницу по HTTPS с самоподписанным сертификатом  
- 🔄 Перенаправляет весь HTTP‑трафик на HTTPS  

Демонстрирует:  
- 🐳 Лучшие практики написания Dockerfile  
- 📂 Bind‑mount томов хоста  
- 🔑 Настройку SSL/TLS внутри контейнера  
- 🛠 Базовое устранение ошибок (в том числе SELinux)

## 🛠 Стек технологий  
- `Docker` (Engine, Compose)  
- `nginx:alpine`  
- `OpenSSL` для генерации сертификата  
- `Bash` (скрипт генерации сертификата)

## 📁 Структура репозитория  
```
assignment-2-nginx-docker/
├── Dockerfile
├── docker‑compose.yml
├── gen-ssl.sh
├── nginx.conf
├── ssl/
│ ├── nginx-selfsigned.crt
│ └── nginx-selfsigned.key
└── html/
└── index.html
```

## ⚙️ Инструкция по запуску

1. 🖥 Установите ([Docker](https://docs.docker.com/get-docker/)) и ([Docker Compose] (https://docs.docker.com/compose/install/)).  

2. 🔑 Сгенерируйте SSL‑сертификат и ключ:  

```bash
chmod +x gen-ssl.sh
./gen-ssl.sh
```

## 🏗 Соберите и запустите контейнеры:

```bash
docker-compose down
docker-compose up -d --build
```

## 🔍 Проверьте работу:

```bash
curl -vk https://localhost:8080
```

Вы увидите страницу «Hello from HTTPS Nginx in Docker». 🎉

## 🖼 Превью результата

## ⚠️ Возможные ошибки и их решение
### ❌ 403 Forbidden при обращении к странице
Проверьте права на папку и файл статики:

```bash
chmod 755 html
chmod 644 html/index.html
```

### 🔄 Перезапустите контейнеры:

```bash
docker-compose down && docker-compose up -d --build
```

### 🔐 Ошибки SSL “Permission denied”
Проверьте права на сертификат и ключ:

```bash
chmod 644 ssl/nginx-selfsigned.crt
chmod 644 ssl/nginx-selfsigned.key
chmod 755 ssl
```

Альтернатива в Dockerfile:

```dockerfile
RUN chmod 644 /etc/nginx/ssl/*.crt /etc/nginx/ssl/*.key
```

### 🛡 SELinux “Permission denied” при bind‑mount
Добавьте :z к томам в docker‑compose.yml:

```yaml
volumes:
  - ./ssl:/etc/nginx/ssl:ro,z
  - ./html:/usr/share/nginx/html:ro,z
```

Или переназначьте контекст безопасности:

```bash
sudo chcon -R -t svirt_sandbox_file_t ssl html
sudo restorecon -R ssl html
```

После любых правок выполняйте:

```bash
docker-compose down && docker-compose up -d --build
```
