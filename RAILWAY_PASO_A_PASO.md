# 🚂 Railway.app - Guía Paso a Paso (GRATIS)

## ✨ La Forma Más Fácil de Desplegar

Railway es perfecto para tu tienda porque:
- ✅ $5 de crédito gratis al mes
- ✅ Detecta automáticamente Go y Node.js
- ✅ MySQL incluido
- ✅ SSL/HTTPS automático
- ✅ Despliegue automático con Git

---

## 📝 Pasos Detallados

### 1️⃣ Subir Código a GitHub

```bash
# Si no tienes Git inicializado
git init
git add .
git commit -m "DTech Store - Ready for deployment"

# Crear repositorio en GitHub
# Ve a: https://github.com/new
# Nombre: dtech-store
# Público o Privado (tu elección)
# NO inicialices con README

# Conectar y subir
git remote add origin https://github.com/TU-USUARIO/dtech-store.git
git branch -M main
git push -u origin main
```

### 2️⃣ Crear Cuenta en Railway

1. Ve a: **https://railway.app**
2. Click en **"Login"**
3. Selecciona **"Login with GitHub"**
4. Autoriza Railway
5. ¡Listo! Ya tienes cuenta

### 3️⃣ Crear Nuevo Proyecto

1. En Railway, click en **"New Project"**
2. Selecciona **"Deploy from GitHub repo"**
3. Busca y selecciona **"dtech-store"**
4. Railway comenzará a analizar tu código

### 4️⃣ Configurar MySQL

1. En tu proyecto, click en **"+ New"**
2. Selecciona **"Database"** → **"Add MySQL"**
3. Railway creará la base de datos automáticamente
4. Click en el servicio MySQL
5. Ve a **"Connect"** y copia la **"MySQL Connection URL"**

### 5️⃣ Importar Datos a MySQL

**Opción A: Desde Railway (Más fácil)**

1. Click en tu base de datos MySQL
2. Ve a la pestaña **"Data"**
3. Click en **"Query"**
4. Abre el archivo `database/schema.sql` en tu computadora
5. Copia TODO el contenido
6. Pégalo en el Query editor de Railway
7. Click en **"Run"**
8. Verás "Query executed successfully"

**Opción B: Desde tu computadora**

```bash
# Instalar Railway CLI
npm i -g @railway/cli

# Login
railway login

# Conectar al proyecto
railway link

# Ejecutar SQL
railway run mysql -u root -p < database/schema.sql
```

### 6️⃣ Configurar Backend

1. Click en el servicio que Railway creó para tu backend
2. Ve a **"Settings"**
3. Configura:
   - **Root Directory:** `backend`
   - **Build Command:** (déjalo vacío, Railway lo detecta)
   - **Start Command:** (déjalo vacío, Railway lo detecta)

4. Ve a **"Variables"**
5. Click en **"+ New Variable"**
6. Agrega estas variables:

```
DB_DSN = [Pega aquí la MySQL Connection URL de Railway]
JWT_SECRET = [Genera un secreto aleatorio largo]
PORT = 8080
GIN_MODE = release
```

Para generar JWT_SECRET:
```bash
openssl rand -base64 32
```

7. Click en **"Deploy"** (arriba a la derecha)

### 7️⃣ Configurar Frontend

1. Click en el servicio del frontend
2. Ve a **"Settings"**
3. Configura:
   - **Root Directory:** `frontend`
   - **Build Command:** `npm install && npm run build`
   - **Start Command:** `npx serve dist -p $PORT`

4. Ve a **"Variables"**
5. Agrega:
```
NODE_VERSION = 18
```

6. **IMPORTANTE:** Necesitas actualizar las URLs de la API

### 8️⃣ Actualizar URLs de API

**En tu computadora:**

```bash
# Ejecutar script automático
./update-api-urls.sh

# Te pedirá la URL del backend
# Ingresa: https://tu-backend.up.railway.app
```

O manualmente, busca en todos los archivos `.astro`:
```javascript
const API_URL = 'http://localhost:8080/api';
```

Y cámbialo por:
```javascript
const API_URL = 'https://tu-backend.up.railway.app/api';
```

Luego:
```bash
git add .
git commit -m "Update API URLs for Railway"
git push
```

Railway redesplegará automáticamente en ~2 minutos.

### 9️⃣ Configurar Dominio Público

1. Click en tu servicio **Frontend**
2. Ve a **"Settings"** → **"Networking"**
3. En **"Public Networking"**, click en **"Generate Domain"**
4. Railway te dará una URL como: `dtech-production.up.railway.app`
5. ¡Esa es tu URL pública!

Haz lo mismo para el backend si quieres.

### 🔟 Actualizar CORS en Backend

Edita `backend/main.go` y cambia:
```go
AllowOrigins: []string{"http://localhost:4321", "http://localhost:3000"},
```

Por:
```go
AllowOrigins: []string{"https://tu-frontend.up.railway.app"},
```

O para permitir todos (menos seguro pero más fácil):
```go
AllowOrigins: []string{"*"},
```

Commit y push:
```bash
git add backend/main.go
git commit -m "Update CORS for production"
git push
```

---

## ✅ Verificación Final

1. **Abre tu URL de Railway** (ej: https://dtech-production.up.railway.app)
2. **Prueba:**
   - ✓ Página de inicio carga
   - ✓ Ver productos
   - ✓ Registrar usuario
   - ✓ Iniciar sesión
   - ✓ Agregar al carrito
   - ✓ Realizar compra
   - ✓ Panel de admin (con cuenta admin)

3. **Si algo no funciona:**
   - Ve a Railway → Click en el servicio → "Logs"
   - Busca errores en rojo
   - Verifica que las variables de entorno estén correctas

---

## 🎯 Checklist de Seguridad

Antes de compartir tu tienda:

- [ ] Cambiar contraseña del admin
- [ ] Generar JWT_SECRET seguro (32+ caracteres)
- [ ] Configurar CORS correctamente
- [ ] Verificar que todas las funciones trabajen
- [ ] Probar en diferentes navegadores
- [ ] Probar en móvil

---

## 💰 Costos

**Railway Gratis:**
- $5 de crédito/mes
- Suficiente para ~500 horas
- Perfecto para empezar

**Si necesitas más:**
- Railway Pro: $5/mes + uso
- O migra a VPS: $5-10/mes

---

## 🎉 ¡Tu Tienda Está en Línea!

Comparte tu URL:
- https://tu-tienda.up.railway.app

Credenciales admin (¡CÁMBIALAS!):
- Email: admin@tienda.com
- Password: admin123

---

## 📞 Soporte

Si tienes problemas:
1. Revisa los logs en Railway
2. Verifica las variables de entorno
3. Asegúrate de que la base de datos esté corriendo
4. Pregúntame si necesitas ayuda específica

¡Felicidades por tu nueva tienda en línea! 🎊
