# ⚡ Inicio Rápido - Despliegue en 10 Minutos

Guía ultra rápida para desplegar tu e-commerce en Railway.

---

## 🎯 Antes de Empezar

✅ Verifica que todo esté listo:
```bash
./verificar-despliegue.sh
```

Si ves "🎉 ¡Todo listo para desplegar!" continúa.

---

## 📝 Paso 1: Cuenta en Railway (1 min)

1. Ve a [railway.app](https://railway.app)
2. Click en **"Login with GitHub"**
3. Autoriza Railway
4. ¡Listo!

---

## 🗄️ Paso 2: Base de Datos (2 min)

1. Click en **"New Project"**
2. Selecciona **"Provision MySQL"**
3. Espera 30 segundos
4. Click en MySQL → **"Variables"** → Copia `MYSQL_URL`
5. Click en **"Data"** → **"Query"**
6. Pega el contenido de `database/schema.sql`
7. Click en **"Execute"**

✅ Base de datos lista

---

## 🔧 Paso 3: Backend (3 min)

1. En tu proyecto, click **"New Service"**
2. Selecciona **"GitHub Repo"**
3. Conecta tu repositorio
4. Configuración:
   - **Root Directory**: `backend`
   - **Dockerfile Path**: `backend/railway.Dockerfile`

5. Ve a **"Variables"** y agrega:
```
DB_DSN=${{MySQL.MYSQL_URL}}
JWT_SECRET=cambia-esto-por-algo-super-seguro-123456789
PORT=8080
GIN_MODE=release
```

6. Click en **"Deploy"**
7. Espera 2 minutos
8. **Copia la URL del backend** (ej: `https://backend-production-xxxx.up.railway.app`)

✅ Backend desplegado

---

## 🎨 Paso 4: Frontend (2 min)

1. Click **"New Service"** → **"GitHub Repo"** (mismo repo)
2. Configuración:
   - **Root Directory**: `frontend`
   - **Dockerfile Path**: `frontend/railway.Dockerfile`

3. Ve a **"Variables"** y agrega:
```
PUBLIC_API_URL=https://tu-backend-url-del-paso-3.railway.app
```

⚠️ **Importante**: Usa la URL real del paso 3

4. Click en **"Deploy"**
5. Espera 2 minutos
6. **Copia la URL del frontend**

✅ Frontend desplegado

---

## 🔄 Paso 5: Actualizar CORS (1 min)

1. Ve al servicio **Backend**
2. Click en **"Variables"**
3. Agrega:
```
ALLOWED_ORIGINS=https://tu-frontend-url-del-paso-4.railway.app
```

4. Railway redesplegará automáticamente (30 segundos)

✅ CORS configurado

---

## ✅ Paso 6: Verificar (1 min)

1. Abre tu frontend: `https://tu-frontend.railway.app`
2. Prueba registrar un usuario
3. Haz login
4. Navega por los productos

### ¿Todo funciona? 🎉

**¡Felicidades! Tu e-commerce está en producción!**

---

## 🐛 ¿Algo no funciona?

### Backend no responde
```bash
# En Railway Dashboard:
# 1. Ve al servicio Backend
# 2. Click en "Deployments"
# 3. Revisa los logs
# 4. Busca errores en rojo
```

### Frontend muestra error de conexión
```bash
# Verifica:
# 1. PUBLIC_API_URL está correcto
# 2. Backend está corriendo
# 3. CORS está configurado
# 4. Abre consola del navegador (F12)
```

### Base de datos no conecta
```bash
# Verifica:
# 1. MySQL está corriendo en Railway
# 2. Schema SQL se importó correctamente
# 3. DB_DSN tiene el formato correcto
```

---

## 📊 Resumen de URLs

Guarda estas URLs:

```
Frontend:  https://tu-frontend.railway.app
Backend:   https://tu-backend.railway.app
MySQL:     (interno en Railway)
```

---

## 🎯 Próximos Pasos

1. **Agrega productos**
   - Usa el panel de admin
   - Ruta: `/admin/productos`

2. **Personaliza**
   - Cambia colores en `frontend/src/styles/global.css`
   - Actualiza logo y nombre

3. **Comparte**
   - Agrega a tu portafolio
   - Comparte en redes sociales
   - Pide feedback

---

## 💡 Tips

- Railway redespliega automáticamente cuando haces push a GitHub
- Los logs están disponibles en tiempo real en Railway Dashboard
- Puedes agregar dominios personalizados en Settings
- El plan gratuito incluye $5 USD al mes

---

## 📚 Más Información

- Guía completa: `DESPLIEGUE_RAILWAY.md`
- Checklist: `CHECKLIST_DESPLIEGUE.md`
- Opciones: `OPCIONES_DESPLIEGUE.md`

---

**Tiempo total**: ~10 minutos ⏱️

**Dificultad**: Fácil 🟢

**Costo**: Gratis 💰

---

¡Disfruta tu e-commerce en producción! 🚀
