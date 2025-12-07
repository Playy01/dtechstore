# 🍌 DTech Store - E-commerce Moderno

E-commerce completo construido con Astro, Supabase y desplegado en Vercel.

![Status](https://img.shields.io/badge/status-active-success.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

## 🌐 Demo en Vivo

**Sitio Web**: [https://dtechstore.vercel.app](https://dtechstore.vercel.app)

**Credenciales de prueba**:
- Email: `admin@tienda.com`
- Password: `admin123`

---

## ✨ Características

### 🛍️ E-commerce Completo
- ✅ Catálogo de productos con imágenes
- ✅ Búsqueda y filtrado por categorías
- ✅ Carrito de compras persistente
- ✅ Sistema de órdenes
- ✅ Gestión de inventario

### 🔐 Autenticación
- ✅ Registro de usuarios
- ✅ Login/Logout
- ✅ Sesiones persistentes
- ✅ Protección de rutas
- ✅ Panel de administración

### 🎨 Diseño Moderno
- ✅ Responsive (móvil, tablet, desktop)
- ✅ Animaciones suaves
- ✅ Tema personalizable
- ✅ Interfaz intuitiva
- ✅ Easter egg oculto 🍌

### ⚡ Performance
- ✅ Carga rápida (Astro SSG)
- ✅ Optimización de imágenes
- ✅ Cache inteligente
- ✅ SEO optimizado

---

## 🛠️ Tecnologías

### Frontend
- **[Astro](https://astro.build)** - Framework web moderno
- **TypeScript** - Tipado estático
- **CSS Variables** - Estilos personalizables

### Backend
- **[Supabase](https://supabase.com)** - Base de datos PostgreSQL
- **Supabase Auth** - Autenticación

### Deployment
- **[Vercel](https://vercel.com)** - Hosting y CI/CD
- **GitHub** - Control de versiones

---

## 🚀 Inicio Rápido

### Prerrequisitos
- Node.js 18+ ([Descargar](https://nodejs.org/))
- Git ([Descargar](https://git-scm.com/))

### Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/Playy01/dtechstore.git
cd dtechstore

# 2. Instalar dependencias
cd frontend
npm install

# 3. Iniciar servidor de desarrollo
npm run dev

# 4. Abrir en el navegador
# http://localhost:4321
```

### Comandos Disponibles

```bash
npm run dev      # Servidor de desarrollo
npm run build    # Build de producción
npm run preview  # Vista previa del build
```

---

## 📁 Estructura del Proyecto

```
dtechstore/
├── frontend/
│   ├── src/
│   │   ├── components/      # Componentes reutilizables
│   │   │   ├── Header.astro
│   │   │   └── Notification.astro
│   │   ├── layouts/         # Layouts de página
│   │   │   └── Layout.astro
│   │   ├── pages/           # Páginas (rutas)
│   │   │   ├── index.astro
│   │   │   ├── productos.astro
│   │   │   ├── carrito.astro
│   │   │   ├── login.astro
│   │   │   └── producto/[id].astro
│   │   ├── styles/          # Estilos globales
│   │   │   └── global.css
│   │   └── lib/             # Utilidades
│   │       ├── supabase.ts
│   │       └── auth.ts
│   ├── public/              # Archivos estáticos
│   │   ├── products.json
│   │   └── imagenes de catalogo/
│   └── package.json
├── database/                # Scripts SQL
│   └── schema-postgres.sql
└── README.md
```

---

## 🎯 Funcionalidades Principales

### Productos
- Listado con paginación
- Búsqueda en tiempo real
- Filtrado por categorías
- Vista detallada de producto
- Gestión de stock

### Carrito
- Agregar/eliminar productos
- Modificar cantidades
- Cálculo automático de totales
- Persistencia en localStorage
- Validación de stock

### Autenticación
- Registro con email/password
- Login seguro
- Sesiones persistentes
- Recuperación de contraseña
- Roles de usuario (admin/cliente)

### Panel de Administración
- Gestión de usuarios
- Gestión de pedidos
- Estadísticas básicas
- Solo accesible para admins

---

## 🔧 Configuración

### Variables de Entorno

El proyecto ya tiene las credenciales de Supabase configuradas en el código. Para usar tu propia base de datos:

1. Crea un proyecto en [Supabase](https://supabase.com)
2. Ejecuta el script SQL en `database/schema-postgres.sql`
3. Actualiza las credenciales en:
   - `frontend/src/config/supabase.ts`
   - `frontend/src/layouts/Layout.astro`

### Personalización

#### Cambiar Colores
Edita `frontend/src/styles/global.css`:
```css
:root {
  --primary: #6366f1;      /* Color principal */
  --primary-dark: #4f46e5; /* Color principal oscuro */
  --bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
```

#### Agregar Productos
Edita `frontend/public/products.json`:
```json
{
  "id": 9,
  "name": "Nuevo Producto",
  "description": "Descripción del producto",
  "price": 499.00,
  "stock": 10,
  "image_url": "/imagenes de catalogo/producto.webp",
  "category": "Categoría"
}
```

---

## 🚢 Despliegue

### Vercel (Recomendado)

El proyecto está configurado para despliegue automático:

1. Haz push a GitHub
2. Vercel detecta el cambio
3. Construye y despliega automáticamente
4. Listo en 2-3 minutos

### Manual

```bash
# 1. Construir el proyecto
cd frontend
npm run build

# 2. El build estará en frontend/dist/
# 3. Sube esta carpeta a tu hosting
```

---

## 🐛 Solución de Problemas

### El servidor no inicia
```bash
# Reinstalar dependencias
rm -rf node_modules package-lock.json
npm install
```

### Cambios no se reflejan
- Hard refresh: `Ctrl + Shift + R`
- O abre en modo incógnito

### Error de base de datos
- Verifica que Supabase esté activo
- Revisa las credenciales en el código
- Verifica la consola del navegador (F12)

---

## 🎨 Easter Egg

¿Puedes encontrar el secreto oculto? 🍌

**Pista**: Busca algo relacionado con el nombre del sitio...

---

## 📚 Documentación Adicional

- [Configurar en Nueva Computadora](./SETUP_NUEVA_COMPUTADORA.md)
- [Guía de Despliegue](./DESPLIEGUE_EXITOSO.md)
- [Easter Egg](./EASTER_EGG.md)

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Para cambios importantes:

1. Fork el proyecto
2. Crea una rama (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Roadmap

### Próximas Funcionalidades
- [ ] Integración con Mercado Pago
- [ ] Sistema de reviews y calificaciones
- [ ] Wishlist de productos
- [ ] Notificaciones por email
- [ ] Panel de analytics
- [ ] Búsqueda avanzada con filtros
- [ ] Sistema de cupones/descuentos
- [ ] Integración con redes sociales

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

## 👤 Autor

**Playy01**
- GitHub: [@Playy01](https://github.com/Playy01)
- Proyecto: [DTech Store](https://github.com/Playy01/dtechstore)

---

## 🙏 Agradecimientos

- [Astro](https://astro.build) - Framework increíble
- [Supabase](https://supabase.com) - Backend as a Service
- [Vercel](https://vercel.com) - Hosting gratuito
- Comunidad open source

---

## 📊 Estado del Proyecto

- ✅ **Versión**: 1.0.0
- ✅ **Estado**: Producción
- ✅ **Última actualización**: Diciembre 2024
- ✅ **Mantenimiento**: Activo

---

**⭐ Si te gusta este proyecto, dale una estrella en GitHub!**

[Ver Demo](https://dtechstore.vercel.app) | [Reportar Bug](https://github.com/Playy01/dtechstore/issues) | [Solicitar Feature](https://github.com/Playy01/dtechstore/issues)
