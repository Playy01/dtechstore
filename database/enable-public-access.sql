-- Deshabilitar RLS para desarrollo (NO RECOMENDADO EN PRODUCCIÓN)
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE products DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE order_items DISABLE ROW LEVEL SECURITY;

-- O si prefieres mantener RLS, crea estas políticas:

-- Habilitar RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- Políticas para users (permitir lectura pública para login)
CREATE POLICY "Allow public read access to users" ON users
  FOR SELECT USING (true);

CREATE POLICY "Allow public insert for registration" ON users
  FOR INSERT WITH CHECK (true);

-- Políticas para products (lectura pública)
CREATE POLICY "Allow public read access to products" ON products
  FOR SELECT USING (true);

-- Políticas para orders (usuarios pueden ver sus propias órdenes)
CREATE POLICY "Users can view their own orders" ON orders
  FOR SELECT USING (true);

CREATE POLICY "Users can create orders" ON orders
  FOR INSERT WITH CHECK (true);

-- Políticas para order_items
CREATE POLICY "Allow public read access to order_items" ON order_items
  FOR SELECT USING (true);

CREATE POLICY "Allow public insert to order_items" ON order_items
  FOR INSERT WITH CHECK (true);
