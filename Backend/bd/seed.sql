-- =========================================================================
-- 1. DATOS BASICOS (Usuarios, Proveedores y Materiales)
-- =========================================================================

-- Insertar Usuarios
INSERT INTO "usuario" (nombre_usuario, correo_usuario, contrasena_usuario, direccion_usuario, tipo_usuario) VALUES
('Juan Cristiano', 'juan.esteban@correo.com', 'hash_pass_123', 'Calle 100 # 50-20, Bogota', 'Cliente'),
('Laura Perez', 'lau.perez@correo.com', 'hash_pass_456', 'Carrera 15 # 85-10, Medellin', 'Cliente');

-- Insertar Proveedores
INSERT INTO "proveedor" (nombre_proveedor, telefono_proveedor, correo_proveedor) VALUES
('Maderas y Estructuras SAS', '+57 3101234567', 'ventas@maderas.com'),
('Tecnologia y Componentes Global', '+57 3209876543', 'contacto@tecno-global.com');

-- Insertar Materiales
INSERT INTO "material" (id_proveedor, nombre_material, costo_material, stock_material) VALUES
(1, 'Madera Teka Tratada', 150.50, 500),
(1, 'Melamina Antimanchas', 80.00, 300),
(2, 'Fibra de Carbono', 350.00, 120);


-- =========================================================================
-- 2. PRODUCTOS: MUEBLES (Interior y Exterior)
-- =========================================================================

-- -------------------------------------------------------------------------
-- Producto 1: Escritorio de Interior
-- -------------------------------------------------------------------------
INSERT INTO "producto" (id_material, nombre_producto, tipo, descripcion, precio) 
VALUES (2, 'Escritorio Studio Compact', 'Mueble', 'Ideal para espacios de estudio reducidos y pasillos estrechos', 320.00);
-- (Supongamos id_producto = 1)

INSERT INTO "mueble" (id_producto, tipo_mueble) 
VALUES (1, 'interior');

INSERT INTO "mueble_interior" (id_producto, ancho_pasillo, largo_pasillo, tipo_mesa) 
VALUES (1, 1.20, 2.00, 'Escritorio compacto');


-- -------------------------------------------------------------------------
-- Producto 2: Mueble de Exterior
-- -------------------------------------------------------------------------
INSERT INTO "producto" (id_material, nombre_producto, tipo, descripcion, precio) 
VALUES (1, 'Conjunto Terraza Garden 6 Puestos', 'Mueble', 'Mueble de jardín resistente a la intemperie', 750.00);
-- (Supongamos id_producto = 2)

INSERT INTO "mueble" (id_producto, tipo_mueble) 
VALUES (2, 'exterior');

INSERT INTO "mueble_exterior" (id_producto, capacidad, forma, cubierta, acabado) 
VALUES (2, 6, 'Rectangular', 'Con sombrilla central', 'Barniz impermeable');


-- =========================================================================
-- 3. PRODUCTOS: CAJAS DE MUSICA
-- =========================================================================

-- Producto 3: Caja de Musica Clasica
INSERT INTO "producto" (id_material, nombre_producto, tipo, descripcion, precio) 
VALUES (1, 'Caja de Musica Vintage Melodia de Cuna', 'Caja Musica', 'Caja de madera tallada a mano con mecanismo mecanico', 95.00);
-- (Supongamos id_producto = 3)

INSERT INTO "caja_musica" (id_producto, melodia) 
VALUES (3, 'Para Elisa - Ludwig van Beethoven');


-- =========================================================================
-- 4. PRODUCTOS: CHASIS DE DRON
-- =========================================================================

-- Producto 4: Chasis para Dron de Carreras
INSERT INTO "producto" (id_material, nombre_producto, tipo, descripcion, precio) 
VALUES (3, 'Chasis FPV Pro Carbon', 'Chasis Dron', 'Estructura ultraligera de alta resistencia para drones de alta velocidad', 210.00);
-- (Supongamos id_producto = 4)

INSERT INTO "chasis_dron" (id_producto, peso, tamano_motor, geometria_chasis, tipo_brazos) 
VALUES (4, 125.50, '2207', 'True X', 'plegables');


-- =========================================================================
-- 5. DATOS TRANSACCIONALES (Carrito y Compras)
-- =========================================================================

-- Agregar productos al Carrito del usuario 1
INSERT INTO "carrito" (id_usuario, id_producto, cantidad) VALUES
(1, 1, 1), -- Escritorio Studio Compact
(1, 3, 2); -- Dos Cajas de Musica

-- Registrar una Compra realizada por el usuario 1
INSERT INTO "compra" (id_usuario, total) 
VALUES (1, 510.00);
-- (Supongamos id_compra = 1)

-- Detalle de la compra anterior
INSERT INTO "detalle_compra" (id_compra, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 320.00), -- 1 Escritorio
(1, 3, 1, 190.00); -- 2 Cajas de musica (95 * 2)