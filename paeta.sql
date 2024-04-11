-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-02-2024 a las 23:58:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

-- Modificar el script con esto
-- Create database paeta;
-- use paeta;

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAsignaturasEstado` (IN `idD` INT)   select a.idAsignatura, a.nombre as Nombre, a.idDepartamento, d.nombre as Departamento, a.estado as Estado
from asignaturas a inner join departamentos d on a.idDepartamento = d.idDepartamento 
where (a.idDepartamento = idD) AND (a.estado = "Activo")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAsignaturaXID` (IN `idA` INT)   select * from Asignaturas 
where idAsignatura  = idA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarAsignaturaXNombre` (`n` VARCHAR(50))   select * from Asignaturas
where nombre like concat ('%',n,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentoEstado` (IN `id` INT)   select estado from Departamentos
where idDepartamento = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosRegistrados` ()   select * from Departamentos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosUsuariosResgistrados` ()   select * from DepartamentosUsuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosXID` (IN `idD` INT)   select * from Departamentos where idDepartamento like (idD)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentosXNombre` (IN `n` INT(50))   select * from Departamentos where nombre like concat ('%',n,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarDepartamentoUsuariosXID` (IN `id` INT)   select * from DepartamentosUsuarios where idDepartamentosUsuarios = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMateriales` ()   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialesRegistrados` (IN `idD` INT)   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m INNER JOIN usuarios u on m.autoria = u.idUsuario 
INNER JOIN temas t on t.idTema = m.idTema
WHERE (idD = u.idDepartamento) AND (t.estado = "Activo") AND (m.estado="Activo")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialeXDepartamento` (IN `idD` INT)   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
where u.idDepartamento = idD$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialeXEstado` (IN `est` VARCHAR(50))   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
WHERE m.estado = est$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialXID` (IN `idM` INT, IN `p` INT)   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento, p as Permisos
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
where idMaterial = idM$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialXNombre` (IN `n` VARCHAR(100))   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario
INNER JOIN temas t on t.idTema = m.idTema
where (titulo = n) AND (m.estado = "Activo")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarMaterialXtema` (IN `tem` VARCHAR(100))   select m.idMaterial, m.titulo, m.descripcion, m.autoria, u.nombre as Usuario, m.duracion, m.nivel, m.idTema, t.nombre as Tema, m.espacioAlmacenamiento as espacio, m.estado as estado, u.idDepartamento as departamento
from materiales m 
INNER JOIN usuarios u on m.autoria = u.idUsuario 
INNER JOIN temas t on t.idTema = m.idTema
WHERE (m.idTema = tem) AND (m.estado = "Activo")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemasRegistrados` ()   select a.idTema, a.nombre as Nombre, a.idAsignatura, d.nombre as Asignatura, a.estado as Estado
from Temas a inner join asignaturas d on a.idAsignatura = d.idAsignatura$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemasXDepartamento` (IN `idD` INT)   select a.idTema, a.nombre as Nombre, a.idAsignatura, d.nombre as Asignatura, a.estado as Estado
from Temas a inner join asignaturas d on a.idAsignatura = d.idAsignatura 
WHERE (idD = d.idDepartamento) AND (a.estado = "Activo")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemasXNombre` (IN `n` VARCHAR(50))   select idTema as ID_Tema, nombre as Nombre, estado as Estado, idAsignatura as ID_Asignatura
from Temas
where nombre = n$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarTemaXID` (IN `idT` INT)   select idTema as ID_Tema, nombre as Nombre, estado as Estado, idAsignatura as ID_Asignatura
from Temas
where idTema = idT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuarioEstado` ()   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as 
    Correo_Electrónico, tipo as 
    Tipo, estado as Estado 
from Usuarios
WHERE estado = "Activo"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosRegistrados` ()   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as 
    Correo_Electrónico, tipo as 
    Tipo, estado as Estado 
from Usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosXID` (IN `id` INT)   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as Correo_Electrónico, 
    tipo as Tipo, 
    estado as Estado,
    idDepartamento as idDepartamento
from Usuarios where idUsuario = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuariosXNombre` (IN `n` INT(60))   select idUsuario as ID, 
	nombre as Nombre, 
    usuario as Usuario, 
    contraseña as Contraseña, 
    email as Correo_Electrónico, 
    tipo as Tipo, estado 
    as Estado
from Usuarios 
where nombre like concat("%", n, "%")$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearAsignatura` (IN `Nb` VARCHAR(20), IN `idD` INT)   insert into Asignaturas (nombre, idDepartamento) values(Nb, idD)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearDepartamento` (IN `nombre` VARCHAR(50))   insert into Departamentos(nombre) values(nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearDepartamentoUsuario` (IN `idU` INT, IN `idD` INT)   insert into DepartamentosUsuarios(
	idDepartamento,
    idUsuario
) values(idU, idD)$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearTema` (IN `n` VARCHAR(50), IN `idA` INT)   insert into Temas (nombre, idAsignatura) values (n,idA)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearUsuario` (IN `n` VARCHAR(100), IN `u` VARCHAR(100), IN `c` VARCHAR(100), IN `em` VARCHAR(100), IN `t` VARCHAR(50), IN `e` VARCHAR(10), IN `idD` INT)   insert into Usuarios(
	nombre, 
    usuario, 
    contraseña, 
    email, 
    tipo, 
    estado,
    idDepartamento
) values(n, u, c, em, t, e,idD)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarDepartamento` (IN `idD` INT)   UPDATE Departamentos
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idDepartamento = idD$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarMaterial` (IN `idM` INT)   UPDATE Materiales
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idMaterial = idM$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarTema` (IN `idT` INT)   UPDATE Temas
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idTema = idT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desactivarUsuario` (IN `idU` INT)   UPDATE Usuarios
SET estado = CASE
   WHEN estado = 'Activo' 
   THEN 'Inactivo'
   ELSE 'Activo'
END
where idUsuario = idU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarAsignatura` (IN `idA` INT)   delete from asignaturas
where idAsignatura = idA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamento` (IN `idD` INT)   BEGIN
	call eliminarDepartamentoUsuarioXIDDepartamento(idD);
	delete from departamentos
	where idDepartamento = idD;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamentoUsuario` (IN `idDU` INT)   delete from DepartamentosUsuarios
where idDepartamentosUsuarios = idDU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamentoUsuarioXIDDepartamento` (IN `idD` INT)   delete from DepartamentosUsuarios
where idDepartamento = idD$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDepartamentoUsuarioXIDUsuario` (IN `idU` INT)   delete from DepartamentosUsuarios
where idUsuario = idU$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarMaterial` (IN `idM` INT)   delete from materiales
where idMaterial = idM$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarTema` (IN `idT` INT)   delete from temas
where idTema = idT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario` (IN `idU` INT)   BEGIN
	call eliminarDepartamentoUsuarioXIDUsuario(idU);
	delete from usuarios
	where idUsuario = idU;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `imprimirAsignaturas` ()   select a.idAsignatura, a.nombre as Nombre, a.idDepartamento, d.nombre as Departamento, a.estado as Estado
from asignaturas a inner join departamentos d on a.idDepartamento = d.idDepartamento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loginUsuario` (IN `u` INT(20), IN `c` INT(20))   select idUsuario as ID, nombre as Nombre, usuario as Usuario, contraseña as Contraseña, email as Correo_Electrónico, tipo as Tipo, estado as Estado
from Usuarios where usuario = u and contraseña = c and estado = 'Activo'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarAsignatura` (IN `idA` INT, IN `Nb` VARCHAR(20), IN `idD` INT, IN `est` VARCHAR(20))   update Asignaturas
set nombre=Nb, idDepartamento=idD, estado=est
where idAsignatura = idA$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarDepartamento` (IN `idD` INT, IN `nombre` VARCHAR(50))   update Departamentos
set nombre = nombre
where idDepartamento = idD$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarMaterial` (IN `idM` INT, IN `t` VARCHAR(100), IN `des` VARCHAR(500), IN `aut` VARCHAR(100), IN `niv` VARCHAR(3), IN `dur` VARCHAR(8), IN `eA` VARCHAR(20), IN `est` VARCHAR(10))   update Materiales
set titulo = t, descripcion = des, autoria = aut, nivel = niv, duracion = dur, espacioAlmacenamiento = eA, estado = est
where idMaterial = idM$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarTema` (IN `idT` INT, IN `n` VARCHAR(50), IN `idA` INT, IN `est` VARCHAR(50))   update Temas
set nombre = n, idAsignatura = idA, estado = est
where idTema = idT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuario` (IN `id` INT, IN `n` VARCHAR(60), IN `u` VARCHAR(20), IN `c` VARCHAR(100), IN `em` VARCHAR(60), IN `t` VARCHAR(60), IN `est` VARCHAR(20), IN `idD` INT)   update Usuarios 
set nombre = n, usuario = u, contraseña = c, email = em, tipo = t,estado = est, idDepartamento = idD
where idUsuario = id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

CREATE TABLE `asignaturas` (
  `idAsignatura` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `idDepartamento` int(11) DEFAULT NULL,
  `estado` varchar(8) DEFAULT 'Activo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `departamentos` (
  `idDepartamento` int(11) NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `estado` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'Activo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `materiales` (
  `idMaterial` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `rutaAlmacenamiento` varchar(100) DEFAULT NULL,
  `espacioAlmacenamiento` int(11) DEFAULT NULL,
  `autoria` varchar(100) DEFAULT NULL,
  `duracion` varchar(8) DEFAULT NULL,
  `nivel` varchar(3) DEFAULT NULL,
  `estado` varchar(10) DEFAULT 'Activo',
  `idTema` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`idMaterial`, `titulo`, `descripcion`, `rutaAlmacenamiento`, `espacioAlmacenamiento`, `autoria`, `duracion`, `nivel`, `estado`, `idTema`) VALUES
(29, 'Cerdos', 'Extructura de los cerdos', 'uploads', 6, '6', '2 Min', '7°', 'Activo', 16),
(32, 'Node js', 'Aprende la Tecnologia de Node Js', 'uploads', 18, '4', '6 Min', '11°', 'Activo', 5),
(31, 'Ciclos', 'Funcion de los ciclos for y while', 'uploads', 8, '4', '3 Min', '10°', 'Activo', 17),
(28, 'Ganado', 'Engordamiento del ganado', 'uploads', 64, '6', '4 Min', '11°', 'Activo', 16),
(51, 'Aves Costa Rica', 'Descubre las maravillas de aves que hay en C.R', 'uploads', 8, '2', '2 Min', '8°', 'Activo', 15),
(50, 'Programacion ATS', 'Aprende a programar', 'uploads', 6, '1', '5 Min', '10°', 'Inactivo', 5),
(46, 'Pacman', 'Pacman', 'uploads', 11, '3', '3 Min', '8°', 'Activo', 14),
(53, '', '', 'uploads', 0, '1', ' Seg', '9°', 'Activo', 5),
(54, '', '', 'uploads', 0, '1', ' Seg', '7°', 'Activo', 5),
(55, '', '', 'uploads', 0, '1', ' Seg', '7°', 'Activo', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temas`
--

CREATE TABLE `temas` (
  `idTema` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `idAsignatura` int(11) DEFAULT NULL,
  `estado` varchar(8) DEFAULT 'Activo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `idDepartamento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `usuario`, `contraseña`, `email`, `tipo`, `estado`, `idDepartamento`) VALUES
(1, 'Félix Leonardo Alpízar Rojas', 'falpizar', 'f31c78ae77f4be4459', 'falpizar@casc.ed.cr', 'Normal', 'Activo', 1),
(2, 'Dilan Fabricio', 'sfabricio', 'f31c78ae77f4be4459', 'sfabricito@gmail.com', 'Normal', 'Activo', 2),
(3, 'Matthew', 'mguillen', 'f31c78ae77f4be4459', 'm@gmail.com', 'Normal', 'Activo', 8),
(4, 'Juan Diego Matute', 'jmatute', 'f31c78ae77f4be4459', 'jmatute@colegio.casc.ed.cr', 'Administrador', 'Activo', 1),
(6, 'David Pérez', 'dpérez', 'f31c78ae77f4be4459', 'dperez@gmail.com', 'Normal', 'Inactivo', 1),
(7, 'Admin', 'Admin', 'f31c78ae77f4be4459', 'falpizar@casc.ed.cr', 'Administrador', 'Activo', 15);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  ADD PRIMARY KEY (`idAsignatura`),
  ADD KEY `idDepartamento` (`idDepartamento`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`idDepartamento`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`idMaterial`),
  ADD KEY `idTema` (`idTema`);

--
-- Indices de la tabla `temas`
--
ALTER TABLE `temas`
  ADD PRIMARY KEY (`idTema`),
  ADD KEY `idAsignatura` (`idAsignatura`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignaturas`
--
ALTER TABLE `asignaturas`
  MODIFY `idAsignatura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `idDepartamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `idMaterial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `temas`
--
ALTER TABLE `temas`
  MODIFY `idTema` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
