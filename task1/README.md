# Модульная инфраструктура для нескольких сред

## Module VM

### Описание

Переиспользуемый Terraform-модуль для развёртывания виртуальной машины в Yandex Cloud в окружениях `dev`, `stage` и `prod`.

Модуль создаёт виртуальную машину в Yandex Cloud и диск для неё, добавляет ВМ в сеть и устанавливает SSH-ключ.

### Variables

| Имя             | Тип      | Описание                                                |
|-----------------|----------|---------------------------------------------------------|
| `platform_id`   | `string` | Yandex Cloud platform id                                |
| `zone`          | `string` | Yandex Cloud zone                                       |
| `cores`         | `number` | CPU count                                               |
| `memory`        | `number` | RAM in GB                                               |
| `subnet_id`     | `string` | Subnet ID where the web server will be deployed         |
| `disk_image_id` | `string` | Attached Disk image                                     |
| `disk_size`     | `number` | Attached Disk size in GB                                |
| `ssh_keys`      | `string` | SSH access public key                                   |
| `environment`   | `string` | Deployment environment name (`dev`, `stage` или `prod`) |

### Outputs

| Имя             | Описание                              |
|-----------------|---------------------------------------|
| `instance_id`   | ID of the VM instance                 |
| `instance_ip`   | Private IP address of the VM instance |
| `instance_name` | Name of the VM instance               |
| `disk_id`       | ID of the attached boot disk          |

## Переменные окружения

Каждое окружение (`envs/dev`, `envs/stage`, `envs/prod`) использует одинаковый набор переменных:

| Имя             | Тип      | Описание                                                |
|-----------------|----------|---------------------------------------------------------|
| `cloud_id`      | `string` | Yandex Cloud cloud id                                   |
| `folder_id`     | `string` | Yandex Cloud folder id                                  |
| `platform_id`   | `string` | Yandex Cloud platform id                                |
| `zone`          | `string` | Yandex Cloud zone                                       |
| `cores`         | `number` | CPU count                                               |
| `memory`        | `number` | RAM in GB                                               |
| `subnet_id`     | `string` | Subnet ID where the web server will be deployed         |
| `disk_image_id` | `string` | Attached Disk image                                     |
| `disk_size`     | `number` | Attached Disk size in GB                                |
| `environment`   | `string` | Deployment environment name (`dev`, `stage` или `prod`) |

## Запуск

Перед применением положите ключ сервисного аккаунта в `authorized_key.json` в корне `task1/` и заполните реальные значения в соответствующем `.tfvars` (`cloud_id`, `folder_id`, `subnet_id` и т.д.).

```bash
docker run --rm -v "$(pwd)":/workspace -w /workspace/envs/dev hashicorp/terraform:latest init
docker run --rm -v "$(pwd)":/workspace -w /workspace/envs/dev hashicorp/terraform:latest plan -var-file=dev.tfvars
docker run --rm -v "$(pwd)":/workspace -w /workspace/envs/dev hashicorp/terraform:latest apply -var-file=dev.tfvars
docker run --rm -it -v "$(pwd)":/workspace -w /workspace/envs/dev hashicorp/terraform:latest apply  -var-file=dev.tfvars
```

### Просмотр outputs модуля

После успешного `terraform apply` выходные значения модуля доступны через префикс `module.vm`:

```bash
terraform output
```
