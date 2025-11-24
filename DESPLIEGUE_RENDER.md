# 🚀 Guía de Despliegue en Render (GRATIS)

Render ofrece plan gratuito con 750 horas al mes por servicio.

## 📋 Requisitos Previos

1. Cuenta en [Render.com](https://render.com) (puedes usar GitHub)
2. Código en un repositorio de GitHub
3. 15 minutos de tu tiempo

---

## 🗄️ Paso 1: Crear Base de Datos PostgreSQL

⚠️ **Nota**: Render ofrece PostgreSQL gratis, no MySQL. Necesitarás adaptar el código o usar un servicio externo para MySQL.

### Opción A: Usar PostgreSQL (Recomendado para Render)
1. Ve a [Render Dashboard](https://dashboard.render.com)
2. Click en **"New +"** → **"PostgreSQL"**
3. Nombre: `dtech-db`
4. Plan: **Free**
5. Click en **"Create Database"**
6. Copia la **"Internal Database URL"**

### Opción B: Usar MySQL externo
Usa [PlanetScale](https://planetscale.com) o [Railway](https://railway.app) para MySQL gratis.

---

## 🔧 Paso 2: Desplegar Backend

1. En Render Dashboard, click **"New +"** → **"Web Service"**
2. Conecta tu repositorio de GitHub
3. Configuración:
   - **Name**: `dtech-backend`
   - **Root Directory**: `backend`
   - **Environment**: `Docker`
   - **Dockerfile Path**: `backend/railway.Dockerfile`
   - **Plan**: `Free`

4. Variables de entorno:
```
DB_DSN=tu-conexion-mysql
JWT_SECRET=tu-secreto-super-seguro-123456789
PORT=8080
GIN_MODE=release
```

5. Click en **"Create Web Service"**
6. Espera 3-5 minutos
7. Copia la URL: `https://dtech-backend.onrender.com`

---

## 🎨 Paso 3: Desplegar Frontend

1. En Render Dashboard, click **"New +"** → **"Static Site"**
2. Conecta tu repositorio de GitHub
3. Configuración:
   - **Name**: `dtech-frontend`
   - **Root Directory**: `frontend`
   - **Build Command**: `npm install && npm run build`
   - **Publish Directory**: `dist`

4. Variables de entorno:
```
PUBLIC_API_URL=https://dtech-backend.onrender.com
```

5. Click en **"Create Static Site"**
6. Espera 2-3 minutos

---

## 🔄 Paso 4: Actualizar CORS

En las variables de entorno del backend, agrega:
```
ALLOWED_ORIGINS=https://dtech-frontend.onrender.com
```

Redeploy el backend.

---

## ✅ Verificar

Abre: `https://dtech-frontend.onrender.com`

---

## ⚠️ Limitaciones del Plan Gratuito

- Los servicios se duermen después de 15 minutos de inactividad
- Primera carga puede tardar 30-60 segundos (cold start)
- 750 horas al mes por servicio
- Perfecto para demos y proyectos personales

---

## 💡 Tip

Para evitar que el backend se duerma, usa un servicio como [UptimeRobot](https://uptimerobot.com) para hacer ping cada 10 minutos.

---

¡Listo! Tu e-commerce está en producción 🎉
