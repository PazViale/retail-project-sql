-- Creo las tablas solicitadas 
CREATE TABLE clientes(
	cliente_id SERIAL PRIMARY KEY,
	nombre_cliente VARCHAR (100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	edad INT CHECK (edad > 18)
);

CREATE TABLE productos(
	producto_id SERIAL PRIMARY KEY,
	nombre_producto VARCHAR (100) NOT NULL,
	categoria VARCHAR (100) NOT NULL,
	precio DECIMAL (10,2) CHECK (precio > 0) NOT NULL,
	stock INT CHECK (stock >= 0) NOT NULL
);

CREATE TABLE ventas(
	ventas_id SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES clientes (cliente_id) NOT NULL,
	producto_id INT REFERENCES productos (producto_id) NOT NULL,
	cantidad INT CHECK (cantidad > 0) NOT NULL,
	fecha_pedido DATE NOT NULL
);

BEGIN;

-- Carga de 5 clientes 
INSERT INTO clientes (nombre_cliente, email, edad) VALUES
    ('Lucas Fernández', 'lucas.fernandez@email.com', 28),
    ('Sofía Martínez', 'sofia.martinez@email.com', 34),
    ('Mateo Gómez', 'mateo.gomez@email.com', 22),
    ('Valentina Ruiz', 'valentina.ruiz@email.com', 41),
    ('Nicolás Díaz', 'nicolas.diaz@email.com', 19);

-- Carga de 5 productos 
INSERT INTO productos (nombre_producto, categoria, precio, stock) VALUES
    ('Mouse Inalámbrico', 'Tecnología', 25.50, 40),
    ('Teclado Mecánico', 'Tecnología', 85.00, 15),
    ('Monitor 24 Pulgadas', 'Tecnología', 210.00, 10),
    ('Silla Ergonómica', 'Muebles', 180.00, 8),
    ('Escritorio Minimalista', 'Muebles', 150.00, 5);

-- Carga de 5 ventas 
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha_pedido) VALUES
    (1, 1, 2, '2026-11-10'),
    (2, 3, 1, '2026-11-11'),
    (3, 2, 1, '2026-11-12'),
    (4, 4, 1, '2026-11-14'),
    (5, 5, 2, '2026-11-15');

COMMIT;

-- Modifico el precio de todos los productos de la categoría Muebles
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Muebles';

-- Elimino la venta con la venta_id 3
DELETE FROM ventas
WHERE ventas_id = 3;
