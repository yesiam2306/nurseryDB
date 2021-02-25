SET NAMES latin1;
SET FOREIGN_KEY_CHECKS = 0;


BEGIN;
CREATE DATABASE IF NOT EXISTS `PolliceVerde`;
COMMIT;

USE `PolliceVerde`;

-- ----------------------------
--  Table structure for `PERIODO`
-- ----------------------------
DROP TABLE IF EXISTS `PERIODO`;
CREATE TABLE `PERIODO` (
  `CodicePeriodo` INT(11) NOT NULL,
  `Tipo` ENUM('Fioritura', 'Fruttificazione', 'Fabbisogno', 'Manutenzione programmata', 'Non Somministrazione', 'Patologia', 'Vegetazione', 'Riposo') NOT NULL,
  `MeseInizio` INT(2) NOT NULL,
  `MeseFine` INT(2) NOT NULL,
  PRIMARY KEY (`CodicePeriodo`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `PERIODO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('1', '1', '1', '1');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('2', '2', '1', '2');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('3', '3', '1', '3');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('4', '3', '1', '4');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('5', '4', '1', '5');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('6', '5', '5', '6');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('7', '6', '1', '7');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('8', '7', '12', '12');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('9', '5', '2', '9');
INSERT INTO `polliceverde`.`periodo` (`CodicePeriodo`, `Tipo`, `MeseInizio`, `MeseFine`) VALUES ('10', '8', '1', '10');
COMMIT;

-- ----------------------------
--  Table structure for `SEZIONE`
-- ----------------------------
DROP TABLE IF EXISTS `SEZIONE`;
CREATE TABLE `SEZIONE` (
  `CodiceSezione` INT(11) NOT NULL,
  `Serra` INT(11) NOT NULL,
		FOREIGN KEY (`Serra`) REFERENCES `PolliceVerde`.`SERRA` (`CodiceSerra`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Nome` VARCHAR(45) NOT NULL,
  `Capienza` INT(3) NOT NULL,
  `Riempimento` INT(3) NOT NULL DEFAULT 0, /*quante piante contiene*/
  `Irrigazione` INT(11) NOT NULL,
  		FOREIGN KEY (`Irrigazione`) REFERENCES `PolliceVerde`.`IRRIGAZIONE` (`CodiceIrrigazione`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Illuminazione` INT(11) NOT NULL,
  		FOREIGN KEY (`Illuminazione`) REFERENCES `PolliceVerde`.`LUCE` (`CodiceLuce`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Temperatura` INT(3) NOT NULL,
  `Umidita` INT(3) NOT NULL,
  PRIMARY KEY (`CodiceSezione`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `SEZIONE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`sezione` (`CodiceSezione`, `Serra`, `Nome`, `Capienza`, `Irrigazione`, `Illuminazione`, `Temperatura`, `Umidita`) VALUES ('1', '1', 'Io', '50', '1', '1', '18', '30'), ('2', '1', 'Non', '50', '2', '1', '18', '32'), ('3', '1', 'Capisco', '50', '3', '1', '18', '34'), ('4', '1', 'Che ', '50', '4', '1', '18', '36'), ('5', '1', 'Nome', '50', '5', '1', '18', '40'), ('6', '2', 'Si', '50', '1', '2', '24', '20'), ('7', '2', 'Possa', '50', '2', '2', '24', '23'), ('8', '2', 'Dare', '50', '3', '2', '24', '25'), ('9', '2', 'A una', '50', '4', '2', '24', '30'), ('10', '2', 'SEZIONE', '50', '5', '2', '24', '15');
COMMIT;

-- ----------------------------
--  Table structure for `PIANTA`
-- ----------------------------
DROP TABLE IF EXISTS `PIANTA`;
CREATE TABLE `PIANTA` (
  `CodicePianta` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Genere` VARCHAR(45) NOT NULL,
  `Cultivar` TINYINT NOT NULL DEFAULT 0,
  `DimensioneMassima` INT(3) NOT NULL,
  `Accrescimento` INT(5) NOT NULL
        REFERENCES `PolliceVerde`.`ACCRESCIMENTO` (`CodiceAccrescimento`),
  `Infestante` TINYINT NOT NULL DEFAULT 0,
  `NumeroFioritureAnnue` INT(1) NOT NULL DEFAULT 0,
  `NumeroFruttificazioniAnnue` INT(1) NOT NULL DEFAULT 0,
  `Luce` INT(11) NOT NULL,
  		FOREIGN KEY (`Luce`) REFERENCES `PolliceVerde`.`LUCE` (`CodiceLuce`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Terreno` INT(11) NOT NULL,
  		FOREIGN KEY (`Terreno`) REFERENCES `PolliceVerde`.`TERRENO` (`CodiceTerreno`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Irrigazione` INT(11) NOT NULL,
  		FOREIGN KEY (`Irrigazione`) REFERENCES `PolliceVerde`.`IRRIGAZIONE` (`CodiceIrrigazione`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Concimazione` INT(11) NOT NULL,
  		FOREIGN KEY (`Concimazione`) REFERENCES `PolliceVerde`.`CONCIMAZIONE` (`CodiceConcimazione`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Manutenzione` INT(11) NOT NULL,
		FOREIGN KEY (`Manutenzione`) REFERENCES `PolliceVerde`.`MANUTENZIONE` (`CodiceManutenzione`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `PeriodoVegetazione` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoVegetazione`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `PeriodoRiposo` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoRiposo`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `PeriodoFioritura` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoFioritura`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `PeriodoFruttificazione` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoFruttificazione`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Sempreverde` TINYINT NOT NULL DEFAULT 0,
  `Dioica` TINYINT NOT NULL DEFAULT 0,
  `IndiceManutenzione` ENUM('Basso', 'Medio', 'Alto') NOT NULL,
  `Contenitore` INT(11) NULL,
		FOREIGN KEY (`Contenitore`) REFERENCES `PolliceVerde`.`CONTENITORE` (`CodiceContenitore`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Sezione` INT(11) NOT NULL,
		FOREIGN KEY (`Sezione`) REFERENCES `PolliceVerde`.`SEZIONE` (`CodiceSezione`) ON DELETE CASCADE ON UPDATE CASCADE,
  `TemperaturaMinima` INT(11) NOT NULL,
  `SpeseManutenzioneIndicative` INT(11) NOT NULL,
  `Prezzo` FLOAT NOT NULL,
  PRIMARY KEY (`CodicePianta`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoVegetazione` BEFORE INSERT ON `PIANTA` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.PeriodoVegetazione) <> 'Vegetazione' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoRiposo` BEFORE INSERT ON `PIANTA` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.PeriodoRiposo) <> 'Riposo' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoFioritura` BEFORE INSERT ON `PIANTA` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.PeriodoFioritura) <> 'Fioritura' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoFruttificazione` BEFORE INSERT ON `PIANTA` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.PeriodoFruttificazione) <> 'Fruttificazione' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `SecondaRidondanzaInsert` BEFORE INSERT ON `PIANTA` FOR EACH ROW BEGIN
SET @riempimento = (SELECT Riempimento
					FROM SEZIONE
					WHERE NEW.Sezione = CodiceSezione
                        );
SET @capienza = (SELECT Capienza
				 FROM SEZIONE
				 WHERE NEW.Sezione = CodiceSezione
                        );
IF @capienza = @riempimento THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Impossibile eseguire procedura: SEZIONE GIA` PIENA';
ELSE 
UPDATE `SEZIONE`
SET `Riempimento` = `Riempimento` + 1
WHERE `CodiceSezione` = NEW.Sezione;
END IF;
END $$
delimiter ;


delimiter $$
CREATE TRIGGER `SecondaRidondanzaDelete` AFTER DELETE ON `PIANTA` FOR EACH ROW BEGIN
UPDATE `SEZIONE`
SET `Riempimento` = `Riempimento` - 1
WHERE `CodiceSezione` = OLD.Sezione;
END $$
delimiter ;

-- ----------------------------
--  Records of `PIANTA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('1', 'gladiolo', 'fiore', '1', '1', '10', '0', '1', '3', '1', '1', '1', '1', '1', '8', '10', '0', '0', '1', '1', '5', '9', '19', '15', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('2', 'aloe', 'albero', '0', '3', '9', '1', '4', '2', '2', '3', '2', '2', '2', '8', '10', '0', '0', '2', '2', '5', '7', '18', '18', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('3', 'ginestra', 'fiore', '0', '5', '8', '0', '3', '1', '3', '3', '3', '3', '3', '8', '10', '0', '0', '3', '3', '5', '6', '17', '26', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('4', 'girasole', 'fiore', '1', '1', '7', '1', '2', '5', '4', '4', '4', '4', '4', '8', '10', '0', '1', '1', '4', '5', '5', '16', '3', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('5', 'crisantemo', 'fiore', '1', '1', '6', '0', '1', '6', '5', '5', '5', '5', '5', '8', '10', '1', '1', '2', '5', '5', '4', '15', '43', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('6', 'cipresso', 'albero', '1', '15', '5', '1', '4', '2', '6', '6', '6', '6', '6', '8', '10', '1', '0', '3', '6', '5', '3', '14', '7', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('7', 'ninfea', 'fiore', '0', '2', '4', '0', '3', '3', '7', '7', '7', '7', '7', '8', '10', '1', '1', '1', '1', '5', '2', '13', '10', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('8', 'viola', 'fiore', '1', '1', '3', '1', '2', '4', '8', '8', '8', '8', '8', '8', '10', '0', '0', '3', '2', '5', '1', '12', '12', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('9', 'enturium', 'fiore', '0', '3', '2', '0', '1', '1', '9', '9', '9', '9', '9', '8', '10', '0', '1', '2', '3', '5', '0', '11', '6', '1', '2');
INSERT INTO `polliceverde`.`pianta` (`CodicePianta`, `Nome`, `Genere`, `Cultivar`, `DimensioneMassima`, `Accrescimento`, `Infestante`, `NumeroFioritureAnnue`, `NumeroFruttificazioniAnnue`, `Luce`, `Terreno`, `Irrigazione`, `Concimazione`, `Manutenzione`, `PeriodoVegetazione`, `PeriodoRiposo`, `Sempreverde`, `Dioica`, `IndiceManutenzione`, `Contenitore`, `Sezione`, `TemperaturaMinima`, `SpeseManutenzioneIndicative`, `Prezzo`, `PeriodoFioritura`, `PeriodoFruttificazione`) VALUES ('10', 'rosa', 'fiore', '1', '1', '1', '0', '2', '2', '10', '10', '10', '10', '10', '8', '10', '0', '1', '1', '1', '5', '5', '11', '7', '1', '2');
COMMIT;

-- ----------------------------
--  Table structure for `QUARANTENA`
-- ----------------------------
DROP TABLE IF EXISTS `QUARANTENA`;
CREATE TABLE `QUARANTENA` (
  `CodiceQuarantena` INT(11) NOT NULL,
  `Pianta` INT(11) NOT NULL,
		FOREIGN KEY (`Pianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Cura` INT(11) NOT NULL,
		FOREIGN KEY (`Cura`) REFERENCES `PolliceVerde`.`CURA` (`CodiceCura`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Patologia` INT(11) NOT NULL,
		FOREIGN KEY (`Patologia`) REFERENCES `PolliceVerde`.`PATOLOGIA` (`CodicePatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `DataInizio` DATE NOT NULL,
  `DataFine` DATE NULL,
  `Esito` ENUM ('Curata', 'Morta') NULL,
PRIMARY KEY (`CodiceQuarantena`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `QUARANTENA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`quarantena` (`CodiceQuarantena`, `Pianta`, `Cura`, `Patologia`, `DataInizio`, `DataFine`, `Esito`) VALUES ('1', '10', '7', '10', '2016-12-15', '2016-12-20', '1'), ('4', '10', '2', '4', '2016-12-05', '2016-12-13', '1'), ('6', '10', '8', '1', '2016-12-05', '2016-12-13', '1'), ('8', '5', '9', '8', '2016-12-15', '2016-12-20', '1'), ('9', '5', '3', '5', '2016-12-15', '2016-12-20', '1'), ('10', '1', '6', '6', '2016-12-28', '2017-01-09', '2');
INSERT INTO `polliceverde`.`quarantena` (`CodiceQuarantena`, `Pianta`, `Cura`,`Patologia`, `DataInizio`) VALUES ('2', '6', '4', '10', '2017-02-05'), ('3', '6', '1', '9', '2017-02-05'), ('5', '6', '5', '1', '2017-02-05'), ('7', '10', '10', '6', '2017-02-05');
COMMIT;
  
-- ----------------------------
--  Table structure for `CONTENITORE`
-- ----------------------------
DROP TABLE IF EXISTS `CONTENITORE`;
CREATE TABLE `CONTENITORE` (
  `CodiceContenitore` INT(11) NOT NULL,
  `Ripiano` INT(11) NOT NULL,
		FOREIGN KEY (`Ripiano`) REFERENCES `PolliceVerde`.`RIPIANO` (`CodiceRipiano`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `SuperficieOccupata` INT(11) NOT NULL,
  `LivelloIdratazione` ENUM('basso', 'medio', 'alto') NOT NULL,
  PRIMARY KEY (`CodiceContenitore`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `CONTENITORE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`contenitore` (`CodiceContenitore`, `Ripiano`, `SuperficieOccupata`, `LivelloIdratazione`) VALUES ('1', '1', '150', '1'), ('2', '1', '150', '1'), ('3', '1', '150', '1'), ('4', '1', '150', '1'), ('5', '1', '150', '2'), ('6', '1', '150', '2'), ('7', '1', '150', '2'), ('8', '1', '150', '2'), ('9', '2', '100', '3'), ('10', '2', '100', '3');
COMMIT;

-- ----------------------------
--  Table structure for `RIPIANO`
-- ----------------------------
DROP TABLE IF EXISTS `RIPIANO`;
CREATE TABLE `RIPIANO` (
  `CodiceRipiano` INT(11) NOT NULL,
  `Sezione` INT(11) NOT NULL,
		FOREIGN KEY (`Sezione`) REFERENCES `PolliceVerde`.`SEZIONE` (`CodiceSezione`) ON DELETE CASCADE ON UPDATE CASCADE,
  `N°contenitori` INT(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CodiceRipiano`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `RIPIANO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`ripiano` (`CodiceRipiano`, `Sezione`, `N°contenitori`) VALUES ('1', '1', '10'), ('2', '1', '10'), ('3', '1', '9'), ('4', '1', '7'), ('5', '1', '3'), ('6', '2', '6'), ('7', '2', '6'), ('8', '2', '6'), ('9', '2', '5'), ('10', '2', '3');
COMMIT;

-- ----------------------------
--  Table structure for `SERRA`
-- ----------------------------
DROP TABLE IF EXISTS `SERRA`;
CREATE TABLE `SERRA` (
  `CodiceSerra` INT(11) NOT NULL,
  `Sede` INT(11) NOT NULL,
		FOREIGN KEY (`Sede`) REFERENCES `PolliceVerde`.`SEDE` (`CodiceSede`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Nome` VARCHAR(45) NOT NULL,
  `Indirizzo` VARCHAR(255) NOT NULL,
  `Larghezza` INT(3) NOT NULL,
  `Lunghezza` INT(3) NOT NULL,
  `Altezza` INT(3) NOT NULL,
  `PianteOspitabili` INT(3) NOT NULL,
  `PianteOspitate` INT(3) NOT NULL,
  PRIMARY KEY (`CodiceSerra`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `SERRA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`serra` (`CodiceSerra`, `Sede`, `Nome`, `Indirizzo`, `Larghezza`, `Lunghezza`, `Altezza`, `PianteOspitabili`, `PianteOspitate`) VALUES ('1', '1', 'Susanna', 'Via Chiabrera 54', '25', '100', '8', '250', '150'), ('8', '2', 'Elvira', 'Via Terun 44', '30', '100', '10', '300', '200'), ('9', '2', 'Cristina', 'Via Terun 45', '30', '100', '10', '300', '200'), ('10', '2', 'Carla', 'Via Dal Norde 28', '50', '200', '15', '400', '300'), ('7', '2', 'Nicoletta', 'Via Terun 43', '30', '100', '10', '300', '200'), ('6', '2', 'Giovanna', 'Via Terun 42', '30', '100', '10', '300', '200'), ('5', '1', 'Maria', 'Via Chiabrera 58', '25', '100', '8', '250', '150'), ('4', '1', 'Teresa', 'Via Chiabrera 57', '25', '100', '8', '250', '150'), ('3', '1', 'Francesca', 'Via Chiabrera 56', '25', '100', '8', '250', '150'), ('2', '1', 'Alberta', 'Via Chiabrera 55', '25', '100', '8', '250', '150');
COMMIT;
-- ----------------------------
--  Table structure for `SEDE`
-- ----------------------------
DROP TABLE IF EXISTS `SEDE`;
CREATE TABLE `SEDE` (
  `CodiceSede` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Indirizzo` VARCHAR(255) NOT NULL,
  `NumeroDipendenti` INT(4) NOT NULL,
  PRIMARY KEY (`CodiceSede`, `Nome`, `Indirizzo`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `SEDE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`sede` (`CodiceSede`, `Nome`, `Indirizzo`, `NumeroDipendenti`) VALUES ('1', 'ROMAGARDEN', 'Via Chiabrera 54', '56'), ('2', 'PADANIAGARDEN', 'Via Terun 42', '48'), ('3', 'CALABRIAGARDEN', 'Via Diotisalvi 9', '43'), ('4', 'SICILIAGARDEN', 'Via Garibaldi 41', '52'), ('5', 'MAREMMAGARDEN', 'Piazza Vittorio Emanuele II 16', '45'), ('6', 'AOSTAGARDEN', 'Via Barco 36', '41'), ('7', 'TIROLOGARDEN', 'Via Inventata 9', '54'), ('8', 'ABBRUZZOGARDEN', 'Via Don Bosco 57', '50'), ('9', 'SARDEGNAGARDEN', 'Via Eja 121', '49'), ('10', 'SEMPREGARDEN', 'Via Damasco 72', '48');
COMMIT;

-- ----------------------------
--  Table structure for `SINTOMATOLOGIA`
-- ----------------------------
DROP TABLE IF EXISTS `SINTOMATOLOGIA`;
CREATE TABLE `SINTOMATOLOGIA` (
  `CodiceSintomatologia` INT(11) NOT NULL,
  `Descrizione` TEXT NOT NULL,
  `PiantaColpita` INT(11) NOT NULL,
		FOREIGN KEY (`PiantaColpita`) REFERENCES `PolliceVerde`.`pianta` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceSintomatologia`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `SINTOMATOLOGIA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`sintomatologia` (`CodiceSintomatologia`, `Descrizione`, `PiantaColpita`) VALUES ('1', 'arricciamento delle foglie', '10'), ('2', 'caduta foglie', '9'), ('3', 'cambio di colore', '8'), ('4', 'cambio di turgidità', '7'), ('5', 'interruzione fioritura', '6'), ('6', 'interruzione fruttificazione', '5'), ('7', 'crescita stentata', '4'), ('8', 'interruzione fioritura, interruzione fruttificazione', '3'), ('9', 'arricciamento delle foglie, caduta foglie', '2'), ('10', 'arricciamento delle foglie, cambio di colore', '1');
COMMIT;

-- ----------------------------
--  Table structure for `SINTOMO`
-- ----------------------------
DROP TABLE IF EXISTS `SINTOMO`;
CREATE TABLE `SINTOMO` (
  `CodiceSintomo` INT(11) NOT NULL,
  `SintomatologiaDiAppartenenza` INT(11) NOT NULL,
		FOREIGN KEY (`SintomatologiaDiAppartenenza`) REFERENCES `PolliceVerde`.`SINTOMATOLOGIA` (`CodiceSintomatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceSintomo`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `SINTOMO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`sintomo` (`CodiceSintomo`, `SintomatologiaDiAppartenenza`) VALUES ('1', '9'), ('2', '9'), ('3', '1'), ('4', '6'), ('5', '8'), ('6', '4'), ('7', '5'), ('8', '4'), ('9', '8'), ('10', '5');
COMMIT;

-- ----------------------------
--  Table structure for `IMMAGINE`
-- ----------------------------
DROP TABLE IF EXISTS `IMMAGINE`;
CREATE TABLE `IMMAGINE` (
  `CodiceImmagine` INT(11) NOT NULL,
  `NumeroPixel (x 10^5)` DECIMAL NOT NULL, 
  `SintomoRiscontrato` INT(11) NOT NULL,
		FOREIGN KEY (`SintomoRiscontrato`) REFERENCES `PolliceVerde`.`SINTOMO` (`CodiceSintomo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Dimensione (KB)` DECIMAL NOT NULL,
  PRIMARY KEY (`CodiceImmagine`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `IMMAGINE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`immagine` (`CodiceImmagine`, `NumeroPixel (x 10^5)`, `SintomoRiscontrato`, `Dimensione (KB)`) VALUES ('1', '49', '1', '1600'), ('2', '50', '1', '1700'), ('3', '45', '2', '1500'), ('4', '51', '2', '1800'), ('5', '52', '3', '1900'), ('6', '43', '3', '1400'), ('7', '42', '4', '1300'), ('8', '49', '4', '1600'), ('9', '49', '5', '1600'), ('10', '49', '5', '1600');
COMMIT;

-- ----------------------------
--  Table structure for `PATOLOGIA`
-- ----------------------------
DROP TABLE IF EXISTS `PATOLOGIA`;
CREATE TABLE `PATOLOGIA` (
  `CodicePatologia` INT(11) NOT NULL,
  `Contraccettivo` ENUM('Chimico', 'Biologico') NOT NULL, 
  `Sintomatologia` INT(11) NOT NULL,
		FOREIGN KEY (`Sintomatologia`) REFERENCES `PolliceVerde`.`SINTOMATOLOGIA` (`CodiceSintomatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `PeriodoInCuiColpisce` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoInCuiColpisce`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodicePatologia`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoPatologia` BEFORE INSERT ON `PATOLOGIA` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.PeriodoInCuiColpisce) <> 'Patologia' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;
  
-- ----------------------------
--  Records of `PATOLOGIA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('1', 'Chimico', '10', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('2', 'Biologico', '9', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('3', 'Chimico', '8', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('4', 'Biologico', '7', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('5', 'Chimico', '6', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('6', 'Biologico', '5', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('7', 'Chimico', '4', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('8', 'Biologico', '3', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('9', 'Chimico', '2', '7');
INSERT INTO `polliceverde`.`patologia` (`CodicePatologia`, `Contraccettivo`, `Sintomatologia`, `PeriodoInCuiColpisce`) VALUES ('10', 'Biologico', '1', '7');
COMMIT;

-- ----------------------------
--  Table structure for `AGENTEPATOGENO`
-- ----------------------------
DROP TABLE IF EXISTS `AGENTEPATOGENO`;
CREATE TABLE `AGENTEPATOGENO` (
  `CodiceAgentePatogeno` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Patologia` INT(11) NOT NULL,
		FOREIGN KEY (`Patologia`) REFERENCES `PolliceVerde`.`PATOLOGIA` (`CodicePatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Farmaco` INT(11) NOT NULL,
		FOREIGN KEY (`Farmaco`) REFERENCES `PolliceVerde`.`FARMACO` (`CodiceFarmaco`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceAgentePatogeno`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
-- ----------------------------
--  Records of `AGENTEPATOGENO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`agentepatogeno` (`CodiceAgentePatogeno`, `Nome`, `Patologia`, `Farmaco`) VALUES ('1', 'ponderosae ', '10', '2'), ('2', 'ljungiana', '9', '3'), ('3', 'pulchellana', '8', '1'), ('4', 'fragariae', '7', '5'), ('5', 'pyri', '6', '4'), ('6', 'sarta', '5', '6'), ('7', 'phloeocoptes', '4', '9'), ('8', 'erinea', '3', '7'), ('9', 'sheldoni ', '2', '8'), ('10', 'tulipae', '1', '10');
COMMIT;

-- ----------------------------
--  Table structure for `FARMACO`
-- ----------------------------
DROP TABLE IF EXISTS `FARMACO`;
CREATE TABLE `FARMACO` (
  `CodiceFarmaco` INT(11) NOT NULL,
  `PrincipioAttivo` VARCHAR(45) NOT NULL,
  `Somministrazione` ENUM('Nebulizzazione', 'Irrigazione', 'Nebulizzazione e Irrigazione') NOT NULL,
  `AmpioSpettro` TINYINT NOT NULL DEFAULT 0,
  `DosaggioConsigliato` INT(3) NOT NULL,
  `TempoMinPostsomministrazione` INT(3) NOT NULL,
  `PeriodoNonSomministrazione` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoNonSomministrazione`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Cura` INT(11) NOT NULL,
		FOREIGN KEY (`Cura`) REFERENCES `PolliceVerde`.`CURA` (`CodiceCura`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `AgentePatogenoCombattuto` INT(11) NOT NULL,
		FOREIGN KEY (`AgentePatogenoCombattuto`) REFERENCES `PolliceVerde`.`AGENTEPATOGENO` (`CodiceAgentePatogeno`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceFarmaco`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
-- ----------------------------
--  Records of `FARMACO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('1', 'Acido acetilsalicilico', 'Nebulizzazione', '1', '3', '30', '6', '10', '7');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('2', 'Aciclovir', 'Nebulizzazione', '0', '2', '60', '9', '9', '4');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('3', 'Betametasone', 'Nebulizzazione', '1', '3', '15', '6', '8', '1');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('4', 'Biperidene', 'Irrigazione', '0', '1', '30', '9', '7', '10');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('5', 'Felbamato', 'Irrigazione', '1', '2', '30', '6', '6', '8');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('6', 'Levetiracetam', 'Irrigazione', '0', '2', '15', '9', '5', '5');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('7', 'Modafinil', 'Nebulizzazione e Irrigazione', '1', '2', '15', '6', '1', '2');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('8', 'Naltrexone', 'Nebulizzazione e Irrigazione', '0', '3', '60', '9', '4', '3');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('9', 'Propafenone', 'Nebulizzazione e Irrigazione', '1', '1', '30', '6', '3', '9');
INSERT INTO `polliceverde`.`farmaco` (`CodiceFarmaco`, `PrincipioAttivo`, `Somministrazione`, `AmpioSpettro`, `DosaggioConsigliato`, `TempoMinPostsomministrazione`, `PeriodoNonSomministrazione`, `Cura`, `AgentePatogenoCombattuto`) VALUES ('10', 'Zonisamide', 'Nebulizzazione', '0', '3', '30', '9', '2', '6');
COMMIT;

-- ----------------------------
--  Table structure for `CURA`
-- ----------------------------
DROP TABLE IF EXISTS `CURA`;
CREATE TABLE `CURA` (
  `CodiceCura` INT(11) NOT NULL,
  `Data` DATE NOT NULL,
  `DosaggioEffettivo` INT(3) NOT NULL,
  `Farmaco` INT(11) NOT NULL,
		FOREIGN KEY (`Farmaco`) REFERENCES `PolliceVerde`.`FARMACO` (`CodiceFarmaco`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceCura`, `Data`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `CURA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`cura` (`CodiceCura`, `Data`, `DosaggioEffettivo`, `Farmaco`) VALUES ('1', '2016-12-05', '1', '10'), ('2', '2016-08-05', '1', '9'), ('3', '2015-06-23', '1', '8'), ('4', '2016-12-25', '2', '7'), ('5', '2016-04-11', '2', '6'), ('6', '2015-02-01', '2', '5'), ('7', '2014-07-20', '3', '4'), ('8', '2016-08-21', '3', '3'), ('9', '2016-06-22', '3', '2'), ('10', '2015-04-15', '3', '1');
COMMIT;

-- ----------------------------
--  Table structure for `ACCRESCIMENTO`
-- ----------------------------
DROP TABLE IF EXISTS `ACCRESCIMENTO`;  
CREATE TABLE `ACCRESCIMENTO` (
  `CodiceAccrescimento` INT(11) NOT NULL,
  `IndiceAccrescimento` DOUBLE GENERATED ALWAYS AS (GREATEST(AccrescimentoTop,AccrescimentoRoot)) VIRTUAL,
  `AccrescimentoTop` DOUBLE NOT NULL,
  `AccrescimentoRoot` DOUBLE NOT NULL,
  `Pianta` INT(11) NOT NULL,
		FOREIGN KEY (`Pianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceAccrescimento`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ACCRESCIMENTO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`accrescimento` (`CodiceAccrescimento`, `AccrescimentoTop`, `AccrescimentoRoot`, `Pianta`) VALUES ('1', '1.4', '0.6', '1'), ('2', '0.4', '0.6', '2'), ('3', '1', '3', '3'), ('4', '6', '2', '4'), ('5', '8', '2', '5'), ('6', '3', '0.7', '6'), ('7', '1.1', '0.5', '7'), ('8', '3', '3', '8'), ('9', '1.8', '1.8', '9'), ('10', '0.6', '0.8', '10');
COMMIT;

-- ----------------------------
--  Table structure for `LUCE`
-- ----------------------------
DROP TABLE IF EXISTS `LUCE`;
CREATE TABLE `LUCE` (
  `CodiceLuce` INT(11) NOT NULL,
  `EsposizioneVegetativaMin` INT(2) NOT NULL DEFAULT 0, /*ore al giorno*/
  `EsposizioneRiposoMin` INT(2) NOT NULL DEFAULT 0,
  `Tipo` ENUM('Luce', 'Penombra', 'Ombra') NOT NULL,
  `LuceDiretta` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`CodiceLuce`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
-- ----------------------------
--  Records of `LUCE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`luce` (`CodiceLuce`, `EsposizioneVegetativaMin`, `EsposizioneRiposoMin`, `Tipo`, `LuceDiretta`) VALUES ('1', '5', '3', '1', '1'), ('2', '6', '4', '2', '0'), ('3', '7', '5', '3', '1'), ('4', '8', '5', '1', '0'), ('5', '9', '4', '2', '1'), ('6', '10', '6', '3', '1'), ('7', '6', '5', '2', '0'), ('8', '7', '6', '1', '0'), ('9', '4', '4', '3', '0'), ('10', '7', '7', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `IRRIGAZIONE`
-- ----------------------------
DROP TABLE IF EXISTS `IRRIGAZIONE`;
CREATE TABLE `IRRIGAZIONE` (
  `CodiceIrrigazione` INT(11) NOT NULL,
  `QuantitaVegetativo` ENUM('Basso', 'Medio', 'Alto') NOT NULL,
  `QuantitaRiposo` ENUM('Basso', 'Medio', 'Alto') NOT NULL,
  `PeriodicitaVegetativa` INT(1) NOT NULL DEFAULT 0, /*giorni alla settimana*/
  `PeriodicitaRiposo` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CodiceIrrigazione`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `IRRIGAZIONE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('1', '1', '1', '7', '5');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('2', '2', '1', '5', '3');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('3', '3', '1', '3', '1');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('4', '1', '1', '6', '4');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('5', '2', '2', '5', '2');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('6', '3', '2', '4', '3');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('7', '1', '1', '7', '6');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('8', '2', '2', '5', '2');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('9', '3', '3', '3', '1');
INSERT INTO `polliceverde`.`irrigazione` (`CodiceIrrigazione`, `QuantitaVegetativo`, `QuantitaRiposo`, `PeriodicitaVegetativa`, `PeriodicitaRiposo`) VALUES ('10', '1', '1', '7', '3');
COMMIT;

-- ----------------------------
--  Table structure for `CONCIMAZIONE`
-- ----------------------------
DROP TABLE IF EXISTS `CONCIMAZIONE`;
CREATE TABLE `CONCIMAZIONE` (
  `CodiceConcimazione` INT(11) NOT NULL,
  `Somministrazione` ENUM('Aerea', 'Radicale') NOT NULL,
  `Quantita` FLOAT NOT NULL, /*totale*/
  `NumeroSomministrazioni` INT(2) NOT NULL DEFAULT 1,
  `Periodicita` INT(2) NULL,
  PRIMARY KEY (`CodiceConcimazione`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
-- ----------------------------
--  Records of `CONCIMAZIONE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`concimazione` (`CodiceConcimazione`, `Somministrazione`, `Quantita`, `NumeroSomministrazioni`, `Periodicita`) VALUES ('1', '1', '1', '2', '1'), ('2', '2', '1', '1', '1'), ('3', '1', '1', '3', '3'), ('4', '2', '1.5', '1', '2'), ('5', '1', '0.5', '3', '1'), ('6', '2', '2', '1', '3'), ('7', '1', '1.5', '2', '1'), ('8', '2', '2', '1', '2'), ('9', '1', '0.5', '3', '1'), ('10', '2', '2', '1', '3');
COMMIT;

-- ----------------------------
--  Table structure for `RINVASO`
-- ----------------------------
DROP TABLE IF EXISTS `RINVASO`;
CREATE TABLE `RINVASO` (
  `CodiceRinvaso` INT(11) NOT NULL,
  `DimensioneVasoNuovo` INT(11) NULL,
  PRIMARY KEY (`CodiceRinvaso`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `RINVASO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('1', '50');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('2', '100');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('3', '45');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('4', '50');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('5', '60');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('6', '85');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('7', '55');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('8', '15');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('9', '30');
INSERT INTO `polliceverde`.`rinvaso` (`CodiceRinvaso`, `DimensioneVasoNuovo`) VALUES ('10', '20');
COMMIT;

-- ----------------------------
--  Table structure for `POTATURA`
-- ----------------------------
DROP TABLE IF EXISTS `POTATURA`;
CREATE TABLE `POTATURA` (
  `CodicePotatura` INT(10) NOT NULL,
  `Tipo` ENUM('CONTENIMENTO DIMENSIONI', 'AUMENTO DI FIORI E FRUTTI', 'RIMOZIONI DI PARTI DANNEGGIATE', 'INTENSA') NOT NULL,
  `Perido` ENUM('Vegetativo', 'Riposo', 'Sempre'),
PRIMARY KEY (`CodicePotatura`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `POTATURA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`potatura` (`CodicePotatura`, `Tipo`, `Perido`) VALUES ('1', '1', '1'), ('2', '1', '2'), ('3', '1', '3'), ('4', '2', '1'), ('5', '2', '2'), ('6', '2', '3'), ('7', '3', '1'), ('8', '3', '2'), ('9', '3', '3'), ('10', '4', '1');
COMMIT;

-- ----------------------------
--  Table structure for `FABBISOGNO`
-- ----------------------------
DROP TABLE IF EXISTS `FABBISOGNO`;
CREATE TABLE `FABBISOGNO` (
  `CodiceFabbisogno` INT(11) NOT NULL,
  `Tipo` ENUM('Concimazione', 'Rinvaso', 'Potatura') NOT NULL,
  `CodiceTipo` INT(11) NOT NULL,
  `PeriodoConsigliato` INT(11) NOT NULL,
		FOREIGN KEY (`PeriodoConsigliato`) REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Pianta` INT(11) NOT NULL,
		FOREIGN KEY (`Pianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceFabbisogno`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
delimiter $$
CREATE TRIGGER `ControlloCodiceTipo` BEFORE INSERT ON `FABBISOGNO` FOR EACH ROW BEGIN
CASE
WHEN NEW.Tipo = 'Concimazione' THEN
IF NEW.CodiceTipo NOT IN ( SELECT CodiceConcimazione
							FROM CONCIMAZIONE) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Intervento di concimazione inesistente';
END IF;
WHEN NEW.Tipo = 'Rinvaso' THEN
IF NEW.CodiceTipo NOT IN ( SELECT CodiceRinvaso
							FROM RINVASO) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Intervento di rinvaso inesistente';
END IF;
WHEN NEW.Tipo = 'Potatura' THEN
IF NEW.CodiceTipo NOT IN ( SELECT CodicePotatura
							FROM POTATURA) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Intervento di potatura inesistente';
END IF;
END CASE;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoFabbisogno` BEFORE INSERT ON `FABBISOGNO` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.PeriodoConsigliato) <> 'Fabbisogno' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;

-- ----------------------------
--  Records of `FABBISOGNO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('1', 'Concimazione', '1', '4', '1');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('2', 'Concimazione', '2', '3', '1');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('3', 'Concimazione', '3', '4', '1');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('4', 'Rinvaso', '1', '3', '5');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('5', 'Rinvaso', '2', '4', '1');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('6', 'Rinvaso', '3', '3', '1');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('7', 'Concimazione', '9', '4', '2');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('8', 'Potatura', '1', '3', '1');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('9', 'Potatura', '2', '4', '2');
INSERT INTO `polliceverde`.`fabbisogno` (`CodiceFabbisogno`, `Tipo`, `CodiceTipo`, `PeriodoConsigliato`, `Pianta`) VALUES ('10', 'Potatura', '5', '3', '3');
COMMIT;

-- ----------------------------
--  Table structure for `INTERVENTO`
-- ----------------------------
DROP TABLE IF EXISTS `INTERVENTO`;
CREATE TABLE `INTERVENTO` (
  `CodiceIntervento` INT(11) NOT NULL,
  `Tipo` ENUM('Concimazione', 'Rinvaso', 'Potatura') NOT NULL,
  `CodiceTipo` INT(11) NOT NULL,
  `Data` DATE NOT NULL,
  `DataStimaProssimo` DATE NULL,
  `Pianta` INT(11) NOT NULL,
		FOREIGN KEY (`Pianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceIntervento`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
delimiter $$
CREATE TRIGGER `ControlloCodiceTipo2` BEFORE INSERT ON `INTERVENTO` FOR EACH ROW BEGIN
CASE
WHEN NEW.Tipo = 'Concimazione' THEN
IF NEW.CodiceTipo NOT IN ( SELECT CodiceConcimazione
							FROM CONCIMAZIONE) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Intervento di concimazione inesistente';
END IF;
WHEN NEW.Tipo = 'Rinvaso' THEN
IF NEW.CodiceTipo NOT IN ( SELECT CodiceRinvaso
							FROM RINVASO) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Intervento di rinvaso inesistente';
END IF;
WHEN NEW.Tipo = 'Potatura' THEN
IF NEW.CodiceTipo NOT IN ( SELECT CodicePotatura
							FROM POTATURA) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Intervento di potatura inesistente';
END IF;
END CASE;
END $$
delimiter ;  

delimiter $$
CREATE TRIGGER `ControlloData` BEFORE INSERT ON `INTERVENTO` FOR EACH ROW BEGIN
IF NEW.Data >= NEW.DataStimaProssimo THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da inserimento della data';
END IF;
END $$
delimiter ;
-- ----------------------------
--  Records of `INTERVENTO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('1', '1', '6', '2016-01-01', '2016-03-01', '6');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('2', '1', '5', '2016-01-01', '2016-03-01', '9');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('3', '1', '8', '2016-01-01', '2016-03-01', '5');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('4', '1', '2', '2016-02-01', '2016-08-01', '1');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('5', '2', '2', '2016-07-01', '2017-07-01', '1');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('6', '2', '3', '2016-08-01', '2016-09-01', '5');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('7', '2', '1', '2016-08-01', '2016-09-01', '4');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('8', '2', '5', '2016-08-01', '2016-09-01', '3');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('9', '3', '7', '2016-08-15', '2016-10-01', '2');
INSERT INTO `polliceverde`.`intervento` (`CodiceIntervento`, `Tipo`, `CodiceTipo`, `Data`, `DataStimaProssimo`, `Pianta`) VALUES ('10', '3', '10', '2016-08-15', '2016-10-01', '1');
COMMIT;
  
-- ----------------------------
--  Table structure for `TERRENO`
-- ----------------------------
DROP TABLE IF EXISTS `TERRENO`;
CREATE TABLE `TERRENO` (
  `CodiceTerreno` INT(11) NOT NULL,
  `PH` INT(2) NOT NULL DEFAULT 7,
  `Consistenza` ENUM('Alto', 'Medio', 'Basso') NOT NULL,
  `Permeabilita` ENUM('Alto', 'Medio', 'Basso', 'Inesistente') NOT NULL,
  PRIMARY KEY (`CodiceTerreno`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `TERRENO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`terreno` (`CodiceTerreno`, `PH`, `Consistenza`, `Permeabilita`) VALUES ('1', '5', '1', '1'), ('2', '6', '1', '2'), ('3', '1', '1', '3'), ('4', '0', '2', '4'), ('5', '7', '2', '1'), ('6', '9', '2', '2'), ('7', '13', '3', '3'), ('8', '6', '3', '4'), ('9', '8', '3', '1'), ('10', '4', '1', '2');
COMMIT;

-- ----------------------------
--  Table structure for `ELEMENTODISCIOLTO`
-- ----------------------------
DROP TABLE IF EXISTS `ELEMENTODISCIOLTO`;
CREATE TABLE `ELEMENTODISCIOLTO` (
  `CodiceElementoDisciolto` INT(11) NOT NULL,
  `PercentualePresenza` INT(3) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Terreno` INT(11) NULL,
  		FOREIGN KEY (`Terreno`) REFERENCES `PolliceVerde`.`TERRENO` (`CodiceTerreno`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Concimazione` INT(11) NULL,
  		FOREIGN KEY (`Concimazione`) REFERENCES `PolliceVerde`.`CONCIMAZIONE` (`CodiceConcimazione`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Microelemento` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`CodiceElementoDisciolto`, `PercentualePresenza`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `ValiditaElemento` BEFORE INSERT ON `ELEMENTODISCIOLTO` FOR EACH ROW BEGIN
SET @controllopercentuale = (SELECT SUM(PercentualePresenza)
							FROM ELEMENTODISCIOLTO
                            WHERE Terreno = NEW.Terreno
                            );
IF NEW.`Nome` IN ( SELECT Nome
				FROM ELEMENTODISCIOLTO
				WHERE Terreno = NEW.Terreno) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore! Elemento già inserito in questo terreno';
ELSEIF NEW.`Nome` IN ( SELECT Nome
						FROM ELEMENTODISCIOLTO
						WHERE Concimazione = NEW.Concimazione) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore! Elemento già inserito in questo intervento di concimazione';
ELSEIF (NEW.`PercentualePresenza` + @controllopercentuale > 100) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore! Percentuale complessiva superiore al 100%';
END IF;    
END $$
delimiter ;
-- ----------------------------
--  Records of `ELEMENTODISCIOLTO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`elementodisciolto` (`CodiceElementoDisciolto`, `PercentualePresenza`, `Terreno`, `Concimazione`, `Microelemento`,`Nome`) VALUES ('1', '10', '10', '10', '1', 'Boro'), ('2', '33', '1', '9', '0', 'Azoto'), ('3', '33', '1', '8', '1', 'Ferro'), ('4', '33', '1', '7', '1', 'Zinco'), ('5', '25', '3', '6', '0', 'Fosforo'), ('6', '25', '4', '5', '0', 'Ferro'), ('7', '25', '2', '4', '1', 'Ferro'), ('8', '25', '3', '3', '0', 'Potassio'), ('9', '50', '2', '2', '1', 'Azoto'), ('10', '50', '5', '1', '0', 'Ferro');
COMMIT;

-- ----------------------------
--  Table structure for `ORDINE`
-- ----------------------------
DROP TABLE IF EXISTS `ORDINE`;
CREATE TABLE `ORDINE` (
  `CodiceOrdine` INT(11) NOT NULL,
  `Data` DATE NOT NULL,
  `Acquirente` INT(11) NOT NULL,
  		FOREIGN KEY (`Acquirente`) REFERENCES `PolliceVerde`.`CLIENT` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Stato` ENUM('In processazione', 'In preparazione', 'Spedito', 'Evaso', 'Pendente') NOT NULL,
  `Scheda` INT(11) NOT NULL,
  		FOREIGN KEY (`Scheda`) REFERENCES `PolliceVerde`.`SCHEDA` (`CodiceScheda`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Pianta` INT(11) NOT NULL,
  		FOREIGN KEY (`Pianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceOrdine`, `Data`, `Acquirente`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ORDINE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`ordine` (`CodiceOrdine`, `Data`, `Acquirente`, `Stato`, `Scheda`, `Pianta`) VALUES ('1', '2015-04-15', '10', '1', '7', '5'), ('2', '2016-06-22', '9', '1', '10', '6'), ('3', '2016-08-21', '8', '2', '9', '10'), ('4', '2014-07-20', '7', '2', '8', '5'), ('5', '2015-02-01', '6', '3', '4', '6'), ('6', '2016-04-11', '5', '3', '6', '4'), ('7', '2016-12-25', '4', '4', '5', '8'), ('8', '2015-06-23', '3', '4', '1', '5'), ('9', '2016-08-05', '2', '5', '3', '10'), ('10', '2016-12-05', '1', '5', '2', '7');
COMMIT;

-- ----------------------------
--  Table structure for `SCHEDA`
-- ----------------------------
DROP TABLE IF EXISTS `SCHEDA`;
CREATE TABLE `SCHEDA` (
  `CodiceScheda` INT(11) NOT NULL,
  `NomePianta` VARCHAR(45) NULL,
  `CodicePianta` INT(11) NULL,
		FOREIGN KEY (`CodicePianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `DataAcquisto` DATE NOT NULL,
  `Cliente` INT(11) NOT NULL,
  		FOREIGN KEY (`Cliente`) REFERENCES `PolliceVerde`.`CLIENT` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `DimensioneContenitore` INT(11) NULL, 
  `DimensioneAcquisto` INT(3) NOT NULL,
  `TerrenoAperto` TINYINT(1) NULL DEFAULT 0,
  `Tipo` ENUM('Ordine', 'Manutenzione Automatica', 'Manutenzione Programmata', 'Manutenzione Privata', 'Manutenzione su richiesta') NOT NULL,
  `Prezzo` FLOAT NOT NULL,
  PRIMARY KEY (`CodiceScheda`, `Cliente`, `DataAcquisto`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `ValiditaScheda` BEFORE INSERT ON `SCHEDA` FOR EACH ROW BEGIN
IF (NEW.DimensioneContenitore IS NOT NULL AND NEW.TerrenoAperto = 1) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da inserimento! La pianta o è in terreno aperto 
						o ha contenitore di dimensione definita';
ELSEIF NEW.Tipo = 'Ordine' AND NEW.CodicePianta IN (SELECT CodicePianta
													FROM SCHEDA
                                                    WHERE Tipo = 'Ordine') THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore! Pianta gia` ordinata!';
END IF;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `InserisciAttributi` BEFORE INSERT ON `SCHEDA` FOR EACH ROW BEGIN
SET NEW.DimensioneContenitore = (SELECT SuperficieOccupata
								 FROM CONTENITORE
								 WHERE CodiceContenitore = (SELECT Contenitore 
														    FROM Pianta
															WHERE CodicePianta = NEW.CodicePianta)
								);
IF NEW.DimensioneContenitore IS NULL THEN
SET NEW.TerrenoAperto = 1;
END IF;
END$$
delimiter ;

-- ----------------------------
--  Records of `SCHEDA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('1', 'rosa', '2016-06-22', '10', '6', '1', '20.00', '1');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('2', 'enturium', '2015-04-15', '9', '5', '1', '2.00', '2');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('3', 'viola', '2016-12-05', '8', '5', '2', '24.00', '1');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('4', 'ninfea', '2016-08-05', '7', '10', '2', '30.00', '3');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('5', 'cipresso', '2015-06-23', '6', '5', '3', '25.00', '1');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('6', 'crisantemo', '2016-12-25', '5', '8', '3', '20.50', '4');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('7', 'ginestra', '2016-04-11', '4', '10', '4', '10.00', '1');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('8', 'girasole', '2015-02-01', '3', '8', '4', '15.00', '5');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('9', 'aloe', '2014-07-20', '2', '10', '5', '22.30', '1');
INSERT INTO `polliceverde`.`scheda` (`CodiceScheda`, `NomePianta`, `DataAcquisto`, `Cliente`, `DimensioneAcquisto`, `Tipo`, `Prezzo`, `CodicePianta`) VALUES ('10', 'gladiolo', '2016-08-21', '1', '5', '5', '21.00', '9');
COMMIT;

-- ----------------------------
--  Table structure for `MANUTENZIONEPRIVATA`
-- ----------------------------
DROP TABLE IF EXISTS `MANUTENZIONEPRIVATA`;
CREATE TABLE `MANUTENZIONEPRIVATA` (
  `CodiceManutenzionePrivata` INT(11) NOT NULL,
  `DataEsecuzione` DATE NOT NULL,
  `Tipo` ENUM('Rinvaso', 'Piantumazione', 'Trattamento contro patologie', 'Concimazione', 'Potatura') NOT NULL,
  `Scheda` INT(11) NOT NULL,
  PRIMARY KEY (`CodiceManutenzionePrivata`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `MANUTENZIONEPRIVATA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('1', '2014-06-23', '1', '5');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('2', '2015-02-15', '2', '4');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('3', '2015-06-21', '3', '6');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('4', '2016-02-15', '4', '1');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('5', '2016-05-15', '5', '3');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('6', '2015-12-08', '5', '8');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('7', '2015-05-15', '4', '9');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('8', '2015-05-15', '3', '7');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('9', '2015-04-15', '1', '10');
INSERT INTO `polliceverde`.`manutenzioneprivata` (`CodiceManutenzionePrivata`, `DataEsecuzione`, `Tipo`, `Scheda`) VALUES ('10', '2015-05-15', '2', '2');
COMMIT;

-- ----------------------------
--  Table structure for `MANUTENZIONESURICHIESTA`
-- ----------------------------
DROP TABLE IF EXISTS `MANUTENZIONESURICHIESTA`;
CREATE TABLE `MANUTENZIONESURICHIESTA` (
  `CodiceManutenzioneSuRichiesta` INT(11) NOT NULL,
  `DataScadenza` DATE NOT NULL,
  `Tipo` ENUM('Rinvaso', 'Piantumazione', 'Trattamento contro patologie', 'Concimazione', 'Potatura') NOT NULL,
  `Scheda` INT(11) NOT NULL,
  `Stato` ENUM('Eseguita', 'In attesa') NOT NULL,
  `PersonaleRichiesto` INT(2) NOT NULL,
  `Prezzo` FLOAT NOT NULL,  
  PRIMARY KEY (`CodiceManutenzioneSuRichiesta`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `MANUTENZIONESURICHIESTA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('1', '2015-01-15', 'Potatura', '10', 'In attesa', '6', '50');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('2', '2015-03-15', 'Concimazione', '9', 'Eseguita', '3', '20');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('3', '2015-05-20', 'Trattamento contro patologie', '8', 'In attesa', '4', '30');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('4', '2015-05-15', 'Piantumazione', '7', 'Eseguita', '3', '20');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('5', '2015-05-10', 'Rinvaso', '6', 'In attesa', '3', '20');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('6', '2015-04-15', 'Potatura', '5', 'In attesa', '3', '25');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('7', '2015-12-15', 'Concimazione', '4', 'Eseguita', '2', '15');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('8', '2016-05-15', 'Trattamento contro patologie', '3', 'Eseguita', '4', '35');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('9', '2015-05-15', 'Piantumazione', '2', 'In attesa', '1', '10');
INSERT INTO `polliceverde`.`manutenzionesurichiesta` (`CodiceManutenzioneSuRichiesta`, `DataScadenza`, `Tipo`, `Scheda`, `Stato`, `PersonaleRichiesto`, `Prezzo`) VALUES ('10', '2016-02-13', 'Rinvaso', '1', 'Eseguita', '2', '20');
COMMIT;

-- ----------------------------
--  Table structure for `MANUTENZIONEPROGRAMMATA`
-- ----------------------------
DROP TABLE IF EXISTS `MANUTENZIONEPROGRAMMATA`;
CREATE TABLE `MANUTENZIONEPROGRAMMATA` (
  `CodiceManutenzioneProgrammata` INT(11) NOT NULL,
  `Periodo` INT(11) NOT NULL
		REFERENCES `PolliceVerde`.`PERIODO` (`CodicePeriodo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Tipo` ENUM('Rinvaso', 'Piantumazione', 'Trattamento contro patologie', 'Concimazione', 'Potatura') NOT NULL,
  `Scheda` INT(11) NOT NULL,
  `Periodicita` INT(11) NOT NULL, /*mesi*/ 
  `PersonaleRichiesto` INT(2) NOT NULL,
  `Prezzo` FLOAT NOT NULL,  
  PRIMARY KEY (`CodiceManutenzioneProgrammata`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `ValiditaPeriodoProgrammata` BEFORE INSERT ON `MANUTENZIONEPROGRAMMATA` FOR EACH ROW BEGIN
IF (SELECT Tipo
	FROM PERIODO
    WHERE CodicePeriodo = NEW.Periodo) <> 'Manutenzione programmata' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da vincolo di integrita referenziale con la tabella PERIODO';
END IF;
END $$
delimiter ;

-- ----------------------------
--  Records of `MANUTENZIONEPROGRAMMATA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('1', '5', '4', '2', '1', '1', '15.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('2', '5', '3', '4', '2', '2', '15.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('3', '5', '2', '8', '3', '2', '15.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('4', '5', '5', '6', '2', '1', '10.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('5', '5', '1', '9', '3', '2', '15.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('6', '5', '2', '7', '4', '3', '25.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('8', '5', '1', '5', '2', '3', '20.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('9', '5', '3', '3', '1', '3', '30.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('10', '5', '4', '10', '1', '4', '35.00');
INSERT INTO `polliceverde`.`manutenzioneprogrammata` (`CodiceManutenzioneProgrammata`, `Periodo`, `Tipo`, `Scheda`, `Periodicita`, `PersonaleRichiesto`, `Prezzo`) VALUES ('7', '5', '5', '1', '2', '3', '20.00');
COMMIT;

-- ----------------------------
--  Table structure for `CLIENTE`
-- ----------------------------
DROP TABLE IF EXISTS `CLIENT`;
CREATE TABLE `CLIENT` (
  `CodiceCliente` INT(11) NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `DomandaDiSicurezza` VARCHAR(45) NOT NULL,
  `RispostaDomandaSicurezza` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `Residenza` VARCHAR(45) NOT NULL,
  `NumeroValutazioni` INT(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CodiceCliente`, `Nickname`, `Email`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `CLIENT`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`client` (`CodiceCliente`, `Nickname`, `Email`, `Password`, `DomandaDiSicurezza`, `RispostaDomandaSicurezza`, `Nome`, `Cognome`, `Residenza`, `NumeroValutazioni`) VALUES 
('1', 'ddc95', 'yesiam01@gmail.com', 'uffa', 'hai voluto fare lo scemo', 'e  mo t\'attacchi', 'diego', 'del castello', 'roma', '12'),
('2', 'tdl96', 'yesiam02@gmail.com', 'non', 'perché', 'boh', 'teresa', 'di lascio', 'pisa', '25'),
('3', 'banana33', 'yesiam03@gmail.com', 'riesco', 'quante', 'tante', 'pistolesi', 'annonna', 'livorno', '75'),
('4', 'padoin23', 'yesiam04@gmail.com', 'a', 'tutte', 'niente', 'radja', 'nainggolan', 'bruxelles', '84'),
('5', 'fragola86', 'yesiam05@gmail.com', 'decidere', 'ricordarmele', 'no', 'walter', 'mazzarri', 'firenze', '55'),
('6', 'kitten90', 'yesiam06@gmail.com', 'la', 'figuriamoci', 'ma infatti', 'woicech', 'szczesny', 'varsavia', '63'),
('7', 'muort60', 'yesiam07@gmail.com', 'password', 'poi', 'sarà come morire', 'edin', 'dzeko', 'sarajevo', '74'),
('8', 'hola69', 'yesiam08@gmail.com', 'mia', 'altro', 'che facile', 'kevin', 'strootman', 'amsterdam', '25'),
('9', 'lettera6', 'yesiam09@gmail.com', 'figuriamoci', 'qualcun', 'dovrà pur esserci', 'kostas', 'manolas', 'atene', '34'), 
('10', '45questoprimailnumero', 'yesiam10@gmail.com', 'quella', 'di ', 'là', 'mohamed', 'salah', 'il cairo', '66');
COMMIT;

-- ----------------------------
--  Table structure for `POST`
-- ----------------------------
DROP TABLE IF EXISTS `POST`;
CREATE TABLE `POST` (
  `CodicePost` INT(11) NOT NULL,
  `Timestamp` TIMESTAMP NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL
		REFERENCES `PolliceVerde`.`CLIENT` (`Nickname`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Thread` INT(11) NOT NULL,
  `Testo` TEXT(255) NOT NULL,
  `Link` LONGTEXT NULL,
  PRIMARY KEY (`CodicePost`, `Timestamp`, `Thread`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `POST`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`post` (`CodicePost`, `Timestamp`, `Nickname`, `Thread`, `Testo`, `Link`) VALUES
('1', '2017-01-01 00:00:01', 'banana33', '7895', 'buon anno a tutti', 'http://www.pollicegreen.com/6-fiori-portafortuna-capodanno-foto/32852/'),
('3', '2016-08-08 15:01:17', 'ddc95', '84', 'non c\'è cactus senza spine', 'https://www.giardinaggio.it/grasse/piante-grasse.asp'),
('5', '2016-04-25 17:10:26', 'banana33', '321', 'maremma tra tutti sti farmaci non ci si capisce più nulla torno ai rimedi della nonna', 'https://www.ideegreen.it/piante-medicinali-elenco-schede-71252.html'),
('8', '2016-07-25 12:54:01', 'tdl96', '515151', 'ecco cosa ci vuole', 'http://www.ecoage.it/deforestazione.htm'),
('9', '2016-06-23 13:17:49', 'ddc95', '3213165', 'per il mio compleanno guardate cosa mi hanno regalato!', 'https://s-media-cache-ak0.pinimg.com/736x/0f/7a/cd/0f7acdc9feba374482b5faf75e5e82b2.jpg');
INSERT INTO `polliceverde`.`post` (`CodicePost`, `Timestamp`, `Nickname`, `Thread`, `Testo`) VALUES 
('2', '2017-01-02 11:43:01', 'padoin23', '351', 'gente che per prima cosa nell\'anno nuovo fa gli auguri alle piante'),
('4', '2015-06-30 17:48:54', 'tdl96', '49841', 'un giorno da giardiniere è un giorno bellissimo'),
('6', '2016-02-17 22:26:32', 'padoin23', '8716', 'juventino infame per te solo lame'),
('7', '2015-01-09 08:32:10', 'tdl96', '6516512', 'un giorno a implementare databases è un giorno snervante'),
('10', '2015-04-15 23:08:01', 'fragola86', '846513', 'avresti fatto 10 anni...');
COMMIT;

-- ----------------------------
--  Table structure for `COMMENTODIRISPOSTA`
-- ----------------------------
DROP TABLE IF EXISTS `COMMENTODIRISPOSTA`;
CREATE TABLE `COMMENTODIRISPOSTA` (
  `CodiceCommentoDiRisposta` INT(11) NOT NULL,
  `Timestamp` TIMESTAMP NOT NULL,
  `Post` INT(11) NOT NULL,
  		FOREIGN KEY (`Post`) REFERENCES `PolliceVerde`.`POST` (`CodicePost`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Nickname` VARCHAR(45) NOT NULL
        REFERENCES `PolliceVerde`.`CLIENT` (`Nickname`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Testo` TEXT(255) NOT NULL,
  PRIMARY KEY (`CodiceCommentoDiRisposta`, `Timestamp`, `Post`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `COMMENTODIRISPOSTA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`commentodirisposta` (`CodiceCommentoDiRisposta`, `Timestamp`, `Post`, `Nickname`, `Testo`) VALUES ('1', '2017-01-02 11:53:01', '2', 'tdl96', 'ahahahaha muoio'), ('2', '2017-01-02 12:43:01', '2', 'ddc95', 'gente strana'), ('3', '2016-06-23 13:49:49', '9', 'banana33', 'chiamala rritaa'), ('4', '2016-07-25 13:54:01', '8', 'padoin23', 'sarebbe ora!!'), ('5', '2015-01-09 08:34:10', '7', 'banana33', '30 e lode va bene o preferisce ridarlo?'), ('6', '2016-02-17 22:32:26', '6', 'ddc95', 'fagliene un paio che ti ho pure sul fanta godo doppio!!'), ('7', '2016-04-25 17:26:10', '5', 'fragola86', 'sono sempre i migliori'), ('8', '2015-06-30 17:54:48', '4', 'ddc95', 'e tanto quello andremo a fare!!'), ('9', '2016-08-08 15:17:01', '3', 'fragola86', 'un poeta'), ('10', '2017-01-01 00:01:00', '1', 'fragola86', 'grazie');
COMMIT;

-- ----------------------------
--  Table structure for `VALUTAZIONE`
-- ----------------------------
DROP TABLE IF EXISTS `VALUTAZIONE`;
CREATE TABLE `VALUTAZIONE` (
  `CodiceValutazione` INT(11) NOT NULL,
  `CommentoDiRisposta` INT(11) NOT NULL 
        REFERENCES `PolliceVerde`.`COMMENTODIRISPOSTA` (`CodiceCommentoDiRisposta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Punteggio` INT(1) NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL
        REFERENCES `PolliceVerde`.`CLIENT` (`Nickname`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`Codicevalutazione`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `PrimaRidondanzaInsert` AFTER INSERT ON `VALUTAZIONE` FOR EACH ROW BEGIN
SET @ClientInteressato = (SELECT Nickname
						FROM COMMENTODIRISPOSTA
                        WHERE NEW.CommentoDiRisposta = CodiceCommentoDiRisposta
                        );
UPDATE `CLIENT`
SET `NumeroValutazioni` = `NumeroValutazioni` + 1  
WHERE `Nickname` = @ClientInteressato;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `PrimaRidondanzaDelete` AFTER DELETE ON `VALUTAZIONE` FOR EACH ROW BEGIN
SET @ClientInteressato = (SELECT Nickname
						FROM COMMENTODIRISPOSTA
                        WHERE OLD.CommentoDiRisposta = CodiceCommentoDiRisposta
                        );
UPDATE `CLIENT`
SET `NumeroValutazioni` = `NumeroValutazioni` - 1  
WHERE `Nickname` = @ClientInteressato;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `VerificaValutazione` BEFORE INSERT ON `VALUTAZIONE` FOR EACH ROW BEGIN
IF NEW.Punteggio > 5 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Valutazione fuori parametro!!';
END IF;
END $$
delimiter ;
-- ----------------------------
--  Records of `VALUTAZIONE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`valutazione` (`CodiceValutazione`, `CommentoDiRisposta`, `Punteggio`, `Nickname`) VALUES ('1', '10', '1', 'ddc95'), ('2', '9', '2', 'fragola86'), ('3', '8', '3', 'padoin23'), ('4', '7', '4', 'banana33'), ('5', '6', '5', 'tdl96'), ('6', '5', '1', 'fragola86'), ('7', '4', '2', 'ddc95'), ('8', '3', '3', 'tdl96'), ('9', '2', '4', 'padoin23'), ('10', '1', '5', 'banana33');
COMMIT;

-- ----------------------------
--  Table structure for `GIARDINO`
-- ----------------------------
DROP TABLE IF EXISTS `GIARDINO`;
CREATE TABLE `GIARDINO` (
  `CodiceGiardino` INT(11) NOT NULL,
  `Cliente` INT(11) NOT NULL,
  		FOREIGN KEY (`Cliente`) REFERENCES `PolliceVerde`.`CLIENT` (`CodiceCliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `NumeroOggetti` INT(3) NOT NULL DEFAULT 0,
  `NumeroSettori` INT(2) NOT NULL DEFAULT 1,
  `Lunghezza` INT(2) NOT NULL,
  `Larghezza` INT(2) NOT NULL,
  PRIMARY KEY (`CodiceGiardino`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `GIARDINO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('1', '10', '10', '7', '8', '5');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('2', '9', '12', '5', '15', '25');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('3', '8', '6', '3', '20', '30');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('4', '7', '8', '5', '20', '15');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('5', '6', '16', '4', '15', '20');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('6', '5', '4', '5', '30', '20');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('7', '4', '7', '1', '25', '15');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('8', '3', '9', '3', '25', '30');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('9', '2', '11', '4', '15', '20');
INSERT INTO `polliceverde`.`giardino` (`CodiceGiardino`, `Cliente`, `NumeroOggetti`, `NumeroSettori`, `Lunghezza`, `Larghezza`) VALUES ('10', '1', '10', '3', '20', '15');
COMMIT;

-- ----------------------------
--  Table structure for `SETTORE`
-- ----------------------------
DROP TABLE IF EXISTS `SETTORE`;
CREATE TABLE `SETTORE` (
  `CodiceSettore` INT(11) NOT NULL,
  `Giardino` INT(11) NOT NULL,
  		FOREIGN KEY (`Giardino`) REFERENCES `PolliceVerde`.`GIARDINO` (`CodiceGiardino`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Ascissa` INT(11) NOT NULL,
  `Ordinata` INT(11) NOT NULL,
  `Lunghezza` INT(2) NOT NULL,
  `Larghezza` INT(2) NOT NULL,
  PRIMARY KEY (`CodiceSettore`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delimiter $$
CREATE TRIGGER `ValiditaSettore` BEFORE INSERT ON `SETTORE` FOR EACH ROW BEGIN
SET @lunghezza = (SELECT Lunghezza
					FROM GIARDINO
                    WHERE CodiceGiardino = NEW.Giardino);
SET @larghezza = (SELECT Larghezza
					FROM GIARDINO
                    WHERE CodiceGiardino = NEW.Giardino);
IF !(NEW.Ascissa BETWEEN 0 AND @larghezza*100
	AND NEW.Ordinata BETWEEN 0 AND @lunghezza*100
    AND NEW.Ascissa + NEW.Larghezza <= @larghezza*100
    AND NEW.Ordinata + NEW.Lunghezza <= @lunghezza*100) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore! Il settore fuoriesce dal giardino';
END IF;
END $$
delimiter ;


delimiter $$
CREATE TRIGGER `IntersezioneSettore` BEFORE INSERT ON `SETTORE` FOR EACH ROW BEGIN

DECLARE ascissa INT(11);
DECLARE fineascissa INT(11);
DECLARE ordinata INT(11);
DECLARE fineordinata INT(11);

DECLARE cursoreascisse CURSOR FOR
SELECT Ascissa
FROM SETTORE
WHERE Giardino = NEW.Giardino;

DECLARE cursorefineascisse CURSOR FOR
SELECT (Ascissa + Larghezza)
FROM SETTORE
WHERE Giardino = NEW.Giardino;

DECLARE cursoreordinate CURSOR FOR
SELECT Ordinata
FROM SETTORE
WHERE Giardino = NEW.Giardino;

DECLARE cursorefineordinate CURSOR FOR
SELECT (Ordinata + Lunghezza)
FROM SETTORE
WHERE Giardino = NEW.Giardino;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET @finito = 1;

OPEN cursoreascisse;
OPEN cursorefineascisse;
OPEN cursoreordinate;
OPEN cursorefineordinate;

verifica: LOOP
FETCH cursoreascisse INTO ascissa;
FETCH cursorefineascisse INTO fineascissa;
FETCH cursoreordinate INTO ordinata;
FETCH cursorefineordinate INTO fineordinata;

IF @finito = 1 THEN 
LEAVE verifica;
END IF;
IF (NEW.Ascissa BETWEEN  ascissa AND fineascissa
	AND NEW.Ordinata BETWEEN ordinata AND fineordinata) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da intersezione';
END IF;    
END LOOP verifica;

CLOSE cursoreascisse;
CLOSE cursorefineascisse;

END $$
delimiter ;

-- ----------------------------
--  Records of `SETTORE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('1', '1', '0', '0', '600', '200');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('2', '1', '0', '600', '200', '500');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('3', '1', '200', '0', '100', '300');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('4', '10', '0', '0', '1000', '1000');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('5', '9', '0', '0', '1000', '1000');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('6', '8', '0', '0', '1000', '2000');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('7', '7', '0', '0', '2000', '1000');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('8', '6', '0', '0', '1500', '1500');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('9', '5', '0', '0', '1000', '1000');
INSERT INTO `polliceverde`.`settore` (`CodiceSettore`, `Giardino`, `Ascissa`, `Ordinata`, `Lunghezza`, `Larghezza`) VALUES ('10', '4', '0', '0', '1500', '1000');
COMMIT;

-- ----------------------------
--  Table structure for `VASO`
-- ----------------------------
DROP TABLE IF EXISTS `VASO`;
CREATE TABLE `VASO` (
  `CodiceVaso` INT(11) NOT NULL,
  `Settore` INT(11) NOT NULL,
	    FOREIGN KEY (`Settore`) REFERENCES `PolliceVerde`.`SETTORE` (`CodiceSettore`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `Ascissa` INT(11) NOT NULL,
  `Ordinata` INT(11) NOT NULL,
  `Lato` INT(2) NOT NULL,
  PRIMARY KEY (`CodiceVaso`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  
delimiter $$
CREATE TRIGGER `ValiditaVaso` BEFORE INSERT ON `VASO` FOR EACH ROW BEGIN
SET @iniziosettoreX = (SELECT Ascissa
					FROM SETTORE
                    WHERE CodiceSettore = NEW.Settore);
SET @finesettoreX = (SELECT Ascissa + Larghezza
					FROM SETTORE
                    WHERE CodiceSettore = NEW.Settore);
SET @iniziosettoreY = (SELECT Ordinata
					FROM SETTORE
                    WHERE CodiceSettore = NEW.Settore);
SET @finesettoreY = (SELECT Ordinata + Lunghezza
					FROM SETTORE
                    WHERE CodiceSettore = NEW.Settore);
IF !(NEW.Ascissa BETWEEN @iniziosettoreX AND @finesettoreX
	AND NEW.Ordinata BETWEEN @iniziosettoreY AND @finesettoreY
    AND NEW.Ascissa + NEW.Lato BETWEEN @iniziosettoreX AND @finesettoreX
    AND NEW.Ordinata + NEW.Lato BETWEEN @iniziosettoreY AND @finesettoreY) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore! Il vaso fuoriesce dal settore';
END IF;
END $$
delimiter ;

delimiter $$
CREATE TRIGGER `IntersezioneVaso` BEFORE INSERT ON `VASO` FOR EACH ROW BEGIN

DECLARE ascissa INT(11);
DECLARE fineascissa INT(11);
DECLARE ordinata INT(11);
DECLARE fineordinata INT(11);

DECLARE cursoreascisse CURSOR FOR
SELECT Ascissa
FROM VASO
WHERE Settore = NEW.Settore;

DECLARE cursorefineascisse CURSOR FOR
SELECT (Ascissa + Lato) AS Fine
FROM VASO
WHERE Settore = NEW.Settore;

DECLARE cursoreordinate CURSOR FOR
SELECT Ordinata
FROM VASO
WHERE Settore = NEW.Settore;

DECLARE cursorefineordinate CURSOR FOR
SELECT (Ordinata + Lato)
FROM VASO
WHERE Settore = NEW.Settore;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET @finito = 1;

OPEN cursoreascisse;
OPEN cursorefineascisse;
OPEN cursoreordinate;
OPEN cursorefineordinate;

verifica: LOOP
FETCH cursoreascisse INTO ascissa;
FETCH cursorefineascisse INTO fineascissa;
FETCH cursoreordinate INTO ordinata;
FETCH cursorefineordinate INTO fineordinata;

IF @finito = 1 THEN 
LEAVE verifica;
END IF;
IF (NEW.Ascissa BETWEEN  ascissa AND fineascissa
	AND NEW.Ordinata BETWEEN ordinata AND fineordinata) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Errore da intersezione';
END IF;    
END LOOP verifica;

CLOSE cursoreascisse;
CLOSE cursorefineascisse;

END $$
delimiter ;

-- ----------------------------
--  Records of `VASO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('1', '9', '0', '0', '200');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('2', '8', '0', '0', '500');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('3', '7', '0', '0', '700');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('4', '1', '0', '0', '200');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('5', '1', '0', '200', '200');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('6', '5', '0', '0', '500');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('7', '4', '0', '0', '400');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('8', '3', '200', '0', '80');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('9', '2', '0', '600', '150');
INSERT INTO `polliceverde`.`vaso` (`CodiceVaso`, `Settore`, `Ascissa`, `Ordinata`, `Lato`) VALUES ('10', '1', '0', '400', '200');
COMMIT;


-- ----------------------------
--  Table structure for `ESECUZIONE_CONCIMAZIONE`
-- ----------------------------
DROP TABLE IF EXISTS `ESECUZIONE_CONCIMAZIONE`;
CREATE TABLE `ESECUZIONE_CONCIMAZIONE` (
  `CodiceConcimazione` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceConcimazione`) REFERENCES `PolliceVerde`.`CONCIMAZIONE` (`CodiceConcimazione`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodiceIntervento` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceIntervento`) REFERENCES `PolliceVerde`.`INTERVENTO` (`CodiceIntervento`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceIntervento`, `CodiceConcimazione`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ESECUZIONE_CONCIMAZIONE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('1', '1');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('2', '2');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('3', '3');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('4', '4');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('5', '5');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('6', '6');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('7', '7');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('8', '8');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('9', '9');
INSERT INTO `polliceverde`.`esecuzione_concimazione` (`CodiceConcimazione`, `CodiceIntervento`) VALUES ('10', '10');
COMMIT;
  
-- ----------------------------
--  Table structure for `PRESENZA`
-- ----------------------------
DROP TABLE IF EXISTS `PRESENZA`;
CREATE TABLE `PRESENZA` (
  `CodiceElementoDisciolto` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceElementoDisciolto`) REFERENCES `PolliceVerde`.`ELEMENTODISCIOLTO` (`CodiceElementoDisciolto`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodiceTerreno` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceTerreno`) REFERENCES `PolliceVerde`.`TERRENO` (`CodiceTerreno`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceElementoDisciolto`, `CodiceTerreno`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `PRESENZA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('1', '1');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('2', '2');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('3', '3');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('4', '4');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('5', '5');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('6', '6');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('7', '7');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('8', '8');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('9', '9');
INSERT INTO `polliceverde`.`presenza` (`CodiceElementoDisciolto`, `CodiceTerreno`) VALUES ('10', '10');
COMMIT;
  
-- ----------------------------
--  Table structure for `ESORDIO`
-- ----------------------------
DROP TABLE IF EXISTS `ESORDIO`;
CREATE TABLE `ESORDIO` (
  `CodiceSintomatologia` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceSintomatologia`) REFERENCES `PolliceVerde`.`SINTOMATOLOGIA` (`CodiceSintomatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodicePatologia` INT(11) NOT NULL,
	    FOREIGN KEY (`CodicePatologia`) REFERENCES `PolliceVerde`.`PATOLOGIA` (`CodicePatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceSintomatologia`, `CodicePatologia`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ESORDIO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('1', '1');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('2', '2');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('3', '3');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('4', '4');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('5', '5');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('6', '6');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('7', '7');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('8', '8');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('9', '9');
INSERT INTO `polliceverde`.`esordio` (`CodiceSintomatologia`, `CodicePatologia`) VALUES ('10', '10');
COMMIT;
  
-- ----------------------------
--  Table structure for `ESIGENZA`
-- ----------------------------
DROP TABLE IF EXISTS `ESIGENZA`;
CREATE TABLE `ESIGENZA` (
  `CodiceFabbisogno` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceFabbisogno`) REFERENCES `PolliceVerde`.`FABBISOGNO` (`CodiceFabbisogno`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodicePianta` INT(11) NOT NULL,
	    FOREIGN KEY (`CodicePianta`) REFERENCES `PolliceVerde`.`PIANTA` (`CodicePianta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodicePianta`, `CodiceFabbisogno`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ESIGENZA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('1', '1');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('2', '2');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('3', '3');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('4', '4');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('6', '5');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('5', '6');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('7', '7');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('8', '8');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('9', '9');
INSERT INTO `polliceverde`.`esigenza` (`CodiceFabbisogno`, `CodicePianta`) VALUES ('10', '10');
COMMIT;

-- ----------------------------
--  Table structure for `ESECUZIONE_RINVASO`
-- ----------------------------
DROP TABLE IF EXISTS `ESECUZIONE_RINVASO`;
CREATE TABLE `ESECUZIONE_RINVASO` (
  `CodiceRinvaso` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceRinvaso`) REFERENCES `PolliceVerde`.`RINVASO` (`CodiceRinvaso`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodiceIntervento` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceIntervento`) REFERENCES `PolliceVerde`.`INTERVENTO` (`CodiceIntervento`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceIntervento`, `CodiceRinvaso`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ESECUZIONE_RINVASO`
-- ----------------------------
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('1', '1');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('2', '2');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('3', '3');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('4', '4');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('5', '5');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('6', '6');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('7', '7');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('8', '8');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('9', '9');
INSERT INTO `polliceverde`.`esecuzione_rinvaso` (`CodiceRinvaso`, `CodiceIntervento`) VALUES ('10', '10');

  
-- ----------------------------
--  Table structure for `INDIVIDUAZIONE`
-- ----------------------------
DROP TABLE IF EXISTS `INDIVIDUAZIONE`;
CREATE TABLE `INDIVIDUAZIONE` (
  `Nome` VARCHAR(45) NOT NULL
		REFERENCES `PolliceVerde`.`AGENTEPATOGENO` (`Nome`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodicePatologia` INT(11) NOT NULL,
	    FOREIGN KEY (`CodicePatologia`) REFERENCES `PolliceVerde`.`PATOLOGIA` (`CodicePatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodicePatologia`, `Nome`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `INDIVIDUAZIONE`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('ponderosae ', '1');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('ljungiana', '2');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('pulchellana', '3');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('fragariae', '4');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('pyri', '5');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('sarta', '6');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('phloeocoptes', '7');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('erinea', '8');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('sheldoni', '9');
INSERT INTO `polliceverde`.`individuazione` (`Nome`, `CodicePatologia`) VALUES ('tulipae', '10');
COMMIT;
  
-- ----------------------------
--  Table structure for `APPARTENENZA`
-- ----------------------------
DROP TABLE IF EXISTS `APPARTENENZA`;
CREATE TABLE `APPARTENENZA` (
  `CodiceSintomo` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceSintomo`) REFERENCES `PolliceVerde`.`SINTOMO` (`CodiceSintomo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodiceSintomatologia` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceSintomatologia`) REFERENCES `PolliceVerde`.`SINTOMATOLOGIA` (`CodiceSintomatologia`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`CodiceSintomo`, `CodiceSintomatologia`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `APPARTENENZA`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('1', '1');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('2', '2');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('3', '3');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('4', '4');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('5', '5');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('6', '6');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('7', '7');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('8', '8');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('9', '9');
INSERT INTO `polliceverde`.`appartenenza` (`CodiceSintomo`, `CodiceSintomatologia`) VALUES ('10', '10');
COMMIT;
  
-- ----------------------------
--  Table structure for `TRATTAMENTO`
-- ----------------------------
DROP TABLE IF EXISTS `TRATTAMENTO`;
CREATE TABLE `TRATTAMENTO` (
  `Nome` VARCHAR(45) NOT NULL
		REFERENCES `PolliceVerde`.`AGENTEPATOGENO` (`Nome`) ON DELETE NO ACTION ON UPDATE CASCADE,
  `CodiceFarmaco` INT(11) NOT NULL,
	    FOREIGN KEY (`CodiceFarmaco`) REFERENCES `PolliceVerde`.`FARMACO` (`CodiceFarmaco`) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY (`Nome`, `CodiceFarmaco`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `TRATTAMENTO`
-- ----------------------------
BEGIN;
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('ponderosae ', '1');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('ljungiana', '2');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('pulchellana', '3');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('fragariae', '4');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('pyri', '5');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('sarta', '6');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('phloeocoptes', '7');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('erinea', '8');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('sheldoni', '9');
INSERT INTO `polliceverde`.`trattamento` (`Nome`, `CodiceFarmaco`) VALUES ('tulipae', '10');
COMMIT;
 
 
 
 
 


-- --------------------------------------
-- Funzione per il calcolo della credibilità
-- --------------------------------------

DROP FUNCTION IF EXISTS `CalcolaCredibilita`;

DELIMITER $$
CREATE FUNCTION `CalcolaCredibilita`(nickname VARCHAR(45)) RETURNS DOUBLE
BEGIN
DECLARE commentiDiRispostaComplessivi INT(11) DEFAULT 0;
DECLARE media DOUBLE DEFAULT 0;
DECLARE credibilita DOUBLE DEFAULT 0;
SET commentiDiRispostaComplessivi = (
			SELECT COUNT(*)
            FROM COMMENTODIRISPOSTA
            WHERE Nickname = nickname
            );
SET media = ( SELECT AVG(V.Punteggio)
			  FROM COMMENTODIRISPOSTA CDR INNER JOIN VALUTAZIONE V 
                     ON CDR.CodiceCommentoDiRisposta = V.CommentoDiRisposta
			  WHERE CDR.Nickname= nickname
              );
SET credibilita= media * commentiDiRispostaComplessivi;
RETURN media;
END$$
DELIMITER ;

-- ---------------------------------------------------
-- Funzione per il calcolo dell'indice di manutenzione
-- ---------------------------------------------------

DROP FUNCTION IF EXISTS `IndiceManutenzione`;

DELIMITER $$
CREATE FUNCTION `IndiceManutenzione`(pianta INT(11)) RETURNS VARCHAR(45)
BEGIN
SET @indiceAccrescimento = (SELECT IndiceAccrescimento
							FROM ACCRESCIMENTO
							WHERE Pianta = pianta);
IF @indiceAccrescimento <= 1 THEN
SET @manutenzioneAccrescimento = 2;
ELSEIF @indiceAccrescimento > 1 AND @indiceAccrescimento <=3 THEN
SET @manutenzioneAccrescimento = 5;
ELSE
SET @manutenzioneAccrescimento = 7;
END IF;
SET @volteinQuarantena = (SELECT COUNT(*)
							FROM QUARANTENA
							WHERE Pianta = pianta);
IF @volteinQuarantena < 3 THEN
SET @manutenzioneQuarantena = 2;
ELSEIF @volteinQuarantena >= 3 AND @volteinQuarantena <6 THEN
SET @manutenzioneQuarantena = 5;
ELSE
SET @manutenzioneQuarantena = 10;
END IF;

IF @manutenzioneQuarantena + @manutenzioneAccrescimento < 8 THEN
SET @IndiceManutenzione = 'Basso';
ELSEIF @manutenzioneQuarantena + @manutenzioneAccrescimento BETWEEN 8 AND 14 THEN
SET @IndiceManutenzione = 'Medio';
ELSE
SET @IndiceManutenzione = 'Alto';
END IF;

RETURN @IndiceManutenzione;
END$$
DELIMITER ;
/*
UPDATE PIANTA
SET IndiceManutenzione = IndiceManutenzione(CodicePianta);
*/
-- ---------------------------------------------------
-- Funzione per il calcolo della distanza minima tra due piante
-- ---------------------------------------------------

DROP FUNCTION IF EXISTS `DistanzaMinima`;

DELIMITER $$
CREATE FUNCTION `DistanzaMinima`(pianta1 INT(11), pianta2 INT(11)) RETURNS DOUBLE
BEGIN
SET @contenitore1 = (SELECT Contenitore
					FROM PIANTA
					WHERE CodicePianta= pianta1);
SET @contenitore2 = (SELECT Contenitore
					FROM PIANTA
					WHERE CodicePianta= pianta2);

IF @contenitore1 IS NOT NULL OR @contenitore2 IS NOT NULL THEN
SET @distanzamin = (SELECT MAX(A.AccrescimentoTop)/4
					FROM PIANTA P INNER JOIN ACCRESCIMENTO A 
						  ON P.Accrescimento = A.CodiceAccrescimento 
					WHERE P.CodicePianta = pianta1 OR P.CodicePianta = pianta2
                    );
ELSE
SET @terreno1 = (SELECT Terreno
				FROM PIANTA
                WHERE CodicePianta= pianta1);
SET @terreno2 = (SELECT Terreno
				FROM PIANTA
                WHERE CodicePianta= pianta2);
SET @fattoreElementi = (SELECT MAX(ABS(ED1.PercentualePresenza - ED2.PercentualePresenza))/4
							FROM ELEMENTODISCIOLTO ED1 INNER JOIN ELEMENTODISCIOLTO ED2 
								  ON (ED1.Terreno = @terreno1 AND ED2.Terreno = @terreno2
									  AND ED1.Nome = ED2.Nome));
SET @fattoreAccrescimento = (SELECT MAX(A.IndiceAccrescimento)/4
							FROM PIANTA P INNER JOIN ACCRESCIMENTO A 
								  ON P.Accrescimento = A.CodiceAccrescimento 
							WHERE P.CodicePianta = pianta1 OR P.CodicePianta = pianta2
							);
SET @distanzamin = GREATEST(@fattoreElementi,@fattoreAccrescimento);
END IF;
SET @verifica1 = (SELECT Infestante
				FROM PIANTA
                WHERE CodicePianta= pianta1);
SET @verifica2 = (SELECT Infestante
				FROM PIANTA
                WHERE CodicePianta= pianta2);
IF @verifica1 = 1 OR @verifica2 = 1 THEN
SET @distanzamin = @distanzamin * 2;
END IF;

RETURN @distanzamin;
END$$
DELIMITER ;

-- ----------------------------------------------------
-- Procedura per la funzione analytic: Smart Design
-- ----------------------------------------------------

DROP PROCEDURE IF EXISTS `SmartDesign`;

DELIMITER $$
CREATE PROCEDURE `SmartDesign` (IN _costomax FLOAT, IN _periodofioritura INT(11), IN _indicemanutenzione VARCHAR(45))
BEGIN
SELECT *
FROM PIANTA
WHERE IndiceManutenzione = _indicemanutenzione
	AND Prezzo <= _costomax
    AND PeriodoFioritura = _periodofioritura;
END$$
DELIMITER ;

-- ----------------------------------------------------
-- Procedura per la funzione analytic: Indagini Statistiche
-- ----------------------------------------------------

DROP PROCEDURE IF EXISTS `IndaginiStatistiche`;

DELIMITER $$
CREATE PROCEDURE `IndaginiStatistiche` (IN _patologia INT(11), IN _inizioPeriodo DATE, IN _finePeriodo DATE)
BEGIN
SELECT CodiceSezione, Temperatura, Umidita, Irrigazione, Illuminazione 
FROM SEZIONE
WHERE CodiceSezione IN (SELECT Sezione 
						FROM PIANTA
                        WHERE CodicePianta in (SELECT Pianta
												FROM QUARANTENA
												WHERE Patologia = _patologia
													AND DataInizio - INTERVAL 1 DAY >= _inizioPeriodo 
													AND DataInizio - INTERVAL 1 DAY <= _finePeriodo
											)
                    );
END$$
DELIMITER ;


-- ----------------------------------------------------
-- Procedura per la funzione analytic: Reporting
-- ----------------------------------------------------

DROP PROCEDURE IF EXISTS `Reporting`;

DELIMITER $$

CREATE PROCEDURE `Reporting` (IN _inizio DATE, IN _fine DATE)
BEGIN

CREATE OR REPLACE VIEW quarantene AS
SELECT Q.*, COUNT(*) AS NumQuarantene
FROM QUARANTENA Q INNER JOIN PIANTA P ON P.CodicePianta = Q.Pianta
WHERE P.Cultivar = 1
GROUP BY Q.Pianta;

CREATE OR REPLACE VIEW ordini AS
SELECT O.*, COUNT(*) AS NumOrdini
FROM ORDINE O INNER JOIN PIANTA P ON P.CodicePianta = O.Pianta
WHERE P.Cultivar = 1
GROUP BY O.Pianta;

(
	SELECT *, 'Elevata manutenzione'
	FROM (
			SELECT Q.Pianta, Q.CodiceQuarantena, Q.NumQuarantene,
			  (SELECT 1 + COUNT(*)
			   FROM quarantene Q0
			   WHERE Q0.NumQuarantene > Q.NumQuarantene
				 AND Q0.DataInizio BETWEEN _inizio AND _fine
			   ) AS Rank
			FROM quarantene Q
		  ) AS D
	WHERE D.Rank <=3
	ORDER BY D.Pianta, D.Rank
)  UNION (
			SELECT *, 'Pochi ordini'
			FROM (
					SELECT O.Pianta, O.CodiceOrdine, O.NumOrdini,
					  (SELECT 1 + COUNT(*)
					   FROM ordini O0
					   WHERE O0.Data BETWEEN _inizio AND _fine
							AND O0.NumOrdini < O.NumOrdini
					   ) AS Rank
					FROM ordini O
				  ) AS D
			WHERE D.Rank <=3
			ORDER BY D.Pianta, D.Rank
		);
END$$

DELIMITER ;

CREATE OR REPLACE VIEW ordiniperreport AS
SELECT O.*, COUNT(*) AS NumOrdini
FROM ORDINE O INNER JOIN PIANTA P ON P.CodicePianta = O.Pianta
GROUP BY O.Pianta;

CREATE OR REPLACE VIEW ordinitarget AS
(SELECT Nome, Genere
FROM PIANTA
WHERE CodicePianta IN (
						SELECT Pianta
						FROM ORDINE
						WHERE Stato = 'Pendente'
                        ))
UNION(
SELECT D.Nome, D.Genere
FROM (
		SELECT P.Nome, P.Genere,
		  (SELECT 1 + COUNT(*)
		   FROM ordiniperreport O0 INNER JOIN PIANTA P0 ON P0.CodicePianta = O0.Pianta
		   WHERE P0.Nome = P.Nome
				AND O0.NumOrdini > O.NumOrdini
		   ) AS Rank
		FROM ordiniperreport O INNER JOIN PIANTA P ON P.CodicePianta = O.Pianta
	  ) AS D
WHERE D.Rank <=3
ORDER BY D.Nome, D.Genere, D.Rank);

END$$

DELIMITER ;
/*
-- ----------------------------
--  Table structure for `REPORT_ORDINE`
-- ----------------------------
DROP TABLE IF EXISTS `REPORT_ORDINE`;
CREATE TABLE `REPORT_ORDINE` (
  `CodiceReport` INT(11) NOT NULL DEFAULT 1,
  `NomePianta` VARCHAR(45) NOT NULL,
  `GenerePianta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodiceReport`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `REPORT_ORDINE`
-- ----------------------------
BEGIN;
INSERT INTO `REPORT_ORDINE`
SELECT (SELECT IF(EXISTS (SELECT CodiceReport
						FROM REPORT_ORDINE), MAX(CodiceReport)+1, 1)
		FROM REPORT_ORDINE) AS CodiceReport, O.*
FROM ordinitarget O
COMMIT;*/