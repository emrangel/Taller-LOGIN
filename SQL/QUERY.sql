DROP TABLES IF EXISTS  `tablas`.`guarderias`, `tablas`.`cuidador`, `tablas`.`perro`, `tablas`.`usuario`;

CREATE TABLE `tablas`.`guarderias` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Telefono` varchar(14) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
);

CREATE TABLE `tablas`.`cuidador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `telefono` varchar(14) NOT NULL,
  `ID_Guarderia` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_ciudador_guarderia_idx` (`ID_Guarderia`),
  CONSTRAINT `fk_ciudador_guarderia` FOREIGN KEY (`ID_Guarderia`) REFERENCES `guarderias` (`ID`)
);

CREATE TABLE `tablas`.`perro` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `raza` varchar(45) NOT NULL,
  `edad` decimal(4,0) NOT NULL,
  `peso` int NOT NULL,
  `ID_Guarderia` int DEFAULT NULL,
  `ID_Cuidador` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_perro_guarderia_idx` (`ID_Guarderia`),
  KEY `fk_perro_cuidador_idx` (`ID_Cuidador`),
  CONSTRAINT `fk_perro_cuidador` FOREIGN KEY (`ID_Cuidador`) REFERENCES `cuidador` (`ID`),
  CONSTRAINT `fk_perro_guarderia` FOREIGN KEY (`ID_Guarderia`) REFERENCES `guarderias` (`ID`)
);

CREATE TABLE `tablas`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alias` VARCHAR(45) NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  `es_admin` INT NOT NULL,
  PRIMARY KEY (`id`));

INSERT INTO `tablas`.guarderias (Nombre, Direccion, Telefono) VALUES('La favorita', 'Carrera 15#78-8', '573125345687');
INSERT INTO `tablas`.guarderias (Nombre, Direccion, Telefono) VALUES('Pet care', 'Calle 125#25-98', '57314568987');

INSERT INTO `tablas`.cuidador (Nombre, Telefono, ID_Guarderia) VALUES('Johnathan Cortés', '57325689858', 1);
INSERT INTO `tablas`.cuidador (Nombre, Telefono, ID_Guarderia) VALUES('Juliana Mejía', '5732025698745', 1);
INSERT INTO `tablas`.cuidador (Nombre, Telefono, ID_Guarderia) VALUES('Carlos Medina', '573025265987', 2);

INSERT INTO `tablas`.perro (nombre, raza, peso, edad, ID_Guarderia, ID_cuidador) VALUES('Hanna', 'Beagle', 3.6, 1, 1, 1);
INSERT INTO `tablas`.perro (nombre, raza, peso, edad, ID_Guarderia, ID_cuidador) VALUES('Max', 'Boston Terrier', 6.0, 2, 1, 1);
INSERT INTO `tablas`.perro (nombre, raza, peso, edad, ID_Guarderia, ID_cuidador) VALUES('Lassie', 'Bulldog', 8.2, 2, 1, 2);
INSERT INTO `tablas`.perro (nombre, raza, peso, edad, ID_Guarderia, ID_cuidador) VALUES('Luky', 'Bretón', 2.2, 1, 1, 1);
INSERT INTO `tablas`.perro (nombre, raza, peso, edad, ID_Guarderia, ID_cuidador) VALUES('Lassie', 'Bulldog', 10.0, 3, 1, 2);
INSERT INTO `tablas`.perro (nombre, raza, peso, edad, ID_Guarderia, ID_cuidador) VALUES('Suki', 'yorkie', 1.2, 5, 2, 1);

INSERT INTO `tablas`.usuario (id, `alias`, `contrasena`, `es_admin`) VALUES (1, 'admin', '123', 1);
INSERT INTO `tablas`.usuario (id, `alias`, `contrasena`, `es_admin`) VALUES (2, 'administrator', '234', 1);
INSERT INTO `tablas`.usuario (id, `alias`, `contrasena`, `es_admin`) VALUES (3, 'user1', '345', 0);
INSERT INTO `tablas`.usuario (id, `alias`, `contrasena`, `es_admin`) VALUES (4, 'user2', '456', 0);