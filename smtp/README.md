# 📧 Задание 3: Отправка E‑mail через SMTP в Bash ✉️

## 📝 Описание проекта  
Скрипт `send_mail.sh` отправляет письма через SMTP с помощью `curl` (или альтернативно swaks), позволяя гибко задавать:  
- 🔧 Параметры SMTP‑сервера (хост, порт)  
- 🔐 Учётные данные (логин, пароль или App‑Password)  
- 📨 Заголовки письма (From, To, Subject)  
- 📝 Тело письма (строка или файл)  
- 🛡 TLS/STARTTLS для безопасной передачи  

## 🛠 Технологии и инструменты  
- `Bash` — скриптовый язык оболочки 🐚  
- `curl` с поддержкой SMTP/SMTPS 🌐  
- `swaks` (Swiss Army Knife for SMTP) — опционально 🔪  
- `OpenSSL` — для генерации App‑пароля (Gmail) 🔑  

## 📂 Структура репозитория  
```
assignment-3-send-mail/
├── send_mail.sh # Основной Bash‑скрипт
├── example_body.txt # Пример файла с телом письма
└── README.md # Текущая документация
```

## ⚙️ Настройка окружения  
Установите необходимые утилиты и задайте переменные окружения:
```bash
chmod +x send_mail.sh

# Настройка SMTP
export SMTP_SERVER="smtp.gmail.com"      # 🖥 SMTP‑сервер
export SMTP_PORT=587                     # 🔌 Порт (STARTTLS: 587)
export SMTP_USER="you@gmail.com"         # 👤 Логин (e‑mail)
export SMTP_PASS="your_app_password"     # 🔏 Пароль или App‑Password

# Параметры письма
export MAIL_FROM="you@gmail.com"         # 📬 От кого
export MAIL_TO="friend@example.com"      # 📥 Кому
export MAIL_SUBJECT="Тестовое письмо"    # 🏷 Тема
# Тело письма: либо переменная, либо файл
export MAIL_BODY="Привет! Это тестовое письмо."
# или
export MAIL_BODY_FILE="example_body.txt"
```

## 🚀 Запуск скрипта

```bash
./send_mail.sh
```

После успешного выполнения увидите:

```css
Email sent to friend@example.com ✅
```

## 🔄 Альтернатива с Swaks
Если `curl` не поддерживает SMTP (ошибка “Protocol smtp not supported”), установите `swaks` и выполните:

```bash
swaks \
  --to friend@example.com \
  --from you@gmail.com \
  --server smtp.gmail.com \
  --port 587 \
  --auth LOGIN \
  --auth-user you@gmail.com \
  --auth-password your_app_password \
  --tls \
  --header "Subject: Тест через swaks" \
  --body "Привет из Swaks! 🎉"
```

## ⚠️ Возможные ошибки и решения
### 🔒 Protocol “smtp” not supported
- `libcurl` собран без SMTP.

- Решение: установить полный пакет libcurl или перекомпилировать с `--enable-smtp`.

### ❌ URL rejected: No host part in the URL
- Неправильный формат `--url`.

- Убедитесь, что указан `smtp://<host>:<port>`.

### 🔐 Authentication failed
- Проверьте SMTP_USER/SMTP_PASS.

- Для Gmail включите App‑Password и двухфакторную аутентификацию.

### ⏱️ Connection timed out
- Сервер или порт недоступны (фаервол, сеть).

### 🗄 Permission denied on temp file
- Убедитесь, что скрипт имеет право писать в `/tmp`.
