#!/bin/bash

# Script de auto-deploy para Vercel
echo "🚀 Iniciando auto-deploy..."

# Agregar todos los cambios
git add .

# Verificar si hay cambios
if git diff --staged --quiet; then
  echo "✅ No hay cambios para subir"
  exit 0
fi

# Crear commit con timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
git commit -m "Auto-deploy: Actualización frontend - $TIMESTAMP"

# Push a GitHub (trigger Vercel)
git push origin main

echo "✅ Cambios subidos exitosamente a GitHub"
echo "⏳ Vercel comenzará el deployment automáticamente..."
