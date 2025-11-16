
## Services

### Core Services

#### 🌐 Nginx (Web Server & Reverse Proxy)
- **Container Name**: `nginx`
- **Image**: `nginx:hidriouc`
- **Port**: 443 (HTTPS)
- **Dockerfile Location**: `requirements/nginx/Dockerfile`
- **Configuration**: `requirements/nginx/tools/nginx.conf`
- **Purpose**: 
  - Reverse proxy for WordPress
  - SSL/TLS termination
  - Static file serving
- **Volumes**: 
  - `wordpress:/var/www/wordpress` - WordPress files
- **Dependencies**: Depends on WordPress service
- **Restart Policy**: Always
- **Configuration**: Loaded from `.env` file

#### 📦 MariaDB (Database)
- **Container Name**: `mariadb`
- **Image**: `mariadb:hidriouc`
- **Port**: 3306 (internal only)
- **Dockerfile Location**: `requirements/mariadb/Dockerfile`
- **Configuration**: `requirements/mariadb/tools/mariadb-conf.sh`
- **Purpose**: 
  - Relational database backend for WordPress
  - Data persistence
- **Volumes**: 
  - `mariadb:/var/lib/mysql` - Database files
- **Health Check**: 
  - Command: `mysqladmin ping --silent`
  - Interval: 5 seconds
  - Timeout: 5 seconds
  - Retries: 5
- **Restart Policy**: Always
- **Network**: inception

#### 📄 WordPress (CMS)
- **Container Name**: `wordpress`
- **Image**: `wordpress:hidriouc`
- **Port**: Internal (exposed via Nginx :443)
- **Dockerfile Location**: `requirements/wordpress/Dockerfile`
- **Configuration**: `requirements/wordpress/tools/wordpress-conf.sh`
- **Purpose**: 
  - Content Management System
  - WordPress application
- **Volumes**: 
  - `wordpress:/var/www/wordpress` - WordPress installation
- **Dependencies**: 
  - MariaDB (service_healthy condition)
  - Waits for database to be healthy before starting
- **Restart Policy**: Always
- **Network**: inception

### Bonus Services

#### ⚡ Redis (Caching)
- **Container Name**: `redis`
- **Image**: `redis:hidriouc`
- **Port**: 6379 (internal only)
- **Dockerfile Location**: `requirements/bonus/redis/Dockerfile`
- **Configuration**: `requirements/bonus/redis/tools/redisConf.sh`
- **Purpose**: 
  - In-memory caching
  - Performance optimization for WordPress
  - Session storage
- **Volumes**: 
  - `wordpress:/var/www/wordpress` - WordPress files
- **Restart Policy**: Always
- **Network**: inception

#### 📤 FTP (File Transfer Protocol)
- **Container Name**: `ftp`
- **Image**: `ftp:hidriouc`
- **Ports**: 
  - 21 (FTP control)
  - 30000-30100 (Passive mode data transfer)
- **Dockerfile Location**: `requirements/bonus/ftp/Dockerfile`
- **Configuration**: 
  - `requirements/bonus/ftp/tools/ftpconf.conf`
  - `requirements/bonus/ftp/tools/ftpconf.sh`
- **Purpose**: 
  - File upload/download to WordPress uploads
  - Remote file management
- **Volumes**: 
  - `wordpress:/data/uploads` - WordPress uploads directory
- **Restart Policy**: Always
- **Network**: inception

#### 🗄️ Adminer (Database Management)
- **Container Name**: `adminer`
- **Image**: `adminer:hidriouc`
- **Port**: 9090
- **Dockerfile Location**: `requirements/bonus/adminer/Dockerfile`
- **Purpose**: 
  - Web-based database management
  - Query execution
  - Database administration
- **Access**: `http://localhost:9090`
- **Restart Policy**: Always
- **Network**: inception

#### 📧 MailHog (Email Testing)
- **Container Name**: `mailhog`
- **Image**: `mailhog:hidriouc`
- **Ports**: 
  - 1025 (SMTP server)
  - 8025 (Web UI)
- **Dockerfile Location**: `requirements/bonus/mailhog/Dockerfile`
- **Configuration**: `requirements/bonus/mailhog/tools/mailhog-config.yaml`
- **Purpose**: 
  - Capture and test email functionality
  - Development and testing email without sending
- **Access**: `http://localhost:8025`
- **Restart Policy**: Always
- **Network**: inception

#### 📄 Static Server (Static Content)
- **Container Name**: `static`
- **Image**: `static:hidriouc`
- **Port**: 8080
- **Dockerfile Location**: `requirements/bonus/static/Dockerfile`
- **Content**: `requirements/bonus/static/tools/staticContent.html`
- **Purpose**: 
  - Serve static HTML content
  - Web server for static files
- **Access**: `http://localhost:8080`
- **Restart Policy**: Always
- **Network**: inception

## Prerequisites

### System Requirements
- Linux (Ubuntu 20.04+ recommended) or macOS
- 4GB RAM minimum
- 10GB disk space available
- Sudo access for volume creation

### Software Requirements
- Docker 20.10 or higher
  ```bash
  docker --version
