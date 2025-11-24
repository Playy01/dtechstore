# 🚀 Guía de Despliegue en Railway (GRATIS)

Railway ofrece $5 USD de crédito gratis cada mes, suficiente para tu aplicación.

## 📋 Requisitos Previos

1. Cuenta en [Railway.app](https://railway.app) (puedes usar GitHub)
2. Código en un repositorio de GitHub
3. 10 minutos de tu tiempo

---

## 🎯 Paso 1: Preparar el Proyecto

Tu proyecto ya está listo con los archivos necesarios:
- ✅ `backend/railway.Dockerfile`
- ✅ `frontend/railway.Dockerfile`
- ✅ `railway.toml`
- ✅ Variables de entorno configuradas

---

## 🗄️ Paso 2: Crear Base de Datos MySQL

1. Ve a [Railway.app](https://railway.app) y haz login
2. Click en **"New Project"**
3. Selecciona **"Provision MySQL"**
4. Railway creará automáticamente la base de datos
5. Click en el servicio MySQL → **"Variables"** → Copia `MYSQL_URL`

### Importar el Schema

1. En el servicio MySQL, ve a **"Data"** → **"Query"**
2. Copia y pega el contenido de `database/schema.sql`
3. Click en **"Execute"**

---

## 🔧 Paso 3: Desplegar Backend (API)

1. En tu proyecto de Railway, click **"New Service"**
2. Selecciona **"GitHub Repo"**
3. Conecta tu repositorio
4. Railway detectará automáticamente el proyecto

### Configurar Backend:

1. Click en el servicio → **"Settings"**
2. En **"Root Directory"** escribe: `backend`
3. En **"Dockerfile Path"** escribe: `backend/railway.Dockerfile`
4. Ve a **"Variables"** y agrega:

```
DB_DSN=${{MySQL.MYSQL_URL}}
JWT_SECRET=tu-secreto-super-seguro-cambialo-ahora-123456789
PORT=8080
GIN_MODE=release
```

5. Click en **"Deploy"**
6. Espera 2-3 minutos
7. Una vez desplegado, copia la URL pública (ej: `https://tu-backend.railway.app`)

### Verificar Backend:

Abre en tu navegador: `https://tu-backend.railway.app/api/health`

Deberías ver: `{"status":"ok"}`

---

## 🎨 Paso 4: Desplegar Frontend

1. En tu proyecto de Railway, click **"New Service"** nuevamente
2. Selecciona el mismo **"GitHub Repo"**
3. Railway creará otro servicio

### Configurar Frontend:

1. Click en el servicio → **"Settings"**
2. En **"Root Directory"** escribe: `frontend`
3. En **"Dockerfile Path"** escribe: `frontend/railway.Dockerfile`
4. Ve a **"Variables"** y agrega:

```
PUBLIC_API_URL=https://tu-backend.railway.app
```

⚠️ **IMPORTANTE**: Reemplaza `tu-backend.railway.app` con la URL real de tu backend del Paso 3.

5. Click en **"Deploy"**
6. Espera 3-4 minutos

---

## 🔄 Paso 5: Actualizar CORS en Backend

Ahora que tienes la URL del frontend, necesitas actualizar el CORS:

1. Ve al servicio del **Backend** en Railway
2. Click en **"Variables"**
3. Agrega una nueva variable:

```
ALLOWED_ORIGINS=https://tu-frontend.railway.app
```

4. Actualiza el código en `backend/main.go` para usar esta variable:

```go
allowedOrigins := os.Getenv("ALLOWED_ORIGINS")
if allowedOrigins == "" {
    allowedOrigins = "http://localhost:4321"
}

r.Use(cors.New(cors.Config{
    AllowOrigins:     []string{allowedOrigins},
    AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
    AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
    ExposeHeaders:    []string{"Content-Length"},
    AllowCredentials: true,
}))
```

5. Haz commit y push a GitHub
6. Railway redesplegará automáticamente

---

## ✅ Paso 6: Verificar Todo Funciona

1. Abre tu frontend: `https://tu-frontend.railway.app`
2. Prueba registrar un usuario
3. Prueba hacer login
4. Navega por los productos

---

## 🎉 ¡Listo! Tu E-commerce está en Producción

### URLs de tu aplicación:
- **Frontend**: `https://tu-frontend.railway.app`
- **Backend API**: `https://tu-backend.railway.app`
- **Base de Datos**: Gestionada por Railway

---

## 💰 Costos

Railway ofrece:
- **$5 USD gratis cada mes**
- Suficiente para ~500 horas de uso
- Perfecto para proyectos pequeños y demos

---

## 🔧 Comandos Útiles

### Ver logs del backend:
1. Ve al servicio Backend en Railway
2. Click en **"Deployments"**
3. Click en el deployment activo
4. Verás los logs en tiempo real

### Actualizar la aplicación:
1. Haz cambios en tu código
2. Commit y push a GitHub
3. Railway redesplegará automáticamente

### Variables de entorno:
- Se configuran en Railway Dashboard
- No las subas a GitHub
- Usa `.env.railway` como referencia

---

## 🐛 Solución de Problemas

### Backend no inicia:
- Verifica que `DB_DSN` esté correctamente configurado
- Revisa los logs en Railway
- Asegúrate que el schema SQL se importó correctamente

### Frontend no conecta con Backend:
- Verifica que `PUBLIC_API_URL` tenga la URL correcta del backend
- Revisa que CORS esté configurado con la URL del frontend
- Abre la consola del navegador para ver errores

### Base de datos no conecta:
- Verifica que MySQL esté corriendo en Railway
- Revisa que la variable `MYSQL_URL` esté disponible
- Importa el schema SQL nuevamente

---

## 📚 Recursos Adicionales

- [Documentación de Railway](https://docs.railway.app)
- [Railway Discord](https://discord.gg/railway)
- [Pricing de Railway](https://railway.app/pricing)

---

## 🔐 Seguridad en Producción

Antes de lanzar públicamente:

1. ✅ Cambia `JWT_SECRET` por algo muy seguro
2. ✅ Usa contraseñas fuertes para la base de datos
3. ✅ Configura CORS solo con tu dominio
4. ✅ Habilita HTTPS (Railway lo hace automáticamente)
5. ✅ No expongas información sensible en logs

---

¡Disfruta tu e-commerce en producción! 🎊
