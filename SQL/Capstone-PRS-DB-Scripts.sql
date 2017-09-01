-- Refresh
USE master
DROP DATABASE IF EXISTS PRS
CREATE DATABASE PRS
USE PRS

-- User
CREATE TABLE [User] (
	Id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserName varchar(20) NOT NULL UNIQUE,
	Password varchar(10) NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	Phone varchar(12),
	Email varchar(75),
	IsReviewer bit NOT NULL DEFAULT 0,
	IsAdmin bit NOT NULL DEFAULT 0,
	Active bit NOT NULL DEFAULT 1,
	DateCreated datetime NOT NULL DEFAULT GetDate(),
	DateUpdated datetime,
	UpdatedByUser int FOREIGN KEY REFERENCES [User](Id)
)  -- CREATE the User TABLE

/*
CREATE UNIQUE INDEX IUX_UserName
	ON [User](UserName)
*/

/*
INSERT into [User]
	(UserName, Password, FirstName, LastName, Phone, Email, IsReviewer, IsAdmin)
	VALUES
	('EDS-Admin', 'adminpw', 'Eric', 'Smith', '015136757888', 'ydrive65@yahoo.com', 1, 1)  -- Create user 'smithed' as Admin
*/

-- Vendor
CREATE TABLE Vendor (
	Id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Code varchar(10) NOT NULL UNIQUE,
	Name varchar(255) NOT NULL,
	Address varchar(255),
	City varchar(255),
	State varchar(2),
	Zip varchar(5),
	Phone varchar(12),
	Email varchar(100),
	IsPreapproved bit NOT NULL DEFAULT 0,
	Active bit NOT NULL DEFAULT 1,
	DateCreated datetime NOT NULL DEFAULT GetDate(),
	DateUpdated datetime,
	UpdatedUser int FOREIGN KEY REFERENCES [User](Id)
)  -- CREATE Vendor TABLE

-- Product
CREATE TABLE Product (
	Id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	VendorId int NOT NULL FOREIGN KEY REFERENCES Vendor(Id),
	PartNumber varchar(50),
	Name varchar(150),
	Price decimal(10,2),
	Unit varchar(255),
	Photopath varchar(255),
	Active bit NOT NULL DEFAULT 1,
	DateCreated datetime NOT NULL DEFAULT GetDate(),
	DateUpdated datetime,
	UpdatedUser int FOREIGN KEY REFERENCES [User](Id)
) -- CREATE Product TABLE

-- Status
CREATE TABLE Status (
	Id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Description varchar(20),
	Active bit NOT NULL DEFAULT 1,
	DateCreated datetime NOT NULL DEFAULT GetDate(),
	DateUpdated datetime,
	UpdatedUser int FOREIGN KEY REFERENCES [User](Id)
) -- CREATE Status TABLE

-- PurchaseRequest
CREATE TABLE PurchaseRequest (	-- CREATE the PurchaseRequest TABLE
	Id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserId int NOT NULL FOREIGN KEY REFERENCES [User](Id),
	Description varchar(100) NOT NULL,
	Justification varchar(255) NOT NULL,
	DateNeeded date,
	DeliveryMode varchar(25),
	StatusId int NOT NULL FOREIGN KEY REFERENCES Status(Id),
	Total decimal(10,2),
	SubmittedDate date,
	Active bit,
	ReasonForRejection varchar(100),
	DateCreated datetime NOT NULL DEFAULT GetDate(),
	DateUpdated datetime,
	UpdatedUser int FOREIGN KEY REFERENCES [User](Id)
)

-- PurchaseRequestLineItem
CREATE TABLE PurchaseRequestLineItem (
	Id int NOT NULL PRIMARY KEY IDENTITY(1,1),
	PurchaseRequestId int NOT NULL FOREIGN KEY REFERENCES PurchaseRequest(Id),
	ProductId int NOT NULL FOREIGN KEY REFERENCES Product(Id),
	Quantity int NOT NULL DEFAULT 0,
	Active bit NOT NULL DEFAULT 1,
	DateCreated datetime NOT NULL DEFAULT GetDate(),
	DateUpdated datetime,
	UpdatedUser int FOREIGN KEY REFERENCES [User](Id)
) -- CREATE PurchaseRequestLineItem TABLE

