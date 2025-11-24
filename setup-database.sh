#!/bin/bash

echo "🗄️  Configurando Base de Datos MySQL..."
echo ""
echo "Opción 1: Crear usuario específico (RECOMENDADO)"
echo "Opción 2: Inicializar con root"
echo ""
read -p "Selecciona una opción (1 o 2): " option

if [ "$option" = "1" ]; then
    echo ""
    read -p "Ingresa el nombre de usuario para la BD: " db_user
    read -sp "Ingresa la contraseña: " db_pass
    echo ""
    
    echo "Creando usuario y base de datos..."
    sudo mysql <<EOF
CREATE USER IF NOT EXISTS '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';
CREATE DATABASE IF NOT EXISTS ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON ecommerce.* TO '${db_user}'@'localhost';
FLUSH PRIVILEGES;
EOF
    
    if [ $? -eq 0 ]; then
        echo "✅ Usuario creado exitosamente"
        
        # Actualizar .env
        sed -i "s|DB_DSN=.*|DB_DSN=${db_user}:${db_pass}@tcp(localhost:3306)/ecommerce?parseTime=true|" backend/.env
        echo "✅ Archivo .env actualizado"
        
        # Inicializar esquema
        mysql -u ${db_user} -p${db_pass} ecommerce < database/schema.sql
        echo "✅ Base de datos inicializada"
    else
        echo "❌ Error al crear usuario"
        exit 1
    fi
    
elif [ "$option" = "2" ]; then
    echo "Inicializando base de datos con root..."
    sudo mysql < database/schema.sql
    
    if [ $? -eq 0 ]; then
        echo "✅ Base de datos inicializada"
        # Actualizar .env para usar socket
        sed -i "s|DB_DSN=.*|DB_DSN=root:@unix(/var/run/mysqld/mysqld.sock)/ecommerce?parseTime=true|" backend/.env
        echo "✅ Archivo .env actualizado"
    else
        echo "❌ Error al inicializar base de datos"
        exit 1
    fi
else
    echo "Opción inválida"
    exit 1
fi

echo ""
echo "✅ Configuración completada!"
echo "Ahora puedes iniciar el backend con: cd backend && go run main.go"
