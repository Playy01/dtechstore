#!/bin/bash

echo "🚀 Iniciando TechStore..."

# Verificar MySQL
if ! command -v mysql &> /dev/null; then
    echo "❌ MySQL no está instalado"
    exit 1
fi

# Verificar Go
if ! command -v go &> /dev/null; then
    echo "❌ Go no está instalado"
    exit 1
fi

# Verificar Node
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado"
    exit 1
fi

echo "✅ Dependencias verificadas"

# Inicializar base de datos
echo "📦 Configurando base de datos..."
mysql -u root -p < database/schema.sql

# Instalar dependencias del backend
echo "📦 Instalando dependencias del backend..."
cd backend
go mod download
cd ..

# Instalar dependencias del frontend
echo "📦 Instalando dependencias del frontend..."
cd frontend
npm install
cd ..

echo "✅ Configuración completa!"
echo ""
echo "Para iniciar el proyecto:"
echo "1. Backend:  cd backend && go run main.go"
echo "2. Frontend: cd frontend && npm run dev"
echo ""
echo "Credenciales admin:"
echo "  Email: admin@tienda.com"
echo "  Password: admin123"
