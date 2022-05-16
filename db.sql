-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.33 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para software_contables
CREATE DATABASE IF NOT EXISTS `software_contables` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `software_contables`;

-- Volcando estructura para tabla software_contables.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `id_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cargo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.cargos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` (`id_cargo`, `descripcion`) VALUES
	(1, 'administrador');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;

-- Volcando estructura para tabla software_contables.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.categorias: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` (`id_categoria`, `nombre`) VALUES
	(1, 'Bebidas');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;

-- Volcando estructura para tabla software_contables.empleados
CREATE TABLE IF NOT EXISTS `empleados` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL DEFAULT '',
  `apellido` varchar(100) NOT NULL DEFAULT '',
  `identificacion` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `id_login` int(11) DEFAULT NULL,
  `id_cargo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `FK_empleados_login` (`id_login`),
  KEY `FK_empleados_cargos` (`id_cargo`),
  CONSTRAINT `FK_empleados_cargos` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`),
  CONSTRAINT `FK_empleados_login` FOREIGN KEY (`id_login`) REFERENCES `login` (`id_login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.empleados: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` (`id_empleado`, `nombre`, `apellido`, `identificacion`, `celular`, `correo`, `direccion`, `id_login`, `id_cargo`) VALUES
	(1, 'Miguel', 'Caicedo', '123456789', '1234567999', 'miguelcaiced@gmail.com', 'Mocoa', 1, 1);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;

-- Volcando estructura para tabla software_contables.facturas_compras
CREATE TABLE IF NOT EXISTS `facturas_compras` (
  `id_factura_compra` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_codigo_producto` int(11) NOT NULL DEFAULT '0',
  `cantidad` int(11) NOT NULL DEFAULT '0',
  `val_unitario` int(11) NOT NULL DEFAULT '0',
  `descuento` int(11) NOT NULL DEFAULT '0',
  `id_proveedor` int(11) NOT NULL DEFAULT '0',
  `impuesto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_factura_compra`),
  KEY `FK_facturas_compras_proveedores` (`id_proveedor`),
  KEY `FK_facturas_compras_id_productos` (`id_codigo_producto`) USING BTREE,
  CONSTRAINT `FK_facturas_compras_id_productos` FOREIGN KEY (`id_codigo_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `FK_facturas_compras_proveedores` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedores`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.facturas_compras: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `facturas_compras` DISABLE KEYS */;
INSERT INTO `facturas_compras` (`id_factura_compra`, `fecha`, `id_codigo_producto`, `cantidad`, `val_unitario`, `descuento`, `id_proveedor`, `impuesto`) VALUES
	(1, '2022-05-16 15:24:56', 4, 5, 8, 55, 1, 22);
/*!40000 ALTER TABLE `facturas_compras` ENABLE KEYS */;

-- Volcando estructura para tabla software_contables.login
CREATE TABLE IF NOT EXISTS `login` (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id_login`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.login: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`id_login`, `username`, `password`) VALUES
	(1, 'admin', 'admin123');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;

-- Volcando estructura para tabla software_contables.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_producto` int(11) NOT NULL DEFAULT '0',
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  `precio_venta` int(11) NOT NULL DEFAULT '0',
  `id_categoria` int(11) NOT NULL DEFAULT '0',
  `existencia` int(11) NOT NULL,
  `precio_compra` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_producto`),
  KEY `FK_productos_id_categoría` (`id_categoria`),
  CONSTRAINT `FK_productos_id_categoría` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.productos: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`id_producto`, `codigo_producto`, `nombre`, `precio_venta`, `id_categoria`, `existencia`, `precio_compra`) VALUES
	(1, 1, 'Coca Cola', 15000, 1, 150, 15000),
	(2, 2, 'Pepsi', 1, 1, 16, 15),
	(3, 6, 'Caldo', 12422, 1, 5, -25),
	(4, 7, 'Caldo', 12422, 1, 5, -25);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla software_contables.proveedores
CREATE TABLE IF NOT EXISTS `proveedores` (
  `id_proveedores` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `nit` varchar(50) NOT NULL DEFAULT '0',
  `direccion` varchar(50) NOT NULL DEFAULT '0',
  `celular` varchar(10) NOT NULL DEFAULT '0',
  `correo` varchar(100) NOT NULL DEFAULT '0',
  `ciudad` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_proveedores`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contables.proveedores: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` (`id_proveedores`, `nombre`, `nit`, `direccion`, `celular`, `correo`, `ciudad`) VALUES
	(1, 'JugosStiven', '1024556', 'El chorizo', '313696969', 'stiven123@gmail.com', 'Mocoa');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
