-- Eurico Dias - script da criacao/reset da base de dados SQLite
-- Grupo 1 do projeto 2

-- Tabela de utilizadores

DROP TABLE IF EXISTS `users`;

CREATE TABLE IF NOT EXISTS `users`(
  `userid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `email` TEXT,
  `name` TEXT,
  `numvotes` INTEGER NOT NULL DEFAULT 0,
  `avatar` TEXT NOT NULL DEFAULT 'avatars/default.jpg');

-- Tabela de samples

DROP TABLE IF EXISTS `samples`;

CREATE TABLE IF NOT EXISTS `samples`(
  `sampleid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `authorid` INTEGER NOT NULL,
  `samplehid` TEXT NOT NULL,
  `name` TEXT,
  `uses` INTEGER NOT NULL DEFAULT 0,
  `date` TEXT NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%SZ%f', 'now')),
  `votes` INTEGER NOT NULL DEFAULT 0,
  `path` TEXT NOT NULL,
  FOREIGN KEY (`authorid`) REFERENCES `users` (`userid`));

-- Tabelas de musicas e de informacao da geracao da musica

DROP TABLE IF EXISTS `songgen`;

CREATE TABLE IF NOT EXISTS `songgen`(
  `songgenid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `songhid` TEXT,
  `bpm` INTEGER NOT NULL DEFAULT 120,
  `samples` BLOB,
  `effects` BLOB,
  `music` BLOB);

DROP TABLE IF EXISTS `songs`;

CREATE TABLE IF NOT EXISTS `songs`(
  `songid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `authorid` INTEGER NOT NULL,
  `songhid` TEXT NOT NULL,
  `name` TEXT,
  `date` TEXT NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%SZ%f', 'now')),
  `votes` INTEGER NOT NULL DEFAULT 0,
  `uses` INTEGER NOT NULL DEFAULT 0,
  `path` TEXT NOT NULL,
  FOREIGN KEY (`authorid`) REFERENCES `users` (`userid`),
  FOREIGN KEY (`songhid`) REFERENCES `songgen` (`songhid`));

-- Tabela de votos

DROP TABLE IF EXISTS `votes`;

CREATE TABLE IF NOT EXISTS `votes`(
  `voteid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `userid` INTEGER NOT NULL,
  `songhid` TEXT NOT NULL,
  `type` INTEGER NOT NULL CHECK(type = 1 or type = -1),
  `date` INTEGER NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%SZ%f', 'now')),
  FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  FOREIGN KEY (`songhid`) REFERENCES `songgen` (`songhid`));


-- Tabela de reports

DROP TABLE IF EXISTS `reports`;

CREATE TABLE IF NOT EXISTS `reports`(
  `reportid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `userid` INTEGER NOT NULL,
  `elemhid` TEXT NOT NULL,
  `date` INTEGER NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%SZ%f', 'now')),
  FOREIGN KEY (`userid`) REFERENCES `users` (`userid`));

-- Tabela de efeitos

DROP TABLE IF EXISTS `effects`;

CREATE TABLE IF NOT EXISTS `effects`(
  `effectid` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL);
