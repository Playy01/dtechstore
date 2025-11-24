# 🚀 Guía de Despliegue - DTech Store

## Opciones de Despliegue

### Opción 1: VPS/Servidor Propio (Recomendado para producción)

#### Requisitos del Servidor:
- Ubuntu 20.04+ o similar
- 2GB RAM mínimo
- 20GB espacio en disco
- Dominio propio (opcional pero recomendado)

#### Paso 1: Preparar el Servidor

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias
sudo apt install -y git nginx mysql-server nodejs npm

# Instalar Go
wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
```

#### Paso 2: Configurar MySQL

```bash
# Configurar MySQL
sudo mysql_secure_installation

# Crear base de datos
sudo mysql -u root -p
```

```sql
CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'ecommerce_user'@'localhost' IDENTIFIED BY 'tu_password_segura';
GRANT ALL PRIVILEGES ON ecommerce.* TO 'ecommerce_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

```bash
# Importar esquema
mysql -u ecommerce_user -p ecommerce < database/schema.sql
```

#### Paso 3: Clonar y Configurar el Proyecto

```bash
# Clonar repositorio (o subir archivos)
cd /var/www
sudo git clone tu-repositorio.git dtech
cd dtech

# Configurar backend
cd backend
cp .env.example .env
nano .env
```

Edita `.env`:
```env
DB_DSN=ecommerce_user:tu_password_segura@tcp(localhost:3306)/ecommerce?parseTime=true
JWT_SECRET=genera-un-secreto-muy-seguro-aqui-con-caracteres-aleatorios
PORT=8080
```

```bash
# Compilar backend
go build -o dtech-api main.go

# Instalar frontend
cd ../frontend
npm install
npm run build
```

#### Paso 4: Configurar Nginx

```bash
sudo nano /etc/nginx/sites-available/dtech
```

```nginx
# Frontend
server {
    listen 80;
    server_name tu-dominio.com www.tu-dominio.com;

    root /var/www/dtech/frontend/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Proxy para API
    location /api {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

```bash
# Activar sitio
sudo ln -s /etc/nginx/sites-available/dtech /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### Paso 5: Configurar Servicios Systemd

**Backend Service:**
```bash
sudo nano /etc/systemd/system/dtech-api.service
```

```ini
[Unit]
Description=DTech API Server
After=network.target mysql.service

[Service]
Type=simple
User=www-data
WorkingDirectory=/var/www/dtech/backend
ExecStart=/var/www/dtech/backend/dtech-api
Restart=always
RestartSec=5
Environment="GIN_MODE=release"

[Install]
WantedBy=multi-user.target
```

```bash
# Iniciar servicios
sudo systemctl daemon-reload
sudo systemctl enable dtech-api
sudo systemctl start dtech-api
sudo systemctl status dtech-api
```

#### Paso 6: Configurar SSL (HTTPS)

```bash
# Instalar Certbot
sudo apt install -y certbot python3-certbot-nginx

# Obtener certificado SSL
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com

# Renovación automática
sudo certbot renew --dry-run
```

---

### Opción 2: Docker (Más fácil y portable)

#### Crear Dockerfile para Backend

```dockerfile
# backend/Dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o dtech-api main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/

COPY --from=builder /app/dtech-api .
EXPOSE 8080

CMD ["./dtech-api"]
```

#### Crear Dockerfile para Frontend

```dockerfile
# frontend/Dockerfile
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

#### Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: ecommerce
      MYSQL_USER: ecommerce_user
      MYSQL_PASSWORD: password
    volumes:
      - mysql_data:/var/lib/mysql
      - ./database/schema.sql:/docker-entrypoint-initdb.d/schema.sql
    ports:
      - "3306:3306"

  backend:
    build: ./backend
    environment:
      DB_DSN: ecommerce_user:password@tcp(mysql:3306)/ecommerce?parseTime=true
      JWT_SECRET: tu-secreto-super-seguro
      PORT: 8080
    ports:
      - "8080:8080"
    depends_on:
      - mysql

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  mysql_data:
```

```bash
# Desplegar con Docker
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener
docker-compose down
```

---

### Opción 3: Servicios Cloud Específicos

#### A) Railway.app (Más fácil)

1. Crea cuenta en https://railway.app
2. Conecta tu repositorio GitHub
3. Railway detectará automáticamente Go y Node.js
4. Agrega MySQL desde el marketplace
5. Configura variables de entorno
6. Deploy automático

#### B) Vercel (Frontend) + Render (Backend)

**Frontend en Vercel:**
```bash
# Instalar Vercel CLI
npm i -g vercel

# Desde la carpeta frontend
cd frontend
vercel

# Configurar:
# - Build Command: npm run build
# - Output Directory: dist
```

**Backend en Render:**
1. Crea cuenta en https://render.com
2. New → Web Service
3. Conecta repositorio
4. Build Command: `go build -o app main.go`
5. Start Command: `./app`
6. Agrega MySQL desde Render

#### C) DigitalOcean App Platform

1. Crea cuenta en DigitalOcean
2. App Platform → Create App
3. Conecta repositorio
4. Detecta automáticamente componentes
5. Agrega base de datos MySQL
6. Deploy

---

## Configuración de Producción

### 1. Variables de Entorno

**Backend (.env):**
```env
DB_DSN=usuario:password@tcp(host:3306)/database?parseTime=true
JWT_SECRET=secreto-muy-largo-y-aleatorio-minimo-32-caracteres
PORT=8080
GIN_MODE=release
```

**Frontend:**
Actualiza las URLs de API en todos los archivos:
```javascript
// Cambiar de:
const API_URL = 'http://localhost:8080/api';

// A:
const API_URL = 'https://tu-dominio.com/api';
// o
const API_URL = '/api'; // Si está en el mismo dominio
```

### 2. Seguridad

```bash
# Firewall
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable

# Fail2ban para proteger SSH
sudo apt install fail2ban
sudo systemctl enable fail2ban
```

### 3. Backups Automáticos

```bash
# Crear script de backup
sudo nano /usr/local/bin/backup-dtech.sh
```

```bash
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/var/backups/dtech"

mkdir -p $BACKUP_DIR

# Backup MySQL
mysqldump -u ecommerce_user -p'password' ecommerce > $BACKUP_DIR/db_$DATE.sql

# Backup archivos
tar -czf $BACKUP_DIR/files_$DATE.tar.gz /var/www/dtech

# Mantener solo últimos 7 días
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
```

```bash
# Hacer ejecutable
sudo chmod +x /usr/local/bin/backup-dtech.sh

# Cron diario
sudo crontab -e
# Agregar: 0 2 * * * /usr/local/bin/backup-dtech.sh
```

### 4. Monitoreo

```bash
# Instalar PM2 para Node.js (alternativa)
npm install -g pm2

# O usar systemd (ya configurado arriba)
sudo systemctl status dtech-api
sudo journalctl -u dtech-api -f
```

---

## Checklist Pre-Despliegue

- [ ] Cambiar contraseñas por defecto
- [ ] Generar JWT_SECRET seguro
- [ ] Configurar SSL/HTTPS
- [ ] Actualizar URLs de API en frontend
- [ ] Configurar backups automáticos
- [ ] Configurar firewall
- [ ] Probar todas las funcionalidades
- [ ] Configurar dominio DNS
- [ ] Habilitar logs
- [ ] Configurar monitoreo

---

## Costos Estimados

### VPS Propio:
- **DigitalOcean Droplet:** $6-12/mes
- **Linode:** $5-10/mes
- **Vultr:** $6-12/mes
- **Dominio:** $10-15/año

### Cloud Managed:
- **Railway:** $5-20/mes
- **Render:** $7-25/mes
- **Vercel + Render:** $0-20/mes (tiene tier gratuito)

---

## Comandos Útiles Post-Despliegue

```bash
# Ver logs backend
sudo journalctl -u dtech-api -f

# Reiniciar servicios
sudo systemctl restart dtech-api
sudo systemctl restart nginx

# Ver estado
sudo systemctl status dtech-api
sudo systemctl status nginx
sudo systemctl status mysql

# Actualizar código
cd /var/www/dtech
git pull
cd backend && go build -o dtech-api main.go
cd ../frontend && npm run build
sudo systemctl restart dtech-api
sudo systemctl reload nginx
```

---

## Soporte y Mantenimiento

### Actualizaciones:
1. Hacer backup antes de actualizar
2. Probar en entorno de desarrollo
3. Desplegar en producción
4. Verificar funcionamiento

### Escalabilidad:
- Usar CDN para imágenes (Cloudflare, AWS CloudFront)
- Implementar caché (Redis)
- Load balancer para múltiples instancias
- Base de datos replicada

---

## ¿Necesitas Ayuda?

Si tienes dudas sobre algún paso específico, puedo ayudarte con:
- Configuración detallada de cualquier servicio
- Scripts de automatización
- Troubleshooting de problemas
- Optimización de rendimiento
