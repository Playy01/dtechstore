#!/bin/bash

# Script para verificar que todo esté listo para el despliegue

echo "🔍 Verificando preparación para despliegue..."
echo ""

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contadores
PASSED=0
FAILED=0

# Función para verificar
check() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} $2"
        ((FAILED++))
    fi
}

echo "📁 Verificando archivos necesarios..."
echo ""

# Verificar archivos de Docker
[ -f "backend/railway.Dockerfile" ]
check $? "backend/railway.Dockerfile existe"

[ -f "frontend/railway.Dockerfile" ]
check $? "frontend/railway.Dockerfile existe"

[ -f "railway.toml" ]
check $? "railway.toml existe"

# Verificar archivos de configuración
[ -f "backend/go.mod" ]
check $? "backend/go.mod existe"

[ -f "frontend/package.json" ]
check $? "frontend/package.json existe"

[ -f "database/schema.sql" ]
check $? "database/schema.sql existe"

[ -f ".gitignore" ]
check $? ".gitignore existe"

echo ""
echo "🔧 Verificando estructura del proyecto..."
echo ""

# Verificar directorios
[ -d "backend" ]
check $? "Directorio backend existe"

[ -d "frontend" ]
check $? "Directorio frontend existe"

[ -d "database" ]
check $? "Directorio database existe"

echo ""
echo "📝 Verificando archivos de código..."
echo ""

# Verificar archivos principales
[ -f "backend/main.go" ]
check $? "backend/main.go existe"

[ -f "frontend/astro.config.mjs" ]
check $? "frontend/astro.config.mjs existe"

[ -f "frontend/nginx.conf" ]
check $? "frontend/nginx.conf existe"

echo ""
echo "📚 Verificando guías de despliegue..."
echo ""

[ -f "DESPLIEGUE_RAILWAY.md" ]
check $? "DESPLIEGUE_RAILWAY.md existe"

[ -f "OPCIONES_DESPLIEGUE.md" ]
check $? "OPCIONES_DESPLIEGUE.md existe"

[ -f "CHECKLIST_DESPLIEGUE.md" ]
check $? "CHECKLIST_DESPLIEGUE.md existe"

echo ""
echo "🔍 Verificando contenido de archivos críticos..."
echo ""

# Verificar que main.go tenga health check
if grep -q "/api/health" backend/main.go; then
    echo -e "${GREEN}✓${NC} Health check endpoint configurado"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Health check endpoint NO encontrado"
    ((FAILED++))
fi

# Verificar que main.go use ALLOWED_ORIGINS
if grep -q "ALLOWED_ORIGINS" backend/main.go; then
    echo -e "${GREEN}✓${NC} CORS dinámico configurado"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} CORS dinámico NO configurado"
    ((FAILED++))
fi

# Verificar que .gitignore incluya .env
if grep -q ".env" .gitignore 2>/dev/null; then
    echo -e "${GREEN}✓${NC} .env en .gitignore"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} .env NO está en .gitignore"
    ((FAILED++))
fi

echo ""
echo "═══════════════════════════════════════"
echo ""

# Resumen
TOTAL=$((PASSED + FAILED))
PERCENTAGE=$((PASSED * 100 / TOTAL))

echo "📊 Resumen:"
echo -e "   ${GREEN}Pasados: $PASSED${NC}"
echo -e "   ${RED}Fallidos: $FAILED${NC}"
echo "   Total: $TOTAL"
echo "   Porcentaje: $PERCENTAGE%"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todo listo para desplegar!${NC}"
    echo ""
    echo "Próximos pasos:"
    echo "1. Lee DESPLIEGUE_RAILWAY.md"
    echo "2. Crea cuenta en Railway.app"
    echo "3. Sigue la guía paso a paso"
    echo ""
    exit 0
else
    echo -e "${RED}⚠️  Hay problemas que resolver antes de desplegar${NC}"
    echo ""
    echo "Revisa los archivos marcados con ✗"
    echo ""
    exit 1
fi
