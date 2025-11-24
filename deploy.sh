#!/bin/bash

echo "🚀 Desplegando DTech Store..."

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker no está instalado${NC}"
    echo "Instala Docker desde: https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose no está instalado${NC}"
    echo "Instala Docker Compose desde: https://docs.docker.com/compose/install/"
    exit 1
fi

echo -e "${GREEN}✓ Docker y Docker Compose encontrados${NC}"

# Detener contenedores existentes
echo -e "${YELLOW}⏸️  Deteniendo contenedores existentes...${NC}"
docker-compose down

# Construir imágenes
echo -e "${YELLOW}🔨 Construyendo imágenes...${NC}"
docker-compose build

# Iniciar servicios
echo -e "${YELLOW}🚀 Iniciando servicios...${NC}"
docker-compose up -d

# Esperar a que los servicios estén listos
echo -e "${YELLOW}⏳ Esperando a que los servicios estén listos...${NC}"
sleep 10

# Verificar estado
echo -e "${YELLOW}📊 Estado de los servicios:${NC}"
docker-compose ps

echo ""
echo -e "${GREEN}✅ ¡Despliegue completado!${NC}"
echo ""
echo "📍 URLs:"
echo "   Frontend: http://localhost"
echo "   Backend:  http://localhost:8080"
echo "   API:      http://localhost:8080/api"
echo ""
echo "📝 Comandos útiles:"
echo "   Ver logs:      docker-compose logs -f"
echo "   Detener:       docker-compose down"
echo "   Reiniciar:     docker-compose restart"
echo "   Ver estado:    docker-compose ps"
echo ""
echo "👤 Credenciales admin:"
echo "   Email:    admin@tienda.com"
echo "   Password: admin123"
echo ""
