--Borrar tablas en caso de que existan
DROP TABLE IF EXISTS  usuarios, direccion_usuario, productos, carrito, metodo_pago, detalle_pago, compra, detalle_compra;

--Creacion de tablas e inserts
--  Tabla usuarios
CREATE TABLE usuarios
(
    id_usuarios SERIAL PRIMARY KEY,
    rut character varying (15) UNIQUE ,
    nombre_cliente character varying(50),
    apellido_cliente character varying(50),
    email VARCHAR(50) NOT NULL,
    contraseña character varying(20)
);

-- INSERT USUARIOS
INSERT INTO usuarios(id_usuarios, rut, nombre_cliente, apellido_cliente, email, contraseña) VALUES(1, '1.111.111-1', 'Juan', 'Ahumada', 'quemasadia@gmail.com', '1234');
INSERT INTO usuarios(id_usuarios, rut, nombre_cliente, apellido_cliente, email, contraseña) VALUES(2, '2.222.222-2', 'Pedro', 'Torres', 'lala12@gmail.com', '5678');
INSERT INTO usuarios(id_usuarios, rut, nombre_cliente, apellido_cliente, email, contraseña) VALUES(3, '3.333.333-3', 'Geraldine', 'Ahumada', 'gireragnarok@gmail.com', '9012');
INSERT INTO usuarios(id_usuarios, rut, nombre_cliente, apellido_cliente, email, contraseña) VALUES(4, '4.444.444-4', 'Francisco', 'Mamani', 'soulbla@gmail.com', '3456');
INSERT INTO usuarios(id_usuarios, rut, nombre_cliente, apellido_cliente, email, contraseña) VALUES(5, '5.555.555-5', 'Noha', 'Mono', 'Monodespierto@gmail.com', '7890');

SELECT * FROM usuarios;

--  Tabla direccion_usuario
CREATE TABLE direccion_usuario
(
    id_direccion SERIAL NOT NULL,
    direccion character varying(50),
	comuna character varying(50),
	ciudad character varying(50),
	region character varying(50),
	usuario_rut character varying (15),
    FOREIGN KEY (usuario_rut) REFERENCES usuarios(rut)
);

-- INSERT direccion_usuario
INSERT INTO direccion_usuario  (id_direccion, direccion, comuna, ciudad, region, usuario_rut) values(1, 'Pasaje Agustin Caballero 2376','Arica','Arica','XV','1.111.111-1');
INSERT INTO direccion_usuario  (id_direccion, direccion, comuna, ciudad, region, usuario_rut) values(2, 'Calle Esmeralda 3476','Iqueuqe','Iquique','I','2.222.222-2');
INSERT INTO direccion_usuario  (id_direccion, direccion, comuna, ciudad, region, usuario_rut) values(3, 'Av. Bolognesi 7437','Antofagasta','Antofagasta','II','3.333.333-3');
INSERT INTO direccion_usuario  (id_direccion, direccion, comuna, ciudad, region, usuario_rut) values(4, 'Av. Colon 9652','Coquimbo','Atacama','III','4.444.444-4');
INSERT INTO direccion_usuario  (id_direccion, direccion, comuna, ciudad, region, usuario_rut) values(5, 'Maipu 2658','Arica','Santiago','RM','5.555.555-5');

SELECT * FROM direccion_usuario;

--  Tabla productos
CREATE TABLE productos
(   
    id integer NOT NULL,
    nombre_producto character varying(50),
    descripcion character varying(100),
    precio integer,
	stock integer,
    PRIMARY KEY (id)
);

-- INSERT productos
INSERT INTO productos (id, nombre_producto, descripcion, precio, stock) values (1,'Crash Bandicoot', 'Juego plataformero, niveles dificiles', 1200, 3);
INSERT INTO productos (id, nombre_producto, descripcion, precio, stock) values (2,'Mortal Kombat XI', 'Luchas con los mejores graficos', 1500, 5);
INSERT INTO productos (id, nombre_producto, descripcion, precio, stock) values (3,'Pac Man', 'Juego plataformero, niveles basicos', 1570, 50);
INSERT INTO productos (id, nombre_producto, descripcion, precio, stock) values (4,'Dragon Ball Xenoverse', 'Vive la experiencia dragon ball', 1000, 25);
INSERT INTO productos (id, nombre_producto, descripcion, precio, stock) values (5,'Call Of Duty Warzone', 'Dispara como nunca', 1200, 130);

SELECT * FROM productos;

--  Tabla carrito
CREATE TABLE carrito
(
    id_carrito serial NOT NULL,
	cantidad integer,
	producto_id integer,
	usuario_rut character varying(15),
    PRIMARY KEY (id_carrito),
	FOREIGN KEY (producto_id) REFERENCES productos(id),
	FOREIGN KEY (usuario_rut) REFERENCES usuarios(rut)
);

-- INSERT carrito
INSERT INTO carrito (id_carrito, cantidad, producto_id, usuario_rut) values(1, 1, 1,'1.111.111-1');


SELECT * FROM carrito;


--  Tabla metodo_pago
CREATE TABLE metodo_pago
(   
    id_metodo SERIAL PRIMARY KEY,
    metodo character varying(20),
	usuario_rut character varying(15),
    FOREIGN KEY (usuario_rut) REFERENCES usuarios(rut)
);

-- INSERT metodo_pago
INSERT INTO metodo_pago (id_metodo, metodo, usuario_rut) values (1, 'credito','1.111.111-1');
INSERT INTO metodo_pago (id_metodo, metodo, usuario_rut) values (2, 'debito','2.222.222-2');
INSERT INTO metodo_pago (id_metodo, metodo, usuario_rut) values (3, 'transferencia','3.333.333-3');


SELECT * FROM metodo_pago;

/*Tablas principalmente asociadas a la compra*/

--  Tabla detalle_pago
CREATE TABLE detalle_pago
(
    id_detalle serial NOT NULL,
	estado character varying(12),
	metodo character varying(20),
    PRIMARY KEY (id_detalle)
);

-- INSERT detalle_pago
INSERT INTO detalle_pago (id_detalle, estado, metodo) values (default,'finalizado','credito');
INSERT INTO detalle_pago (id_detalle, estado, metodo) values (default,'finalizado','debito');
INSERT INTO detalle_pago (id_detalle, estado, metodo) values (default,'finalizado','transferencia');

SELECT * FROM detalle_pago;

--  Tabla compra
CREATE TABLE compra
(
    id_compras serial NOT NULL,
	usuario_rut character varying(15),
	fecha date,
	detalle_pago_id_detalle integer,
    PRIMARY KEY (id_compras),
	FOREIGN KEY (detalle_pago_id_detalle) REFERENCES detalle_pago(id_detalle),
	FOREIGN KEY (usuario_rut) REFERENCES usuarios(rut)
);

-- INSERT compra
INSERT INTO compra (id_compras, usuario_rut, fecha, detalle_pago_id_detalle ) values (default,'1.111.111-1','12-12-2022',1);


SELECT * FROM compra;

--  Tabla detalle_compra
CREATE TABLE detalle_compra
(
    id_detallecompra serial NOT NULL,
	productos_id integer,
	cantidad_compra integer,
	compras_id integer,
    PRIMARY KEY (id_detallecompra),
	FOREIGN KEY (productos_id) REFERENCES productos(id),
	FOREIGN KEY (compras_id) REFERENCES compra(id_compras)
);

-- INSERT detalle_compra
INSERT INTO detalle_compra (id_detallecompra, productos_id, cantidad_compra,compras_id) values (default,1,1,1);

SELECT * FROM detalle_compra;


--Preguntas

--Rebaja del 20%
UPDATE productos SET precio=round(precio*0.8,0);

-- LISTAR TODOS LOS PRODCUTOS CON STOCK MENOR O IGUAL A 5
SELECT *
FROM productos
WHERE stock <= 5;

-- SIMULAR LA COMPRA DE AL MENOS 3 PRODUCTOS, CALCULAR SUBTOTAL, AGREGAR EL IVA Y MOSTRAR EL TOTAL DE LA COMPRA
INSERT INTO compra (id_compras, usuario_rut, fecha, detalle_pago_id_detalle ) values (default,'1.111.111-1','17-1-2023', 5);
INSERT INTO detalle_compra (id_detallecompra, productos_id, cantidad_compra,compras_id) values (default,1,1,1);
INSERT INTO detalle_compra (id_detallecompra, productos_id, cantidad_compra,compras_id) values (default,3,1,1);
INSERT INTO detalle_compra (id_detallecompra, productos_id, cantidad_compra,compras_id) values (default,5,1,1);
INSERT INTO detalle_pago values (default,'finalizado','debito');

SELECT c.id_compras, c.fecha, sum(dc.cantidad_compra * p.precio) AS subtotal, 
(sum(dc.cantidad_compra * p.precio) * 0.19) AS IVA, 
sum(dc.cantidad_compra * p.precio) + (sum(dc.cantidad_compra * p.precio) * 0.19) AS total 
FROM compra c 
JOIN detalle_compra dc ON c.id_compras = dc.compras_id 
JOIN productos p ON dc.productos_id = p.id 
GROUP BY c.id_compras, c.fecha

-- MOSTAR EL TOTAL DE VENTAS DE MES DE DICIEMBRE DE 2022
SELECT count(id_compras) as Total_de_ventas, sum(d.cantidad_compra * p.precio) as Total_diciembre_2022
FROM compra c
JOIN detalle_compra d ON c.id_compras = d.compras_id
JOIN productos p ON d.productos_id = p.id
WHERE date_part('month', fecha) = 12
AND date_part('year', fecha) = 2022;

-- Listar el comportamiento del usuario que mas compras realizo en 2022
SELECT usuario_rut AS max_comprador
FROM( SELECT usuario_rut,COUNT(usuario_rut) AS n_compras
	FROM compra
	group by usuario_rut
	order by n_compras desc
	limit 1) as tabla_calculada 

 