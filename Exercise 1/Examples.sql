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

--Inserting
INSERT INTO Students(Fnum, [Name], Gender)
VALUES('001', 'Ivan Ivanov', Default)

--Inserting in All Columns
INSERT INTO Students
VALUES('002', 'Martina Ivanova', NULL, 'F', 'm@abv.bg'),
	  ('003', 'Petar Ivanov', '089545566', 'M', 'p@abv.bg'),
	  ('004', 'Toni Todorov', '089967676', 'M', 't@gmail.com')

SELECT * FROM Students

--Updating
UPDATE Students
SET Gender = 'M', Phone = '+359 656 6666'
WHERE Fnum = '001'

--Deleting
DELETE FROM Students
WHERE Fnum = '001'


SELECT * FROM Students
WHERE Phone IS NULL

SELECT * FROM Students
WHERE Phone LIKE '089%'

SELECT * FROM Students
ORDER BY [Name] DESC

SELECT COUNT(Fnum) AS [Count], Gender FROM Students
GROUP BY Gender

SELECT COUNT(Fnum) AS [Count], Gender FROM Students
GROUP BY Gender
HAVING COUNT(Fnum) > 1