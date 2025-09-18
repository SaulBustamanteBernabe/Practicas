-- phpMyAdmin SQL Dump
-- version 5.2.2deb1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-09-2025 a las 00:26:34
-- Versión del servidor: 11.8.3-MariaDB-0+deb13u1 from Debian
-- Versión de PHP: 8.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `incidencias_escuela`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser` (IN `name` TEXT, IN `matricula` INT, IN `pass` TEXT, IN `genero` TEXT, IN `email` TEXT, IN `telefono` TEXT, IN `direccion` TEXT)   BEGIN
	INSERT INTO `Users`(`tFullNameUser`, `eMatricula`, `tPassword`, `tGenero`, `tCorreoInstitucional`, `tTelefono`, `tDireccion`)
    VALUES (name, matricula, pass, genero, email, telefono, direccion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()   BEGIN
	SELECT 
    	`eCodUser`,
        `tFullNameUser`,
        `eMatricula`,
        `tGenero`,
        `tCorreoInstitucional`,
        `tTelefono`,
        `tDireccion`
	FROM `Users`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById` (IN `pUserId` INT)   BEGIN
	SELECT 
    	`eCodUser`,
        `tFullNameUser`,
        `eMatricula`,
        `tGenero`,
        `tCorreoInstitucional`,
        `tTelefono`,
        `tDireccion`
	FROM `Users`
    WHERE `eCodUser` = `pUserId`;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Afectados`
--

CREATE TABLE `Afectados` (
  `fkeCodIncidencia` int(11) NOT NULL,
  `fkeCodUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE `aula` (
  `eCodAula` int(11) NOT NULL,
  `tNameAula` text NOT NULL,
  `fkeCodGrado` int(11) NOT NULL,
  `fkeCodGrupo` int(11) NOT NULL,
  `fkeCodTypeClassroom` int(11) NOT NULL,
  `fhCreatedAula` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateAula` datetime DEFAULT NULL,
  `bStateAula` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Carrera`
--

CREATE TABLE `Carrera` (
  `eCodCarrera` int(11) NOT NULL,
  `tNameCarrera` text NOT NULL,
  `fkeCodFacultad` int(11) NOT NULL,
  `fkeCodUser` int(11) NOT NULL,
  `fhCreatedCarrera` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateCarrera` datetime DEFAULT NULL,
  `bStateCarrera` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Causantes`
--

CREATE TABLE `Causantes` (
  `fkeCodIncidencia` int(11) NOT NULL,
  `fkeCodUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ciclo`
--

CREATE TABLE `Ciclo` (
  `eCodCiclo` int(11) NOT NULL,
  `tNameCiclo` text NOT NULL,
  `thCreatedCiclo` datetime NOT NULL DEFAULT current_timestamp(),
  `thUpdateCiclo` datetime DEFAULT NULL,
  `bStateCiclo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Facultad`
--

CREATE TABLE `Facultad` (
  `eCodFacultad` int(11) NOT NULL,
  `tNameFacultad` text NOT NULL,
  `fhCreatedFacultad` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateFacultad` datetime DEFAULT NULL,
  `bStateFacultad` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Grado`
--

CREATE TABLE `Grado` (
  `eCodGrado` int(11) NOT NULL,
  `tNameGrado` text NOT NULL,
  `fhCreatedGrado` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateGrado` datetime DEFAULT NULL,
  `bStateGrado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Gravedad`
--

CREATE TABLE `Gravedad` (
  `eCodGravedad` int(11) NOT NULL,
  `tNameGravedad` text NOT NULL,
  `fhCreatedGravedad` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateGravedad` datetime DEFAULT NULL,
  `bStateGravedad` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Gravedad`
--

INSERT INTO `Gravedad` (`eCodGravedad`, `tNameGravedad`, `fhCreatedGravedad`, `fhUpdateGravedad`, `bStateGravedad`) VALUES
(1, 'Baja', '2025-09-11 18:11:19', NULL, 1),
(2, 'Media', '2025-09-11 18:11:19', NULL, 1),
(3, 'Alta', '2025-09-11 18:11:19', NULL, 1),
(4, 'Critica', '2025-09-11 18:11:19', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Grupo`
--

CREATE TABLE `Grupo` (
  `eCodGrupo` int(11) NOT NULL,
  `tNameGrupo` text NOT NULL,
  `fkeCodCarrera` int(11) NOT NULL,
  `fkeCodUser` int(11) NOT NULL,
  `fhCreateGrupo` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateGrupo` int(11) DEFAULT NULL,
  `bStateGrupo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Horario`
--

CREATE TABLE `Horario` (
  `eCodHorario` int(11) NOT NULL,
  `fkeCodCiclo` int(11) NOT NULL,
  `fkeCodAsigMat` int(11) NOT NULL,
  `eDiaSemana` int(11) NOT NULL,
  `hHoraInicioClase` time NOT NULL,
  `hHoraFinClase` time NOT NULL,
  `fkeCodAula` int(11) NOT NULL,
  `fkeCodUsers` int(11) NOT NULL,
  `thCreatedHorario` datetime NOT NULL DEFAULT current_timestamp(),
  `thUpdateHorario` datetime DEFAULT NULL,
  `bStateHorario` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Incidencias`
--

CREATE TABLE `Incidencias` (
  `eCodIncidencia` int(11) NOT NULL,
  `fkeCodTypeIssue` int(11) NOT NULL,
  `fkeCodAula` int(11) NOT NULL,
  `fkeCodGravedad` int(11) NOT NULL,
  `fkeCodUsers_Registra` int(11) NOT NULL,
  `fhFechaHoraOcurrencia` datetime NOT NULL,
  `tDescripcion` text NOT NULL,
  `tEstadoIncidencia` enum('POR REVISAR','REVISADA','CANCELADA','') NOT NULL,
  `fkeCodUsers_AQuienReporta` int(11) NOT NULL,
  `fkeCodUsers_QuienRegistra` int(11) NOT NULL,
  `fhCreatedIncidencia` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateIncidencia` datetime DEFAULT NULL,
  `bStateIncidencia` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Logs`
--

CREATE TABLE `Logs` (
  `eCodLogs` int(11) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Materias`
--

CREATE TABLE `Materias` (
  `eCodMateria` int(11) NOT NULL,
  `tNameMateria` text NOT NULL,
  `thCreatedMateria` datetime NOT NULL DEFAULT current_timestamp(),
  `thUpdateMateria` datetime DEFAULT NULL,
  `bStateMateria` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MateriasAsignacion`
--

CREATE TABLE `MateriasAsignacion` (
  `eCodAsigMat` int(11) NOT NULL,
  `fkeCodMat` int(11) NOT NULL,
  `fkeCodUsers` int(11) NOT NULL,
  `eNumHorasClase` int(11) NOT NULL,
  `thCreatedAsigMat` datetime NOT NULL DEFAULT current_timestamp(),
  `thUpdateAsigMat` datetime DEFAULT NULL,
  `bStateAsigMat` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RelUserType`
--

CREATE TABLE `RelUserType` (
  `fkeCodUsers` int(11) NOT NULL,
  `fkeCodTypeUsers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `typeClassroom`
--

CREATE TABLE `typeClassroom` (
  `eCodTypeClassroom` int(11) NOT NULL,
  `tNameTypeClassroom` text NOT NULL,
  `fhCreatedTypeClassroom` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateTypeClassroom` datetime DEFAULT NULL,
  `bStateTypeClassroom` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `typeIssues`
--

CREATE TABLE `typeIssues` (
  `eCodTypeIssues` int(11) NOT NULL,
  `tNameTypeIssues` text NOT NULL,
  `tDescriptionTypeIssues` text NOT NULL,
  `fhCreatedTypeIssues` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateTypeIssues` datetime DEFAULT NULL,
  `bStateTypeIssues` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `typeUsers`
--

CREATE TABLE `typeUsers` (
  `eCodTypeUsers` int(11) NOT NULL,
  `tNameTypeUsers` text NOT NULL,
  `fhCreatedTypeUsers` datetime NOT NULL DEFAULT current_timestamp(),
  `fhUpdateTypeUsers` datetime DEFAULT NULL,
  `bStateTypeUsers` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Users`
--

CREATE TABLE `Users` (
  `eCodUser` int(11) NOT NULL,
  `tFullNameUser` text NOT NULL,
  `eMatricula` int(11) NOT NULL,
  `tPassword` text NOT NULL,
  `tGenero` text NOT NULL,
  `tCorreoInstitucional` text NOT NULL,
  `tTelefono` text NOT NULL,
  `tDireccion` text NOT NULL,
  `bStateUser` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `Users`
--

INSERT INTO `Users` (`eCodUser`, `tFullNameUser`, `eMatricula`, `tPassword`, `tGenero`, `tCorreoInstitucional`, `tTelefono`, `tDireccion`, `bStateUser`) VALUES
(1, 'Saúl Bustamante Bernabe', 20226000, '151515', 'Masculino', 'sbustamante@ucol.mx', '3143372383', 'Casa', 1),
(2, 'Alejandro Jeronimo Azamar', 20191012, '191919', 'No Binario, es un helicóptero de combate', 'ajeronimo@ucol.mx', '3141000104', 'Colonia del pacifico, en las brisas c.p. 28218', 1),
(3, 'Citlaly Estefania Samano Lopez', 20181126, '090909', 'Femenino', 'csamano@ucol.mx', '3141650597', 'Casa Centro 1', 1),
(4, 'Angel Gabriel Diaz Ramirez', 20190966, '764733', 'Masculino', 'adiaz@ucol.mx', '3141627605', 'Por la bimbo', 1),
(5, 'NombrePruebaB_PUT', 20102010, '$2b$10$gSaemUe55rtzQmY6PqvKj.Ol.eHP27EWDLFq30OckMLVgRQIlZM5G', 'Genero123', 'qwerty_put@ucol.mx', '3141001234', 'CasaEjemplo', 0),
(6, 'NombrePruebaB_PUT', 20102010, '$2b$10$11.I88GVPvQPynCNh726YeMbp1xg6pOqSw5jYOPxrTK/cwyqEN3V.', 'Genero123', 'qwerty_put@ucol.mx', '3141001234', 'CasaEjemplo', 0),
(7, 'NAME', 101010, 'PASS', 'GEN', 'EMAIL', 'TELEFONO', 'DIRECCION', 1),
(8, 'NombrePruebaC_SP', 10101010, '$2b$10$fEr3trttWJ.Ahx7vjsq63.FtKtCSgAybzqwyEFwgb5WNd4kdL3lIi', 'Genero123_SP', 'qwerty_SP@ucol.mx', '3141001234_SP', 'CasaEjemplo_SP', 1),
(9, 'NombrePruebaX_Editado', 20102019, '$2b$10$kZwkKIzO3YPIAZsTYULnruD9QQCrg.zc8qmfNEs0cQ2z16AKN2yRa', 'Genero123', 'qwerty_put123@ucol.mx', '3141001234', 'CasaEjemplo', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Afectados`
--
ALTER TABLE `Afectados`
  ADD KEY `fkeCodIncidencia` (`fkeCodIncidencia`,`fkeCodUser`),
  ADD KEY `fkeCodUser` (`fkeCodUser`);

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`eCodAula`),
  ADD UNIQUE KEY `fkeCodGrado` (`fkeCodGrado`),
  ADD UNIQUE KEY `fkeCodGrupo` (`fkeCodGrupo`),
  ADD UNIQUE KEY `fkeCodTypeClassroom` (`fkeCodTypeClassroom`);

--
-- Indices de la tabla `Carrera`
--
ALTER TABLE `Carrera`
  ADD PRIMARY KEY (`eCodCarrera`),
  ADD UNIQUE KEY `fkeCodFacultad` (`fkeCodFacultad`),
  ADD UNIQUE KEY `fkeCodUser` (`fkeCodUser`);

--
-- Indices de la tabla `Causantes`
--
ALTER TABLE `Causantes`
  ADD KEY `fkeCodIncidencia` (`fkeCodIncidencia`,`fkeCodUser`),
  ADD KEY `fkeCodUser` (`fkeCodUser`);

--
-- Indices de la tabla `Ciclo`
--
ALTER TABLE `Ciclo`
  ADD PRIMARY KEY (`eCodCiclo`);

--
-- Indices de la tabla `Facultad`
--
ALTER TABLE `Facultad`
  ADD PRIMARY KEY (`eCodFacultad`);

--
-- Indices de la tabla `Grado`
--
ALTER TABLE `Grado`
  ADD PRIMARY KEY (`eCodGrado`);

--
-- Indices de la tabla `Gravedad`
--
ALTER TABLE `Gravedad`
  ADD PRIMARY KEY (`eCodGravedad`);

--
-- Indices de la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD PRIMARY KEY (`eCodGrupo`),
  ADD UNIQUE KEY `fkeCodCarrera` (`fkeCodCarrera`),
  ADD UNIQUE KEY `fkeCodUser` (`fkeCodUser`);

--
-- Indices de la tabla `Horario`
--
ALTER TABLE `Horario`
  ADD PRIMARY KEY (`eCodHorario`),
  ADD UNIQUE KEY `fkeCodCiclo` (`fkeCodCiclo`),
  ADD UNIQUE KEY `fkeCodAsigMat` (`fkeCodAsigMat`),
  ADD UNIQUE KEY `fkeCodAula` (`fkeCodAula`),
  ADD UNIQUE KEY `fkeCodUsers` (`fkeCodUsers`);

--
-- Indices de la tabla `Incidencias`
--
ALTER TABLE `Incidencias`
  ADD PRIMARY KEY (`eCodIncidencia`),
  ADD KEY `fkeCodTypeIssue` (`fkeCodTypeIssue`),
  ADD KEY `fkeCodAula` (`fkeCodAula`),
  ADD KEY `fkeCodGravedad` (`fkeCodGravedad`),
  ADD KEY `fkeCodUsers_Registra` (`fkeCodUsers_Registra`),
  ADD KEY `fkeCodUsers_AQuienReporta` (`fkeCodUsers_AQuienReporta`),
  ADD KEY `fkeCodUsers_QuienRegistra` (`fkeCodUsers_QuienRegistra`);

--
-- Indices de la tabla `Logs`
--
ALTER TABLE `Logs`
  ADD PRIMARY KEY (`eCodLogs`);

--
-- Indices de la tabla `Materias`
--
ALTER TABLE `Materias`
  ADD PRIMARY KEY (`eCodMateria`);

--
-- Indices de la tabla `MateriasAsignacion`
--
ALTER TABLE `MateriasAsignacion`
  ADD PRIMARY KEY (`eCodAsigMat`),
  ADD UNIQUE KEY `fkeCodMat` (`fkeCodMat`),
  ADD UNIQUE KEY `fkeCodUsers` (`fkeCodUsers`);

--
-- Indices de la tabla `RelUserType`
--
ALTER TABLE `RelUserType`
  ADD KEY `fkeCodUsers` (`fkeCodUsers`,`fkeCodTypeUsers`),
  ADD KEY `fkeCodTypeUsers` (`fkeCodTypeUsers`);

--
-- Indices de la tabla `typeClassroom`
--
ALTER TABLE `typeClassroom`
  ADD PRIMARY KEY (`eCodTypeClassroom`);

--
-- Indices de la tabla `typeIssues`
--
ALTER TABLE `typeIssues`
  ADD PRIMARY KEY (`eCodTypeIssues`);

--
-- Indices de la tabla `typeUsers`
--
ALTER TABLE `typeUsers`
  ADD PRIMARY KEY (`eCodTypeUsers`);

--
-- Indices de la tabla `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`eCodUser`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aula`
--
ALTER TABLE `aula`
  MODIFY `eCodAula` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Carrera`
--
ALTER TABLE `Carrera`
  MODIFY `eCodCarrera` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Ciclo`
--
ALTER TABLE `Ciclo`
  MODIFY `eCodCiclo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Facultad`
--
ALTER TABLE `Facultad`
  MODIFY `eCodFacultad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Grado`
--
ALTER TABLE `Grado`
  MODIFY `eCodGrado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Gravedad`
--
ALTER TABLE `Gravedad`
  MODIFY `eCodGravedad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `Grupo`
--
ALTER TABLE `Grupo`
  MODIFY `eCodGrupo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Horario`
--
ALTER TABLE `Horario`
  MODIFY `eCodHorario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Incidencias`
--
ALTER TABLE `Incidencias`
  MODIFY `eCodIncidencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Logs`
--
ALTER TABLE `Logs`
  MODIFY `eCodLogs` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Materias`
--
ALTER TABLE `Materias`
  MODIFY `eCodMateria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `MateriasAsignacion`
--
ALTER TABLE `MateriasAsignacion`
  MODIFY `eCodAsigMat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `typeClassroom`
--
ALTER TABLE `typeClassroom`
  MODIFY `eCodTypeClassroom` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `typeIssues`
--
ALTER TABLE `typeIssues`
  MODIFY `eCodTypeIssues` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `typeUsers`
--
ALTER TABLE `typeUsers`
  MODIFY `eCodTypeUsers` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Users`
--
ALTER TABLE `Users`
  MODIFY `eCodUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Afectados`
--
ALTER TABLE `Afectados`
  ADD CONSTRAINT `Afectados_ibfk_1` FOREIGN KEY (`fkeCodIncidencia`) REFERENCES `Incidencias` (`eCodIncidencia`) ON DELETE CASCADE,
  ADD CONSTRAINT `Afectados_ibfk_2` FOREIGN KEY (`fkeCodUser`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `aula`
--
ALTER TABLE `aula`
  ADD CONSTRAINT `aula_ibfk_1` FOREIGN KEY (`fkeCodGrado`) REFERENCES `Grado` (`eCodGrado`) ON DELETE CASCADE,
  ADD CONSTRAINT `aula_ibfk_2` FOREIGN KEY (`fkeCodGrupo`) REFERENCES `Grupo` (`eCodGrupo`) ON DELETE CASCADE,
  ADD CONSTRAINT `aula_ibfk_3` FOREIGN KEY (`fkeCodTypeClassroom`) REFERENCES `typeClassroom` (`eCodTypeClassroom`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Carrera`
--
ALTER TABLE `Carrera`
  ADD CONSTRAINT `Carrera_ibfk_1` FOREIGN KEY (`fkeCodFacultad`) REFERENCES `Facultad` (`eCodFacultad`) ON DELETE CASCADE,
  ADD CONSTRAINT `Carrera_ibfk_2` FOREIGN KEY (`fkeCodUser`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Causantes`
--
ALTER TABLE `Causantes`
  ADD CONSTRAINT `Causantes_ibfk_1` FOREIGN KEY (`fkeCodIncidencia`) REFERENCES `Incidencias` (`eCodIncidencia`) ON DELETE CASCADE,
  ADD CONSTRAINT `Causantes_ibfk_2` FOREIGN KEY (`fkeCodUser`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Grupo`
--
ALTER TABLE `Grupo`
  ADD CONSTRAINT `Grupo_ibfk_1` FOREIGN KEY (`fkeCodCarrera`) REFERENCES `Carrera` (`eCodCarrera`) ON DELETE CASCADE,
  ADD CONSTRAINT `Grupo_ibfk_2` FOREIGN KEY (`fkeCodUser`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Horario`
--
ALTER TABLE `Horario`
  ADD CONSTRAINT `Horario_ibfk_1` FOREIGN KEY (`fkeCodCiclo`) REFERENCES `Ciclo` (`eCodCiclo`) ON DELETE CASCADE,
  ADD CONSTRAINT `Horario_ibfk_2` FOREIGN KEY (`fkeCodAsigMat`) REFERENCES `MateriasAsignacion` (`eCodAsigMat`) ON DELETE CASCADE,
  ADD CONSTRAINT `Horario_ibfk_3` FOREIGN KEY (`fkeCodAula`) REFERENCES `aula` (`eCodAula`) ON DELETE CASCADE,
  ADD CONSTRAINT `Horario_ibfk_4` FOREIGN KEY (`fkeCodUsers`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Incidencias`
--
ALTER TABLE `Incidencias`
  ADD CONSTRAINT `Incidencias_ibfk_1` FOREIGN KEY (`fkeCodTypeIssue`) REFERENCES `typeIssues` (`eCodTypeIssues`) ON DELETE CASCADE,
  ADD CONSTRAINT `Incidencias_ibfk_2` FOREIGN KEY (`fkeCodAula`) REFERENCES `aula` (`eCodAula`) ON DELETE CASCADE,
  ADD CONSTRAINT `Incidencias_ibfk_3` FOREIGN KEY (`fkeCodGravedad`) REFERENCES `Gravedad` (`eCodGravedad`) ON DELETE CASCADE,
  ADD CONSTRAINT `Incidencias_ibfk_4` FOREIGN KEY (`fkeCodUsers_Registra`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE,
  ADD CONSTRAINT `Incidencias_ibfk_5` FOREIGN KEY (`fkeCodUsers_AQuienReporta`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE,
  ADD CONSTRAINT `Incidencias_ibfk_6` FOREIGN KEY (`fkeCodUsers_QuienRegistra`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `MateriasAsignacion`
--
ALTER TABLE `MateriasAsignacion`
  ADD CONSTRAINT `MateriasAsignacion_ibfk_1` FOREIGN KEY (`fkeCodMat`) REFERENCES `Materias` (`eCodMateria`) ON DELETE CASCADE,
  ADD CONSTRAINT `MateriasAsignacion_ibfk_2` FOREIGN KEY (`fkeCodUsers`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;

--
-- Filtros para la tabla `RelUserType`
--
ALTER TABLE `RelUserType`
  ADD CONSTRAINT `RelUserType_ibfk_1` FOREIGN KEY (`fkeCodTypeUsers`) REFERENCES `typeUsers` (`eCodTypeUsers`) ON DELETE CASCADE,
  ADD CONSTRAINT `RelUserType_ibfk_2` FOREIGN KEY (`fkeCodUsers`) REFERENCES `Users` (`eCodUser`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
