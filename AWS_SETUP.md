# AWS Setup Guide для Shum UI

## 🚀 Кроки налаштування AWS для CI/CD деплою

### 1. Створення EC2 Instance

#### 1.1 Запуск EC2
1. Увійдіть в AWS Console
2. Перейдіть до EC2 Dashboard
3. Натисніть "Launch Instance"
4. Налаштування:
   - **Name**: `shum-ui-server`
   - **AMI**: Ubuntu Server 22.04 LTS
   - **Instance Type**: t3.micro (Free tier) або t3.small
   - **Key Pair**: Створіть новий або використайте існуючий
   - **Security Group**: Створіть новий з правилами:
     - SSH (22) - ваш IP
     - HTTP (80) - 0.0.0.0/0
     - HTTPS (443) - 0.0.0.0/0 (опціонально)

#### 1.2 Налаштування EC2
```bash
# Підключіться до EC2
ssh -i your-key.pem ubuntu@your-ec2-ip

# Оновіть систему
sudo apt update && sudo apt upgrade -y

# Встановіть Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Перезапустіть сесію або виконайте
newgrp docker

# Встановіть Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Перевірте встановлення
docker --version
docker-compose --version
```

### 2. Створення IAM User для CI/CD

#### 2.1 Створення користувача
1. Перейдіть до IAM Dashboard
2. Створіть нового користувача:
   - **Username**: `shum-cicd-user`
   - **Access Type**: Programmatic access

#### 2.2 Налаштування політик
Призначте наступні політики:
- `AmazonEC2ContainerRegistryFullAccess`
- `AmazonEC2FullAccess`

Або створіть кастомну політику:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets"
            ],
            "Resource": "*"
        }
    ]
}
```

#### 2.3 Збереження ключів
Збережіть:
- **Access Key ID**
- **Secret Access Key**

### 3. Створення ECR Repository

#### 3.1 Створення репозиторію
1. Перейдіть до ECR Dashboard
2. Натисніть "Create repository"
3. Налаштування:
   - **Repository name**: `shum-ui`
   - **Tag immutability**: Enabled
   - **Scan on push**: Enabled

### 4. Налаштування GitHub Secrets

#### 4.1 Додавання секретів
У вашому GitHub репозиторії перейдіть до:
`Settings` → `Secrets and variables` → `Actions`

Додайте наступні секрети:
- `AWS_ACCESS_KEY_ID` - Access Key з IAM
- `AWS_SECRET_ACCESS_KEY` - Secret Key з IAM
- `EC2_HOST` - IP адреса вашого EC2 інстансу
- `EC2_USERNAME` - `ubuntu`
- `EC2_SSH_KEY` - приватний SSH ключ (весь вміст .pem файлу)

### 5. Налаштування Domain (опціонально)

#### 5.1 Route 53
1. Створіть hosted zone для вашого домену
2. Додайте A record:
   - **Name**: `app.yourdomain.com`
   - **Value**: IP адреса EC2
   - **TTL**: 300

#### 5.2 SSL Certificate
1. Створіть SSL сертифікат в AWS Certificate Manager
2. Валідуйте через DNS або email
3. Оновіть nginx.conf для HTTPS

### 6. Моніторинг та логування

#### 6.1 CloudWatch
1. Створіть CloudWatch Log Group
2. Налаштуйте логування з EC2
3. Створіть алерти для CPU/пам'яті

#### 6.2 Health Checks
```bash
# Тестування health endpoint
curl http://your-ec2-ip/health

# Перевірка логів
docker logs shum-app
```

### 7. Безпека

#### 7.1 Security Groups
- Обмежте SSH доступ тільки з вашого IP
- Використовуйте VPC для ізоляції
- Налаштуйте Network ACLs

#### 7.2 IAM Best Practices
- Використовуйте принцип найменших привілеїв
- Регулярно ротуйте ключі
- Увімкніть MFA для користувачів

### 8. Масштабування

#### 8.1 Auto Scaling Group
1. Створіть Launch Template
2. Налаштуйте Auto Scaling Group
3. Додайте Load Balancer

#### 8.2 Load Balancer
1. Створіть Application Load Balancer
2. Налаштуйте Target Groups
3. Додайте health checks

### 9. Резервне копіювання

#### 9.1 EBS Snapshots
- Налаштуйте автоматичні снапшоти
- Зберігайте в різних AZ

#### 9.2 S3 Backup
- Створіть bucket для backup
- Налаштуйте lifecycle policies

## 🔧 Troubleshooting

### Поширені проблеми

#### Docker не запускається
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

#### Порт 80 зайнятий
```bash
sudo netstat -tulpn | grep :80
sudo systemctl stop apache2  # якщо встановлений
```

#### Проблеми з правами
```bash
sudo chown $USER:$USER ~/.docker -R
```

### Корисні команди

```bash
# Перевірка статусу контейнерів
docker ps -a

# Перегляд логів
docker logs -f shum-app

# Перезапуск контейнера
docker restart shum-app

# Очищення невикористаних ресурсів
docker system prune -a
```

## 📊 Моніторинг

### CloudWatch Metrics
- CPU Utilization
- Memory Usage
- Network I/O
- Disk I/O

### Логування
- Application logs
- Nginx access/error logs
- Docker logs

### Алерти
- High CPU usage
- Memory pressure
- Container restarts
- Health check failures 