#!/bin/bash
echo "Inicializando base de datos..."
echo "Por favor ingresa la contraseña de MySQL root:"
mysql -u root -p < database/schema.sql
if [ $? -eq 0 ]; then
    echo "✅ Base de datos inicializada correctamente"
else
    echo "❌ Error al inicializar la base de datos"
fi
