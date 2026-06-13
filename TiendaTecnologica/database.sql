-- Script para crear la base de datos de TechStore

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS TechStore;
USE TechStore;

-- Tabla de Categorías
CREATE TABLE IF NOT EXISTS Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla de Productos
CREATE TABLE IF NOT EXISTS Productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    imagen_url VARCHAR(255),
    categoria_id INT,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id) ON DELETE SET NULL
);

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    rol ENUM('admin', 'cliente') DEFAULT 'cliente',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Carrito/Pedidos (Opcional para un ecommerce)
CREATE TABLE IF NOT EXISTS Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    estado ENUM('pendiente', 'pagado', 'enviado', 'entregado') DEFAULT 'pendiente',
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE
);

-- Tabla de Detalles de Pedido
CREATE TABLE IF NOT EXISTS Detalles_Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES Productos(id) ON DELETE CASCADE
);

-- Insertar datos de prueba
INSERT INTO Categorias (nombre, descripcion) VALUES
('Computadoras', 'Laptops, PCs Gamer y equipos empresariales'),
('Accesorios', 'Teclados, mouse, audífonos y más'),
('Componentes', 'RAM, SSD, tarjetas gráficas y hardware');

INSERT INTO Productos (nombre, descripcion, precio, imagen_url, categoria_id) VALUES
('Laptop Profesional', 'Intel Core i5 / 16GB RAM / SSD', 650.00, 'img/productos/laptop.jpg', 1),
('Mouse Gamer RGB', 'Sensor óptico de alta precisión', 25.00, 'img/productos/mouse.jpg', 2),
('Teclado Mecánico', 'Switches profesionales', 60.00, 'img/productos/teclado.jpg', 2);

-- Insertar usuarios administradores
INSERT INTO Usuarios (nombre_completo, correo, password_hash, fecha_nacimiento, rol) VALUES
('Administrador Principal', 'admi', 'tienda123', '2000-06-13', 'admin'),
('Carlos Perez', 'carlos', 'carlos123', '1992-04-12', 'admin'),
('Administrador', 'ronald', 'tienda123', '2000-06-13', 'admin'),
('Administrador', 'guillermo', 'guillermo123', '2000-06-13', 'admin'),
('Administrador', 'victor', 'victor123', '2000-06-13', 'admin'),
('Administrador', 'israel', 'israel123', '2000-06-13', 'admin');

-- Insertar clientes registrados (ejemplos)
INSERT INTO Clientes (nombre_completo, correo, password_hash, fecha_nacimiento, rol) VALUES
('Juan Pérez', 'juan@ejemplo.com', 'juan123', '1995-08-20', 'cliente'),
('Laura Gómez', 'laura@ejemplo.com', 'laura123', '1998-03-15', 'cliente');