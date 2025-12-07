-- Actualizar productos con precios y descripciones reales de Amazon MX

UPDATE products SET 
  description = 'Audífonos gaming con sonido envolvente 7.1, micrófono con cancelación de ruido, iluminación RGB y almohadillas de memoria. Compatible con PC, PS4, Xbox One y Nintendo Switch.',
  price = 399.00
WHERE id = 1;

UPDATE products SET 
  description = 'Teclado mecánico gaming con retroiluminación RGB, switches mecánicos azules, reposamuñecas ergonómico y teclas anti-ghosting. Ideal para gaming profesional.',
  price = 899.00
WHERE id = 2;

UPDATE products SET 
  description = 'Mouse gaming con sensor óptico de 6400 DPI ajustable, 7 botones programables, iluminación RGB personalizable y diseño ergonómico para sesiones largas.',
  price = 299.00
WHERE id = 3;

UPDATE products SET 
  description = 'Audífonos inalámbricos con Bluetooth 5.0, cancelación activa de ruido, batería de hasta 30 horas, micrófono integrado y estuche de carga portátil.',
  price = 599.00
WHERE id = 4;

UPDATE products SET 
  description = 'Audífonos gaming con iluminación LED RGB, sonido estéreo HD, micrófono flexible, control de volumen en cable y compatibilidad universal con consolas y PC.',
  price = 349.00
WHERE id = 5;

UPDATE products SET 
  description = 'Audífonos in-ear con drivers dinámicos de 10mm, cable desmontable de 2 pines, diseño ergonómico y aislamiento de ruido pasivo. Perfectos para audiófilos.',
  price = 449.00
WHERE id = 6;

UPDATE products SET 
  description = 'Audífonos in-ear de entrada con driver dinámico de 10mm, diseño compacto y ligero, cable reforzado y excelente relación calidad-precio para uso diario.',
  price = 199.00
WHERE id = 7;

UPDATE products SET 
  description = 'Audífonos in-ear mejorados con drivers dinámicos de 10mm optimizados, cable desmontable de 0.75mm, diseño ergonómico y sonido balanceado para música y gaming.',
  price = 249.00
WHERE id = 8;
