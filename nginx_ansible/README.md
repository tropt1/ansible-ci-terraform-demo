# 📘 Ansible: Установка и настройка Nginx

---

Эта папка содержит Ansible playbook, который выполняет автоматизированную установку и конфигурацию:

- Веб-сервера Nginx с использованием шаблона конфигурации
- Сервера OpenSSH для удалённого доступа

---

## 📁 Структура проекта
```bash
nginx_ansible/
├── ansible.cfg
├── inventory
├── playbook.yml
├── roles/
│   ├── nginx/
│   │   ├── tasks/main.yml
│   │   ├── templates/nginx.conf.j2
│   │   ├── vars/main.yml
│   │   └── handlers/main.yml
│   └── ssh/
│       ├── tasks/main.yml
│       └── files/id_rsa.pub
```

## 🧰 Требования
- Ubuntu (локально или на виртуальной машине)
- Установлен Ansible
- Интернет-доступ для установки пакетов

## ⚙️ Подготовка

Убедитесь, что в inventory указан IP или localhost, например:

```ini
[web]
localhost:2222 ansible_user=<указать созданного юзера>
```

## 🚀 Запуск playbook
```bash
ansible-playbook playbook.yml --ask-pass --ask-become-pass
```

> В задании не указано, но можно будет сделать отдельную task для создания пользователя и установки ему пароля. После этого будет необязательно указывать пароль каждый раз при запуске playbook
 
## 📄 Что делает playbook:

### Роль nginx:

- Устанавливает nginx
- Генерирует конфиг /etc/nginx/nginx.conf из шаблона
- Запускает и активирует сервис
- Проверяет доступность порта 80

### Роль ssh:
- Устанавливает openssh-server
- Запускает и включает ssh
- Создаёт пользователя devops
- Добавляет SSH-ключ

## ✅ Пример успешного запуска
```bash
PLAY [Configure Nginx Web Server] *********************************************

TASK [nginx : Install nginx] **************************************************
changed: [localhost]

TASK [nginx : Deploy nginx configuration] *************************************
changed: [localhost]

...

TASK [nginx : Check if nginx is listening on port 80] *************************
ok: [localhost]

PLAY RECAP ********************************************************************
localhost                  : ok=6    changed=4    unreachable=0    failed=0
```
