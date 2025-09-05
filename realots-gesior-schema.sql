-- phpMyAdmin SQL Dump
-- version 5.2.2deb1+jammy3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 05-09-2025 a las 16:37:21
-- Versión del servidor: 8.0.43-0ubuntu0.22.04.1
-- Versión de PHP: 8.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `realots`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `banishments`
--

CREATE TABLE `banishments` (
  `banishment_id` smallint UNSIGNED NOT NULL,
  `account_nr` mediumint UNSIGNED DEFAULT '0',
  `account_id` mediumint UNSIGNED DEFAULT '0',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `violation` varchar(150) DEFAULT NULL,
  `comment` varchar(255) DEFAULT 'None',
  `timestamp` int UNSIGNED DEFAULT '0',
  `banished_until` int UNSIGNED DEFAULT '0',
  `gm_id` mediumint UNSIGNED DEFAULT '0',
  `punishment_type` enum('1','2','3') DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `buddy`
--

CREATE TABLE `buddy` (
  `entry_id` mediumint UNSIGNED NOT NULL,
  `account_nr` mediumint UNSIGNED NOT NULL,
  `buddy_id` mediumint UNSIGNED NOT NULL,
  `buddy_string` varchar(25) NOT NULL,
  `timestamp` int UNSIGNED NOT NULL DEFAULT '0',
  `initiating_id` mediumint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creatures`
--

CREATE TABLE `creatures` (
  `id` tinyint UNSIGNED NOT NULL,
  `race` varchar(18) NOT NULL,
  `plural` varchar(20) NOT NULL,
  `description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creature_stats`
--

CREATE TABLE `creature_stats` (
  `name` varchar(25) NOT NULL,
  `killed_by` smallint UNSIGNED NOT NULL,
  `killed` smallint UNSIGNED NOT NULL,
  `time` int UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `deaths`
--

CREATE TABLE `deaths` (
  `record_id` mediumint UNSIGNED NOT NULL,
  `player_id` mediumint UNSIGNED NOT NULL,
  `level` smallint UNSIGNED NOT NULL,
  `by_peekay` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `peekay_id` mediumint UNSIGNED NOT NULL,
  `creature_string` varchar(21) NOT NULL,
  `unjust` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `timestamp` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `geoip`
--

CREATE TABLE `geoip` (
  `end` int UNSIGNED NOT NULL,
  `cc` char(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guilds`
--

CREATE TABLE `guilds` (
  `guild_id` smallint UNSIGNED NOT NULL,
  `guild_name` varchar(30) NOT NULL,
  `guild_owner` mediumint UNSIGNED NOT NULL,
  `description` varchar(255) DEFAULT '',
  `ts` int UNSIGNED NOT NULL DEFAULT '0',
  `ranks` tinyint UNSIGNED NOT NULL DEFAULT '3',
  `rank_1` varchar(20) NOT NULL DEFAULT 'Leader',
  `rank_2` varchar(20) NOT NULL DEFAULT 'Vice Leader',
  `rank_3` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_4` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_5` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_6` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_7` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_8` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_9` varchar(20) NOT NULL DEFAULT 'Member',
  `rank_10` varchar(20) NOT NULL DEFAULT 'Member',
  `logo` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guild_members`
--

CREATE TABLE `guild_members` (
  `entry_id` mediumint UNSIGNED NOT NULL,
  `account_id` mediumint UNSIGNED NOT NULL,
  `guild_id` smallint UNSIGNED NOT NULL,
  `guild_title` varchar(20) DEFAULT 'Member',
  `player_title` varchar(20) DEFAULT '',
  `invitation` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `timestamp` int UNSIGNED NOT NULL,
  `rank` tinyint UNSIGNED DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `highscores`
--

CREATE TABLE `highscores` (
  `account_id` mediumint UNSIGNED NOT NULL,
  `charname` varchar(25) NOT NULL,
  `vocation` varchar(15) NOT NULL DEFAULT '',
  `level` smallint UNSIGNED NOT NULL,
  `exp` int NOT NULL DEFAULT '0',
  `mlvl` tinyint UNSIGNED NOT NULL,
  `skill_shield` tinyint UNSIGNED NOT NULL,
  `skill_dist` tinyint UNSIGNED NOT NULL,
  `skill_axe` tinyint UNSIGNED NOT NULL,
  `skill_sword` tinyint UNSIGNED NOT NULL,
  `skill_club` tinyint UNSIGNED NOT NULL,
  `skill_fist` tinyint UNSIGNED NOT NULL,
  `skill_fish` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `house`
--

CREATE TABLE `house` (
  `house_id` smallint UNSIGNED NOT NULL DEFAULT '0',
  `house_name` varchar(32) NOT NULL,
  `rent_offset` smallint UNSIGNED NOT NULL,
  `area` smallint UNSIGNED NOT NULL,
  `guild_house` enum('0','1') DEFAULT '0',
  `sqm` smallint UNSIGNED DEFAULT '0',
  `description` varchar(49) NOT NULL,
  `coords` char(13) NOT NULL,
  `price` mediumint UNSIGNED NOT NULL,
  `price_old` mediumint UNSIGNED NOT NULL,
  `auctioned` enum('0','1') DEFAULT '0',
  `auction_days` tinyint UNSIGNED DEFAULT '7',
  `bid` int UNSIGNED DEFAULT '0',
  `bidder_id` mediumint UNSIGNED DEFAULT '0',
  `price_per_sqm` tinyint UNSIGNED DEFAULT '0',
  `bidlimit` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `houses`
--

CREATE TABLE `houses` (
  `house_id` int NOT NULL DEFAULT '0',
  `player_id` int DEFAULT NULL,
  `owner_string` varchar(100) DEFAULT NULL,
  `virgin` enum('0','1') DEFAULT '0',
  `gold` int UNSIGNED DEFAULT '0',
  `worldname` varchar(10) DEFAULT 'RealOTS',
  `paid_until` int UNSIGNED DEFAULT '0',
  `grace` varchar(11) DEFAULT '7',
  `guests` text NOT NULL,
  `subowners` text NOT NULL,
  `cleanup` enum('0','1') DEFAULT '0',
  `evict` enum('0','1') DEFAULT '0',
  `price_per_sqm` int DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `house_transfer`
--

CREATE TABLE `house_transfer` (
  `id` int UNSIGNED NOT NULL,
  `house_id` smallint UNSIGNED NOT NULL,
  `transfer_to` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `gold` int UNSIGNED NOT NULL DEFAULT '0',
  `done` tinyint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

CREATE TABLE `items` (
  `id` smallint UNSIGNED NOT NULL,
  `name` varchar(25) NOT NULL,
  `flags` varchar(64) NOT NULL,
  `attrs` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `online`
--

CREATE TABLE `online` (
  `name` varchar(25) NOT NULL,
  `level` smallint UNSIGNED NOT NULL,
  `vocation` varchar(15) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paygol`
--

CREATE TABLE `paygol` (
  `id` mediumint UNSIGNED NOT NULL,
  `account` varchar(25) NOT NULL,
  `time` int UNSIGNED NOT NULL,
  `points` smallint UNSIGNED NOT NULL,
  `params` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pending_transfer`
--

CREATE TABLE `pending_transfer` (
  `id` mediumint UNSIGNED NOT NULL,
  `player_id` mediumint UNSIGNED NOT NULL,
  `amount` tinyint UNSIGNED NOT NULL,
  `time` int UNSIGNED NOT NULL DEFAULT '0',
  `done` tinyint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pg`
--

CREATE TABLE `pg` (
  `account_id` mediumint UNSIGNED NOT NULL,
  `charname` varchar(25) NOT NULL,
  `level` smallint UNSIGNED NOT NULL,
  `exp` int NOT NULL,
  `exp_1` int NOT NULL DEFAULT '0',
  `exp_2` int NOT NULL DEFAULT '0',
  `exp_3` int NOT NULL DEFAULT '0',
  `exp_4` int NOT NULL DEFAULT '0',
  `exp_5` int NOT NULL DEFAULT '0',
  `exp_6` int NOT NULL DEFAULT '0',
  `exp_7` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pgold`
--

CREATE TABLE `pgold` (
  `account_id` mediumint UNSIGNED NOT NULL,
  `charname` varchar(25) NOT NULL,
  `level` smallint UNSIGNED NOT NULL,
  `exp` int NOT NULL,
  `exp_1` int NOT NULL DEFAULT '0',
  `exp_2` int NOT NULL DEFAULT '0',
  `exp_3` int NOT NULL DEFAULT '0',
  `exp_4` int NOT NULL DEFAULT '0',
  `exp_5` int NOT NULL DEFAULT '0',
  `exp_6` int NOT NULL DEFAULT '0',
  `exp_7` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `players`
--

CREATE TABLE `players` (
  `player_id` mediumint UNSIGNED NOT NULL,
  `charname` varchar(64) NOT NULL,
  `account_id` mediumint UNSIGNED NOT NULL,
  `account_nr` mediumint UNSIGNED NOT NULL,
  `creation` int UNSIGNED DEFAULT '1148300000',
  `lastlogin` int UNSIGNED DEFAULT '1148300000',
  `gender` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `online` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `vocation` varchar(15) NOT NULL DEFAULT 'none',
  `hideprofile` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `playerdelete` int UNSIGNED DEFAULT '0',
  `level` smallint UNSIGNED NOT NULL DEFAULT '1',
  `residence` varchar(11) NOT NULL DEFAULT 'Rookgaard',
  `oldname` varchar(30) DEFAULT '',
  `comment` varchar(500) NOT NULL DEFAULT '',
  `charIP` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `world` int NOT NULL DEFAULT '0',
  `create_ip` int NOT NULL DEFAULT '0',
  `create_date` int NOT NULL DEFAULT '0',
  `last_ip` int NOT NULL DEFAULT '0',
  `last_login` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `premium_history`
--

CREATE TABLE `premium_history` (
  `id` mediumint UNSIGNED NOT NULL,
  `account_id` mediumint UNSIGNED NOT NULL,
  `type` tinyint UNSIGNED NOT NULL,
  `data` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `time` int UNSIGNED NOT NULL,
  `transfer` mediumint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privs`
--

CREATE TABLE `privs` (
  `id` int UNSIGNED NOT NULL,
  `priv_id` mediumint UNSIGNED NOT NULL,
  `priv_string` varchar(255) NOT NULL,
  `days` smallint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `services`
--

CREATE TABLE `services` (
  `id` smallint UNSIGNED NOT NULL,
  `account_id` mediumint UNSIGNED NOT NULL,
  `player_id` mediumint UNSIGNED NOT NULL,
  `timestamp` int UNSIGNED NOT NULL,
  `type` tinyint UNSIGNED NOT NULL,
  `state` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `data1` varchar(25) NOT NULL,
  `data2` varchar(25) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `spells`
--

CREATE TABLE `spells` (
  `spell` varchar(19) NOT NULL,
  `name` varchar(21) NOT NULL,
  `words` varchar(24) NOT NULL,
  `category` enum('Attack','Healing','Summon','Supply','Support') NOT NULL,
  `type` enum('Instant','Rune') NOT NULL,
  `level` tinyint UNSIGNED NOT NULL,
  `mana` smallint UNSIGNED NOT NULL,
  `price` smallint UNSIGNED NOT NULL,
  `premium` enum('no','yes') NOT NULL,
  `vocation` tinyint UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `soul` tinyint UNSIGNED NOT NULL,
  `mlvl` tinyint UNSIGNED NOT NULL,
  `charges` tinyint UNSIGNED NOT NULL,
  `city` varchar(77) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stats`
--

CREATE TABLE `stats` (
  `players_online` smallint UNSIGNED NOT NULL DEFAULT '0',
  `record_online` smallint UNSIGNED DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` smallint UNSIGNED NOT NULL,
  `login` mediumint UNSIGNED NOT NULL,
  `email` varchar(30) DEFAULT 'noreply@email.com',
  `passwd` varchar(30) DEFAULT '123',
  `session_ip` varchar(16) NOT NULL DEFAULT '0',
  `last_ip` varchar(15) NOT NULL DEFAULT '',
  `creation_ts` int UNSIGNED NOT NULL DEFAULT '0',
  `last_ts` int UNSIGNED NOT NULL DEFAULT '0',
  `userlevel` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `premium` enum('0','1') NOT NULL DEFAULT '1',
  `banished` enum('0','1') NOT NULL DEFAULT '0',
  `banished_until` int UNSIGNED NOT NULL DEFAULT '0',
  `premium_days` smallint UNSIGNED NOT NULL DEFAULT '0',
  `trial_premium` enum('0','1') NOT NULL DEFAULT '1',
  `trial_premium_days` smallint UNSIGNED NOT NULL DEFAULT '7',
  `bandelete` enum('0','1') NOT NULL DEFAULT '0',
  `creation_ip` varchar(15) NOT NULL DEFAULT '',
  `lastrecover` int UNSIGNED NOT NULL DEFAULT '0',
  `posts` smallint UNSIGNED NOT NULL DEFAULT '0',
  `last_post` int UNSIGNED NOT NULL DEFAULT '0',
  `roses` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `key` varchar(20) NOT NULL DEFAULT '0',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int NOT NULL DEFAULT '0',
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `page_access` int NOT NULL DEFAULT '0',
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `next_email` int NOT NULL DEFAULT '0',
  `premium_points` int NOT NULL DEFAULT '0',
  `create_date` int NOT NULL DEFAULT '0',
  `create_ip` int NOT NULL DEFAULT '0',
  `flag` varchar(80) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `z_forum`
--

CREATE TABLE `z_forum` (
  `id` smallint UNSIGNED NOT NULL,
  `first_post` smallint UNSIGNED NOT NULL DEFAULT '0',
  `last_post` int UNSIGNED DEFAULT NULL,
  `section` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `replies` smallint UNSIGNED DEFAULT NULL,
  `views` mediumint UNSIGNED DEFAULT NULL,
  `author_aid` smallint UNSIGNED NOT NULL DEFAULT '0',
  `author_guid` smallint UNSIGNED NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(64) NOT NULL,
  `post_smile` tinyint UNSIGNED DEFAULT NULL,
  `post_date` int UNSIGNED NOT NULL DEFAULT '0',
  `last_edit_aid` smallint UNSIGNED NOT NULL DEFAULT '0',
  `edit_date` int UNSIGNED NOT NULL DEFAULT '0',
  `post_ip` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `banishments`
--
ALTER TABLE `banishments`
  ADD PRIMARY KEY (`banishment_id`),
  ADD KEY `account_nr` (`account_nr`);

--
-- Indices de la tabla `buddy`
--
ALTER TABLE `buddy`
  ADD PRIMARY KEY (`entry_id`),
  ADD KEY `account_nr` (`account_nr`),
  ADD KEY `buddy_string` (`buddy_string`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `initiating_id` (`initiating_id`),
  ADD KEY `buddy_id` (`buddy_id`);

--
-- Indices de la tabla `creatures`
--
ALTER TABLE `creatures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`race`);

--
-- Indices de la tabla `creature_stats`
--
ALTER TABLE `creature_stats`
  ADD KEY `name` (`name`),
  ADD KEY `time` (`time`);

--
-- Indices de la tabla `deaths`
--
ALTER TABLE `deaths`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `by_peekay` (`by_peekay`,`peekay_id`);

--
-- Indices de la tabla `geoip`
--
ALTER TABLE `geoip`
  ADD KEY `end` (`end`);

--
-- Indices de la tabla `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`guild_id`),
  ADD KEY `buddy_id` (`guild_id`),
  ADD KEY `guild_name` (`guild_name`),
  ADD KEY `guild_owner` (`guild_owner`),
  ADD KEY `description` (`description`),
  ADD KEY `ranks` (`ranks`);

--
-- Indices de la tabla `guild_members`
--
ALTER TABLE `guild_members`
  ADD PRIMARY KEY (`entry_id`),
  ADD KEY `entry_id` (`entry_id`);

--
-- Indices de la tabla `highscores`
--
ALTER TABLE `highscores`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `level` (`level`,`exp`),
  ADD KEY `mlvl` (`mlvl`),
  ADD KEY `skill_shield` (`skill_shield`),
  ADD KEY `skill_dist` (`skill_dist`),
  ADD KEY `skill_sword` (`skill_axe`),
  ADD KEY `skill_club` (`skill_sword`),
  ADD KEY `skill_axe` (`skill_club`),
  ADD KEY `skill_fish` (`skill_fish`),
  ADD KEY `skill_fist` (`skill_fist`);

--
-- Indices de la tabla `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`house_id`),
  ADD UNIQUE KEY `house_name` (`house_name`),
  ADD KEY `area` (`area`),
  ADD KEY `sqm` (`sqm`),
  ADD KEY `auction_days` (`auction_days`),
  ADD KEY `price` (`price`);

--
-- Indices de la tabla `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`house_id`),
  ADD UNIQUE KEY `player_id` (`player_id`);

--
-- Indices de la tabla `house_transfer`
--
ALTER TABLE `house_transfer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `done` (`done`);

--
-- Indices de la tabla `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indices de la tabla `online`
--
ALTER TABLE `online`
  ADD PRIMARY KEY (`name`);

--
-- Indices de la tabla `paygol`
--
ALTER TABLE `paygol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pending_transfer`
--
ALTER TABLE `pending_transfer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `done` (`done`);

--
-- Indices de la tabla `pg`
--
ALTER TABLE `pg`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `exp_1` (`exp_1`),
  ADD KEY `exp_2` (`exp_2`),
  ADD KEY `exp_3` (`exp_3`),
  ADD KEY `exp_4` (`exp_4`),
  ADD KEY `exp_5` (`exp_5`),
  ADD KEY `exp_6` (`exp_6`),
  ADD KEY `exp_7` (`exp_7`);

--
-- Indices de la tabla `pgold`
--
ALTER TABLE `pgold`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `exp_1` (`exp_1`),
  ADD KEY `exp_2` (`exp_2`),
  ADD KEY `exp_3` (`exp_3`),
  ADD KEY `exp_4` (`exp_4`),
  ADD KEY `exp_5` (`exp_5`),
  ADD KEY `exp_6` (`exp_6`),
  ADD KEY `exp_7` (`exp_7`);

--
-- Indices de la tabla `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`player_id`),
  ADD UNIQUE KEY `charname` (`charname`),
  ADD UNIQUE KEY `account_id` (`account_id`),
  ADD KEY `account_nr` (`account_nr`),
  ADD KEY `lastlogin` (`lastlogin`),
  ADD KEY `playerdelete` (`playerdelete`),
  ADD KEY `charIP` (`charIP`),
  ADD KEY `online` (`online`);

--
-- Indices de la tabla `premium_history`
--
ALTER TABLE `premium_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indices de la tabla `privs`
--
ALTER TABLE `privs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`priv_id`),
  ADD KEY `days` (`days`);

--
-- Indices de la tabla `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `spells`
--
ALTER TABLE `spells`
  ADD PRIMARY KEY (`spell`);

--
-- Indices de la tabla `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`players_online`),
  ADD KEY `players_online` (`players_online`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `passwd` (`passwd`),
  ADD KEY `userlevel` (`userlevel`),
  ADD KEY `login_2` (`login`);

--
-- Indices de la tabla `z_forum`
--
ALTER TABLE `z_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `first_post` (`first_post`),
  ADD KEY `post_date` (`post_date`),
  ADD KEY `section` (`section`,`post_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `banishments`
--
ALTER TABLE `banishments`
  MODIFY `banishment_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `buddy`
--
ALTER TABLE `buddy`
  MODIFY `entry_id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `creatures`
--
ALTER TABLE `creatures`
  MODIFY `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `deaths`
--
ALTER TABLE `deaths`
  MODIFY `record_id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `guilds`
--
ALTER TABLE `guilds`
  MODIFY `guild_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `guild_members`
--
ALTER TABLE `guild_members`
  MODIFY `entry_id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `house_transfer`
--
ALTER TABLE `house_transfer`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paygol`
--
ALTER TABLE `paygol`
  MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pending_transfer`
--
ALTER TABLE `pending_transfer`
  MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `players`
--
ALTER TABLE `players`
  MODIFY `player_id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `premium_history`
--
ALTER TABLE `premium_history`
  MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `privs`
--
ALTER TABLE `privs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `services`
--
ALTER TABLE `services`
  MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `z_forum`
--
ALTER TABLE `z_forum`
  MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
