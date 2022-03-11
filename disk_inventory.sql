/******************************************************/
/* Date			Programmer	Description               */
/*                                                    */
/* 3/4/2022		JWokersien	Initial creation of disk  */
/*							database                  */
/* 3/11/2022    JWokersien  Add insert statements     */
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
);  --Available, Onloan, Damaged, Broken
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
/**** End of Project 1 ****/
-- Start insert statements
-- Insert data into disk_type part c
INSERT INTO disk_type
	(description) 
VALUES				-- Types do not have to match mine
	('CD'),
	('Vinyl'),
	('8track'),
	('Cassette'),
	('DVD');
-- Insert genres
INSERT INTO genre
	(description)
VALUES				-- Genres do not have to match mine
	('Classic Rock')
	,('Country')
	,('Jazz')
	,('AltRock')
	,('Metal')
	,('Soundtrack')
	;
-- Insert status rows
INSERT INTO status
	(description)
VALUES				-- Statuses do not have to match mine
	('Available')
	,('On loan')
	,('Damaged')
	,('Missing')
	,('Unavailable')
	;
-- e.1 Insert 21 borrowers
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Mickey', 'Mouse', '123-123-1234');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Minnie', 'Mouse', '222-333-1234');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Daisy', 'Duck', '333-434-2234');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Daffy', 'Duck', '122-777-1734');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Donald', 'Duck', '878-523-3334');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Huey', 'Duck', '999-123-1299');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Dewey', 'Duck', '763-133-1934');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Louie', 'Duck', '889-193-1934');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Elmer', 'Fudd', '544-453-5554');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Buzz', 'Lightyear', '873-723-7734');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Sheriff', 'Woody', '765-423-7234');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Little Bo', 'Peep', '899-655-7634');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Slinky', 'Dog', '673-523-1534');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Mr. Potato', 'Head', '898-193-1934');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Mr.', 'Spell', '543-423-1834');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Race', 'Car', '321-344-1834');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('T', 'Rex', '623-723-1934');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Mrs. Potato', 'Head', '543-443-1288');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Winnie the', 'Pooh', '998-723-5434');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Christopher', 'Robin', '563-723-7734');
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Tigger', 'Tigger', '873-923-7734');
--e.2 Delete only 1 borrower row using a where clause
DELETE borrower
WHERE borrower_id = 21;
--d. Insert at least 20 rows of disk data into the table using real-world disk names
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Crazy Train', '1/1/1995', 1, 1, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('No More Tears', '12/21/1995', 1, 1, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Red', '11/13/2008', 2, 2, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Jagged Little Pill', '1/15/1995', 1, 2, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Candy-O', '10/10/1991', 1, 2, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Hotel California', '11/1/1977', 1, 2, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('One of These Nights', '4/1/1975', 1, 2, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('The Long Run', '10/21/1979', 1, 2, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Hints, Allegations, and Things Left Unsaid', '1/21/1999', 4, 2, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Blender', '1/29/2000', 4, 1, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Dirt', '1/27/1992', 4, 1, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Unplugged', '5/23/1996', 4, 1, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Facelift', '8/22/1990', 4, 1, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Black Gives Way to Blue', '11/21/2009', 4, 1, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Live', '11/11/2009', 4, 3, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Ten', '12/1/1991', 4, 4, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Vitalogy', '3/22/1994', 4, 3, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('No Code', '4/2/1996', 4, 1, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Backspacer', '5/21/2009', 4, 1, 2) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Home', '1/19/1995', 1, 2, 1) 
;
INSERT disk
(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES     -- do not have to match my disks
('Twilight Soundtrack', '11/2/2008', 6, 2, 1) 
;
--d.2 Update only 1 disk row using a where clause
UPDATE disk
SET release_date = '10/10/2008'
WHERE disk_name = 'Twilight Soundtrack';
-- Insert borrowed rows DiskHasBorrower table
INSERT disk_has_borrower
	(borrower_id, disk_id, borrowed_date, returned_date)
VALUES
	(1, 1, '1-2-2012', '2-15-2012')
	,(3, 5, '11-12-2021', '12-15-2021')
	,(3, 6, '1-22-2022', '2-22-2022')
	,(2, 7, '7-22-2021', '8-15-2021')
	,(5, 2, '10-2-2021', '12-20-2021')
	,(5, 7, '4-2-2021', '5-20-2021')
	,(5, 8, '11-2-2021', '12-19-2021')
	,(6, 3, '1-28-2021', '2-20-2021')
	,(11, 14, '7-26-2021', NULL)
	,(12, 15, '8-25-2021', '9-26-2021')
	,(13, 15, '9-24-2021', '9-26-2021')
	,(14, 11, '10-23-2021', '11-26-2021')
	,(15, 11, '11-28-2021', '12-2-2021')
	,(15, 12, '12-26-2021', NULL)
	,(8, 8, '3-21-2021', '6-23-2021')
	,(9, 4, '4-2-2021', '7-20-2021')
	,(10, 9, '1-2-2021', '2-20-2021')
	,(4, 3, '2-2-2021', '2-20-2021')
	,(5, 7, '1-2-2021', '2-21-2021')
	,(7, 4, '1-2-2021', NULL)
	,(7, 11, '3-3-2021', '4-5-2021')
	,(7, 13, '7-2-2021', '7-22-2021')
	;
--g. Create a query to list the disks that are on loan and have not been returned
SELECT borrower_id as Borrower_id, disk_id as Disk_id, CAST(borrowed_date as date) as Borrowed_date, returned_date as Return_date
FROM disk_has_borrower
WHERE returned_date IS NULL;

--After testing, push file to GitHub
