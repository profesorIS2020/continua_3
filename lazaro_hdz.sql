-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:13306
-- Tiempo de generación: 02-11-2023 a las 16:38:16
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
-- Base de datos: `lazaro_hdz`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `logs`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `logs` ()   BEGIN 
DECLARE instructor varchar(20);
SET @bd_name = DATABASE();
SET instructor = (SELECT DISTINCT`TABLE_NAME` FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @bd_name AND COLUMNS.TABLE_NAME = 'instructor');
 -- SELECT instructor;
IF(instructor='instructor') THEN 
     INSERT INTO reg_conf  SELECT  `TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`, `ORDINAL_POSITION`, `COLUMN_DEFAULT`, `IS_NULLABLE`, `DATA_TYPE`, `NUMERIC_PRECISION`, `NUMERIC_SCALE`, `DATETIME_PRECISION`, `CHARACTER_SET_NAME`, `COLLATION_NAME`, `COLUMN_TYPE`, `COLUMN_KEY` FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @bd_name AND COLUMNS.TABLE_NAME = 'instructor';
ELSE
INSERT INTO `reg_conf`(`TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`, `ORDINAL_POSITION`, `COLUMN_DEFAULT`, `IS_NULLABLE`, `DATA_TYPE`, `NUMERIC_PRECISION`, `NUMERIC_SCALE`, `DATETIME_PRECISION`, `CHARACTER_SET_NAME`, `COLLATION_NAME`, `COLUMN_TYPE`, `COLUMN_KEY`) VALUES ('No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor','No hay tabla instructor');
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructor`
--

DROP TABLE IF EXISTS `instructor`;
CREATE TABLE IF NOT EXISTS `instructor` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  `student_name` varchar(100) DEFAULT NULL,
  `student_lastname` varchar(100) DEFAULT NULL,
  `dni` varchar(100) DEFAULT NULL,
  `user` varchar(100) NOT NULL,
  `created_in` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `instructor`
--

INSERT INTO `instructor` (`ID`, `name`, `dept_name`, `salary`, `student_name`, `student_lastname`, `dni`, `user`, `created_in`) VALUES
('10101', 'Srinivasan', 'Comp. Sci.', '65000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('12121', 'Wu', 'Finance', '90000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('15151', 'Mozart', 'Music', '40000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('22222', 'Einstein', 'Physics', '95000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('32343', 'El Said', 'History', '60000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('33456', 'Gold', 'Physics', '87000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('45565', 'Katz', 'Comp. Sci.', '75000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('58583', 'Califieri', 'History', '62000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('76543', 'Singh', 'Finance', '80000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('76766', 'Crick', 'Biology', '72000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('83821', 'Brandt', 'Comp. Sci.', '92000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05'),
('98345', 'Kim', 'Elec. Eng.', '80000.00', NULL, NULL, NULL, '', '2023-11-02 14:43:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

DROP TABLE IF EXISTS `registro`;
CREATE TABLE IF NOT EXISTS `registro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `dni` varchar(255) NOT NULL,
  `created_in` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Disparadores `registro`
--
DROP TRIGGER IF EXISTS `register`;
DELIMITER $$
CREATE TRIGGER `register` AFTER INSERT ON `registro` FOR EACH ROW BEGIN
SET @bd_name = DATABASE();
SET @record_table = (SELECT CREATE_TIME FROM information_schema.TABLES WHERE TABLE_SCHEMA = @bd_name AND TABLES.TABLE_NAME = 'instructor'); 
UPDATE instructor SET student_name = NEW.nombre, student_lastname = NEW.apellidos , dni = NEW.dni , created_in = @record_table, instructor.user = USER();

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reg_conf`
--

DROP TABLE IF EXISTS `reg_conf`;
CREATE TABLE IF NOT EXISTS `reg_conf` (
  `TABLE_SCHEMA` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_tolower_ci NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_tolower_ci NOT NULL DEFAULT '',
  `COLUMN_NAME` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_tolower_ci NOT NULL DEFAULT '',
  `ORDINAL_POSITION` int UNSIGNED NOT NULL,
  `COLUMN_DEFAULT` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `IS_NULLABLE` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `DATA_TYPE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `NUMERIC_PRECISION` bigint UNSIGNED DEFAULT NULL,
  `NUMERIC_SCALE` bigint UNSIGNED DEFAULT NULL,
  `DATETIME_PRECISION` int UNSIGNED DEFAULT NULL,
  `CHARACTER_SET_NAME` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `COLLATION_NAME` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `COLUMN_TYPE` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `COLUMN_KEY` enum('','PRI','UNI','MUL') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER $$
--
-- Eventos
--
DROP EVENT IF EXISTS `insertion_event`$$
CREATE DEFINER=`root`@`localhost` EVENT `insertion_event` ON SCHEDULE EVERY 1 MINUTE STARTS '2023-11-03 14:20:00' ENDS '2023-11-03 16:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL logs()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
