--Creating Database
CREATE DATABASE My_DB
GO
USE My_DB
GO


--Creating Table
CREATE TABLE Students
(
	FNum CHAR(3) NOT NULL PRIMARY KEY,
	[Name] VARCHAR(100) NOT NULL,
	Phone VARCHAR(20),
	Gender CHAR(1) DEFAULT ('-')
		CHECK(Gender = 'M' OR Gender = 'F' OR Gender = '-'),
	Email VARCHAR(100), CONSTRAINT UK_Email UNIQUE(Email)
)

--Adding Column to Table
ALTER TABLE Students
ADD [Address] VARCHAR NOT NULL

--Modifying Column
ALTER TABLE Students
ALTER COLUMN [Address] VARCHAR(100)

--Dropping Column
ALTER TABLE Students
DROP COLUMN [Address]

--Dropping Constraint
ALTER TABLE Students
DROP CONSTRAINT PK__Students__9238BA09268C966F

--Adding Constraint
ALTER TABLE Students
ADD CONSTRAINT PK_Students PRIMARY KEY(FNum)

--Dropping Table and Database
/*
	DROP TABLE Students

	USE MASTER
	GO
	DROP DATABASE My_DB
	GO
*/