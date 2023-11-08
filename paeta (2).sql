-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 08-11-2023 a las 14:13:57
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `paeta`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `buscarAsignaturasEstado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAsignaturasEstado` (IN `idD` INT)   select a.idAsignatura, a.nombre as Nombre, a.idDepartamento, d.nombre as Departamento, a.estado as Estado
from asignaturas a inner join departamentos d on a.idDepartamento = d.idDepartamento 
where (a.idDepartamento = idD) AND (a.estado = "Activo")$$

DROP PROCEDURE IF EXISTS `buscarAsignaturaXID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAsignaturaXID` (IN `idA` INT)   select * from Asignaturas 
where idAsignatura  = idA$$

DROP PROCEDURE IF EXISTS `buscarAsignaturaXNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAsignaturaXNombre` (`n` VARCHAR(50))   select * from Asignaturas
where nombre like concat ('%',n,'%')$$

DROP PROCEDURE IF EXISTS `buscarDepartamentoEstado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentoEstado` (IN `id` INT)   select estado from Departamentos
where idDepartamento = id$$

DROP PROCEDURE IF EXISTS `buscarDepartamentosRegistrados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosRegistrados` ()   select * from Departamentos$$

DROP PROCEDURE IF EXISTS `buscarDepartamentosUsuariosResgistrados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosUsuariosResgistrados` ()   select * from DepartamentosUsuarios$$

DROP PROCEDURE IF EXISTS `buscarDepartamentosXID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosXID` (IN `idD` INT)   select * from Departamentos where idDepartamento like (idD)$$

DROP PROCEDURE IF EXISTS `buscarDepartamentosXNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosXNombre` (IN `n` INT(50))   select * from Departamentos where nombre like concat ('%',n,'%')$$

DROP PROCEDURE IF EXISTS `buscarDepartamentoUsuariosXID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentoUsuariosXID` (IN `id` INT)   select * from DepartamentosUsuarios where idDepartamentosUsuarios = id$$

DROP PROCEDURE IF EXISTS `buscarMateriales`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMateriales` ()   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema$$

DROP PROCEDURE IF EXISTS `buscarMaterialesRegistrados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialesRegistrados` (IN `idD` INT)   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m INNER JOIN usuarios u on m.autoria = u.idUsuario 
INNER JOIN temas t on t.idTema = m.idTema
WHERE (idD = u.idDepartamento) AND (t.estado = "Activo") AND (m.estado="Activo")$$

DROP PROCEDURE IF EXISTS `buscarMaterialeXDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialeXDepartamento` (IN `idD` INT)   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
where u.idDepartamento = idD$$

DROP PROCEDURE IF EXISTS `buscarMaterialeXEstado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialeXEstado` (IN `est` VARCHAR(50))   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
WHERE m.estado = est$$

DROP PROCEDURE IF EXISTS `buscarMaterialXID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialXID` (IN `idM` INT, IN `p` INT)   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento, p as Permisos
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
where idMaterial = idM$$

DROP PROCEDURE IF EXISTS `buscarMaterialXNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialXNombre` (IN `n` VARCHAR(100))   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
where (titulo = n) AND (m.estado = "Activo")$$

DROP PROCEDURE IF EXISTS `buscarMaterialXtema`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialXtema` (IN `tem` VARCHAR(100))   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario 
INNER JOIN temas t on t.idTema = m.idTema
WHERE (m.idTema = tem) AND (m.estado = "Activo")$$

DROP PROCEDURE IF EXISTS `buscarTemasRegistrados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemasRegistrados` ()   select a.idTema, a.nombre as Nombre, a.idAsignatura, d.nombre as Asignatura, a.estado as Estado
from Temas a inner join asignaturas d on a.idAsignatura = d.idAsignatura$$

DROP PROCEDURE IF EXISTS `buscarTemasXDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemasXDepartamento` (IN `idD` INT)   select a.idTema, a.nombre as Nombre, a.idAsignatura, d.nombre as Asignatura, a.estado as Estado
from Temas a inner join asignaturas d on a.idAsignatura = d.idAsignatura 
WHERE (idD = d.idDepartamento) AND (a.estado = "Activo")$$

DROP PROCEDURE IF EXISTS `buscarTemasXNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemasXNombre` (IN `n` VARCHAR(50))   select idTema as ID_Tema, nombre as Nombre, estado as Estado, idAsignatura as ID_Asignatura
from Temas
where nombre = n$$

DROP PROCEDURE IF EXISTS `buscarTemaXID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemaXID` (IN `idT` INT)   select idTema as ID_Tema, nombre as Nombre, estado as Estado, idAsignatura as ID_Asignatura
from Temas
where idTema = idT$$

DROP PROCEDURE IF EXISTS `buscarUsuarioEstado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuarioEstado` ()   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as 
    Correo_Electrónico, tipo as 
    Tipo, estado as Estado 
from Usuarios
WHERE estado = "Activo"$$

DROP PROCEDURE IF EXISTS `buscarUsuariosRegistrados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosRegistrados` ()   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as 
    Correo_Electrónico, tipo as 
    Tipo, estado as Estado 
from Usuarios$$

DROP PROCEDURE IF EXISTS `buscarUsuariosXID`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosXID` (IN `id` INT)   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as Correo_Electrónico, 
    tipo as Tipo, 
    estado as Estado,
    idDepartamento as idDepartamento
from Usuarios where idUsuario = id$$

DROP PROCEDURE IF EXISTS `buscarUsuariosXNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosXNombre` (IN `n` INT(60))   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as Correo_Electrónico, 
    tipo as Tipo, estado 
    as Estado
from Usuarios 
where nombre like concat("%", n, "%")$$

DROP PROCEDURE IF EXISTS `buscarUsuariosXUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosXUsuario` (IN `u` VARCHAR(60))   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as Correo_Electrónico, 
    tipo as Tipo, 
    estado as Estado,
    idDepartamento as idDepartamento
from usuarios 
where LOWER(usuario) = LOWER(u)$$

DROP PROCEDURE IF EXISTS `crearAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearAsignatura` (IN `Nb` VARCHAR(20), IN `idD` INT)   insert into Asignaturas (nombre, idDepartamento) values(Nb, idD)$$

DROP PROCEDURE IF EXISTS `crearDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearDepartamento` (IN `nombre` VARCHAR(50))   insert into Departamentos(nombre) values(nombre)$$

DROP PROCEDURE IF EXISTS `crearDepartamentoUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearDepartamentoUsuario` (IN `idU` INT, IN `idD` INT)   insert into DepartamentosUsuarios(
	idDepartamento,
    idUsuario
) values(idU, idD)$$

DROP PROCEDURE IF EXISTS `crearMaterial`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearMaterial` (IN `t` VARCHAR(100), IN `des` VARCHAR(500), IN `aut` VARCHAR(100), IN `niv` VARCHAR(3), IN `dur` VARCHAR(20), IN `rA` VARCHAR(100), IN `eA` VARCHAR(20), IN `idT` INT)   insert into Materiales (
	titulo, 
    descripcion, 
    autoria, 
    nivel, 
    duracion, 
    rutaAlmacenamiento, 
    espacioAlmacenamiento,
    idTema
) values (t, des, aut, niv, dur, rA, eA, idT)$$

DROP PROCEDURE IF EXISTS `crearTema`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearTema` (IN `n` VARCHAR(50), IN `idA` INT)   insert into Temas (nombre, idAsignatura) values (n,idA)$$

DROP PROCEDURE IF EXISTS `crearUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearUsuario` (IN `n` VARCHAR(100), IN `u` VARCHAR(100), IN `c` VARCHAR(100), IN `em` VARCHAR(100), IN `t` VARCHAR(50), IN `e` VARCHAR(10), IN `idD` INT)   insert into Usuarios(
	nombre, 
    usuario, 
    contraseña, 
    email, 
    tipo, 
    estado,
    idDepartamento
) values(n, u, c, em, t, e,idD)$$

DROP PROCEDURE IF EXISTS `desactivarDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarDepartamento` (IN `idD` INT)   UPDATE Departamentos
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idDepartamento = idD$$

DROP PROCEDURE IF EXISTS `desactivarMaterial`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarMaterial` (IN `idM` INT)   UPDATE Materiales
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idMaterial = idM$$

DROP PROCEDURE IF EXISTS `desactivarTema`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarTema` (IN `idT` INT)   UPDATE Temas
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idTema = idT$$

DROP PROCEDURE IF EXISTS `desactivarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarUsuario` (IN `idU` INT)   UPDATE Usuarios
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idUsuario = idU$$

DROP PROCEDURE IF EXISTS `eliminarAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarAsignatura` (IN `idA` INT)   delete from asignaturas
where idAsignatura = idA$$

DROP PROCEDURE IF EXISTS `eliminarDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamento` (IN `idD` INT)   BEGIN
	call eliminarDepartamentoUsuarioXIDDepartamento(idD);
	delete from departamentos
	where idDepartamento = idD;
    
END$$

DROP PROCEDURE IF EXISTS `eliminarDepartamentoUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamentoUsuario` (IN `idDU` INT)   delete from DepartamentosUsuarios
where idDepartamentosUsuarios = idDU$$

DROP PROCEDURE IF EXISTS `eliminarDepartamentoUsuarioXIDDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamentoUsuarioXIDDepartamento` (IN `idD` INT)   delete from DepartamentosUsuarios
where idDepartamento = idD$$

DROP PROCEDURE IF EXISTS `eliminarDepartamentoUsuarioXIDUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamentoUsuarioXIDUsuario` (IN `idU` INT)   delete from DepartamentosUsuarios
where idUsuario = idU$$

DROP PROCEDURE IF EXISTS `eliminarMaterial`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarMaterial` (IN `idM` INT)   delete from materiales
where idMaterial = idM$$

DROP PROCEDURE IF EXISTS `eliminarTema`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarTema` (IN `idT` INT)   delete from temas
where idTema = idT$$

DROP PROCEDURE IF EXISTS `eliminarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario` (IN `idU` INT)   BEGIN
	call eliminarDepartamentoUsuarioXIDUsuario(idU);
	delete from usuarios
	where idUsuario = idU;
    
END$$

DROP PROCEDURE IF EXISTS `imprimirAsignaturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `imprimirAsignaturas` ()   select a.idAsignatura, a.nombre as Nombre, a.idDepartamento, d.nombre as Departamento, a.estado as Estado
from asignaturas a inner join departamentos d on a.idDepartamento = d.idDepartamento$$

DROP PROCEDURE IF EXISTS `loginUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `loginUsuario` (IN `u` INT(20), IN `c` INT(20))   select idUsuario as ID, nombre as Nombre, usuario as Usuario, contraseña as Contraseña, email as Correo_Electrónico, tipo as Tipo, estado as Estado
from Usuarios where usuario = u and contraseña = c and estado = 'Activo'$$

DROP PROCEDURE IF EXISTS `modificarAsignatura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarAsignatura` (IN `idA` INT, IN `Nb` VARCHAR(20), IN `idD` INT, IN `est` VARCHAR(20))   update Asignaturas
set nombre=Nb, idDepartamento=idD, estado=est
where idAsignatura = idA$$

DROP PROCEDURE IF EXISTS `modificarDepartamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarDepartamento` (IN `idD` INT, IN `nombre` VARCHAR(50))   update Departamentos
set nombre = nombre
where idDepartamento = idD$$

DROP PROCEDURE IF EXISTS `modificarMaterial`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarMaterial` (IN `idM` INT, IN `t` VARCHAR(100), IN `des` VARCHAR(500), IN `aut` VARCHAR(100), IN `niv` VARCHAR(3), IN `dur` VARCHAR(8), IN `eA` VARCHAR(20), IN `est` VARCHAR(10))   update Materiales
set titulo = t, descripcion = des, autoria = aut, nivel = niv, duracion = dur, espacioAlmacenamiento = eA, estado = est
where idMaterial = idM$$

DROP PROCEDURE IF EXISTS `modificarTema`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarTema` (IN `idT` INT, IN `n` VARCHAR(50), IN `idA` INT, IN `est` VARCHAR(50))   update Temas
set nombre = n, idAsignatura = idA, estado = est
where idTema = idT$$

DROP PROCEDURE IF EXISTS `modificarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuario` (IN `id` INT, IN `n` VARCHAR(60), IN `u` VARCHAR(20), IN `c` VARCHAR(100), IN `em` VARCHAR(60), IN `t` VARCHAR(60), IN `est` VARCHAR(20), IN `idD` INT)   update Usuarios 
set nombre = n, usuario = u, contraseña = c, email = em, tipo = t,estado = est, idDepartamento = idD
where idUsuario = id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

DROP TABLE IF EXISTS `asignaturas`;
CREATE TABLE IF NOT EXISTS `asignaturas` (
  `idAsignatura` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) DEFAULT NULL,
  `idDepartamento` int DEFAULT NULL,
  `estado` varchar(8) DEFAULT 'Activo',
  PRIMARY KEY (`idAsignatura`),
  KEY `idDepartamento` (`idDepartamento`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `asignaturas`
--

INSERT INTO `asignaturas` (`idAsignatura`, `nombre`, `idDepartamento`, `estado`) VALUES
(2, 'PROGRAMACION 11', 1, 'Activo'),
(3, 'GUIADO TURISTICO 11', 2, 'Activo'),
(4, 'GANADERIA LECHE', 3, 'Activo'),
(6, 'Manejo de comida', 8, 'Activo'),
(8, 'Diseño Grafico', 1, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE IF NOT EXISTS `departamentos` (
  `idDepartamento` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `estado` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`idDepartamento`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`idDepartamento`, `nombre`, `estado`) VALUES
(1, 'Informática', 'Activo'),
(2, 'Turismo', 'Activo'),
(3, 'Agropecuaria', 'Activo'),
(8, 'Agroindustria', 'Activo'),
(15, 'Administrador', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

DROP TABLE IF EXISTS `materiales`;
CREATE TABLE IF NOT EXISTS `materiales` (
  `idMaterial` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `rutaAlmacenamiento` varchar(100) DEFAULT NULL,
  `espacioAlmacenamiento` int DEFAULT NULL,
  `autoria` varchar(100) DEFAULT NULL,
  `duracion` varchar(8) DEFAULT NULL,
  `nivel` varchar(3) DEFAULT NULL,
  `estado` varchar(10) DEFAULT 'Activo',
  `idTema` int DEFAULT NULL,
  PRIMARY KEY (`idMaterial`),
  KEY `idTema` (`idTema`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`idMaterial`, `titulo`, `descripcion`, `rutaAlmacenamiento`, `espacioAlmacenamiento`, `autoria`, `duracion`, `nivel`, `estado`, `idTema`) VALUES
(29, 'Cerdos', 'Extructura de los cerdos', 'uploads', 6, '6', '2 Min', '7°', 'Activo', 16),
(32, 'Node js', 'Aprende la Tecnologia de Node Js', 'uploads', 18, '4', '6 Min', '11°', 'Inactivo', 5),
(31, 'Ciclos', 'Funcion de los ciclos for y while', 'uploads', 8, '4', '3 Min', '10°', 'Activo', 17),
(28, 'Ganado', 'Engordamiento del ganado', 'uploads', 64, '6', '4 Min', '11°', 'Activo', 16),
(51, 'Aves Costa Rica', 'Descubre las maravillas de aves que hay en C.R', 'uploads', 8, '2', '2 Min', '8°', 'Activo', 15),
(50, 'Programacion ATS', 'Aprende a programar', 'uploads', 6, '1', '5 Min', '10°', 'Inactivo', 5),
(46, 'Pacman', 'Pacman', 'uploads', 11, '3', '3 Min', '8°', 'Activo', 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temas`
--

DROP TABLE IF EXISTS `temas`;
CREATE TABLE IF NOT EXISTS `temas` (
  `idTema` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `idAsignatura` int DEFAULT NULL,
  `estado` varchar(8) DEFAULT 'Activo',
  PRIMARY KEY (`idTema`),
  KEY `idAsignatura` (`idAsignatura`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `temas`
--

INSERT INTO `temas` (`idTema`, `nombre`, `idAsignatura`, `estado`) VALUES
(5, 'Python', 2, 'Activo'),
(15, 'Aves', 3, 'Activo'),
(14, 'Enlatados', 6, 'Activo'),
(16, 'Extructura del ganado', 4, 'Activo'),
(17, 'Java', 2, 'Activo'),
(18, 'Manejo de fincas', 4, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `idDepartamento` int NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `usuario`, `contraseña`, `email`, `tipo`, `estado`, `idDepartamento`) VALUES
(1, 'Félix Leonardo Alpízar Rojas', 'falpizar', 'f31c78ae77f4be4459', 'falpizar@casc.ed.cr', 'Normal', 'Activo', 1),
(2, 'Dilan Fabricio', 'sfabricio', 'f31c78ae77f4be4459', 'sfabricito@gmail.com', 'Normal', 'Activo', 2),
(3, 'Matthew', 'mguillen', 'f31c78ae77f4be4459', 'm@gmail.com', 'Normal', 'Activo', 8),
(4, 'Juan Diego Matute', 'jmatute', 'f31c78ae77f4be4459', 'jmatute@colegio.casc.ed.cr', 'Normal', 'Activo', 1),
(6, 'David Pérez', 'dpérez', 'f31c78ae77f4be4459', 'dperez@gmail.com', 'Normal', 'Activo', 3),
(7, 'Admin', 'Admin', 'f31c78ae77f4be4459', 'falpizar@casc.ed.cr', 'Administrador', 'Activo', 15);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
