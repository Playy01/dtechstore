# Cómo Agregar Más Productos

## Opción 1: Desde la Base de Datos (SQL)

Edita `database/schema.sql` y agrega más productos:

```sql
INSERT INTO products (name, description, price, stock, image_url, category) VALUES
('Nombre del Producto', 'Descripción detallada', 99.99, 50, '/ruta/imagen.webp', 'Categoría');
```

Luego recarga la base de datos:
```bash
mysql -u root -p ecommerce < database/schema.sql
```

## Opción 2: Usando la API (Como Admin)

### 1. Inicia sesión como admin

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@tienda.com","password":"admin123"}'
```

Guarda el token que recibes.

### 2. Crea un producto

```bash
curl -X POST http://localhost:8080/api/products \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TU_TOKEN_AQUI" \
  -d '{
    "name": "Nuevo Producto",
    "description": "Descripción del producto",
    "price": 79.99,
    "stock": 30,
    "image_url": "/imagenes de catalogo/producto.webp",
    "category": "Electrónica"
  }'
```

## Opción 3: Interfaz Web (Recomendado para Admins)

Puedes crear una página de administración en el frontend:

1. Crea `frontend/src/pages/admin/productos.astro`
2. Agrega un formulario para crear/editar productos
3. Usa las rutas de la API con autenticación

## Formato de Imágenes

- Coloca las imágenes en `frontend/public/imagenes de catalogo/`
- Formatos recomendados: WebP, JPG, PNG
- Tamaño recomendado: 800x800px
- La ruta en la BD debe ser: `/imagenes de catalogo/nombre.webp`

## Categorías Disponibles

Las categorías actuales son:
- Audífonos
- Teclados
- Mouse

Puedes agregar nuevas categorías simplemente usando un nombre diferente al crear productos.
