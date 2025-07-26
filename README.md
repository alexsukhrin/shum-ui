# Shum UI

Flutter веб-додаток з CI/CD деплоєм на AWS EC2.

## 🚀 Швидкий старт

### Локальна розробка

```bash
# Встановити залежності
flutter pub get

# Запустити в режимі розробки
flutter run -d web-server --web-port 8080

# Запустити тести
flutter test
```

### Docker

```bash
# Зібрати образ
docker build -t shum-ui .

# Запустити локально
docker run -p 80:80 shum-ui

# Або використовуючи docker-compose
docker-compose up -d
```

## 🏗️ CI/CD Pipeline

### GitHub Actions

Автоматичний деплой на AWS EC2 при пуші в гілку `master`.

**Необхідні секрети в GitHub:**
- `AWS_ACCESS_KEY_ID` - AWS Access Key
- `AWS_SECRET_ACCESS_KEY` - AWS Secret Key
- `EC2_HOST` - IP адреса EC2 інстансу
- `EC2_USERNAME` - користувач EC2 (зазвичай `ubuntu`)
- `EC2_SSH_KEY` - приватний SSH ключ

### Ручний деплой

```bash
# Налаштувати змінні середовища
export EC2_HOST="your-ec2-ip"
export EC2_USER="ubuntu"

# Запустити деплой
./deploy.sh
```

## 🐳 Docker

### Структура

- `Dockerfile` - багатоетапна збірка Flutter + Nginx
- `nginx.conf` - конфігурація Nginx для Flutter веб-додатку
- `docker-compose.yml` - оркестрація контейнерів

### Особливості

- **Multi-stage build** для оптимізації розміру
- **Gzip компресія** для статичних файлів
- **Кешування** для кращої продуктивності
- **Security headers** для безпеки
- **Health check** endpoint

## 🌐 AWS EC2 Налаштування

### Необхідні сервіси

1. **EC2 Instance** (t3.micro або більше)
2. **ECR Repository** для Docker образів
3. **Security Groups** з відкритим портом 80

### Налаштування EC2

```bash
# Оновити систему
sudo apt update && sudo apt upgrade -y

# Встановити Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Встановити Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## 📊 Моніторинг

### Health Check

```bash
curl http://your-ec2-ip/health
```

### Логи

```bash
# Docker логи
docker logs shum-app

# Nginx логи
docker exec shum-app tail -f /var/log/nginx/access.log
docker exec shum-app tail -f /var/log/nginx/error.log
```

## 🔧 Розробка

### Структура проекту

```
shum/
├── lib/                    # Dart код
├── web/                    # Веб-файли
├── test/                   # Тести
├── Dockerfile             # Docker конфігурація
├── nginx.conf             # Nginx конфігурація
├── docker-compose.yml     # Docker Compose
├── deploy.sh              # Скрипт деплою
└── .github/workflows/     # GitHub Actions
```

### Команди

```bash
# Аналіз коду
flutter analyze

# Форматування
dart format lib/

# Тести
flutter test

# Збірка для продакшену
flutter build web --release
```

## 📝 Ліцензія

MIT License
