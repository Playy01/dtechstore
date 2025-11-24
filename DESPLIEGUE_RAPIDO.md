# 🚀 Despliegue Rápido con Docker

## Opción Más Fácil y Rápida

### Requisitos:
- Docker instalado
- Docker Compose instalado

### Pasos:

1. **Ejecutar script de despliegue:**
```bash
./deploy.sh
```

¡Eso es todo! El script automáticamente:
- Construye las imágenes Docker
- Configura MySQL
- Inicia el backend (Go)
- Inicia el frontend (Astro)
- Configura la red entre servicios

### Acceder a tu tienda:

- **Frontend:** http://localhost
- **Backend API:** http://localhost:8080/api
- **Admin:** http://localhost (login como admin)

### Credenciales Admin:
- Email: `admin@tienda.com`
- Password: `admin123`

---

## Comandos Útiles

```bash
# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mysql

# Detener todos los servicios
docker-compose down

# Reiniciar servicios
docker-compose restart

# Ver estado de servicios
docker-compose ps

# Reconstruir y reiniciar
docker-compose up -d --build

# Acceder a la base de datos
docker-compose exec mysql mysql -u ecommerce_user -p ecommerce
```

---

## Desplegar en Servidor Remoto

### 1. Copiar archivos al servidor:
```bash
scp -r . usuario@tu-servidor.com:/var/www/dtech
```

### 2. Conectar al servidor:
```bash
ssh usuario@tu-servidor.com
cd /var/www/dtech
```

### 3. Ejecutar despliegue:
```bash
./deploy.sh
```

### 4. Configurar dominio (opcional):

Edita `frontend/nginx.conf` y cambia:
```nginx
server_name _;
```

Por:
```nginx
server_name tu-dominio.com www.tu-dominio.com;
```

Luego reinicia:
```bash
docker-compose restart frontend
```

---

## Configurar HTTPS (Producción)

Si tienes un dominio, puedes agregar SSL gratis con Let's Encrypt:

```bash
# Instalar Certbot
sudo apt install certbot python3-certbot-nginx

# Obtener certificado
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com

# Renovación automática
sudo certbot renew --dry-run
```

---

## Personalizar Configuración

### Cambiar puerto del frontend:
Edita `docker-compose.yml`:
```yaml
frontend:
  ports:
    - "3000:80"  # Cambia 3000 por el puerto que quieras
```

### Cambiar credenciales de MySQL:
Edita `docker-compose.yml`:
```yaml
mysql:
  environment:
    MYSQL_PASSWORD: tu_nueva_password
```

Y actualiza en `backend`:
```yaml
backend:
  environment:
    DB_DSN: ecommerce_user:tu_nueva_password@tcp(mysql:3306)/ecommerce?parseTime=true
```

### Cambiar JWT Secret:
Edita `docker-compose.yml`:
```yaml
backend:
  environment:
    JWT_SECRET: tu-secreto-super-seguro-aqui
```

---

## Solución de Problemas

### El frontend no carga:
```bash
docker-compose logs frontend
docker-compose restart frontend
```

### El backend no responde:
```bash
docker-compose logs backend
docker-compose restart backend
```

### Error de base de datos:
```bash
docker-compose logs mysql
docker-compose restart mysql
```

### Reiniciar todo desde cero:
```bash
docker-compose down -v  # -v elimina volúmenes
./deploy.sh
```

---

## Backup y Restauración

### Hacer backup:
```bash
# Backup de base de datos
docker-compose exec mysql mysqldump -u ecommerce_user -pecommerce_pass ecommerce > backup.sql

# Backup de volúmenes
docker run --rm -v dtech_mysql_data:/data -v $(pwd):/backup alpine tar czf /backup/mysql-backup.tar.gz /data
```

### Restaurar backup:
```bash
# Restaurar base de datos
docker-compose exec -T mysql mysql -u ecommerce_user -pecommerce_pass ecommerce < backup.sql
```

---

## Monitoreo

### Ver uso de recursos:
```bash
docker stats
```

### Ver espacio en disco:
```bash
docker system df
```

### Limpiar recursos no usados:
```bash
docker system prune -a
```

---

## ¿Listo para Producción?

Checklist:
- [ ] Cambiar contraseñas por defecto
- [ ] Configurar JWT_SECRET seguro
- [ ] Configurar dominio
- [ ] Habilitar HTTPS
- [ ] Configurar backups automáticos
- [ ] Configurar firewall
- [ ] Probar todas las funcionalidades

¡Tu tienda está lista para recibir clientes! 🎉
