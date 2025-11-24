# 🛍️ DTech E-commerce Platform

Plataforma de comercio electrónico completa con estilo moderno y diseño profesional.

## 🚀 Estado del Proyecto

**✅ 100% Listo para Producción**

- Backend en Go con Gin
- Frontend en Astro
- Base de datos MySQL
- Dockerizado y optimizado
- Documentación completa de despliegue

## ⚡ Despliegue Rápido

**¿Quieres desplegar en producción?**

👉 **Abre [EMPIEZA_AQUI.md](EMPIEZA_AQUI.md)** para comenzar

O ejecuta:
```bash
./verificar-despliegue.sh
```

Tiempo estimado: **10-15 minutos** en Railway (gratis)

## Tecnologías

- **Backend**: Go (Gin framework)
- **Frontend**: Astro
- **Base de datos**: MySQL
- **Autenticación**: JWT

## Estructura del Proyecto

```
├── backend/           # API REST en Go
│   ├── handlers/      # Controladores
│   ├── middleware/    # Middleware de autenticación
│   ├── models/        # Modelos de datos
│   ├── routes/        # Definición de rutas
│   └── main.go        # Punto de entrada
├── frontend/          # Aplicación Astro
│   └── src/
│       ├── components/
│       ├── layouts/
│       ├── pages/
│       └── styles/
└── database/          # Scripts SQL
```

## Configuración Rápida

```bash
chmod +x start.sh
./start.sh
```

O manualmente:

### 1. Base de Datos MySQL

```bash
mysql -u root -p < database/schema.sql
```

### 2. Backend (Go)

```bash
cd backend
cp .env.example .env
# Edita .env con tus credenciales de MySQL
go mod download
go run main.go
```

El servidor correrá en `http://localhost:8080`

### 3. Frontend (Astro)

```bash
cd frontend
npm install
npm run dev
```

El frontend correrá en `http://localhost:4321`

## Funcionalidades

### Usuarios
- Registro y login
- Autenticación con JWT
- Roles (usuario/admin)

### Productos
- Listado con filtros y búsqueda
- Categorías
- Gestión de stock
- CRUD completo (admin)

### Carrito y Órdenes
- Agregar productos al carrito
- Gestión de cantidades
- Crear órdenes
- Historial de compras

## Productos Iniciales

Los productos se cargan automáticamente desde las imágenes en `imagenes de catalogo/`:
- Free Wolf X7, K820, M96, X15, X2
- KZ Castor, EDX Lite, EDX Pro

## Credenciales Admin

- Email: `admin@tienda.com`
- Password: `admin123`

## API Endpoints

### Health Check
- `GET /api/health` - Verificar estado de la API

### Auth
- `POST /api/auth/register` - Registro
- `POST /api/auth/login` - Login
- `GET /api/auth/profile` - Perfil (requiere auth)

### Products
- `GET /api/products` - Listar productos
- `GET /api/products/:id` - Obtener producto
- `GET /api/products/categories` - Listar categorías
- `POST /api/products` - Crear (admin)
- `PUT /api/products/:id` - Actualizar (admin)
- `DELETE /api/products/:id` - Eliminar (admin)

### Orders
- `POST /api/orders` - Crear orden (requiere auth)
- `GET /api/orders` - Listar órdenes (requiere auth)
- `GET /api/orders/:id` - Obtener orden (requiere auth)

## 📚 Documentación de Despliegue

### Guías Disponibles
- **[EMPIEZA_AQUI.md](EMPIEZA_AQUI.md)** - Punto de inicio
- **[INICIO_RAPIDO.md](INICIO_RAPIDO.md)** - Despliegue en 10 minutos
- **[DESPLIEGUE_RAILWAY.md](DESPLIEGUE_RAILWAY.md)** - Guía completa Railway
- **[OPCIONES_DESPLIEGUE.md](OPCIONES_DESPLIEGUE.md)** - Comparación de servicios
- **[INDICE_DESPLIEGUE.md](INDICE_DESPLIEGUE.md)** - Índice completo

### Herramientas
- **[verificar-despliegue.sh](verificar-despliegue.sh)** - Script de verificación
- **[CHECKLIST_DESPLIEGUE.md](CHECKLIST_DESPLIEGUE.md)** - Lista de verificación
- **[COMANDOS_UTILES.md](COMANDOS_UTILES.md)** - Comandos útiles

## 🌐 Despliegue en Servicios Gratuitos

### Railway (Recomendado)
- MySQL incluido
- $5 USD gratis/mes
- Sin cold starts
- Tiempo: 10-15 minutos

### Render (Alternativa)
- PostgreSQL gratis
- 750 horas/mes
- Con cold starts
- Tiempo: 15-20 minutos

Ver comparación completa en [OPCIONES_DESPLIEGUE.md](OPCIONES_DESPLIEGUE.md)

## 🐳 Docker

El proyecto incluye Dockerfiles optimizados:
- `backend/railway.Dockerfile` - Backend en Go
- `frontend/railway.Dockerfile` - Frontend en Astro
- `railway.toml` - Configuración de Railway

## 📊 Características

- ✅ Autenticación JWT
- ✅ Roles de usuario (admin/usuario)
- ✅ Gestión de productos
- ✅ Carrito de compras
- ✅ Sistema de órdenes
- ✅ Panel de administración
- ✅ Responsive design
- ✅ Dockerizado
- ✅ Listo para producción
