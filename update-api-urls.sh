#!/bin/bash

echo "🔧 Actualizador de URLs de API"
echo ""

# Pedir la URL del backend
read -p "Ingresa la URL de tu backend (ej: https://tu-backend.up.railway.app): " BACKEND_URL

# Remover trailing slash si existe
BACKEND_URL=${BACKEND_URL%/}

echo ""
echo "📝 Actualizando archivos..."

# Lista de archivos a actualizar
FILES=(
  "frontend/src/pages/producto/[id].astro"
  "frontend/src/pages/productos.astro"
  "frontend/src/pages/index.astro"
  "frontend/src/pages/carrito.astro"
  "frontend/src/pages/login.astro"
  "frontend/src/pages/registro.astro"
  "frontend/src/pages/pago.astro"
  "frontend/src/pages/perfil.astro"
  "frontend/src/pages/ordenes.astro"
  "frontend/src/pages/admin/usuarios.astro"
  "frontend/src/pages/admin/pedidos.astro"
)

# Actualizar cada archivo
for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    sed -i "s|const API_URL = 'http://localhost:8080/api';|const API_URL = '${BACKEND_URL}/api';|g" "$file"
    echo "✓ Actualizado: $file"
  fi
done

# Actualizar CORS en el backend
sed -i "s|AllowOrigins:     \[\]string{\"http://localhost:4321\", \"http://localhost:3000\"}|AllowOrigins:     []string{\"*\"}|g" backend/main.go
echo "✓ Actualizado CORS en backend"

echo ""
echo "✅ URLs actualizadas exitosamente!"
echo ""
echo "📤 Ahora haz commit y push:"
echo "   git add ."
echo "   git commit -m 'Update API URLs for production'"
echo "   git push"
echo ""
