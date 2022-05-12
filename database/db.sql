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


-- Volcando estructura de base de datos para software_contable
CREATE DATABASE IF NOT EXISTS `software_contable` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `software_contable`;

-- Volcando estructura para tabla software_contable.cargo
CREATE TABLE IF NOT EXISTS `cargo` (
  `id_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_cargo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `marca` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL DEFAULT '',
  `apellido` varchar(100) NOT NULL DEFAULT '',
  `cedula` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `barrio` varchar(50) DEFAULT NULL,
  `id_login` int(11) DEFAULT NULL,
  `id_cargo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_empleado`) USING BTREE,
  KEY `FK_id_login` (`id_login`),
  KEY `FK_id_cargo` (`id_cargo`),
  CONSTRAINT `FK_id_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id_cargo`),
  CONSTRAINT `FK_id_login` FOREIGN KEY (`id_login`) REFERENCES `login` (`id_login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.factura_compra
CREATE TABLE IF NOT EXISTS `factura_compra` (
  `id_factura_compra` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT '0',
  `val_unitario` int(11) NOT NULL DEFAULT '0',
  `descuento` int(11) NOT NULL DEFAULT '0',
  `id_proveedor` int(11) NOT NULL DEFAULT '0',
  `id_producto` int(11) NOT NULL DEFAULT '0',
  `impuesto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_factura_compra`),
  KEY `FK_id_proveedor` (`id_proveedor`),
  KEY `FK_id_producto_compra` (`id_producto`),
  CONSTRAINT `FK_id_producto_compra` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `FK_id_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.factura_venta
CREATE TABLE IF NOT EXISTS `factura_venta` (
  `id_fact_venta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `valor_unitario` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `valor_total` int(11) DEFAULT NULL,
  `descuento` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_modo_pago` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_fact_venta`),
  KEY `FK_id_empleado` (`id_empleado`),
  KEY `FK_id_modo_pago` (`id_modo_pago`),
  KEY `FK_id_cliente` (`id_cliente`),
  KEY `FK_valor_unitario` (`valor_unitario`),
  KEY `FK_id_producto` (`id_producto`),
  CONSTRAINT `FK_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `FK_id_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `FK_id_modo_pago` FOREIGN KEY (`id_modo_pago`) REFERENCES `modo_pago` (`id_modo_pago`),
  CONSTRAINT `FK_id_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `FK_valor_unitario` FOREIGN KEY (`valor_unitario`) REFERENCES `producto` (`precio_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.kardex
CREATE TABLE IF NOT EXISTS `kardex` (
  `id_kardex` int(11) NOT NULL AUTO_INCREMENT,
  `id_factura_venta` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_factura_compra` int(11) DEFAULT NULL,
  `Existencia` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_kardex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.login
CREATE TABLE IF NOT EXISTS `login` (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.modo_pago
CREATE TABLE IF NOT EXISTS `modo_pago` (
  `id_modo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `modo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_modo_pago`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_producto` int(11) NOT NULL DEFAULT '0',
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  `precio_venta` int(11) DEFAULT '0',
  `id_categoria` int(11) NOT NULL DEFAULT '0',
  `precio_compra` int(11) DEFAULT '0',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `precio_venta` (`precio_venta`),
  KEY `FK_id_categoria` (`id_categoria`),
  KEY `FK_id_precio_compra` (`precio_compra`),
  CONSTRAINT `FK_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `FK_id_precio_compra` FOREIGN KEY (`precio_compra`) REFERENCES `factura_compra` (`id_factura_compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla software_contable.proveedor
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `nit` varchar(50) NOT NULL DEFAULT '0',
  `direccion` varchar(50) NOT NULL DEFAULT '0',
  `celular` varchar(10) NOT NULL DEFAULT '0',
  `correo` varchar(100) NOT NULL DEFAULT '0',
  `ciudad` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
