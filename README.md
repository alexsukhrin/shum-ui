# Shum UI

Flutter web application with CI/CD deployment to AWS EC2.

## 🚀 Quick Start

### Local Development

```bash
# Install dependencies
flutter pub get

# Run in development mode
flutter run -d web-server --web-port 8080

# Run tests
flutter test
```

### Docker

```bash
# Build image
docker build -t shum-ui .

# Run locally
docker run -p 80:80 shum-ui

# Or using docker-compose
docker-compose up -d
```

## 🏗️ CI/CD Pipeline

### GitHub Actions

Automatic deployment to AWS EC2 on push to `master` branch.

**Required GitHub Secrets:**
- `AWS_ACCESS_KEY_ID` - AWS Access Key
- `AWS_SECRET_ACCESS_KEY` - AWS Secret Key
- `EC2_HOST` - EC2 instance IP address
- `EC2_USERNAME` - EC2 user (usually `ubuntu`)
- `EC2_SSH_KEY` - Private SSH key

### Manual Deployment

```bash
# Set environment variables
export EC2_HOST="your-ec2-ip"
export EC2_USER="ubuntu"

# Run deployment
./deploy.sh
```

## 🐳 Docker

### Structure

- `Dockerfile` - Multi-stage Flutter + Nginx build
- `nginx.conf` - Nginx configuration for Flutter web app
- `docker-compose.yml` - Container orchestration

### Features

- **Multi-stage build** for size optimization
- **Gzip compression** for static files
- **Caching** for better performance
- **Security headers** for security
- **Health check** endpoint

## 🌐 AWS EC2 Setup

### Required Services

1. **EC2 Instance** (t3.micro or larger)
2. **ECR Repository** for Docker images
3. **Security Groups** with port 80 open

### EC2 Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## 📊 Monitoring

### Health Check

```bash
curl http://your-ec2-ip/health
```

### Logs

```bash
# Docker logs
docker logs shum-app

# Nginx logs
docker exec shum-app tail -f /var/log/nginx/access.log
docker exec shum-app tail -f /var/log/nginx/error.log
```

## 🔧 Development

### Project Structure

```
shum/
├── lib/                    # Dart code
├── web/                    # Web files
├── test/                   # Tests
├── Dockerfile             # Docker configuration
├── nginx.conf             # Nginx configuration
├── docker-compose.yml     # Docker Compose
├── deploy.sh              # Deployment script
└── .github/workflows/     # GitHub Actions
```

### Commands

```bash
# Code analysis
flutter analyze

# Formatting
dart format lib/

# Tests
flutter test

# Production build
flutter build web --release
```

## 📝 License

MIT License
