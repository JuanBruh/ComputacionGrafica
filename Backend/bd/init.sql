-- 1. TABLAS INDEPENDIENTES (Sin dependencias de FK)

CREATE TABLE "usuario" (
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(255) NOT NULL,
    correo_usuario VARCHAR(255) UNIQUE NOT NULL,
    contrasena_usuario VARCHAR(255) NOT NULL,
    direccion_usuario TEXT,
    tipo_usuario VARCHAR(50) DEFAULT 'Cliente'
);

CREATE TABLE "proveedor" (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_proveedor VARCHAR(255) NOT NULL,
    telefono_proveedor VARCHAR(50),
    correo_proveedor VARCHAR(255)
);

CREATE TABLE "material" (
    id_material SERIAL PRIMARY KEY,
    id_proveedor INTEGER REFERENCES "proveedor"(id_proveedor) ON DELETE SET NULL,
    nombre_material VARCHAR(255) NOT NULL,
    costo_material NUMERIC(10,2),
    stock_material INTEGER DEFAULT 0
);

-- Tabla de Productos (Supertipo)
CREATE TABLE "producto" (
    id_producto SERIAL PRIMARY KEY,
    id_material INTEGER REFERENCES "material"(id_material) ON DELETE SET NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL, -- 'Mueble', 'Caja Musica', 'Chasis Dron'
    descripcion TEXT,
    precio NUMERIC(10,2) NOT NULL
);


-- 2. SUBTIPOS DE PRODUCTO (Herencia por clave primaria)

-- Subtipo Mueble (General)
CREATE TABLE "mueble" (
    id_producto INTEGER PRIMARY KEY REFERENCES "producto"(id_producto) ON DELETE CASCADE,
    tipo_mueble VARCHAR(50) NOT NULL CHECK (tipo_mueble IN ('interior', 'exterior'))
);

-- Subtipo Caja de Musica
CREATE TABLE "caja_musica" (
    id_producto INTEGER PRIMARY KEY REFERENCES "producto"(id_producto) ON DELETE CASCADE,
    melodia VARCHAR(255)
);

-- Subtipo Chasis de Dron
CREATE TABLE "chasis_dron" (
    id_producto INTEGER PRIMARY KEY REFERENCES "producto"(id_producto) ON DELETE CASCADE,
    peso NUMERIC(6,2),
    tamano_motor VARCHAR(100),
    geometria_chasis VARCHAR(100),
    tipo_brazos VARCHAR(100) CHECK (tipo_brazos IN ('fijos', 'plegables'))
);

-- 3. SUBTIPOS DE MUEBLE (Interior y Exterior)

-- Mueble de Interior (Configuracion de pasillos y mesas)
CREATE TABLE "mueble_interior" (
    id_producto INTEGER PRIMARY KEY REFERENCES "mueble"(id_producto) ON DELETE CASCADE,
    ancho_pasillo NUMERIC(5,2),
    largo_pasillo NUMERIC(5,2),
    tipo_mesa VARCHAR(100) -- 'rebatible de pared' o 'escritorio compacto'
);

-- Mueble de Exterior (Configuracion de puestos, forma, sombrilla y acabados)
CREATE TABLE "mueble_exterior" (
    id_producto INTEGER PRIMARY KEY REFERENCES "mueble"(id_producto) ON DELETE CASCADE,
    capacidad INTEGER, 
    forma VARCHAR(100),
    cubierta VARCHAR(100),
    acabado VARCHAR(100)
);


-- 4. TABLAS TRANSACCIONALES Y DE RELACION

-- Tabla Carrito (Relaci0n Usuario - Producto)
CREATE TABLE "carrito" (
    id_carrito SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES "usuario"(id_usuario) ON DELETE CASCADE,
    id_producto INTEGER REFERENCES "producto"(id_producto) ON DELETE CASCADE,
    cantidad INTEGER NOT NULL DEFAULT 1
);

-- Tabla Compra (Encabezado de la transacci0n)
CREATE TABLE "compra" (
    id_compra SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES "usuario"(id_usuario) ON DELETE SET NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total NUMERIC(10,2) NOT NULL
);

-- Detalle de Compra (Para relacionar la compra con uno o mas productos y cantidades)
CREATE TABLE "detalle_compra" (
    id_detalle SERIAL PRIMARY KEY,
    id_compra INTEGER REFERENCES "compra"(id_compra) ON DELETE CASCADE,
    id_producto INTEGER REFERENCES "producto"(id_producto) ON DELETE RESTRICT,
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL
);