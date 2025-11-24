# 🆓 Despliegue GRATIS - DTech Store

## Opción Recomendada: Railway.app

Railway ofrece $5 de crédito gratis al mes (suficiente para tu tienda) y es MUY fácil de usar.

---

## 📋 Paso a Paso

### Paso 1: Preparar el Código

Primero, necesitas subir tu código a GitHub:

```bash
# Inicializar Git (si no lo has hecho)
git init

# Agregar archivos
git add .

# Hacer commit
git commit -m "Initial commit - DTech Store"

# Crear repositorio en GitHub
# Ve a https://github.com/new y crea un repositorio llamado "dtech-store"

# Conectar y subir
git remote add origin https://github.com/TU-USUARIO/dtech-store.git
git branch -M main
git push -u origin main
```

### Paso 2: Crear Cuenta en Railway

1. Ve a https://railway.app
2. Click en "Start a New Project"
3. Inicia sesión con GitHub (es gratis)
4. Autoriza Railway para acceder a tus repositorios

### Paso 3: Desplegar MySQL

1. En Railway, click en "+ New"
2. Selecciona "Database" → "MySQL"
3. Railway creará automáticamente la base de datos
4. Click en la base de datos → "Variables" → Copia estas variables:
   - `MYSQL_URL`
   - `MYSQL_HOST`
   - `MYSQL_USER`
   - `MYSQL_PASSWORD`
   - `MYSQL_DATABASE`

### Paso 4: Importar Esquema de Base de Datos

1. En Railway, click en tu base de datos MySQL
2. Ve a "Data" → "Query"
3. Copia y pega el contenido de `database/schema.sql`
4. Click en "Run Query"

### Paso 5: Desplegar Backend (Go)

1. En Railway, click en "+ New"
2. Selecciona "GitHub Repo"
3. Busca y selecciona tu repositorio "dtech-store"
4. Railway detectará automáticamente que es un proyecto Go
5. Click en el servicio → "Settings"
6. Configura:
   - **Root Directory:** `backend`
   - **Build Command:** `go build -o main .`
   - **Start Command:** `./main`

7. Ve a "Variables" y agrega:
   ```
   DB_DSN=usuario:password@tcp(host:3306)/database?parseTime=true
   JWT_SECRET=genera-un-secreto-muy-largo-aqui-minimo-32-caracteres
   PORT=8080
   GIN_MODE=release
   ```
   
   Reemplaza con los datos de tu MySQL de Railway.

8. Click en "Deploy"

### Paso 6: Desplegar Frontend (Astro)

1. En Railway, click en "+ New"
2. Selecciona "GitHub Repo" → tu repositorio
3. Railway detectará Node.js
4. Click en el servicio → "Settings"
5. Configura:
   - **Root Directory:** `frontend`
   - **Build Command:** `npm install && npm run build`
   - **Start Command:** `npx serve dist -p $PORT`

6. Ve a "Variables" y agrega:
   ```
   NODE_VERSION=18
   ```

7. Click en "Deploy"

### Paso 7: Configurar Dominios

1. Click en tu servicio Frontend
2. Ve a "Settings" → "Networking"
3. Click en "Generate Domain"
4. Railway te dará una URL como: `tu-app.up.railway.app`

5. Haz lo mismo para el Backend
6. Obtendrás algo como: `tu-backend.up.railway.app`

### Paso 8: Actualizar URLs en el Frontend

Necesitas actualizar las URLs de la API en tu código:

**Opción A: Usar variables de entorno (Recomendado)**

Crea `frontend/.env`:
```env
PUBLIC_API_URL=https://tu-backend.up.railway.app/api
```

Y actualiza todos los archivos que usan `API_URL`:
```javascript
const API_URL = import.meta.env.PUBLIC_API_URL || 'http://localhost:8080/api';
```

**Opción B: Cambiar directamente**

Busca en todos los archivos `.astro` y cambia:
```javascript
const API_URL = 'http://localhost:8080/api';
```

Por:
```javascript
const API_URL = 'https://tu-backend.up.railway.app/api';
```

Archivos a actualizar:
- `frontend/src/pages/producto/[id].astro`
- `frontend/src/pages/productos.astro`
- `frontend/src/pages/carrito.astro`
- `frontend/src/pages/login.astro`
- `frontend/src/pages/registro.astro`
- `frontend/src/pages/pago.astro`
- `frontend/src/pages/perfil.astro`
- `frontend/src/pages/ordenes.astro`
- `frontend/src/pages/admin/usuarios.astro`
- `frontend/src/pages/admin/pedidos.astro`

Luego haz commit y push:
```bash
git add .
git commit -m "Update API URLs for production"
git push
```

Railway redesplegará automáticamente.

---

## ✅ ¡Listo!

Tu tienda está en línea en:
- **Frontend:** https://tu-app.up.railway.app
- **Backend:** https://tu-backend.up.railway.app

---

## 🎯 Alternativa: Render.com (También Gratis)

Si Railway no funciona, Render también es gratis:

### Backend en Render:

1. Ve a https://render.com
2. Crea cuenta (gratis)
3. "New +" → "Web Service"
4. Conecta GitHub → Selecciona tu repo
5. Configura:
   - **Name:** dtech-backend
   - **Root Directory:** backend
   - **Environment:** Go
   - **Build Command:** `go build -o main .`
   - **Start Command:** `./main`
   - **Plan:** Free

6. Variables de entorno:
   ```
   DB_DSN=...
   JWT_SECRET=...
   PORT=8080
   ```

7. "Create Web Service"

### MySQL en Render:

1. "New +" → "PostgreSQL" (MySQL no está en free tier)
2. O usa https://www.freemysqlhosting.net/
3. O usa PlanetScale (MySQL gratis): https://planetscale.com

### Frontend en Vercel:

1. Ve a https://vercel.com
2. Importa tu repositorio
3. Configura:
   - **Framework:** Astro
   - **Root Directory:** frontend
   - **Build Command:** `npm run build`
   - **Output Directory:** dist

4. Variables de entorno:
   ```
   PUBLIC_API_URL=https://tu-backend.onrender.com/api
   ```

5. Deploy

---

## 🔄 Actualizaciones Automáticas

Con Railway o Render:
- Cada vez que hagas `git push`, se redesplega automáticamente
- No necesitas hacer nada más

---

## 💡 Consejos

### 1. Monitorear Uso

Railway te da $5/mes gratis:
- Ve a "Usage" para ver cuánto has usado
- Normalmente alcanza para 500+ horas al mes

### 2. Optimizar Costos

Si te quedas sin créditos:
- Usa el tier gratuito de Vercel para el frontend
- Solo paga por el backend en Railway ($5-10/mes)

### 3. Dominio Personalizado

Railway permite dominios custom gratis:
1. Compra un dominio en Namecheap ($8/año)
2. En Railway → Settings → Custom Domain
3. Agrega tu dominio
4. Configura DNS según las instrucciones

---

## 🆘 Solución de Problemas

### Error: "Cannot connect to database"
- Verifica que las variables de entorno estén correctas
- Asegúrate de que MySQL esté corriendo en Railway

### Error: "API not found"
- Verifica que las URLs estén actualizadas en el frontend
- Revisa los logs en Railway → Click en servicio → "Logs"

### Frontend no carga
- Verifica que el build command sea correcto
- Revisa logs en Railway

### Imágenes no cargan
- Asegúrate de que la carpeta `imagenes de catalogo` esté en `frontend/public/`

---

## 📊 Límites del Tier Gratuito

### Railway:
- $5 de crédito/mes
- ~500 horas de ejecución
- 1GB RAM
- 1GB almacenamiento

### Render:
- 750 horas/mes
- 512MB RAM
- Se duerme después de 15 min de inactividad

### Vercel:
- 100GB bandwidth/mes
- Ilimitado para proyectos personales

---

## 🚀 Próximos Pasos

Una vez desplegado:

1. **Prueba todo:**
   - Registro de usuarios
   - Login
   - Agregar productos al carrito
   - Realizar compra
   - Panel de admin

2. **Comparte tu tienda:**
   - Copia la URL de Railway
   - Compártela con amigos/clientes

3. **Monitorea:**
   - Revisa logs regularmente
   - Verifica el uso de créditos

4. **Escala cuando necesites:**
   - Si creces, migra a un VPS ($5-10/mes)
   - O paga por más recursos en Railway

---

## 🎉 ¡Tu Tienda Está en Línea!

Credenciales admin:
- Email: `admin@tienda.com`
- Password: `admin123`

**¡Cambia estas credenciales inmediatamente en producción!**

---

¿Necesitas ayuda con algún paso específico? ¡Pregúntame!
