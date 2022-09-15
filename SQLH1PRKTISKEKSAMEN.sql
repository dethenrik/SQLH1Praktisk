USE Master
GO
IF DB_ID('BBB+unilogin') IS NOT NULL
	BEGIN
		ALTER DATABASE BBB_unilogin SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE BBB_unilogin
	END
GO
CREATE DATABASE BBB_unilogin
GO
use BBB_unilogin
GO


DROP TABLE IF EXISTS [User]
CREATE TABLE[User] (
  [UId] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
  Username varchar(50) NOT NULL,
  email varchar(50) NOT NULL UNIQUE,
  [password] varchar(55) NOT NULL,
  Account varchar(55) NOT NULL,
  LaundryRoom int NOT NULL,
  registration_date date NOT NULL,
);


INSERT INTO [User] (Username, email, [Password], Account, LaundryRoom, registration_date)
values ('john', 'john_doe66@gmail.com', 'password', '100.00', 2, '2021-02-15')

INSERT INTO [User] (Username, email, [Password], Account, LaundryRoom, registration_date)
values	('Neil Armstrong', 'firstman@nasa.gov', 'eaglelander69', '1000.00', 1, '2021-02-10')

INSERT INTO [User] (Username, email, [Password], Account, LaundryRoom, registration_date)
values	('Batman', 'noreply@thecase.com', 'Rob1n', '500.00' , 3, '2021-03-10')

INSERT INTO [User] (Username, email, [Password], Account, LaundryRoom, registration_date)
values	('Goldman Sachs', 'moneylaundering@gs.com', 'NotRecognized', '100000.00' , 1, '2021-01-01')

INSERT INTO [User] (Username, email, [Password], Account, LaundryRoom, registration_date)
values	('50 Cent', '50cent@gmail.com', 'itsmybirtday', '0.50' , 3, '2021-07-06')



DROP TABLE IF EXISTS Laundryroom
CREATE TABLE Laundryroom (
  LId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
  LaundryName VARCHAR(255) NOT NULL,
  Openinghours TIME NOT NULL,
  Closinghours TIME NOT NULL,
);

INSERT INTO Laundryroom (LaundryName, Openinghours, Closinghours)
values	('WhiteWash Inc', '08:00', '20:00')

INSERT INTO Laundryroom (LaundryName, Openinghours, Closinghours)
values	('Double Bubble', '02:00', '22:00')

INSERT INTO Laundryroom (LaundryName, Openinghours, Closinghours)
values	('Wash & Coffe', '12:00', '20:00')


DROP TABLE IF EXISTS Machines
CREATE TABLE Machines(
  MId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
  [NAME] VARCHAR(55) NOT NULL,
  PricePRwash varchar(55) NOT NULL,
  Washtime varchar(55)  NOT NULL,
  Laundry int NOT NULL,
  CONSTRAINT FK_MId FOREIGN KEY (Laundry) REFERENCES Laundryroom(LId)
);

INSERT INTO Machines ([NAME], PricePRwash, Washtime, Laundry)
values	( 'Mielle 911 turbo', '5.00', '1h', 2)

INSERT INTO Machines ([NAME], PricePRwash, Washtime, Laundry)
values	('Siemens IClean', '10000.00', '30m', 1)

INSERT INTO Machines ([NAME], PricePRwash, Washtime, Laundry)
values	('Electrolax FX-2', '15.00', '45m', 2)

INSERT INTO Machines ([NAME], PricePRwash, Washtime, Laundry)
values	('NASA Spacewasher 8000', '500.00', '5m', 1)

INSERT INTO Machines ([NAME], PricePRwash, Washtime, Laundry)
values	('The lost sock', '3.50', '1h 30m', 3)

INSERT INTO Machines ([NAME], PricePRwash, Washtime, Laundry)
values	('YO MAMA', '0.50', 120, 3)


DROP TABLE IF EXISTS Bookings
CREATE TABLE Bookings(
  BId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
  [Date] DATETIME NOT NULL,
  [UserId] int NOT NULL,
  Machine int NOT NULL
  CONSTRAINT FK_BId FOREIGN KEY([UserId]) REFERENCES [User]([UId]),
  CONSTRAINT FK_Machine FOREIGN KEY(Machine) REFERENCES Machines([MId]),
);

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 12:00', 1, 1)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 16:00', 1, 3)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 08:00', 2, 4)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 15:00', 3, 5)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 20:00', 4, 2)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 19:00', 4, 2)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 10:00', 4, 2)

INSERT INTO Bookings ([Date], [UserId], Machine)
values	('2021-02-26 16:00', 5, 6)


BEGIN TRANSACTION GoldmanSach_tran
INSERT INTO Bookings([DATE],[UserId],[Machine])
VALUES ('2022-09-15',4,2)

GO
CREATE VIEW BookingsView AS
SELECT [Date], [User].Username, Machines.[NAME], Machines.PricePRwash from Bookings
join [User] on Bookings.UserId = [User].[UId]
join Machines on Bookings.Machine = Machines.MId
GO

GO
SELECT * FROM [User] WHERE email like '%gmail.com%'
GO

GO 
SELECT [NAME], PricePRwash, Washtime, Laundryroom.LaundryName, Laundryroom.Openinghours, Laundryroom.Closinghours FROM Machines
JOIN Laundryroom ON Machines.MId = Laundryroom.LId
GO

GO
SELECT Machines.[NAME], COUNT(BId) FROM Bookings 
Join Machines ON Bookings.Machine = Machines.MId
GROUP BY [NAME]
GO

GO
DELETE FROM Bookings WHERE CAST([Date] as time) BETWEEN '12:00' AND '13:00'
GO

UPDATE [User]
SET [password] = 'SelinaKyle'
WHERE email = 'noreply@thecave.com'
AND [password] = 'Robin';