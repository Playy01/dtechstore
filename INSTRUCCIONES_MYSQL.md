# Configuración de MySQL

## Problema Actual
El backend no puede conectarse a MySQL porque root usa autenticación de socket en Linux.

## Solución 1: Crear un usuario específico para la aplicación (RECOMENDADO)

```bash
# Conectarse a MySQL como root
sudo mysql

# Dentro de MySQL, ejecutar:
CREATE USER 'ecommerce_user'@'localhost' IDENTIFIED BY 'tu_password_segura';
GRANT ALL PRIVILEGES ON ecommerce.* TO 'ecommerce_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

Luego edita `backend/.env`:
```
DB_DSN=ecommerce_user:tu_password_segura@tcp(localhost:3306)/ecommerce?parseTime=true
```

## Solución 2: Usar sudo para MySQL root

Edita `backend/.env` para usar socket:
```
DB_DSN=root:@unix(/var/run/mysqld/mysqld.sock)/ecommerce?parseTime=true
```

## Solución 3: Cambiar autenticación de root (NO RECOMENDADO)

```bash
sudo mysql

# Dentro de MySQL:
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'nueva_password';
FLUSH PRIVILEGES;
EXIT;
```

Luego edita `backend/.env`:
```
DB_DSN=root:nueva_password@tcp(localhost:3306)/ecommerce?parseTime=true
```

## Inicializar la Base de Datos

Una vez configurado el usuario, ejecuta:

```bash
# Si usas el usuario específico:
mysql -u ecommerce_user -p < database/schema.sql

# O si usas root:
sudo mysql < database/schema.sql
```

## Reiniciar el Backend

Después de configurar MySQL, reinicia el backend y debería conectarse correctamente.
