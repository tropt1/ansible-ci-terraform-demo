## 📖 Обзор задания  
В этой папке реализован CI/CD‑pipeline на GitHub Actions, который при пуше в ветку main автоматически:  
- 🏗 Собирает Docker‑образ и публикует его в GitHub Container Registry (GHCR) с помощью docker/build-push-action@v3 и Buildx.  
- 🚀 Деплоит сервисы через docker-compose с действием hoverkraft-tech/compose-action@v2.2.0 и выполняет smoke‑тест curl к HTTPS 

---

## 🔍 Краткий разбор пайплайна  

### 1. CI: сборка и публикация образа  
- Workflow запускается при событии push в ветку main (см. on: push.branches).  
- actions/checkout@v3 получает исходники репозитория.  
- docker/setup-buildx-action@v3 настраивает Buildx (BuildKit) для много‑архитектурной сборки.  
- docker/login-action@v2 логинится в ghcr.io, используя GITHUB_TOKEN с правом packages: write.  
- docker/build-push-action@v3 собирает образ из папки с Dockerfile и пушит его в GHCR под тегом latest  

### 2. CD: деплой и smoke‑тест  
- hoverkraft-tech/compose-action@v2.2.0 выполняет docker-compose up -d --build и затем docker-compose down для управления жизненным циклом контейнеров.  
- После старта сервисов скрипт ждёт 10 секунд и выполняет curl -vk https://localhost:443 для проверки доступности HTTPS-сервера.

---

## Результат CI/CD пайплайна
- Можете зайти в [Actions](https://github.com/tropt1/ansible-ci-terraform-demo/actions) репозитория и увидеть результат запуска пайплайна

![Снимок экрана от 2025-05-10 23-20-24](https://github.com/user-attachments/assets/8edc5cd3-5d18-41b0-a834-b03b13c3aa2e)
