-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-06-2019 a las 09:46:19
-- Versión del servidor: 10.1.29-MariaDB
-- Versión de PHP: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sw_db`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `horas_dia` ()  BEGIN
declare x int;
   declare tiempo time;
   declare person int;
   declare fechas date;
   declare c_tiempo time;
   declare ide time;
   declare monto float;
   set c_tiempo=0;
   
   call sw_db.obt_id(@number_id);   
   
   
   SELECT IF( tipo = '5', 1, 0 ) into x
   from marcado
   where id=@number_id;
   
   SELECT id_personal into person
   from marcado
   where id=@number_id;
   
    SELECT hora into c_tiempo
   from marcado
   where id=@number_id;
   
    SELECT fecha into fechas
   from marcado
   where id=@number_id;
   
   call sw_db.hora_salida(person, tiempo);
   

	if(x = 1)
    then  BEGIN	
        set ide=c_tiempo-tiempo;
        select time_to_sec(ide) / (60 * 60) into monto;
		INSERT INTO `total` (`tipo`,`fecha_ini`,`id_personal`,`monto`) VALUES (1,fechas,person,monto);  
   
   end;end if ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `horas_extras` ()  BEGIN
declare ini date;
    declare fin date;
	declare person int;
    	declare ide int;
        declare x float;
        declare tarifa int;

   SELECT MAX(id) into ide FROM horas_extras ;
    
select h.fecha_ini into ini
from horas_extras h
where h.id=ide;

select h.fecha_final into fin
from horas_extras h
where h.id=ide;

select h.id_personal into person
from horas_extras h
where h.id=ide;


select c.tarifa into tarifa
from contrato c
where c.id_personal=person;


select sum(monto) into x
from total t
where t.id_personal=person and (t.fecha_ini BETWEEN ini and fin); 
	
    update horas_extras set monto=x*tarifa
    where horas_extras.id=ide;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hora_salida` (IN `ide` INT, OUT `tiempo` TIME)  BEGIN
 select h.fin into tiempo
 from contrato c, horario h
 where c.id_horario=h.id and c.id_personal=ide;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obt_id` (OUT `number_id` INT)  BEGIN
   SELECT MAX(id) into number_id FROM marcado ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`id`, `nombre`, `descripcion`) VALUES
(1, 'tecnico', 'colaborador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_ubicacion` int(10) UNSIGNED NOT NULL,
  `telefono` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `nombre`, `id_ubicacion`, `telefono`) VALUES
(1, 'Eliot Humedez', 1, 72121241),
(2, 'Marcelo Quiroga', 2, 72155532),
(3, 'Benito Estrada', 3, 72155532);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato`
--

CREATE TABLE `contrato` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_personal` int(10) UNSIGNED NOT NULL,
  `tarifa` int(11) NOT NULL,
  `fecha_ini` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `id_horario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contrato`
--

INSERT INTO `contrato` (`id`, `nombre`, `id_personal`, `tarifa`, `fecha_ini`, `fecha_fin`, `id_horario`) VALUES
(1, 'fijo', 5, 50, '2019-06-08', '2019-06-15', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inicio` time NOT NULL,
  `fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id`, `nombre`, `inicio`, `fin`) VALUES
(1, 'nocturno', '05:00:00', '08:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horas_extras`
--

CREATE TABLE `horas_extras` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ini` date NOT NULL,
  `fecha_final` date NOT NULL,
  `id_personal` int(10) UNSIGNED NOT NULL,
  `monto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcado`
--

CREATE TABLE `marcado` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_personal` int(10) UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `tipo` int(11) NOT NULL,
  `id_ubicacion` int(10) UNSIGNED NOT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Disparadores `marcado`
--
DELIMITER $$
CREATE TRIGGER `tr_actualizar_total` AFTER INSERT ON `marcado` FOR EACH ROW begin
	
call sw_db.horas_dia();
	
 end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_05_15_000000_create_ubicacion_table', 1),
(4, '2019_05_15_000001_create_cargo_table', 1),
(5, '2019_05_15_000002_create_horario_table', 1),
(6, '2019_05_15_000003_create_personal_table', 1),
(7, '2019_05_15_000004_create_cliente_table', 1),
(8, '2019_05_15_000005_create_contrato_table', 1),
(9, '2019_05_15_000006_create_nota_servicio_table', 1),
(10, '2019_05_15_000007_create_horas_extras_table', 1),
(11, '2019_05_15_000008_create_marcado_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota_servicio`
--

CREATE TABLE `nota_servicio` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_cliente` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `id_personal` int(10) UNSIGNED NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula` int(11) NOT NULL,
  `huella` longtext COLLATE utf8mb4_unicode_ci,
  `foto` longtext COLLATE utf8mb4_unicode_ci,
  `id_cargo` int(10) UNSIGNED DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `id_user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`id`, `nombre`, `cedula`, `huella`, `foto`, `id_cargo`, `estado`, `id_user`) VALUES
(3, 'Luis Velez', 7823929, 'fdsfd', 'pp.jpg', 1, 0, 1),
(4, 'Eliot', 123456, '123456', 'eliot.jpg', 1, 0, 2),
(5, 'Marcelo', 123456, '123456', NULL, 1, 0, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `total`
--

CREATE TABLE `total` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_ini` date NOT NULL,
  `id_personal` int(10) UNSIGNED NOT NULL,
  `monto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`id`, `nombre`, `x`, `y`) VALUES
(1, 'u_c_eliot', -63.18995512170301, -17.79118944057838),
(2, 'u_c_marcelo', -63.1915000740983, -17.79094426254376),
(3, 'u_c_benito', -63.19158590478719, -17.790208726419962);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Luis Velez', 'luis3461580@gmail.com', '$2y$10$dQ4weEI7O31SWMhCd8mda.8jP06CLkdzZNjUNnm3wXk.p0B0H8NIe', NULL, '2019-06-08 10:44:35', '2019-06-08 10:44:35'),
(2, 'Eliot', 'eliot@gmail.com', '$2y$10$K/g4dhHsYCS0E4XA/gHiyeFZW7q3F.JFo1h1VgqmoZoaajHC.NgLa', NULL, '2019-06-08 10:52:44', '2019-06-08 10:52:44'),
(3, 'Marcelo', 'Marcelo@gmail.com', '$2y$10$xdlIY9htt2j2rgetDxoi5.KiIUQhwJxHKADOz/zrg1hu818eytx.6', NULL, '2019-06-08 11:03:13', '2019-06-08 11:03:13');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cliente_ubicacion` (`id_ubicacion`);

--
-- Indices de la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contrato_horario` (`id_horario`),
  ADD KEY `fk_contrato_personal` (`id_personal`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `horas_extras`
--
ALTER TABLE `horas_extras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_horas_personal` (`id_personal`);

--
-- Indices de la tabla `marcado`
--
ALTER TABLE `marcado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_marcado_personal` (`id_personal`),
  ADD KEY `fk_marcado_ubicacion` (`id_ubicacion`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `nota_servicio`
--
ALTER TABLE `nota_servicio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nota_cliente` (`id_cliente`),
  ADD KEY `fk_nota_personal` (`id_personal`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_personal_cargo` (`id_cargo`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `total`
--
ALTER TABLE `total`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_horas_personal` (`id_personal`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `contrato`
--
ALTER TABLE `contrato`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `horario`
--
ALTER TABLE `horario`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `horas_extras`
--
ALTER TABLE `horas_extras`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marcado`
--
ALTER TABLE `marcado`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `nota_servicio`
--
ALTER TABLE `nota_servicio`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `total`
--
ALTER TABLE `total`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_ubicacion` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicacion` (`id`);

--
-- Filtros para la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `fk_contrato_horario` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id`),
  ADD CONSTRAINT `fk_contrato_personal` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id`);

--
-- Filtros para la tabla `horas_extras`
--
ALTER TABLE `horas_extras`
  ADD CONSTRAINT `fk_horas_personal` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id`);

--
-- Filtros para la tabla `marcado`
--
ALTER TABLE `marcado`
  ADD CONSTRAINT `fk_marcado_personal` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id`),
  ADD CONSTRAINT `fk_marcado_ubicacion` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicacion` (`id`);

--
-- Filtros para la tabla `nota_servicio`
--
ALTER TABLE `nota_servicio`
  ADD CONSTRAINT `fk_nota_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `fk_nota_personal` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id`);

--
-- Filtros para la tabla `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `fk_personal_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id`),
  ADD CONSTRAINT `fk_personal_users` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `total`
--
ALTER TABLE `total`
  ADD CONSTRAINT `fk_total_person` FOREIGN KEY (`id_personal`) REFERENCES `personal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
