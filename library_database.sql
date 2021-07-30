-- skip creating database if exists, create if not exists, and select the library database --
CREATE DATABASE IF NOT EXISTS `library`;
USE library;

-- drop tables if exists --
DROP TABLE IF EXISTS `library`.`loans` ;
DROP TABLE IF EXISTS `library`.`books` ;
DROP TABLE IF EXISTS `library`.`publishers` ;
DROP TABLE IF EXISTS `library`.`authors` ;
DROP TABLE IF EXISTS `library`.`patrons` ;

-- create table `library`.`patrons` --
CREATE TABLE IF NOT EXISTS `library`.`patrons` (
  `patronID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NOT NULL,
  `middleName` VARCHAR(50) NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `phoneNumber` VARCHAR(20) NULL,
  `emailAddress` VARCHAR(320) NULL,
  `totalFees` DECIMAL(10,2) DEFAULT 0.00,
  PRIMARY KEY (`patronID`),
  UNIQUE INDEX `patronID_UNIQUE` (`patronID` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC));

-- create table `library`.`authors` --
CREATE TABLE IF NOT EXISTS `library`.`authors` (
  `authorID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NOT NULL,
  `middleName` VARCHAR(50) NULL,
  `lastName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`authorID`),
  UNIQUE INDEX `authorID_UNIQUE` (`authorID` ASC));
  -- create table `library`.`publishers` --
  DROP TABLE IF EXISTS `library`.`publishers` ;

  CREATE TABLE IF NOT EXISTS `library`.`publishers` (
    `publisherID` INT NOT NULL AUTO_INCREMENT,
    `publisherName` VARCHAR(256) NOT NULL,
    PRIMARY KEY (`publisherID`),
    UNIQUE INDEX `publisherID_UNIQUE` (`publisherID` ASC));

-- create table `library`.`books` --
CREATE TABLE IF NOT EXISTS `library`.`books` (
  `bookID` INT NOT NULL AUTO_INCREMENT,
  `bookTitle` VARCHAR(256) NOT NULL,
  `authorID` INT NOT NULL,
  `edition` VARCHAR(45) NOT NULL,
  `isbn` VARCHAR(25) NOT NULL,
  `callNumber` VARCHAR(75) NOT NULL,
  `publisherID` INT NOT NULL,
  PRIMARY KEY (`bookID`),
  UNIQUE INDEX `bookID_UNIQUE` (`bookID` ASC),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC),
  UNIQUE INDEX `callNumber_UNIQUE` (`callNumber` ASC),
  INDEX `publisherID_idx` (`publisherID` ASC),
  INDEX `authorID_idx` (`authorID` ASC),
  CONSTRAINT `publisherID`
    FOREIGN KEY (`publisherID`)
    REFERENCES `library`.`publishers` (`publisherID`),
  CONSTRAINT `authorID`
    FOREIGN KEY (`authorID`)
    REFERENCES `library`.`authors` (`authorID`));

-- create table `library`.`loans` --
CREATE TABLE IF NOT EXISTS `library`.`loans` (
  `loanID` INT NOT NULL AUTO_INCREMENT,
  `bookID` INT NOT NULL,
  `patronID` INT NOT NULL,
  `dueDate` DATETIME NOT NULL,
  `borrowDate` DATETIME NOT NULL,
  `returnDate` DATETIME NULL,
  PRIMARY KEY (`loanID`),
  UNIQUE INDEX `loanID_UNIQUE` (`loanID` ASC),
  INDEX `patronID_idx` (`patronID` ASC),
  INDEX `bookID_idx` (`bookID` ASC),
  CONSTRAINT `patronID`
    FOREIGN KEY (`patronID`)
    REFERENCES `library`.`patrons` (`patronID`),
  CONSTRAINT `bookID`
    FOREIGN KEY (`bookID`)
    REFERENCES `library`.`books` (`bookID`));

-- insert data into table `library`.`authors` --
INSERT INTO `authors` (authorID, firstName, middleName, lastName) VALUES
(1, 'George', NULL, 'Orwell'),
(2, 'J.R.R.', NULL, 'Tolkien'),
(3, 'Philip', 'K', 'Dick');

-- insert data into table `library`.`publishers` --
INSERT INTO `publishers` (publisherID, publisherName) VALUES
(1, 'Harper Collins'),
(2, 'Del Rey'),
(3, 'Signet Classics');

-- insert data into table `library`.`books` --
INSERT INTO `books` (bookID, bookTitle, authorID, edition, isbn, callNumber, publisherID) VALUES
(1, 'The Hobbit', 2, '70th Anniversary edition', 0261102214, 'DS249.46 .H35 1926', 1),
(2, '1984', 1, 'Unabridged, January 1, 1961', 9780451524935, 'DFwr9.67 .H23 1943', 3),
(3, 'Do Androids Dream of Electric Sheep?', 3, 'May 28, 1996', 0345404475, 'DQie8.77 .F25 9573', 2);

-- insert data into table `library`.`patrons` --
INSERT INTO `patrons` (patronID, firstName, middleName, lastName, username, password, phoneNumber, emailAddress, totalFees) VALUES
(1, 'Amber', 'Lee', 'Suratte', 'asuratte', 'books01', '999-999-9999', 'amberexample@gmail.com', 0.00),
(2, 'Kyle', NULL, 'Suratte', 'ksuratte', 'sprocket22', '999-999-9999', 'kyleexample@gmail.com', 2.44),
(3, 'Lexi', 'Marie', 'Bebis', 'strawburrimilk', 'bella00', '999-999-9999', 'lexiexample@gmail.com', 5.87);

-- insert data into table `library`.`loans` --
INSERT INTO `loans` (loanID, bookID, patronID, dueDate, borrowDate, returnDate) VALUES
(1, 2, 1, '2021-04-15 11:59:59', '2021-03-22 12:30:01', NULL),
(2, 3, 2, '2021-05-18 11:59:59', '2021-03-28 09:25:44', NULL),
(3, 1, 3, '2021-03-18 11:59:59', '2021-02-28 05:12:50', '2021-03-17 03:33:22');

-- create librarian user --
GRANT SELECT, INSERT, UPDATE
ON library.*
TO librarian
IDENTIFIED BY 'b00kw0rm';

-- create librarian user --
GRANT SELECT
ON library.*
TO patron
IDENTIFIED BY 'r3ad3r';
