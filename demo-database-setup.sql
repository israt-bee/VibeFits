-- VibeFits Demo Database Setup
-- Complete schema and sample data for fashion e-commerce platform

-- Session storage table (required for authentication)
CREATE TABLE IF NOT EXISTS sessions (
  sid VARCHAR PRIMARY KEY,
  sess JSONB NOT NULL,
  expire TIMESTAMP NOT NULL
);
CREATE INDEX IF NOT EXISTS IDX_session_expire ON sessions(expire);

-- User management table
CREATE TABLE IF NOT EXISTS users (
  id VARCHAR PRIMARY KEY,
  email VARCHAR UNIQUE,
  first_name VARCHAR,
  last_name VARCHAR,
  profile_image_url VARCHAR,
  is_admin BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Product catalog table
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  title VARCHAR NOT NULL,
  description TEXT,
  price VARCHAR NOT NULL,
  original_price VARCHAR,
  category VARCHAR NOT NULL,
  image_url VARCHAR,
  stock INTEGER DEFAULT 0,
  sizes JSONB DEFAULT '[]'::jsonb,
  fashion_modes JSONB DEFAULT '[]'::jsonb,
  sku VARCHAR UNIQUE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Shopping cart table
CREATE TABLE IF NOT EXISTS cart_items (
  id SERIAL PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  product_id INTEGER REFERENCES products(id),
  quantity INTEGER DEFAULT 1,
  size VARCHAR,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, product_id, size)
);

-- Wishlist table
CREATE TABLE IF NOT EXISTS wishlist (
  id SERIAL PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  product_id INTEGER REFERENCES products(id),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, product_id)
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  status VARCHAR DEFAULT 'pending',
  subtotal VARCHAR NOT NULL,
  shipping VARCHAR DEFAULT '0.00',
  tax VARCHAR DEFAULT '0.00',
  total VARCHAR NOT NULL,
  payment_method VARCHAR NOT NULL,
  payment_status VARCHAR DEFAULT 'pending',
  shipping_info JSONB NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id),
  product_id INTEGER REFERENCES products(id),
  quantity INTEGER NOT NULL,
  size VARCHAR,
  price VARCHAR NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Insert demo fashion products
INSERT INTO products (title, description, price, original_price, category, image_url, stock, sizes, fashion_modes, sku, is_active) VALUES
('Elegant Evening Dress', 'A stunning black evening dress perfect for formal occasions and romantic dinners', '89.99', '120.00', 'dresses', 'https://images.unsplash.com/photo-1566479179817-c08de05e1ba8?w=500&q=80', 15, '["S", "M", "L", "XL"]'::jsonb, '["formal", "romantic", "classic"]'::jsonb, 'DRESS001', true),
('Casual Summer Dress', 'Light and breezy cotton dress ideal for casual outings and chill vibes', '45.99', '65.00', 'dresses', 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=500&q=80', 25, '["XS", "S", "M", "L"]'::jsonb, '["casual", "chill", "minimal"]'::jsonb, 'DRESS002', true),
('Vintage Floral Dress', 'Retro-inspired floral print dress that brings back classic vintage charm', '67.99', '85.00', 'dresses', 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?w=500&q=80', 12, '["S", "M", "L"]'::jsonb, '["vintage", "retro", "romantic"]'::jsonb, 'DRESS003', true),
('Bold Statement Dress', 'Make a confident statement with this eye-catching dress in vibrant colors', '75.99', '95.00', 'dresses', 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500&q=80', 8, '["M", "L", "XL"]'::jsonb, '["bold", "confident", "formal"]'::jsonb, 'DRESS004', true),
('Desi Embroidered Kurta', 'Traditional embroidered kurta with modern styling for cultural events', '85.99', '110.00', 'dresses', 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=500&q=80', 20, '["XS", "S", "M", "L", "XL"]'::jsonb, '["desi", "formal", "classic"]'::jsonb, 'DRESS005', true),
('Chill Oversized Hoodie', 'Comfortable oversized hoodie perfect for relaxed, chill vibes', '55.99', '70.00', 'dresses', 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500&q=80', 30, '["S", "M", "L", "XL"]'::jsonb, '["chill", "casual", "minimal"]'::jsonb, 'DRESS006', true),
('Romantic Lace Blouse', 'Delicate lace blouse with romantic feminine details', '68.99', '85.00', 'dresses', 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=500&q=80', 18, '["XS", "S", "M", "L"]'::jsonb, '["romantic", "classic", "formal"]'::jsonb, 'DRESS007', true),

('Luxury Matte Lipstick Set', 'Premium collection of matte lipsticks in classic and bold shades', '34.99', '49.99', 'makeup', 'https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=500&q=80', 50, '["One Size"]'::jsonb, '["classic", "bold", "confident"]'::jsonb, 'MAKEUP001', true),
('Natural Glow Foundation', 'Lightweight foundation for a natural, minimal makeup look', '28.99', '35.00', 'makeup', 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=500&q=80', 30, '["Light", "Medium", "Dark"]'::jsonb, '["minimal", "casual", "chill"]'::jsonb, 'MAKEUP002', true),
('Vintage Eye Shadow Palette', 'Retro-inspired eyeshadow colors perfect for vintage and romantic looks', '42.99', '55.00', 'makeup', 'https://images.unsplash.com/photo-1583241800092-9fb010b42e44?w=500&q=80', 20, '["One Size"]'::jsonb, '["vintage", "retro", "romantic"]'::jsonb, 'MAKEUP003', true),
('Confident Red Lipstick', 'Bold red lipstick for confident and powerful looks', '24.99', '30.00', 'makeup', 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=500&q=80', 40, '["One Size"]'::jsonb, '["bold", "confident", "formal"]'::jsonb, 'MAKEUP004', true),
('Retro Cat-Eye Sunglasses', 'Classic cat-eye sunglasses with retro vintage appeal', '45.99', '60.00', 'makeup', 'https://images.unsplash.com/photo-1508296695146-257a814070b4?w=500&q=80', 25, '["One Size"]'::jsonb, '["retro", "vintage", "bold"]'::jsonb, 'ACC001', true),
('Minimal Gold Jewelry Set', 'Elegant minimalist gold jewelry for understated sophistication', '120.99', '150.00', 'makeup', 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=500&q=80', 15, '["One Size"]'::jsonb, '["minimal", "classic", "formal"]'::jsonb, 'ACC002', true),

('Classic Leather Watch', 'Timeless leather strap watch that complements any formal or classic outfit', '159.99', '220.00', 'watches', 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=500&q=80', 18, '["One Size"]'::jsonb, '["classic", "formal", "confident"]'::jsonb, 'WATCH001', true),
('Minimalist Steel Watch', 'Clean, modern design perfect for minimal and casual styling', '89.99', '120.00', 'watches', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80', 22, '["One Size"]'::jsonb, '["minimal", "casual", "chill"]'::jsonb, 'WATCH002', true),
('Vintage Gold Watch', 'Elegant vintage-style timepiece with retro charm and romantic appeal', '199.99', '250.00', 'watches', 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=500&q=80', 10, '["One Size"]'::jsonb, '["vintage", "retro", "romantic"]'::jsonb, 'WATCH003', true),

('Casual Canvas Sneakers', 'Comfortable everyday sneakers perfect for chill and casual looks', '65.99', '85.00', 'shoes', 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500&q=80', 35, '["7", "8", "9", "10", "11"]'::jsonb, '["casual", "chill", "minimal"]'::jsonb, 'SHOES001', true),
('Classic High Heels', 'Elegant black heels ideal for formal events and confident styling', '95.99', '125.00', 'shoes', 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=500&q=80', 15, '["6", "7", "8", "9", "10"]'::jsonb, '["formal", "classic", "confident"]'::jsonb, 'SHOES002', true),
('Vintage Leather Boots', 'Retro-style ankle boots that add vintage flair to any outfit', '125.99', '160.00', 'shoes', 'https://images.unsplash.com/photo-1544966503-7cc5ac882d5f?w=500&q=80', 12, '["6", "7", "8", "9"]'::jsonb, '["vintage", "retro", "bold"]'::jsonb, 'SHOES003', true),
('Bold Platform Sandals', 'Make a statement with these eye-catching platform sandals', '78.99', '95.00', 'shoes', 'https://images.unsplash.com/photo-1535043934128-cf0b28d52f95?w=500&q=80', 18, '["6", "7", "8", "9", "10"]'::jsonb, '["bold", "confident", "casual"]'::jsonb, 'SHOES004', true);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(is_active);
CREATE INDEX IF NOT EXISTS idx_cart_user ON cart_items(user_id);
CREATE INDEX IF NOT EXISTS idx_wishlist_user ON wishlist(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_user ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);