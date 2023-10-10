-- Active: 1696323393835@@127.0.0.1@3306

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `passportData` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `birthDate` VARCHAR(45) NOT NULL,
  `exemption` VARCHAR(45) NOT NULL
);



CREATE TABLE IF NOT EXISTS `mydb`.`SupportEmployee`
(
    `idSupportEmployee` INT     NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `responseStat`      INT     NOT NULL,
    `accesible`         TINYINT NOT NULL,
    `lastSeen`          DATE    NOT NULL
);


CREATE TABLE IF NOT EXISTS `mydb`.`SupportRequest`
(
    `idSupportRequest` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `requestText` VARCHAR(45) NOT NULL,
    `User_idUser` INT NOT NULL,
    `SupportEmployee_idSupportEmployee` INT,
    FOREIGN KEY (`User_idUser`) REFERENCES `mydb`.`User` (`idUser`),
    FOREIGN KEY (`SupportEmployee_idSupportEmployee`) REFERENCES `mydb`.`User` (`idUser`)
);

CREATE TABLE IF NOT EXISTS `mydb`.`PaymentStatus`
(
    `idPaymentStatus` INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `statusDetails`   VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS `mydb`.`Reciept` (
  `idReciept` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `total` INT NOT NULL,
  `closeTime` DATE NULL,
  `User_idUser` INT NOT NULL,
  `PaymentStatus_idPaymentStatus` INT NOT NULL,
  CONSTRAINT `fk_Reciept_User`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`),
  CONSTRAINT `fk_Reciept_PaymentStatus1`
    FOREIGN KEY (`PaymentStatus_idPaymentStatus`)
    REFERENCES `mydb`.`PaymentStatus` (`idPaymentStatus`)
);

CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `idOrder` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `creationDate` DATE NOT NULL,
  `paymentmethod` VARCHAR(45) NOT NULL,
  `PaymentStatus_idPaymentStatus` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  CONSTRAINT `fk_Order_PaymentStatus1`
    FOREIGN KEY (`PaymentStatus_idPaymentStatus`)
    REFERENCES `mydb`.`PaymentStatus` (`idPaymentStatus`),
  CONSTRAINT `fk_Order_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
);

CREATE TABLE IF NOT EXISTS `mydb`.`Company` (
  `companyName` VARCHAR(45) NOT NULL PRIMARY KEY,
  `mainInfo` VARCHAR(45) NOT NULL,
  `park` VARCHAR(45) NOT NULL,
  `since` VARCHAR(45) NOT NULL,
  `annualPassTraffic` INT NULL);

CREATE TABLE IF NOT EXISTS `mydb`.`CompanyMark` (
  `idCompanyMark` VARCHAR(45) NOT NULL PRIMARY KEY,
  `Company_companyName` VARCHAR(45) NOT NULL,
  `userName` VARCHAR(45) NOT NULL,
  `mark` VARCHAR(45) NOT NULL,
  `markText` VARCHAR(45) NULL,
  CONSTRAINT `fk_CompanyMark_Company1`
    FOREIGN KEY (`Company_companyName`)
    REFERENCES `mydb`.`Company` (`companyName`));


CREATE TABLE IF NOT EXISTS `mydb`.`Flight` (
  `idFlight` VARCHAR(18) NOT NULL PRIMARY KEY,
  `route` VARCHAR(45) NOT NULL,
  `passengerQty` INT NOT NULL,
  `duration` INT NULL);

CREATE TABLE IF NOT EXISTS `mydb`.`Flight_has_Company` (
  `Flight_idFlight` VARCHAR(18) NOT NULL,
  `Company_companyName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Flight_idFlight`, `Company_companyName`),
  CONSTRAINT `fk_Flight_has_Company_Flight1`
    FOREIGN KEY (`Flight_idFlight`)
    REFERENCES `mydb`.`Flight` (`idFlight`),
  CONSTRAINT `fk_Flight_has_Company_Company1`
    FOREIGN KEY (`Company_companyName`)
    REFERENCES `mydb`.`Company` (`companyName`));

CREATE TABLE IF NOT EXISTS `mydb`.`TechnicalStatus` (
  `idTechnicalStatus` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTechnicalStatus`));

CREATE TABLE IF NOT EXISTS `mydb`.`Plane` (
  `idPlane` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `calSign` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  `maintenance` DATE NOT NULL,
  `TechnicalStatus_idTechnicalStatus` INT NOT NULL,
  `Flight_idFlight` VARCHAR(18) NOT NULL,
  CONSTRAINT `fk_Plane_TechnicalStatus1`
    FOREIGN KEY (`TechnicalStatus_idTechnicalStatus`)
    REFERENCES `mydb`.`TechnicalStatus` (`idTechnicalStatus`),
  CONSTRAINT `fk_Plane_Flight1`
    FOREIGN KEY (`Flight_idFlight`)
    REFERENCES `mydb`.`Flight` (`idFlight`));


CREATE TABLE IF NOT EXISTS `mydb`.`Place` (
  `idPlace` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `row` VARCHAR(45) NOT NULL,
  `class` VARCHAR(45) NOT NULL,
  `Plane_idPlane` INT NOT NULL,
  CONSTRAINT `fk_Place_Plane1`
    FOREIGN KEY (`Plane_idPlane`)
    REFERENCES `mydb`.`Plane` (`idPlane`));


-- DROP table `mydb`.`Ticket`;

CREATE TABLE IF NOT EXISTS `mydb`.`Ticket` (
  `idTicket` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `ticketLink` VARCHAR(45) NULL,
  `Place_idPlace` INT NOT NULL,
  `Order_idOrder` INT NOT NULL,
  CONSTRAINT `fk_Ticket_Place1`
    FOREIGN KEY (`Place_idPlace`)
    REFERENCES `mydb`.`Place` (`idPlace`),
  CONSTRAINT `fk_Ticket_Order1`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `mydb`.`Order` (`idOrder`));


