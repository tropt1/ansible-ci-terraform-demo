# 📘 Описание

В данной папке находятся файлы для terraform, который создает виртуальную машину и необходимые для ее работы зависимости в облаке Yandex Cloud.

## 📁 Структура проекта
```
yc-terraform-vm/
├── provider.tf          # Настройка Terraform-провайдера Yandex.Cloud
├── variables.tf         # Определение входных переменных
├── main.tf              # Ресурсы VPC, подсеть, VM
├── outputs.tf           # Вывод IP-адресов инстанса
├── secrets.tfvars       # Значения для yc_token, cloud_id, folder_id, zone (игнорируется)
└── .gitignore           # Игнорирует secrets.tfvars и служебные файлы
```

## ⚙️ Инструкции по запуску

1. Установите Terraform
Скачайте и установите Terraform версии ≥ 1.1 по инструкции официального реестра

2. Получите файл ключа сервисного аккаунта

- Создайте сервисный аккаунт через `yc iam service-account create`
- Назначьте ему роль `roles/vpc.admin` на нужном каталоге
- Сгенерируйте JSON-ключ:

```lua
yc iam service-account create-key \
  --service-account-id <ID> \
  --output key.json
```

3. Создайте и заполните secrets.tfvars
```bash
nano secrets.tfvars
```

```hcl
yc_token  = "<path/to/key.json>"  
cloud_id  = "<ваш-cloud-id>"  
folder_id = "<ваш-folder-id>"  
zone      = "ru-central1-a"
```
4. Инициализируйте и примените Terraform

```bash
terraform init                              
terraform plan -var-file=secrets.tfvars     
terraform apply -var-file=secrets.tfvars  
```

Если прав доступа достаточно, Terraform создаст сеть, подсеть и VM

## 🚧 Неудачная попытка запуска
При первом terraform apply появился ответ от API Yandex.Cloud:

```vbnet
rpc error: code = PermissionDenied desc = Operation is not permitted in the folder
```
Это означало, что ключ пользователя/сервисного аккаунта не имел роли `vpc.admin` в указанном `folder_id`. Несмотря на привязку роли к пользователю, ошибка сохранялась, и запуск ресурсов не состоялся.
