# AWS Setup Guide for Shum UI

## 🚀 AWS Setup Steps for CI/CD Deployment

### 1. Create EC2 Instance

#### 1.1 Launch EC2
1. Sign in to AWS Console
2. Navigate to EC2 Dashboard
3. Click "Launch Instance"
4. Configuration:
   - **Name**: `shum-ui-server`
   - **AMI**: Ubuntu Server 22.04 LTS
   - **Instance Type**: t3.micro (Free tier) or t3.small
   - **Key Pair**: Create new or use existing
   - **Security Group**: Create new with rules:
     - SSH (22) - your IP
     - HTTP (80) - 0.0.0.0/0
     - HTTPS (443) - 0.0.0.0/0 (optional)

#### 1.2 EC2 Setup
```bash
# Connect to EC2
ssh -i your-key.pem ubuntu@your-ec2-ip

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Restart session or run
newgrp docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version
```

### 2. Create IAM User for CI/CD

#### 2.1 Create User
1. Navigate to IAM Dashboard
2. Create new user:
   - **Username**: `shum-cicd-user`
   - **Access Type**: Programmatic access

#### 2.2 Configure Policies
Assign the following policies:
- `AmazonEC2ContainerRegistryFullAccess`
- `AmazonEC2FullAccess`

Or create custom policy:
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

#### 2.3 Save Keys
Save:
- **Access Key ID**
- **Secret Access Key**

### 3. Create ECR Repository

#### 3.1 Create Repository
1. Navigate to ECR Dashboard
2. Click "Create repository"
3. Configuration:
   - **Repository name**: `shum-ui`
   - **Tag immutability**: Enabled
   - **Scan on push**: Enabled

### 4. Configure GitHub Secrets

#### 4.1 Add Secrets
In your GitHub repository, go to:
`Settings` → `Secrets and variables` → `Actions`

Add the following secrets:
- `AWS_ACCESS_KEY_ID` - Access Key from IAM
- `AWS_SECRET_ACCESS_KEY` - Secret Key from IAM
- `EC2_HOST` - Your EC2 instance IP address
- `EC2_USERNAME` - `ubuntu`
- `EC2_SSH_KEY` - Private SSH key (entire .pem file content)

### 5. Domain Setup (Optional)

#### 5.1 Route 53
1. Create hosted zone for your domain
2. Add A record:
   - **Name**: `app.yourdomain.com`
   - **Value**: EC2 IP address
   - **TTL**: 300

#### 5.2 SSL Certificate
1. Create SSL certificate in AWS Certificate Manager
2. Validate via DNS or email
3. Update nginx.conf for HTTPS

### 6. Monitoring and Logging

#### 6.1 CloudWatch
1. Create CloudWatch Log Group
2. Configure logging from EC2
3. Create alerts for CPU/memory

#### 6.2 Health Checks
```bash
# Test health endpoint
curl http://your-ec2-ip/health

# Check logs
docker logs shum-app
```

### 7. Security

#### 7.1 Security Groups
- Restrict SSH access to your IP only
- Use VPC for isolation
- Configure Network ACLs

#### 7.2 IAM Best Practices
- Use principle of least privilege
- Rotate keys regularly
- Enable MFA for users

### 8. Scaling

#### 8.1 Auto Scaling Group
1. Create Launch Template
2. Configure Auto Scaling Group
3. Add Load Balancer

#### 8.2 Load Balancer
1. Create Application Load Balancer
2. Configure Target Groups
3. Add health checks

### 9. Backup

#### 9.1 EBS Snapshots
- Configure automatic snapshots
- Store in different AZs

#### 9.2 S3 Backup
- Create bucket for backup
- Configure lifecycle policies

## 🔧 Troubleshooting

### Common Issues

#### Docker not starting
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

#### Port 80 occupied
```bash
sudo netstat -tulpn | grep :80
sudo systemctl stop apache2  # if installed
```

#### Permission issues
```bash
sudo chown $USER:$USER ~/.docker -R
```

### Useful Commands

```bash
# Check container status
docker ps -a

# View logs
docker logs -f shum-app

# Restart container
docker restart shum-app

# Clean up unused resources
docker system prune -a
```

## 📊 Monitoring

### CloudWatch Metrics
- CPU Utilization
- Memory Usage
- Network I/O
- Disk I/O

### Logging
- Application logs
- Nginx access/error logs
- Docker logs

### Alerts
- High CPU usage
- Memory pressure
- Container restarts
- Health check failures 