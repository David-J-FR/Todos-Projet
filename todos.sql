-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 11 jan. 2024 à 15:44
-- Version du serveur : 8.0.31
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `todos`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'taches recurrentes');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20240103121302', '2024-01-03 12:13:53', 133),
('DoctrineMigrations\\Version20240104131056', '2024-01-04 13:11:14', 76),
('DoctrineMigrations\\Version20240104145804', '2024-01-04 14:58:19', 142),
('DoctrineMigrations\\Version20240105095108', '2024-01-05 09:51:35', 59),
('DoctrineMigrations\\Version20240109154137', '2024-01-09 15:41:43', 218),
('DoctrineMigrations\\Version20240110131645', '2024-01-10 13:17:14', 71);

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `duedate` date NOT NULL,
  `priority` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5058659712469DE2` (`category_id`),
  KEY `IDX_505865979D86650F` (`user_id_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `tasks`
--

INSERT INTO `tasks` (`id`, `category_id`, `name`, `description`, `duedate`, `priority`, `user_id_id`) VALUES
(13, 1, 'Ajout', 'ajouter des choses à faire', '2024-01-06', 'Urgente', 2),
(16, 1, 'Devoirs', 'Réviser pour le partiel', '2024-01-06', 'Urgente', 2),
(18, 1, 'test1', 'ceci est le premier test à faire', '2024-01-06', 'Moyenne', 1),
(19, 1, 'Rangement', 'je dois ranger mes affaires de sport', '2024-01-12', 'Moyenne', 10),
(20, 1, 'test11', 'ceci est un autre test', '2024-01-12', 'Moyenne', 10),
(21, 1, 'test1', 'zdfzfz', '2024-01-12', 'Urgente', 2);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `img_avatar`, `is_verified`) VALUES
(1, 'test@gmail.com', '[]', '$2y$13$17rjKruL9iVs5fiLHD9G4.R70i2.LojIY78TFB9mLm0BKJh.1Xvs6', 'Jean', 'Hugues', NULL, NULL),
(2, 'testeur@gmail.com', '[]', '$2y$13$J6rP1cX4Tv8M2m3LTwS8Len/fcQoZLAOLp8n2Mn2epW1kSQsDCTba', 'Will', 'Smith', NULL, NULL),
(3, 'joe@gmail.com', '[]', '$2y$13$f65fGQkjACu.vv3.TNw9OOMDtcM4s9MCRK5pLEPHd8RhyEQshQ8ce', 'Joe', 'Ker', 'testprofil-659bcde4dd369.png', NULL),
(4, 'test2@gmail.com', '[]', '$2y$13$nwBzgdXStAIm4IFw//aLHu9RmMpKDlL9bG4Q/TQmEWXExZhy/EeFG', 'Doc', 'Genico', 'pptest-659bd07ebd66a.jpg', NULL),
(5, 'toto@gmail.com', '[]', '$2y$13$AWVaoM/1DxZ5VpsCxPOaJeNoiz3xUY76F2LFqI3JtKSyPC7Aq5jtS', 'toto', 'rototo', 'free-nature-images-659bea18517c8.jpg', NULL),
(6, 'solo@gmail.com', '[]', '$2y$13$rym2b8B1isyy/uOCAZQNMumWvkvSFE8LGISZB.zQc04v7wUSJYPxm', 'John', 'Lennon', 'testprofil-659bfaa2bf8dd.png', NULL),
(7, 'pinkiepieh911@gmail.com', '[]', '$2y$13$ujl6kl3D/NKaQ4iPUtbvaORC9tcDEjzz/ZF5ENJIxh18mwAKxx73i', 'zejr', 'ijro', NULL, NULL),
(9, 'davidherve54@hotmail.fr', '[]', '$2y$13$LHgaUhw8M1bkNLcf6NiUYuh9tltRaJLwgm6WbY9OdMuAuOl/02vXu', 'David', 'herve', NULL, NULL),
(10, 'davidwinch54@gmail.com', '[]', '$2y$13$i6HCMWUITW267A/0qmdvwOV3Yo2PDH97CrSz9IjmL1SJ.DMCNZgfK', 'Jean', 'Tonik', 'testprofil-659e9ceb26744.png', 1),
(11, 'andore@gmail.fr', '[]', '$2y$13$2VluTj28B1P3Lkvq7fjlMe664tsR2HqecInhU9cfHUDA/x9064x/W', 'fzkozkfozk', 'fokfokfoz', NULL, NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `FK_5058659712469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `FK_505865979D86650F` FOREIGN KEY (`user_id_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
