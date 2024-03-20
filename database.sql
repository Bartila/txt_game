-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Sty 29, 2024 at 10:42 PM
-- Wersja serwera: 8.3.0
-- Wersja PHP: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exampledb`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bosses`
--

CREATE TABLE `bosses` (
  `id` int NOT NULL,
  `name` varchar(60) NOT NULL,
  `attack` int NOT NULL,
  `health` int NOT NULL,
  `maxhealth` int NOT NULL,
  `defense` int NOT NULL,
  `consumable` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `bosses`
--

INSERT INTO `bosses` (`id`, `name`, `attack`, `health`, `maxhealth`, `defense`, `consumable`) VALUES
(1, 'Goblin King', 15, 100, 100, 5, 2),
(2, 'Smoczex Płaczex', 50, 500, 500, 30, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `characters`
--

CREATE TABLE `characters` (
  `id` int NOT NULL,
  `name` varchar(60) NOT NULL,
  `level` int NOT NULL,
  `exp` int NOT NULL,
  `coins` int NOT NULL,
  `weaponsid` int DEFAULT NULL,
  `attack` int NOT NULL,
  `health` int NOT NULL,
  `maxhealth` int NOT NULL,
  `defense` int NOT NULL,
  `potion` int NOT NULL,
  `consumable` int NOT NULL,
  `duel_won` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`id`, `name`, `level`, `exp`, `coins`, `weaponsid`, `attack`, `health`, `maxhealth`, `defense`, `potion`, `consumable`, `duel_won`) VALUES
(1, 'Admin', 10, 26, 50, NULL, 7, 8, 8, 9, 0, 0, 1);


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `enemies`
--

CREATE TABLE `enemies` (
  `id` int NOT NULL,
  `lvl` int NOT NULL,
  `name` varchar(60) NOT NULL,
  `attack` int NOT NULL,
  `health` int NOT NULL,
  `maxhealth` int NOT NULL,
  `defense` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `enemies`
--

INSERT INTO `enemies` (`id`, `lvl`, `name`, `attack`, `health`, `maxhealth`, `defense`) VALUES
(1, 1, 'Wolf', 2, 5, 5, 1),
(2, 3, 'Goblin', 3, 10, 10, 2),
(3, 7, 'Skeleton', 5, 20, 20, 0),
(4, 10, 'Hobgoblin', 6, 35, 35, 10),
(5, 12, 'Armored Skeleton', 6, 35, 35, 30);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `eq`
--

CREATE TABLE `eq` (
  `id` int NOT NULL,
  `characterid` int NOT NULL,
  `weaponid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `rolename` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `rolename`) VALUES
(1, 'user'),
(2, 'admin');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `roleid` int NOT NULL,
  `charactersid` int NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `roleid`, `charactersid`, `nickname`, `email`, `password`) VALUES
(1, 2, 1, 'admin', 'admin@test.pl', '$2y$10$Lo9/WtJ4K5qgMVPuF1IQg.T9Ey4bhZgo9/.ZL7VNppemBFxpvqZGC');
-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `weapons`
--

CREATE TABLE `weapons` (
  `id` int NOT NULL,
  `name` varchar(60) NOT NULL,
  `price` int NOT NULL,
  `attack_bonus` int NOT NULL,
  `health_bonus` int NOT NULL,
  `defense_bonus` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `weapons`
--

INSERT INTO `weapons` (`id`, `name`, `price`, `attack_bonus`, `health_bonus`, `defense_bonus`) VALUES
(1, 'Knife', 10, 5, 1, 1),
(2, 'Sword', 150, 20, 10, 10),
(3, 'Halberd', 750, 50, 20, 20),
(4, 'Shield', 120, 1, 30, 30),
(5, 'Greatshield', 550, 5, 50, 200);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `bosses`
--
ALTER TABLE `bosses`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `weaponsid` (`weaponsid`);

--
-- Indeksy dla tabeli `enemies`
--
ALTER TABLE `enemies`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `eq`
--
ALTER TABLE `eq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `weaponid` (`weaponid`),
  ADD KEY `eq_ibfk_1` (`characterid`);

--
-- Indeksy dla tabeli `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `charactersid` (`charactersid`),
  ADD KEY `roleid` (`roleid`);

--
-- Indeksy dla tabeli `weapons`
--
ALTER TABLE `weapons`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bosses`
--
ALTER TABLE `bosses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `enemies`
--
ALTER TABLE `enemies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `eq`
--
ALTER TABLE `eq`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `weapons`
--
ALTER TABLE `weapons`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `characters`
--
ALTER TABLE `characters`
  ADD CONSTRAINT `characters_ibfk_2` FOREIGN KEY (`weaponsid`) REFERENCES `weapons` (`id`);

--
-- Constraints for table `eq`
--
ALTER TABLE `eq`
  ADD CONSTRAINT `eq_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`),
  ADD CONSTRAINT `eq_ibfk_2` FOREIGN KEY (`weaponid`) REFERENCES `weapons` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`charactersid`) REFERENCES `characters` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
