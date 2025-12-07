# 🖥️ Configurar Proyecto en Nueva Computadora

Esta guía te ayudará a configurar el proyecto DTech Store en cualquier computadora nueva.

---

## 📋 Requisitos Previos

### 1. Instalar Node.js
- **Descargar**: https://nodejs.org/
- **Versión recomendada**: 18.x o superior (LTS)
- **Verificar instalación**:
  ```bash
  node --version
  npm --version
  ```

### 2. Instalar Git
- **Descargar**: https://git-scm.com/downloads
- **Verificar instalación**:
  ```bash
  git --version
  ```

### 3. Editor de Código (Opcional pero recomendado)
- **VS Code**: https://code.visualstudio.com/
- **Kiro IDE**: https://kiro.ai/ (opcional, no necesario)
- **Cualquier otro editor**: Sublime, Atom, WebStorm, etc.

---

## 🚀 Pasos para Configurar el Proyecto

### Paso 1: Clonar el Repositorio

```bash
# Opción A: HTTPS (más fácil)
git clone https://github.com/Playy01/dtechstore.git

# Opción B: SSH (si tienes SSH configurado)
git clone git@github.com:Playy01/dtechstore.git

# Entrar al directorio
cd dtechstore
```

### Paso 2: Instalar Dependencias

```bash
# Ir a la carpeta del frontend
cd frontend

# Instalar todas las dependencias
npm install

# Esto instalará:
# - Astro
# - Supabase
# - TypeScript
# - Y todas las demás dependencias
```

### Paso 3: Verificar Configuración

El proyecto ya tiene todo configurado:
- ✅ Supabase URL y Keys (en el código)
- ✅ Variables de entorno (no necesarias localmente)
- ✅ Configuración de Astro

### Paso 4: Ejecutar el Proyecto

```bash
# Modo desarrollo (con hot reload)
npm run dev

# El servidor iniciará en:
# http://localhost:4321
```

### Paso 5: Construir para Producción (Opcional)

```bash
# Crear build de producción
npm run build

# Vista previa del build
npm run preview
```

---

## 📁 Estructura del Proyecto

```
dtechstore/
├── frontend/                 # Aplicación principal
│   ├── src/
│   │   ├── components/      # Componentes reutilizables
│   │   ├── layouts/         # Layouts de página
│   │   ├── pages/           # Páginas del sitio
│   │   ├── styles/          # Estilos globales
│   │   └── lib/             # Utilidades y helpers
│   ├── public/              # Archivos estáticos
│   │   ├── products.json    # Datos de productos
│   │   └── imagenes de catalogo/  # Imágenes
│   └── package.json         # Dependencias
├── database/                # Scripts SQL
└── README.md               # Documentación
```

---

## 🔧 Comandos Útiles

### Desarrollo
```bash
cd frontend
npm run dev          # Iniciar servidor de desarrollo
npm run build        # Construir para producción
npm run preview      # Vista previa del build
```

### Git
```bash
git status           # Ver cambios
git add .            # Agregar todos los cambios
git commit -m "mensaje"  # Hacer commit
git push origin main # Subir cambios a GitHub
git pull origin main # Descargar cambios de GitHub
```

---

## 🌐 Despliegue Automático

El proyecto está configurado con **despliegue automático en Vercel**:

1. Haces cambios en tu computadora
2. Haces commit y push a GitHub
3. Vercel detecta el cambio automáticamente
4. Vercel construye y despliega en 2-3 minutos
5. Tu sitio se actualiza: https://dtechstore.vercel.app

**No necesitas hacer nada más** - el despliegue es automático.

---

## 🔐 Credenciales y Configuración

### Supabase (Base de Datos)
Ya está configurado en el código:
- **URL**: `https://szfamthbjrsqctzgokx.supabase.co`
- **Key**: Ya incluida en el código
- **Dashboard**: https://supabase.com/dashboard

### Usuario Admin
- **Email**: `admin@tienda.com`
- **Password**: `admin123`

### GitHub
- **Repositorio**: https://github.com/Playy01/dtechstore
- Necesitas acceso al repositorio (ya lo tienes si eres Playy01)

### Vercel
- **Dashboard**: https://vercel.com/dashboard
- **Proyecto**: dtechstore
- Conectado automáticamente a GitHub

---

## 🐛 Solución de Problemas

### Error: "npm: command not found"
**Solución**: Instala Node.js desde https://nodejs.org/

### Error: "git: command not found"
**Solución**: Instala Git desde https://git-scm.com/downloads

### Error: "Permission denied" al clonar
**Solución**: 
- Usa HTTPS en lugar de SSH
- O configura SSH keys en GitHub

### Error: "Module not found"
**Solución**:
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### Puerto 4321 ya en uso
**Solución**:
```bash
# Matar el proceso en el puerto
# Linux/Mac:
lsof -ti:4321 | xargs kill -9

# Windows:
netstat -ano | findstr :4321
taskkill /PID [número] /F
```

### Cambios no se reflejan en el navegador
**Solución**:
- Hard refresh: `Ctrl + Shift + R` (Windows/Linux) o `Cmd + Shift + R` (Mac)
- O abre en modo incógnito

---

## 📝 Flujo de Trabajo Recomendado

### 1. Antes de Empezar a Trabajar
```bash
cd dtechstore/frontend
git pull origin main    # Descargar últimos cambios
npm install            # Actualizar dependencias si hay nuevas
npm run dev            # Iniciar servidor
```

### 2. Mientras Trabajas
- Edita archivos en tu editor favorito
- Los cambios se reflejan automáticamente en el navegador
- Guarda frecuentemente

### 3. Después de Trabajar
```bash
git add .
git commit -m "Descripción de lo que hiciste"
git push origin main
```

### 4. Verificar Despliegue
- Ve a https://vercel.com/dashboard
- Espera 2-3 minutos
- Verifica en https://dtechstore.vercel.app

---

## 🎯 Casos de Uso Comunes

### Agregar un Nuevo Producto
1. Edita `frontend/public/products.json`
2. Agrega la imagen en `frontend/public/imagenes de catalogo/`
3. Guarda y haz commit/push

### Cambiar Colores del Sitio
1. Edita `frontend/src/styles/global.css`
2. Modifica las variables CSS en `:root`
3. Guarda y verifica en el navegador

### Crear una Nueva Página
1. Crea archivo en `frontend/src/pages/`
2. Ejemplo: `frontend/src/pages/contacto.astro`
3. Usa el Layout existente

### Modificar el Header
1. Edita `frontend/src/components/Header.astro`
2. Los cambios se aplican en todas las páginas

---

## 💡 Tips y Mejores Prácticas

### ✅ Hacer
- Hacer commits frecuentes con mensajes descriptivos
- Probar localmente antes de hacer push
- Usar `npm run build` para verificar que no hay errores
- Mantener las dependencias actualizadas

### ❌ Evitar
- No subir `node_modules/` (ya está en .gitignore)
- No subir archivos de configuración personal
- No hacer push directo a producción sin probar
- No modificar archivos en `dist/` (se generan automáticamente)

---

## 🆘 Recursos de Ayuda

### Documentación
- **Astro**: https://docs.astro.build
- **Supabase**: https://supabase.com/docs
- **Vercel**: https://vercel.com/docs
- **Git**: https://git-scm.com/doc

### Comunidades
- **Astro Discord**: https://astro.build/chat
- **Supabase Discord**: https://discord.supabase.com
- **Stack Overflow**: https://stackoverflow.com

### Tutoriales
- **Astro Tutorial**: https://docs.astro.build/en/tutorial/0-introduction/
- **Git Basics**: https://git-scm.com/book/en/v2/Getting-Started-Git-Basics
- **Node.js Guide**: https://nodejs.org/en/docs/guides/

---

## ✅ Checklist de Configuración

Marca cada paso cuando lo completes:

- [ ] Node.js instalado y funcionando
- [ ] Git instalado y funcionando
- [ ] Repositorio clonado
- [ ] Dependencias instaladas (`npm install`)
- [ ] Servidor de desarrollo corriendo (`npm run dev`)
- [ ] Sitio abre en http://localhost:4321
- [ ] Puedes hacer login con admin@tienda.com
- [ ] Puedes ver productos
- [ ] Git configurado con tu usuario
- [ ] Puedes hacer push a GitHub

---

## 🎉 ¡Listo!

Una vez completados todos los pasos, ya puedes:
- ✅ Desarrollar localmente
- ✅ Ver cambios en tiempo real
- ✅ Hacer commits y push
- ✅ Desplegar automáticamente a Vercel
- ✅ Trabajar desde cualquier computadora

**¡Feliz desarrollo!** 🚀

---

**Última actualización**: Diciembre 2024
**Versión del proyecto**: 1.0.0
