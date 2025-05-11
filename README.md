## 📚 Обзор проекта

В этом репозитории собраны решения пяти независимых заданий по DevOps-практикам:

1. Ansible: настройка Nginx + OpenSSH ролями, шаблонами и handler’ами  
2. Docker & Docker Compose: HTTPS Nginx с самоподписанным сертификатом и привязкой томов  
3. Bash-скрипт отправки почты: send_mail.sh для SMTP через curl (или swaks)  
4. CI/CD: GitHub Actions pipeline для сборки и деплоя
5. Terraform + Yandex.Cloud: поднимаем VPC, подсеть и виртуальную машину (незавершено из-за ошибок прав доступа)

---

## 📂 Структура репозитория
```
.
├── nginx_ansible/ # Задание 1: Ansible playbook, roles/nginx и roles/ssh
│ ├── ansible.cfg
│ ├── inventory
│ ├── playbook.yml
│ ├── roles/
│ │ ├── nginx/
│ │ └── ssh/
│ └── README.md
│
├── Docker/ # Задание 2: Dockerfile, nginx.conf, html/, ssl/, gen-ssl.sh, docker-compose.yml
│ ├── Dockerfile
│ ├── nginx.conf
│ ├── html/
│ ├── ssl/
│ ├── gen-ssl.sh
│ ├── docker-compose.yml
│ └── README.md
│
├── smtp/ # Задание 3: Bash-скрипт send_mail.sh
│ ├── send_mail.sh
│ └── README.md
│
├── .github / # Задание 4: GitHub Actions workflow
│ ├── workflows/ci-cd.yml
│ └── README.md
│
│── terraform-yc/ # Задание 5: Terraform конфигурация (не завершена из-за ошибки доступа)
│ ├── provider.tf
│ ├── variables.tf
│ ├── main.tf
│ ├── outputs.tf
│ ├── secrets.tfvars (игнорируется)
│ └── README.md
```

---

## 🚀 Инструкции по запуску каждого задания

### 1. Ansible (Задание 1)

```bash
cd nginx_ansible
ansible-playbook playbook.yml
```
Роль `nginx` ставит и настраивает Nginx, проверяет порт 80.

Роль `ssh` ставит OpenSSH, создаёт пользователя с ключом.

### 2. Docker & Docker Compose (Задание 2)
```bash
cd Docker
chmod +x gen-ssl.sh
./gen-ssl.sh
docker-compose up -d --build
curl -vk https://localhost:8080   # по порту, указанному в compose
```

1. Генерация самоподписного сертификата.
2. HTTPS-сервер Nginx с редиректом HTTP→HTTPS.
3. Статика через bind-mount.

### 3. Bash-скрипт отправки почты (Задание 3)
```bash
cd smtp
chmod +x send_mail.sh
export SMTP_SERVER="smtp.example.com"
export SMTP_USER="user@example.com"
export SMTP_PASS="password"
export MAIL_FROM="user@example.com"
export MAIL_TO="recipient@example.com"
export MAIL_SUBJECT="Test"
export MAIL_BODY="Hello from Bash"
./send_mail.sh
```
Альтернатива:

```bash
swaks --to recipient@example.com … --tls
```

### 4. CI/CD GitHub Actions (Задание 4)
- CI (job `build`): сборка и пуш образа в `ghcr.io`
- CD (job `deploy`): docker-compose up + smoke-test `curl`

Workflow находится в `.github/workflows/ci-cd.yml`. Запуски появляются на вкладке *Actions*.

### 5. Terraform + Yandex.Cloud (Задание 5)
```bash
cd yc-terraform-vm
# заполнить secrets.tfvars (yc_token, cloud_id, folder_id, zone)
terraform init
terraform plan -var-file=secrets.tfvars
terraform apply -var-file=secrets.tfvars
```
> Внимание: запуск не завершён из-за ошибки доступа в каталоге (`PermissionDenied`). Необходим сервисный аккаунт с ролью `vpc.admin` и корректный JSON-ключ.

---

## 🔧 Основные проблемы и статусы
- Задание 1–3 выполнены полностью, проверены локально.
- Задание 4 рабочий GitHub Actions pipeline, тесты проходят на runner’e.
- Задание 5 остановлено: требуется настроить права сервисного аккаунта в Yandex.Cloud.
