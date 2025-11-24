-- Crear base de datos
CREATE DATABASE IF NOT EXISTS ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(500),
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de órdenes
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de items de orden
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar usuario admin por defecto (password: admin123)
INSERT INTO users (email, password, name, role) VALUES 
('admin@tienda.com', '$2b$12$2qONmra47mA/St/LcPXXlOYOWLesQPrCKtQRTU7U2zTASO9ZTiJeK', 'Administrador', 'admin');

-- Productos iniciales basados en las imágenes
INSERT INTO products (name, description, price, stock, image_url, category) VALUES
('Free Wolf X7', 'Audífonos gaming Free Wolf X7 con sonido envolvente 7.1 y micrófono con cancelación de ruido', 45.99, 25, '/imagenes de catalogo/free wolf X7.webp', 'Audífonos'),
('Free Wolf K820', 'Teclado mecánico gaming Free Wolf K820 con retroiluminación RGB y switches mecánicos', 79.99, 15, '/imagenes de catalogo/free wolf k820.webp', 'Teclados'),
('Free Wolf M96', 'Mouse gaming Free Wolf M96 con sensor óptico de alta precisión y 7 botones programables', 35.99, 30, '/imagenes de catalogo/free wolf m96.webp', 'Mouse'),
('Free Wolf X15', 'Audífonos inalámbricos Free Wolf X15 con Bluetooth 5.0 y batería de larga duración', 55.99, 20, '/imagenes de catalogo/free wolf x15.webp', 'Audífonos'),
('Free Wolf X2', 'Audífonos gaming Free Wolf X2 con iluminación LED y sonido estéreo de alta calidad', 39.99, 35, '/imagenes de catalogo/free wolf x2.webp', 'Audífonos'),
('KZ Castor', 'Audífonos in-ear KZ Castor con drivers dinámicos y diseño ergonómico', 29.99, 40, '/imagenes de catalogo/kz castor.webp', 'Audífonos'),
('KZ EDX Lite', 'Audífonos in-ear KZ EDX Lite con excelente calidad de sonido y diseño compacto', 19.99, 50, '/imagenes de catalogo/kz edx lite.webp', 'Audífonos'),
('KZ EDX Pro', 'Audífonos in-ear KZ EDX Pro con drivers mejorados y cable desmontable', 24.99, 45, '/imagenes de catalogo/kz edx pro.webp', 'Audífonos');
