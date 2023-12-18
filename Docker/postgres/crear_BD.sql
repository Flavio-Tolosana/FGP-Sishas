-- DROP SCHEMA test_sisinf;
CREATE SCHEMA test_sisinf AUTHORIZATION postgres;

-------------------------- CREACIÓN SECUENCIAS ---------------------------------

-- DROP SEQUENCE test_sisinf.atributos_idatributo_seq;
CREATE SEQUENCE test_sisinf.atributos_idatributo_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- DROP SEQUENCE test_sisinf.atributostipo_idatributostipo_seq;
CREATE SEQUENCE test_sisinf.atributostipo_idatributostipo_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- DROP SEQUENCE test_sisinf.producto_idproducto_seq;
CREATE SEQUENCE test_sisinf.producto_idproducto_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- DROP SEQUENCE test_sisinf.tipos_idtipo_seq;
CREATE SEQUENCE test_sisinf.tipos_idtipo_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

---------------------------- CREACIÓN TABLAS -----------------------------------

-- DROP TABLE test_sisinf.tipos;
CREATE TABLE test_sisinf.tipos (
	idtipo serial4 NOT NULL,
	nombretipo varchar NOT NULL,
	CONSTRAINT tipos_pk PRIMARY KEY (idtipo)
);


-- DROP TABLE test_sisinf.usuario;
CREATE TABLE test_sisinf.usuario (
	correoelectronico varchar NOT NULL,
	nombre varchar NOT NULL,
	apellidos varchar NOT NULL,
	contrasegna varchar NOT NULL,
	calle varchar NULL,
	pisopuerta varchar NULL,
	codigopostal varchar NULL,
	numerotelefono varchar NULL,
	esadmin bool NOT NULL,
	CONSTRAINT cliente_pk PRIMARY KEY (correoelectronico)
);


-- DROP TABLE test_sisinf.producto;
CREATE TABLE test_sisinf.producto (
	idproducto serial4 NOT NULL,
	nombre varchar NULL,
	estadoproducto varchar NULL,
	marca varchar NOT NULL,
	color varchar NOT NULL,
	precio float8 NULL,
	tipoproducto int4 NOT NULL,
	estadoventa varchar NOT NULL,
	precioventa float8 NULL,
	unidades int4 NOT NULL,
	urlfoto varchar NOT NULL,
	usuariovendedorproducto varchar NOT NULL,
	CONSTRAINT producto_pk PRIMARY KEY (idproducto),
	CONSTRAINT producto_fk FOREIGN KEY (tipoproducto) REFERENCES test_sisinf.tipos(idtipo),
    CONSTRAINT producto_fk1 FOREIGN KEY (usuariovendedorproducto) REFERENCES test_sisinf.usuario(correoelectronico)
);


-- DROP TABLE test_sisinf.atributostipo;
CREATE TABLE test_sisinf.atributostipo (
	idatributostipo serial4 NOT NULL,
	tipoproducto int4 NOT NULL,
	nombreatributo varchar NOT NULL,
	CONSTRAINT atributostipo_pk PRIMARY KEY (idatributostipo),
	CONSTRAINT atributostipo_fk FOREIGN KEY (tipoproducto) REFERENCES test_sisinf.tipos(idtipo)
);


-- DROP TABLE test_sisinf.atributos;
CREATE TABLE test_sisinf.atributos (
	idatributo serial4 NOT NULL,
	producto int4 NOT NULL,
	atributotipo int4 NOT NULL,
	valoratributo varchar NOT NULL,
	CONSTRAINT atributos_pk PRIMARY KEY (idatributo),
	CONSTRAINT atributos_fk FOREIGN KEY (producto) REFERENCES test_sisinf.producto(idproducto),
	CONSTRAINT atributos_fk_1 FOREIGN KEY (atributotipo) REFERENCES test_sisinf.atributostipo(idatributostipo)
);


-- DROP TABLE test_sisinf.carrito;
CREATE TABLE test_sisinf.carrito (
	correoelectronico varchar NOT NULL,
	idproducto int4 NOT NULL,
	cantidad int4 NOT NULL,
	CONSTRAINT carrito_pk PRIMARY KEY (correoelectronico, idproducto),
	CONSTRAINT carrito_fk FOREIGN KEY (correoelectronico) REFERENCES test_sisinf.usuario(correoelectronico),
	CONSTRAINT carrito_fk_1 FOREIGN KEY (idproducto) REFERENCES test_sisinf.producto(idproducto)
);


-- DROP TABLE test_sisinf.compras;
CREATE TABLE test_sisinf.compras (
	correoelectronico varchar NOT NULL,
	idproducto int4 NOT NULL,
	cantidad int4 NOT NULL,
	tiempocompra varchar NOT NULL,
	precio float8 NOT NULL,
	CONSTRAINT compras_pk PRIMARY KEY (correoelectronico, idproducto, tiempocompra),
	CONSTRAINT compras_fk FOREIGN KEY (correoelectronico) REFERENCES test_sisinf.usuario(correoelectronico),
	CONSTRAINT compras_fk_1 FOREIGN KEY (idproducto) REFERENCES test_sisinf.producto(idproducto)
);

-------------------------- INSERCIÓN EN TABLAS ---------------------------------
------------ Inserción tabla Usuario
-- Insertar Usuario 1: Flavio Tolosana Hernando
INSERT INTO test_sisinf.usuario
(correoelectronico, nombre, apellidos, contrasegna, calle, pisopuerta, codigopostal, numerotelefono, esadmin)
VALUES('flavio@gmail.com', 'Flavio', 'Tolosana Hernando', 'flaviopswd', 'Aguaron', '5 4M', '50014', '698765432', false);

-- Insertar Usuario 2: Pablo Pina Gracia
INSERT INTO test_sisinf.usuario
(correoelectronico, nombre, apellidos, contrasegna, calle, pisopuerta, codigopostal, numerotelefono, esadmin)
VALUES('pablo@gmail.com', 'Pablo', 'Pina Gracia', 'pablopswd', 'Longares', '3 2B', '50014', '612345678', false);

-- Insertar Usuario 3: Gonzalo Valero Domingo
INSERT INTO test_sisinf.usuario
(correoelectronico, nombre, apellidos, contrasegna, calle, pisopuerta, codigopostal, numerotelefono, esadmin)
VALUES('gonzalo@gmail.com', 'Gonzalo', 'Valero Domingo', 'gonzalopswd', 'Jota', '15 Puerta: 15', '50014', '613785478', false);

-- Insertar Administrador
INSERT INTO test_sisinf.usuario
(correoelectronico, nombre, apellidos, contrasegna, esadmin)
VALUES('admin@admin.com', 'Administrador', 'Apellidos Admin', 'admin', true);

------------ Inserción tabla Tipos
-- Insertar manguera
INSERT INTO test_sisinf.tipos
(idtipo, nombretipo)
VALUES(nextval('test_sisinf.tipos_idtipo_seq'::regclass), 'manguera');

-- Insertar cachimba
INSERT INTO test_sisinf.tipos
(idtipo, nombretipo)
VALUES(nextval('test_sisinf.tipos_idtipo_seq'::regclass), 'cachimba');

-- Insertar base
INSERT INTO test_sisinf.tipos
(idtipo, nombretipo)
VALUES(nextval('test_sisinf.tipos_idtipo_seq'::regclass), 'base');

-- Insertar mastil
INSERT INTO test_sisinf.tipos
(idtipo, nombretipo)
VALUES(nextval('test_sisinf.tipos_idtipo_seq'::regclass), 'mastil');

-- Insertar cazoleta
INSERT INTO test_sisinf.tipos
(idtipo, nombretipo)
VALUES(nextval('test_sisinf.tipos_idtipo_seq'::regclass), 'cazoleta');

-- Insertar accesorio
INSERT INTO test_sisinf.tipos
(idtipo, nombretipo)
VALUES(nextval('test_sisinf.tipos_idtipo_seq'::regclass), 'accesorio');

------------ Inserción tabla Atributostipo
-- Insertar tipo atributo de manguera
INSERT INTO test_sisinf.atributostipo
(idatributostipo, tipoproducto, nombreatributo)
VALUES(nextval('test_sisinf.atributostipo_idatributostipo_seq'::regclass), 1, 'largura');

-- Insertar tipo atributo de cachimba
INSERT INTO test_sisinf.atributostipo
(idatributostipo, tipoproducto, nombreatributo)
VALUES(nextval('test_sisinf.atributostipo_idatributostipo_seq'::regclass), 2, 'altura');

-- Insertar tipo atributo de base
INSERT INTO test_sisinf.atributostipo
(idatributostipo, tipoproducto, nombreatributo)
VALUES(nextval('test_sisinf.atributostipo_idatributostipo_seq'::regclass), 3, 'encaje');

-- Insertar tipo atributo de mastil
INSERT INTO test_sisinf.atributostipo
(idatributostipo, tipoproducto, nombreatributo)
VALUES(nextval('test_sisinf.atributostipo_idatributostipo_seq'::regclass), 4, 'encaje');

-- Insertar tipo atributo de cazoleta
INSERT INTO test_sisinf.atributostipo
(idatributostipo, tipoproducto, nombreatributo)
VALUES(nextval('test_sisinf.atributostipo_idatributostipo_seq'::regclass), 5, 'tipoCazoleta');

-- Insertar tipo atributo de accesorio
INSERT INTO test_sisinf.atributostipo
(idatributostipo, tipoproducto, nombreatributo)
VALUES(nextval('test_sisinf.atributostipo_idatributostipo_seq'::regclass), 6, 'tipoAccesorio');

------------ Inserción tabla Producto
-- Insertar producto 1
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Manguera 1', 'Primera Mano', 'X', 'Negro', 29.99, 1, 'Vendido', 0, 5, 'imagenes/productos/1.png', 'admin@admin.com');

-- Insertar producto 2
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba 1', 'Primera Mano', 'X', 'Azul', 59.99, 2, 'Vendido', 0, 3, 'imagenes/productos/2.png', 'admin@admin.com');

-- Insertar producto 3
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Base 1', 'Primera Mano', 'X', 'Transparente', 14.99, 3, 'Vendido', 0, 4, 'imagenes/productos/3.png', 'admin@admin.com');

-- Insertar producto 4
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil 1', 'Primera Mano', 'X', 'Azul', 9.99, 4, 'Vendido', 0, 7, 'imagenes/productos/4.png', 'admin@admin.com');

-- Insertar producto 5
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cazoleta 1', 'Primera Mano', 'X', 'Verde', 7.99, 5, 'Vendido', 0, 5, 'imagenes/productos/5.png', 'admin@admin.com');

-- Insertar producto 6
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Accesorio 1', 'Primera Mano', 'X', 'Azul', 7.99, 6, 'Vendido', 0, 6, 'imagenes/productos/6.png', 'admin@admin.com');

-- Insertar producto 7
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Manguera 2', 'Primera Mano', 'Y', 'Roja', 21.99, 1, 'Vendido', 0, 4, 'imagenes/productos/7.png', 'admin@admin.com');

-- Insertar producto 8
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba 2', 'Primera Mano', 'Y', 'Multicolor', 77.99, 2, 'Vendido', 0, 3, 'imagenes/productos/8.png', 'admin@admin.com');

-- Insertar producto 9
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Base 2', 'Primera Mano', 'Y', 'Azul', 14.99, 3, 'Vendido', 0, 6, 'imagenes/productos/9.png', 'admin@admin.com');

-- Insertar producto 10
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil 2', 'Primera Mano', 'Y', 'Multicolor', 25.99, 4, 'Vendido', 0, 3, 'imagenes/productos/10.png', 'admin@admin.com');

-- Insertar producto 11
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cazoleta 2', 'Primera Mano', 'Y', 'Amarillo', 12.99, 5, 'Vendido', 0, 5, 'imagenes/productos/11.png', 'admin@admin.com');

-- Insertar producto 12
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Accesorio 2', 'Primera Mano', 'Y', 'Blanco', 34.99, 6, 'Vendido', 0, 8, 'imagenes/productos/12.png', 'admin@admin.com');

-- Insertar producto 13
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Accesorio Flavio', 'Segunda Mano', 'Z', 'Metalico', 4.99, 6, 'Vendido', 2, 1, 'imagenes/productos/13.png', 'flavio@gmail.com');

-- Insertar producto 14
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba Piña', 'Segunda Mano', 'Z', 'Amarilla', 99.99, 2, 'Vendido', 75.5, 1, 'imagenes/productos/14.png', 'pablo@gmail.com');

-- Insertar producto 15
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil IronMan', 'Segunda Mano', 'Z', 'Rojo', 18.99, 4, 'Vendido', 10.50, 1, 'imagenes/productos/15.png', 'gonzalo@gmail.com');

-- Insertar producto 16
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Manguera 3', 'Primera Mano', 'X', 'Azul', 29.99, 1, 'Vendido', 0, 5, 'imagenes/productos/16.png', 'admin@admin.com');

-- Insertar producto 17
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Manguera 4', 'Primera Mano', 'Y', 'Marron', 19.99, 1, 'Vendido', 0, 5, 'imagenes/productos/17.png', 'admin@admin.com');

-- Insertar producto 18
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Manguera 5', 'Primera Mano', 'Z', 'Marron', 25.99, 1, 'Vendido', 0, 5, 'imagenes/productos/18.png', 'admin@admin.com');

-- Insertar producto 19
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba 3', 'Primera Mano', 'X', 'Blanca', 63.99, 2, 'Vendido', 0, 3, 'imagenes/productos/19.png', 'admin@admin.com');

-- Insertar producto 20
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba 4', 'Primera Mano', 'Y', 'Negra', 75.99, 2, 'Vendido', 0, 3, 'imagenes/productos/20.png', 'admin@admin.com');

-- Insertar producto 21
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba 5', 'Primera Mano', 'Z', 'Azul', 69.99, 2, 'Vendido', 0, 3, 'imagenes/productos/21.png', 'admin@admin.com');

-- Insertar producto 22
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Base 3', 'Primera Mano', 'X', 'Transparente', 14.99, 3, 'Vendido', 0, 4, 'imagenes/productos/22.png', 'admin@admin.com');

-- Insertar producto 23
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Base 4', 'Primera Mano', 'Y', 'Roja', 22.99, 3, 'Vendido', 0, 4, 'imagenes/productos/23.png', 'admin@admin.com');

-- Insertar producto 24
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Base 5', 'Primera Mano', 'Z', 'Amarilla', 25.99, 3, 'Vendido', 0, 4, 'imagenes/productos/24.png', 'admin@admin.com');

-- Insertar producto 25
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil 3', 'Primera Mano', 'X', 'Blanco', 9.99, 4, 'Vendido', 0, 7, 'imagenes/productos/25.png', 'admin@admin.com');

-- Insertar producto 26
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil 4', 'Primera Mano', 'Y', 'Verde', 12.99, 4, 'Vendido', 0, 7, 'imagenes/productos/26.png', 'admin@admin.com');

-- Insertar producto 27
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil 5', 'Primera Mano', 'Z', 'Metalico', 19.99, 4, 'Vendido', 0, 7, 'imagenes/productos/27.png', 'admin@admin.com');

-- Insertar producto 28
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cazoleta 3', 'Primera Mano', 'X', 'Gris', 7.99, 5, 'Vendido', 0, 5, 'imagenes/productos/28.png', 'admin@admin.com');

-- Insertar producto 29
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cazoleta 4', 'Primera Mano', 'Y', 'Roja', 9.99, 5, 'Vendido', 0, 5, 'imagenes/productos/29.png', 'admin@admin.com');

-- Insertar producto 30
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cazoleta 5', 'Primera Mano', 'Z', 'Negra', 8.99, 5, 'Vendido', 0, 5, 'imagenes/productos/30.png', 'admin@admin.com');

-- Insertar producto 31
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Altavoz', 'Primera Mano', 'X', 'Oro', 97.99, 6, 'Vendido', 0, 2, 'imagenes/productos/31.png', 'admin@admin.com');

-- Insertar producto 32
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Agujereador', 'Primera Mano', 'Y', 'Oro', 7.99, 6, 'Vendido', 0, 8, 'imagenes/productos/32.png', 'admin@admin.com');

-- Insertar producto 33
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Boquilla Stitch', 'Primera Mano', 'Z', 'Azul', 12.99, 6, 'Vendido', 0, 5, 'imagenes/productos/33.png', 'admin@admin.com');

-- Insertar producto 34
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Manguera verde', 'Segunda Mano', 'Z', 'Verde', 18.99, 1, 'Vendido', 10, 1, 'imagenes/productos/34.png', 'flavio@gmail.com');

-- Insertar producto 35
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cachimba Spider', 'Segunda Mano', 'Z', 'Blanca', 99.99, 2, 'Vendido', 69, 1, 'imagenes/productos/35.png', 'flavio@gmail.com');

-- Insertar producto 36
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Base rosa', 'Segunda Mano', 'Z', 'Rosa', 19.99, 3, 'Vendido', 5.5, 1, 'imagenes/productos/36.png', 'pablo@gmail.com');

-- Insertar producto 37
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Mastil mono', 'Segunda Mano', 'Z', 'Marron', 19.99, 4, 'Vendido', 8.75, 1, 'imagenes/productos/37.png', 'pablo@gmail.com');

-- Insertar producto 38
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Cazoleta azul', 'Segunda Mano', 'Z', 'Azul', 12.99, 5, 'Vendido', 5.50, 1, 'imagenes/productos/38.png', 'gonzalo@gmail.com');

-- Insertar producto 39
INSERT INTO test_sisinf.producto
(idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto)
VALUES(nextval('test_sisinf.producto_idproducto_seq'::regclass), 'Set boquillas', 'Segunda Mano', 'Z', 'Multicolor', 6.99, 6, 'Vendido', 1.50, 1, 'imagenes/productos/39.png', 'gonzalo@gmail.com');


------------ Inserción tabla Atributos
-- Insertar atributos producto 1
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 1, 1, '36');

-- Insertar atributos producto 2
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 2, 2, '48');

-- Insertar atributos producto 3
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 3, 3, '10');

-- Insertar atributos producto 4
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 4, 4, '15');

-- Insertar atributos producto 5
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 5, 5, 'Tradi');

-- Insertar atributos producto 6
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 6, 6, 'Rosca');

-- Insertar atributos producto 7
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 7, 1, '32');

-- Insertar atributos producto 8
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 8, 2, '56');

-- Insertar atributos producto 9
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 9, 3, '15');

-- Insertar atributos producto 10
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 10, 4, '10');

-- Insertar atributos producto 11
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 11, 5, 'Phunnel');

-- Insertar atributos producto 12
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 12, 6, 'Estufa');

-- Insertar atributos producto 13
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 13, 6, 'Guarda carbones');

-- Insertar atributos producto 14
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 14, 2, '43');

-- Insertar atributos producto 15
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 15, 4, '10');

-- Insertar atributos producto 16
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 16, 1, '29');

-- Insertar atributos producto 17
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 17, 1, '35');

-- Insertar atributos producto 18
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 18, 1, '33');

-- Insertar atributos producto 19
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 19, 2, '50');

-- Insertar atributos producto 20
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 20, 2, '53');

-- Insertar atributos producto 21
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 21, 2, '55');

-- Insertar atributos producto 22
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 22, 3, '10');

-- Insertar atributos producto 23
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 23, 3, '10');

-- Insertar atributos producto 24
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 24, 3, '15');

-- Insertar atributos producto 25
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 25, 4, '10');

-- Insertar atributos producto 26
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 26, 4, '10');

-- Insertar atributos producto 27
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 27, 4, '15');

-- Insertar atributos producto 28
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 28, 5, 'Tradi');

-- Insertar atributos producto 29
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 29, 5, 'Tradi');

-- Insertar atributos producto 30
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 30, 5, 'Phunnel');

-- Insertar atributos producto 31
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 31, 6, 'Altavoz mastil');

-- Insertar atributos producto 32
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 32, 6, 'Agujereador');

-- Insertar atributos producto 33
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 33, 6, 'Boquilla');

-- Insertar atributos producto 34
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 34, 1, '36');

-- Insertar atributos producto 35
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 35, 2, '48');

-- Insertar atributos producto 36
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 36, 3, '15');

-- Insertar atributos producto 37
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 37, 4, '15');

-- Insertar atributos producto 38
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 38, 5, 'Tradi');

-- Insertar atributos producto 39
INSERT INTO test_sisinf.atributos
(idatributo, producto, atributotipo, valoratributo)
VALUES(nextval('test_sisinf.atributos_idatributo_seq'::regclass), 39, 6, 'Boquillas');
