create database controlclientes character set utf8mb4;

use controlclientes;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `correo` varchar(200) NOT NULL,
  `contrasena` varchar(200) NOT NULL,
  `nombres` varchar(80),
  `apellidos` varchar(80)
);

DROP TABLE IF EXISTS `user_session`;
CREATE TABLE `user_session`(
  `id` int(11) not null AUTO_INCREMENT PRIMARY KEY,
    `id_user` int(11) not null,
    `token` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
    `created_at` timestamp not null DEFAULT CURRENT_TIMESTAMP,
    `expires_at` timestamp not null
);
ALTER TABLE `user_session`
  ADD CONSTRAINT `user_session_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TRIGGER dateinsert BEFORE INSERT ON `user_session`
FOR EACH ROW
SET NEW.expires_at =  DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL 7 DAY);



CREATE TABLE `accesos`(
	`id` int(10) not null AUTO_INCREMENT PRIMARY KEY,
	`id_acceso_padre` int(10),
	`nombre` varchar(30) not null,
	`ruta` varchar(50)
);

CREATE TABLE `roles`(
	`id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nombre` varchar(30) NOT NULL
);

CREATE TABLE `acceso_por_rol`(
	`id_acceso` int(10) NOT NULL,
	`id_rol` int(10) NOT NULL,
	`permitido` int(1)
);
ALTER TABLE `acceso_por_rol` ADD PRIMARY KEY (`id_acceso`, `id_rol`);

ALTER TABLE `acceso_por_rol`
  ADD CONSTRAINT `acceso_por_rol_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `acceso_por_rol_ibfk_2` FOREIGN KEY (`id_acceso`) REFERENCES `accesos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE `roles_por_usuario`(
	`id_user` int(11) NOT NULL,
	`id_rol` int (10) NOT NULL
);
ALTER TABLE `roles_por_usuario` ADD PRIMARY KEY (`id_user`,`id_rol`);
ALTER TABLE `roles_por_usuario`
  ADD CONSTRAINT `roles_por_usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `roles_por_usuario_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- Inserta los datos de accesos
INSERT INTO accesos (nombre) VALUES ('Catálogos');
INSERT INTO accesos (nombre) VALUES ('Movimientos');
INSERT INTO accesos (nombre) VALUES ('Reportes');
INSERT INTO accesos (nombre) VALUES ('Administración');

INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Proyectos','proyectos');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Modelos','modelos');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Tipos de inmuebles','tipoinmuebles');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Inmuebles','inmuebles');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Formas de pago','formpago');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Asesores','asesores');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Inversionistas','inversionistas');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (1,'Identificación','identificacion');

INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (2,'Clientes','clientes');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (2,'Negociaciones','negociaciones');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (2,'Asesores','asesoresmov');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (2,'Inversionistas','inversionistasmov');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (2,'Recordatorio de pago','recordpago');

INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Clientes morosos','clientmorosos');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Flujo de pagos proyectados','pagosproy');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Flujo de pagos efectuados','pagosefect');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Flujo de pagos','flujopagos');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Estado de cuenta','estadocuenta');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Estado de cuenta inversionista','estadocuentainv');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (3,'Negociaviones de clientes','negclient');

INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (4,'Usuarios','usuarios');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (4,'Roles','roles');
INSERT INTO accesos (id_acceso_padre, nombre,ruta) VALUES (4,'Accesos','accesos');


-- Inseta el rol Admin y los accesos
INSERT INTO users (correo,contrasena,nombres,apellidos) VALUES ('programacion','w6jo/6eg6ZKtAWofXdSxbA==','Roberto','Castro');
-- contraseña: programacion
INSERT INTO roles (nombre) VALUES ('admin');


INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (1,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (2,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (3,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (4,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (5,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (6,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (7,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (8,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (9,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (10,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (11,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (12,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (13,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (14,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (15,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (16,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (17,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (18,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (19,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (20,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (21,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (22,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (23,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (24,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (25,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (26,1,1);
INSERT INTO acceso_por_rol (id_acceso,id_rol,permitido) VALUES (27,1,1);



INSERT INTO roles_por_usuario (id_user,id_rol) VALUES(1,1);


CREATE TABLE `proyecto` (
  `idproyecto` INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `nombre` VARCHAR(30), 
  `dialimite` INT(2), 
  `porcentajemora` INT(2), 
  `finca` varchar(10), 
  `folio` varchar(10), 
  `libro` varchar(10), 
  `valortipocambio` decimal, 
  `fechatipocambio` DATE, 
  `nombre_rep` varchar(60), 
  `fechanac_rep` timestamp, 
  `estadocivil_rep` varchar(1), 
  `dpi_rep` numeric(13), 
  `descripcion_rep` varchar(40), 
  `nombreedificio` varchar(40), 
  `entidadvendedora` varchar(40), 
  `fechaactanotarial` timestamp, 
  `notario` varchar(60), 
  `registro` varchar(10), 
  `folio_reg` varchar(10), 
  `libro_reg` varchar(10), 
  `fecha_reg` timestamp, 
  `area` decimal, 
  `direccion` varchar(110), 
  `fechavencimiento` timestamp, 
  `textocorreo` VARCHAR(500),
  `ModificadoPor` varchar(20), 
  `FechaModificado` timestamp, 
  `CreadoPor` varchar(20), 
  `FechaCreado` timestamp
);

-- query de sqlite para exportar tabla
/*select "insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values("||idproyecto||",'"||nombre||"',"||dialimite||","||porcentajemora||",'"||ifnull(finca,"")||"','"||ifnull(folio,"")||"','"||ifnull(libro,"")||"',"||ifnull(valortipocambio,0)||")" as query from proyecto*/


insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(1,'FABRA Ciudad Vieja',15,0.2,'1','1','1',7.8);
insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(2,'GRANAT',5,0,'','','',0);
insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(3,'NARAMA',15,5,'9351','351','939',8);
insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(4,'GRANAT Canton Exposicion',10,1,'','','',0);
insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(5,'ROQUE',0,0,'9661','161','940',7.8);
insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(6,'EL PRADO',15,0,'333','93','56',7.8);
insert into proyecto (idproyecto,nombre,dialimite,porcentajemora,finca,folio,libro,valortipocambio) values(7,'AIRALI',16,5,'9154','154','939',8);