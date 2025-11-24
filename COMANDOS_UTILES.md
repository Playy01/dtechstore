# 🛠️ Comandos Útiles

Comandos que te ayudarán durante y después del despliegue.

---

## ✅ Verificación

### Verificar que todo esté listo
```bash
./verificar-despliegue.sh
```

### Ver estructura del proyecto
```bash
tree -L 2 -I 'node_modules|dist|.astro'
```

### Verificar archivos Docker
```bash
ls -la backend/railway.Dockerfile frontend/railway.Dockerfile
```

---

## 🐳 Docker Local (Pruebas)

### Construir backend
```bash
cd backend
docker build -f railway.Dockerfile -t dtech-backend .
```

### Construir frontend
```bash
cd frontend
docker build -f railway.Dockerfile -t dtech-frontend .
```

### Ejecutar backend local
```bash
docker run -p 8080:8080 \
  -e DB_DSN="tu-conexion" \
  -e JWT_SECRET="secreto" \
  dtech-backend
```

### Ejecutar frontend local
```bash
docker run -p 80:80 dtech-frontend
```

---

## 🔍 Pruebas de API

### Health check
```bash
curl https://tu-backend.railway.app/api/health
```

### Listar productos
```bash
curl https://tu-backend.railway.app/api/products
```

### Registrar usuario
```bash
curl -X POST https://tu-backend.railway.app/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "password123"
  }'
```

### Login
```bash
curl -X POST https://tu-backend.railway.app/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```

### Obtener perfil (con token)
```bash
TOKEN="tu-token-jwt"
curl https://tu-backend.railway.app/api/users/me \
  -H "Authorization: Bearer $TOKEN"
```

---

## 📊 Base de Datos

### Conectar a MySQL local
```bash
mysql -u root -p ecommerce
```

### Importar schema
```bash
mysql -u root -p ecommerce < database/schema.sql
```

### Ver tablas
```sql
SHOW TABLES;
```

### Ver usuarios
```sql
SELECT id, name, email, role FROM users;
```

### Ver productos
```sql
SELECT id, name, price, stock FROM products;
```

### Ver órdenes
```sql
SELECT o.id, u.name, o.total, o.status, o.created_at 
FROM orders o 
JOIN users u ON o.user_id = u.id;
```

---

## 🔧 Git

### Ver estado
```bash
git status
```

### Agregar cambios
```bash
git add .
```

### Commit
```bash
git commit -m "Preparado para despliegue en Railway"
```

### Push a GitHub
```bash
git push origin main
```

### Ver último commit
```bash
git log -1
```

### Ver cambios
```bash
git diff
```

---

## 📝 Logs y Debugging

### Ver logs del backend (local)
```bash
cd backend
go run main.go
```

### Ver logs del frontend (local)
```bash
cd frontend
npm run dev
```

### Compilar backend
```bash
cd backend
go build -o dtech-api main.go
```

### Ejecutar backend compilado
```bash
cd backend
./dtech-api
```

---

## 🧪 Testing

### Test de conexión a base de datos
```bash
cd backend
go run main.go
# Busca: "Conexión a MySQL exitosa"
```

### Test de compilación frontend
```bash
cd frontend
npm run build
```

### Test de servidor local
```bash
cd frontend
npm run preview
```

---

## 📦 Dependencias

### Actualizar dependencias Go
```bash
cd backend
go mod tidy
go mod download
```

### Actualizar dependencias Node
```bash
cd frontend
npm update
```

### Ver dependencias Go
```bash
cd backend
go list -m all
```

### Ver dependencias Node
```bash
cd frontend
npm list
```

---

## 🔐 Seguridad

### Generar JWT secret seguro
```bash
openssl rand -base64 32
```

### Generar password hash (para testing)
```bash
echo -n "password123" | sha256sum
```

### Ver variables de entorno (local)
```bash
cat backend/.env
```

---

## 🌐 Railway CLI (Opcional)

### Instalar Railway CLI
```bash
npm i -g @railway/cli
```

### Login
```bash
railway login
```

### Ver proyectos
```bash
railway list
```

### Ver logs en tiempo real
```bash
railway logs
```

### Ver variables
```bash
railway variables
```

### Ejecutar comando en Railway
```bash
railway run <comando>
```

---

## 📊 Monitoreo

### Ver uso de recursos (local)
```bash
docker stats
```

### Ver procesos
```bash
ps aux | grep dtech
```

### Ver puertos en uso
```bash
netstat -tulpn | grep :8080
```

### Matar proceso en puerto 8080
```bash
lsof -ti:8080 | xargs kill -9
```

---

## 🧹 Limpieza

### Limpiar builds de Go
```bash
cd backend
go clean
rm -f dtech-api
```

### Limpiar builds de Node
```bash
cd frontend
rm -rf dist .astro
```

### Limpiar Docker
```bash
docker system prune -a
```

### Limpiar node_modules
```bash
cd frontend
rm -rf node_modules
npm install
```

---

## 🔄 Actualización

### Actualizar código en Railway
```bash
# Railway redespliega automáticamente al hacer push
git add .
git commit -m "Actualización"
git push origin main
```

### Forzar redespliegue en Railway
```bash
# En Railway Dashboard:
# 1. Ve al servicio
# 2. Click en "Deployments"
# 3. Click en "Redeploy"
```

---

## 📸 Backup

### Backup de base de datos (local)
```bash
mysqldump -u root -p ecommerce > backup_$(date +%Y%m%d).sql
```

### Restaurar backup
```bash
mysql -u root -p ecommerce < backup_20251124.sql
```

### Backup de código
```bash
tar -czf backup_codigo_$(date +%Y%m%d).tar.gz \
  backend/ frontend/ database/ \
  --exclude=node_modules \
  --exclude=dist \
  --exclude=.astro
```

---

## 🎯 Shortcuts

### Desarrollo rápido
```bash
# Terminal 1: Backend
cd backend && go run main.go

# Terminal 2: Frontend
cd frontend && npm run dev
```

### Build completo
```bash
# Backend
cd backend && go build -o dtech-api main.go

# Frontend
cd frontend && npm run build
```

### Verificación completa
```bash
./verificar-despliegue.sh && \
echo "✅ Verificación pasada" || \
echo "❌ Verificación fallida"
```

---

## 💡 Tips

### Alias útiles (agregar a ~/.bashrc)
```bash
alias dtech-verify='./verificar-despliegue.sh'
alias dtech-backend='cd backend && go run main.go'
alias dtech-frontend='cd frontend && npm run dev'
alias dtech-logs='railway logs'
```

### Variables de entorno rápidas
```bash
export DB_DSN="root:password@tcp(localhost:3306)/ecommerce?parseTime=true"
export JWT_SECRET="tu-secreto-local"
export PORT="8080"
```

---

## 🆘 Comandos de Emergencia

### Backend no responde
```bash
# 1. Ver logs
railway logs

# 2. Verificar variables
railway variables

# 3. Redeploy
# (desde Railway Dashboard)
```

### Frontend no carga
```bash
# 1. Verificar build local
cd frontend && npm run build

# 2. Ver errores
npm run build 2>&1 | grep -i error

# 3. Limpiar y rebuild
rm -rf dist .astro node_modules
npm install
npm run build
```

### Base de datos no conecta
```bash
# 1. Verificar conexión
mysql -h host -u user -p database

# 2. Ver tablas
mysql -h host -u user -p -e "SHOW TABLES;" database

# 3. Reimportar schema
mysql -h host -u user -p database < database/schema.sql
```

---

## 📚 Recursos

- [Railway CLI Docs](https://docs.railway.app/develop/cli)
- [Docker Docs](https://docs.docker.com)
- [Go Commands](https://pkg.go.dev/cmd/go)
- [npm Commands](https://docs.npmjs.com/cli/v8/commands)

---

**Tip**: Guarda este archivo como referencia rápida durante el desarrollo y despliegue.
