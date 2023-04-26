-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           11.1.0-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela vorpv2.respeito
CREATE TABLE IF NOT EXISTS `respeito` (
  `id` varchar(255) NOT NULL,
  `respeito` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela vorpv2.respeito: ~25 rows (aproximadamente)
DELETE FROM `respeito`;
INSERT INTO `respeito` (`id`, `respeito`) VALUES
	('steam:110000104d521c0', 0),
	('steam:11000010720fa52', 2),
	('steam:11000010797f8c3', 0),
	('steam:110000109bd4226', 0),
	('steam:11000010a606efd', 0),
	('steam:11000010b240afe', 0),
	('steam:11000010b988574', -7),
	('steam:11000010f8af77c', 0),
	('steam:110000110c8b484', 0),
	('steam:1100001167fb416', 0),
	('steam:11000011d166b4b', 1),
	('steam:11000013454a8a9', 1),
	('steam:1100001368484ea', 0),
	('steam:11000013c0b7f42', -2),
	('steam:11000013cdaa4a1', 0),
	('steam:11000013d9f2972', 1),
	('steam:11000013f0cf35b', 2),
	('steam:110000142a84da8', 1),
	('steam:110000146f0da7f', 0),
	('steam:11000014764beb8', -100),
	('steam:1100001496d27ce', 0),
	('steam:11000014ccc662e', 0),
	('steam:1100001586efdef', 0),
	('steam:110000158726ea1', 0),
	('steam:110000159f7573c', 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
