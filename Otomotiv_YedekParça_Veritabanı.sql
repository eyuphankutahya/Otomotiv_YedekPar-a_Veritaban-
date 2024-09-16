-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

CREATE SCHEMA IF NOT EXISTS `vize` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Calısan` (
  `CalısanID` INT NOT NULL,
  `İsimSoyisim` VARCHAR(40) NOT NULL,
  `Telefon` INT NOT NULL,
  `Adres` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Maas` INT NOT NULL,
  `HesapNumarası` INT NOT NULL,
  PRIMARY KEY (`CalısanID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Musteri` (
  `MüşteriID` INT NOT NULL,
  `MüşteriAdı` VARCHAR(45) NOT NULL,
  `Telefon` INT NOT NULL,
  `Adres` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`MüşteriID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vize`.`Satıs` (
  `SatısID` INT NOT NULL,
  `FısID` INT NOT NULL,
  `SatısTarihi` DATE NOT NULL,
  `Adet` INT NOT NULL,
  `BirimFiyat` INT NOT NULL,
  `ToplamTutar` INT NOT NULL,
  `OdemeTipi` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`SatısID`, `FısID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `mydb`.`Musteri_Satıs` (
  `Musteri_MusteriID` INT NOT NULL,
  `Satıs_SatısID` INT NOT NULL,
  `Satıs_FısID` INT NOT NULL,
  PRIMARY KEY (`Musteri_MusteriID`, `Satıs_SatısID`, `Satıs_FısID`),
  INDEX `fk_Musteri_has_Satıs_Satıs1_idx` (`Satıs_SatısID` ASC, `Satıs_FısID` ASC) VISIBLE,
  INDEX `fk_Musteri_has_Satıs_Musteri_idx` (`Musteri_MusteriID` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `vize`.`Urunler` (
  `ÜrünID` INT NOT NULL,
  `ÜrünAdı` VARCHAR(50) NOT NULL,
  `Resim` BLOB NOT NULL,
  `MevcutStok` INT NOT NULL,
  `KritikStok` INT NOT NULL,
  `AlısFiyat` INT NOT NULL,
  `SatısFiyat` INT NOT NULL,
  `AlımTarihi` DATE NOT NULL,
  `TedarikciID` INT NOT NULL,
  PRIMARY KEY (`ÜrünID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `vize`.`Satıs_Urunler` (
  `Satıs_SatısID` INT NOT NULL,
  `Satıs_FısID` INT NOT NULL,
  `Urunler_ÜrünID` INT NOT NULL,
  PRIMARY KEY (`Satıs_SatısID`, `Satıs_FısID`, `Urunler_ÜrünID`),
  INDEX `fk_Satıs_has_Urunler_Urunler1_idx` (`Urunler_ÜrünID` ASC) VISIBLE,
  INDEX `fk_Satıs_has_Urunler_Satıs1_idx` (`Satıs_SatısID` ASC, `Satıs_FısID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `vize`.`Tedarik` (
  `TedarikciID` INT NOT NULL,
  `FirmaIsmi` VARCHAR(40) NOT NULL,
  `YetkiliKisi` VARCHAR(40) NOT NULL,
  `Adres` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Telefon` INT NOT NULL,
  `Websitesi` VARCHAR(40) NOT NULL,
  `Iban` INT NOT NULL,
  `GuncelBakiye` INT NOT NULL,
  PRIMARY KEY (`TedarikciID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `vize`.`Tedarik_Urunler` (
  `Tedarik_TedarikciID` INT NOT NULL,
  `Urunler_ÜrünId` INT NOT NULL,
  PRIMARY KEY (`Tedarik_TedarikciID`, `Urunler_ÜrünId`),
  INDEX `fk_Tedarik_has_Urunler_Urunler1_idx` (`Urunler_ÜrünId` ASC) VISIBLE,
  INDEX `fk_Tedarik_has_Urunler_Tedarik1_idx` (`Tedarik_TedarikciID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `vize`.`Fatura` (
  `Fatura_ID` INT NOT NULL,
  `FaturaTipi` VARCHAR(25) NOT NULL,
  `FaturaTarihi` DATE NOT NULL,
  `ÜrünAdı` VARCHAR(40) NOT NULL,
  `ÜrünAdet` INT NOT NULL,
  `BirimFiyat` INT NOT NULL,
  `KdvOran` INT NOT NULL,
  `İskontoOranı` INT NOT NULL,
  `ToplamFiyat` INT NOT NULL,
  `VergiDairesi` VARCHAR(20) NOT NULL,
  `VergiNumarası` INT NOT NULL,
  `TeslimAlanKisi` VARCHAR(25) NOT NULL,
  `Tedarik_Urunler_Tedarik_TedarikciID` INT NOT NULL,
  `Tedarik_Urunler_Urunler_ÜrünID` INT NOT NULL,
  PRIMARY KEY (`Fatura_ID`, `Tedarik_Urunler_Tedarik_TedarikciID`, `Tedarik_Urunler_Urunler_ÜrünID`),
  INDEX `fk_Fatura_Tedarik_Urunler1_idx` (`Tedarik_Urunler_Tedarik_TedarikciID` ASC, `Tedarik_Urunler_Urunler_ÜrünID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `mydb`.`Muhasebe` (
  `Masraf` INT NOT NULL,
  `Calısan_CalısanID` INT NOT NULL,
  `Musteri_Satıs_Musteri_MüşteriID` INT NOT NULL,
  `Satıs_Urunler_Satıs_SatısID` INT NOT NULL,
  `Satıs_Urunler_Satıs_FısID` INT NOT NULL,
  `Satıs_Urunler_Urunler_ÜrünID(Satılan)` INT NOT NULL,
  `Fatura_Fatura_ID` INT NOT NULL,
  `Fatura_Tedarik_Urunler_Tedarik_TedarikcID` INT NOT NULL,
  `Fatura_Tedarik_Urunler_Urunler_ÜrünID(Alınan)` INT NOT NULL,
  PRIMARY KEY (`Calısan_CalısanID`, `Musteri_Satıs_Musteri_MüşteriID`, `Satıs_Urunler_Satıs_SatısID`, `Satıs_Urunler_Satıs_FısID`, `Satıs_Urunler_Urunler_ÜrünID(Satılan)`, `Fatura_Fatura_ID`, `Fatura_Tedarik_Urunler_Tedarik_TedarikcID`, `Fatura_Tedarik_Urunler_Urunler_ÜrünID(Alınan)`),
  INDEX `fk_Muhasebe_Musteri_Satıs1_idx` (`Musteri_Satıs_Musteri_MüşteriID` ASC) VISIBLE,
  INDEX `fk_Muhasebe_Satıs_Urunler1_idx` (`Satıs_Urunler_Satıs_SatısID` ASC, `Satıs_Urunler_Satıs_FısID` ASC, `Satıs_Urunler_Urunler_ÜrünID(Satılan)` ASC) VISIBLE,
  INDEX `fk_Muhasebe_Fatura1_idx` (`Fatura_Fatura_ID` ASC, `Fatura_Tedarik_Urunler_Tedarik_TedarikcID` ASC, `Fatura_Tedarik_Urunler_Urunler_ÜrünID(Alınan)` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Kategori` (
  `AracBilgileriID` INT NOT NULL,
  `Marka` VARCHAR(40) NOT NULL,
  `Model` VARCHAR(40) NOT NULL,
  `AracModelYılı` INT NOT NULL,
  `AltModelBilgisi` VARCHAR(40) NOT NULL,
  `MotorTipi` VARCHAR(40) NOT NULL,
  `MotorHacmi` INT NOT NULL,
  `YakıtTürü` VARCHAR(40) NOT NULL,
  `KullanıldığıKısım` VARCHAR(40) NOT NULL,
  `ParçaSınıfı` VARCHAR(40) NOT NULL,
  `ParcaTipi` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`AracBilgileriID`))
ENGINE = InnoDB;

USE `vize` ;

CREATE TABLE IF NOT EXISTS `vize`.`Urunler_Kategori` (
  `Urunler_ÜrünID` INT NOT NULL,
  `Kategori_AracBilgileriID` INT NOT NULL,
  PRIMARY KEY (`Urunler_ÜrünID`, `Kategori_AracBilgileriID`),
  INDEX `fk_Urunler_has_Kategori_Kategori1_idx` (`Kategori_AracBilgileriID` ASC) VISIBLE,
  INDEX `fk_Urunler_has_Kategori_Urunler_idx` (`Urunler_ÜrünID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
