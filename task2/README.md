# Интеграция с CI/CD и удалённым хранением состояния

## Запуск

Перед применением создайте бакет "future20" S3 в Yandex Cloud и сервисный аккаунт с доступом на чтение/запись.
После положите ключ сервисного аккаунта в `authorized_key.json` в корне `task2/` и заполните реальные значения в соответствующем `.tfvars` (`cloud_id`, `folder_id`, `subnet_id` и т.д.).

```bash

docker run --rm -v "$(pwd)":/workspace -w /workspace/envs/dev -e AWS_ACCESS_KEY_ID="..." -e AWS_SECRET_ACCESS_KEY="..." hashicorp/terraform:latest init
docker run --rm -v "$(pwd)":/workspace -w /workspace/envs/dev -e AWS_ACCESS_KEY_ID="..." -e AWS_SECRET_ACCESS_KEY="..." hashicorp/terraform:latest validate
docker run --rm -v "$(pwd)":/workspace -w /workspace/envs/dev -e AWS_ACCESS_KEY_ID="..." -e AWS_SECRET_ACCESS_KEY="..." hashicorp/terraform:latest plan  -var-file=dev.tfvars
docker run --rm -it -v "$(pwd)":/workspace -w /workspace/envs/dev -e AWS_ACCESS_KEY_ID="..." -e AWS_SECRET_ACCESS_KEY="..." hashicorp/terraform:latest apply  -var-file=dev.tfvars
```

### Просмотр outputs модуля

После успешного `terraform apply` выходные значения модуля доступны через префикс `module.vm`:

```bash
terraform output
```

## CI
Пайплайн [/.github/workflows/task2.yml](/.github/workflows/task2.yml)

### Секреты
- AWS_ACCESS_KEY_ID - Идентификатор ключа Yandex Cloud
- AWS_SECRET_ACCESS_KEY - Cекретный ключ Yandex Cloud
- AUTHORIZED_KEY_JSON_BASE64 - файл authorized_key.json в BASE64

### Окружение
Требуется окружение dev с настроенным требованием ревью.

### Plan
- Определяет переменные окружения S3 из секретов репозитория.
- Создаёт `/workspace/` и восстанавливает `authorized_key.json` из секрета.
- Выполняет `terraform init`, `validate`, `plan -out=tfplan`.
- Сохраняет plan-файл как artifact `tfplan`.

### Apply
- Запускается на окружении `dev`.
- Скачивает artifact `tfplan` из job `plan`.
- Создаёт `/workspace/` и восстанавливает `authorized_key.json` из секрета.
- Выполняет `terraform init` и `terraform apply -auto-approve tfplan`.
