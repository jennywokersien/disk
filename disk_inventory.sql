/******************************************************/
/* Date			Programmer	Description               */
/*                                                    */
/* 3/4/2022		JWokersien	Initial creation of disk  */
/*							database                  */
/*                                                    */
/******************************************************/
use master;
go
DROP DATABASE IF EXISTS disk_inventoryjw;
go
CREATE DATABASE disk_inventoryjw;
go
--Add server user
IF SUSER_ID('diskUserjw') IS NULL
	CREATE LOGIN diskUserjw
	WITH PASSWORD = 'Pa$$w0rd', 
	DEFAULT_DATABASE = disk_inventoryjw;
use disk_inventoryjw;
go
--Add db user
CREATE USER diskUserjw;
ALTER ROLE db_datareader
	ADD MEMBER diskUserjw;
go

--create lookup tables
CREATE TABLE disk_type (
	disk_type_id	INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
);  --CD, DVD, Vinyl, 8track, cassette
CREATE TABLE genre (
	genre_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
);  --Country, Metal, Rock, Alt
CREATE TABLE status (
	status_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
);  --Available, Onload, Damaged, Broken
CREATE TABLE borrower (
	borrower_id		INT NOT NULL IDENTITY PRIMARY KEY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NOT NULL,
	phone_num		VARCHAR(15) NOT NULL		
);
CREATE TABLE disk (
	disk_id			INT NOT NULL IDENTITY PRIMARY KEY,
	disk_name		NVARCHAR(60) NOT NULL,
	release_date	DATE NOT NULL,
	genre_id		INT NOT NULL REFERENCES genre(genre_id),
	status_id		INT NOT NULL REFERENCES status(status_id),
	disk_type_id	INT NOT NULL REFERENCES disk_type(disk_type_id)
);
CREATE TABLE disk_has_borrower (
	disk_has_borrower_id	INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id					INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date			DATETIME2 NOT NULL,
	returned_date			DATETIME2 NULL
);