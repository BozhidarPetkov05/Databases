CREATE DATABASE TradeCompany
GO
USE TradeCompany
GO

CREATE TABLE Regions
(
	Region_Id SMALLINT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(25) NOT NULL UNIQUE
)

CREATE TABLE Countries
(
	Country_Id CHAR(2) PRIMARY KEY,
	[Name] VARCHAR(40) NOT NULL,
	Region_Id SMALLINT
	CONSTRAINT FK_Countries_Regions
	FOREIGN KEY (Region_Id) REFERENCES Regions(Region_Id)
)

CREATE TABLE Customers
(
	Customer_Id NUMERIC(6) PRIMARY KEY,
	Country_Id CHAR(2) NOT NULL FOREIGN KEY REFERENCES Countries(Country_Id),
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	[Address] TEXT,
	Email VARCHAR(30),
	Gender CHAR(1) DEFAULT 'M'
		CHECK(Gender = 'M' OR Gender = 'F' OR Gender = NULL)
)

CREATE TABLE Jobs
(
	Job_Id VARCHAR(10) PRIMARY KEY,
	Job_Title VARCHAR(35) NOT NULL,
	Min_Salary NUMERIC(6),
	Max_Salary NUMERIC(6)
)

CREATE TABLE Employees
(
	Employee_Id INT PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(25) NOT NULL,
	Email VARCHAR(40) UNIQUE NOT NULL,
	Phone VARCHAR(20),
	Hire_Date DATETIME NOT NULL,
	Salary NUMERIC(8,2) NOT NULL,
	Job_Id VARCHAR(10) FOREIGN KEY REFERENCES Jobs(Job_Id),
	Manager_Id INT FOREIGN KEY REFERENCES Employees(Employee_Id),
	Department_Id INT
)

CREATE TABLE Departments
(
	Department_Id INT PRIMARY KEY,
	[Name] VARCHAR(30) NOT NULL,
	Manager_Id INT FOREIGN KEY REFERENCES Employees(Employee_Id),
	Country_Id CHAR(2) NOT NULL FOREIGN KEY REFERENCES Countries(Country_Id),
	City VARCHAR(30) NOT NULL,
	[State] VARCHAR(25),
	[Address] VARCHAR(40),
	Postal_Code VARCHAR(12)
)

ALTER TABLE Employees
ADD FOREIGN KEY (Department_Id) REFERENCES Departments(Department_Id)

CREATE TABLE Products
(
	Product_Id INT PRIMARY KEY,
	[Name] VARCHAR(70) NOT NULL,
	Price NUMERIC(8,2) NOT NULL,
	[Description] VARCHAR(2000)
)

CREATE TABLE Orders
(
	Order_Id INT PRIMARY KEY,
	Order_Date DATETIME NOT NULL,
	Customer_Id NUMERIC(6) NOT NULL FOREIGN KEY REFERENCES Customers(Customer_Id),
	Employee_Id INT NOT NULL FOREIGN KEY REFERENCES Employees(Employee_Id),
	Ship_Address VARCHAR(150)
)

CREATE TABLE Order_Items
(
	Order_Id INT FOREIGN KEY REFERENCES Orders(Order_Id)  ON DELETE CASCADE ON UPDATE CASCADE,
	Product_Id INT FOREIGN KEY REFERENCES Products(Product_Id),
	PRIMARY KEY(Order_Id, Product_Id),
	Unit_Price NUMERIC(8,2) NOT NULL,
	Quantity NUMERIC(8) NOT NULL
)