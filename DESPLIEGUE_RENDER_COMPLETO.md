# 🚀 Despliegue en Render - Guía Completa

## 📋 Requisitos
- ✅ Cuenta en Render conectada a GitHub
- ✅ Código en GitHub (ya lo tienes)

---

## 🗄️ Paso 1: Crear Base de Datos MySQL (PlanetScale)

### 1.1 Crear Cuenta en PlanetScale

1. Ve a 👉 **https://planetscale.com**
2. Click en **"Sign up"**
3. Selecciona **"Sign in with GitHub"**
4. Autoriza PlanetScale

### 1.2 Crear Base de Datos

1. En el Dashboard de PlanetScale, click en **"Create database"**
2. **Name**: `dtech-ecommerce`
3. **Region**: Selecciona la más cercana (ej: AWS us-east-1)
4. **Plan**: Hobby (Free)
5. Click en **"Create database"**

### 1.3 Obtener Credenciales

1. En tu base de datos, ve a **"Connect"**
2. Selecciona **"Connect with: Go"**
3. Copia la cadena de conexión (algo como):
   ```
   user:password@tcp(aws.connect.psdb.cloud)/dtech-ecommerce?tls=true
   ```
4. **Guarda esta cadena** - la necesitarás después

### 1.4 Importar Schema

1. En PlanetScale, ve a **"Console"**
2. Copia y pega el contenido de `database/schema.sql`
3. Click en **"Execute"**

---

## 🔧 Paso 2: Desplegar Backend en Render

### 2.1 Crear Web Service

1. En Render Dashboard, click en **"New +"**
2. Selecciona **"Web Service"**
3. Conecta tu repositorio **"dtechstore"**
4. Click en **"Connect"**

### 2.2 Configurar Backend

**Name**: `dtech-backend`

**Region**: Oregon (US West)

**Branch**: `main`

**Root Directory**: `backend`

**Environment**: `Docker`

**Dockerfile Path**: `../Dockerfile.backend`

**Plan**: Free

### 2.3 Variables de Entorno

Click en **"Advanced"** y agrega estas variables:

**Variable 1:**
- Key: `DB_DSN`
- Value: (la cadena de PlanetScale que guardaste)

**Variable 2:**
- Key: `JWT_SECRET`
- Value: `dtech-super-secret-key-2024-production-render`

**Variable 3:**
- Key: `PORT`
- Value: `8080`

**Variable 4:**
- Key: `GIN_MODE`
- Value: `release`

### 2.4 Desplegar

1. Click en **"Create Web Service"**
2. Espera 3-5 minutos mientras se despliega
3. Una vez listo, copia la URL (ej: `https://dtech-backend.onrender.com`)

---

## 🎨 Paso 3: Desplegar Frontend en Render

### 3.1 Crear Static Site

1. En Render Dashboard, click en **"New +"**
2. Selecciona **"Static Site"**
3. Conecta el mismo repositorio **"dtechstore"**

### 3.2 Configurar Frontend

**Name**: `dtech-frontend`

**Branch**: `main`

**Root Directory**: `frontend`

**Build Command**: 
```
npm install && npm run build
```

**Publish Directory**: 
```
dist
```

### 3.3 Variables de Entorno

Click en **"Advanced"** y agrega:

**Variable:**
- Key: `PUBLIC_API_URL`
- Value: (la URL del backend del Paso 2.4)

### 3.4 Desplegar

1. Click en **"Create Static Site"**
2. Espera 2-3 minutos
3. Una vez listo, copia la URL del frontend

---

## 🔄 Paso 4: Actualizar CORS

Ahora que tienes la URL del frontend, actualiza el backend:

1. Ve al servicio **Backend** en Render
2. Click en **"Environment"**
3. Agrega una nueva variable:
   - Key: `ALLOWED_ORIGINS`
   - Value: (la URL del frontend del Paso 3.4)
4. Click en **"Save Changes"**
5. Render redesple automáticamente

---

## ✅ Paso 5: Verificar

1. Abre tu frontend: `https://dtech-frontend.onrender.com`
2. Prueba registrar un usuario
3. Haz login
4. Navega por los productos

---

## ⚠️ Nota sobre Cold Starts

Render Free tiene "cold starts":
- Si no hay tráfico por 15 minutos, el servicio se duerme
- La primera carga después puede tardar 30-60 segundos
- Esto es normal en el plan gratuito

---

## 🎉 ¡Listo!

Tu e-commerce está en producción con:
- ✅ Backend en Render
- ✅ Frontend en Render
- ✅ Base de datos MySQL en PlanetScale
- ✅ Todo gratis

---

## 💰 Costos

- **Render**: Gratis (750 horas/mes por servicio)
- **PlanetScale**: Gratis (1 base de datos, 5GB storage)
- **Total**: $0 USD/mes

---

## 🐛 Solución de Problemas

### Backend no inicia
- Verifica que `DB_DSN` esté correcta
- Revisa logs en Render Dashboard
- Confirma que PlanetScale esté activo

### Frontend no conecta
- Verifica `PUBLIC_API_URL` en variables
- Revisa que `ALLOWED_ORIGINS` esté configurado en backend
- Abre consola del navegador (F12) para ver errores

### Base de datos no conecta
- Verifica que el schema se importó en PlanetScale
- Confirma que la cadena de conexión incluya `?tls=true`
- Revisa que la base de datos esté en "Ready" en PlanetScale

---

¡Disfruta tu e-commerce en producción! 🎊
