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

-- Volcando estructura para tabla software_contable.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `id_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_cargo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.cargos: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` (`id_cargo`, `descripcion`) VALUES
	(1, 'administrador');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.categorias: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` (`id_categoria`, `nombre`) VALUES
	(1, 'Lacteos');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.clientes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.empleados
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
  PRIMARY KEY (`id_empleado`) USING BTREE,
  KEY `FK_id_login` (`id_login`),
  KEY `FK_id_cargo` (`id_cargo`),
  CONSTRAINT `FK_id_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`),
  CONSTRAINT `FK_id_login` FOREIGN KEY (`id_login`) REFERENCES `login` (`id_login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.empleados: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` (`id_empleado`, `nombre`, `apellido`, `identificacion`, `celular`, `correo`, `direccion`, `id_login`, `id_cargo`) VALUES
	(1, 'Camilo', 'Rodriguez', '1006679966', '3136997711', 'enderkramcr482@gmail.com', 'La esmeralda', 1, 1);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.facturas_compras
CREATE TABLE IF NOT EXISTS `facturas_compras` (
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
  CONSTRAINT `FK_id_producto_compra` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `FK_id_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.facturas_compras: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `facturas_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_compras` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.facturas_ventas
CREATE TABLE IF NOT EXISTS `facturas_ventas` (
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
  CONSTRAINT `FK_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `FK_id_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`),
  CONSTRAINT `FK_id_modo_pago` FOREIGN KEY (`id_modo_pago`) REFERENCES `modos_de_pago` (`id_modo_pago`),
  CONSTRAINT `FK_id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `FK_valor_unitario` FOREIGN KEY (`valor_unitario`) REFERENCES `productos` (`precio_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.facturas_ventas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `facturas_ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_ventas` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.kardex
CREATE TABLE IF NOT EXISTS `kardex` (
  `id_kardex` int(11) NOT NULL AUTO_INCREMENT,
  `id_factura_venta` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_factura_compra` int(11) DEFAULT NULL,
  `Existencia` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_kardex`),
  KEY `FK_kardex_id_producto` (`id_producto`),
  KEY `FK_kardex_id_factura_venta` (`id_factura_venta`),
  KEY `FK_kardex_id_factura_compra` (`id_factura_compra`),
  CONSTRAINT `FK_kardex_id_factura_compra` FOREIGN KEY (`id_factura_compra`) REFERENCES `facturas_compras` (`id_factura_compra`),
  CONSTRAINT `FK_kardex_id_factura_venta` FOREIGN KEY (`id_factura_venta`) REFERENCES `facturas_ventas` (`id_fact_venta`),
  CONSTRAINT `FK_kardex_id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.kardex: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `kardex` DISABLE KEYS */;
/*!40000 ALTER TABLE `kardex` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.login
CREATE TABLE IF NOT EXISTS `login` (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.login: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`id_login`, `username`, `password`) VALUES
	(1, 'admin', 'admin123');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.modos_de_pago
CREATE TABLE IF NOT EXISTS `modos_de_pago` (
  `id_modo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `modo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_modo_pago`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.modos_de_pago: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `modos_de_pago` DISABLE KEYS */;
INSERT INTO `modos_de_pago` (`id_modo_pago`, `modo`) VALUES
	(1, 'efectivo'),
	(2, 'tarjeta');
/*!40000 ALTER TABLE `modos_de_pago` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.productos
CREATE TABLE IF NOT EXISTS `productos` (
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
  CONSTRAINT `FK_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`),
  CONSTRAINT `FK_id_precio_compra` FOREIGN KEY (`precio_compra`) REFERENCES `facturas_compras` (`id_factura_compra`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.productos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla software_contable.proveedores
CREATE TABLE IF NOT EXISTS `proveedores` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `nit` varchar(50) NOT NULL DEFAULT '0',
  `direccion` varchar(50) NOT NULL DEFAULT '0',
  `celular` varchar(10) NOT NULL DEFAULT '0',
  `correo` varchar(100) NOT NULL DEFAULT '0',
  `ciudad` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla software_contable.proveedores: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
