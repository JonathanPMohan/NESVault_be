--DROP DATABASE [ IF EXISTS ] { database_name | database_snapshot_name } [ ,...n ] [;]
IF EXISTS (
        SELECT [name]
FROM sys.databases
WHERE [name] = N'NesVault'
        )
BEGIN
    -- Delete Database Backup and Restore History from MSDB System Database
    EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'NesVault'
​
    -- GO
    -- Close Connections
    USE [master]
​
    -- GO
    ALTER DATABASE [NesVault]
​
    SET SINGLE_USER
    WITH
​
    ROLLBACK IMMEDIATE
​
    -- GO
    -- Drop Database in SQL Server
    DROP DATABASE [NesVault]
-- GO
END
​
-- Create a new database called 'NesVault'
-- Connect to the 'master' database to run this snippet
USE master
GO
​
-- Create the new database if it does not exist already
IF NOT EXISTS (
        SELECT [name]
FROM sys.databases
WHERE [name] = N'NesVault'
        )
    CREATE DATABASE NesVault
GO
​
USE NesVault
GO
​
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/sweMRF
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
SET XACT_ABORT ON
​
BEGIN TRANSACTION NES_CREATE
​
CREATE TABLE [Carts] (
  [Id] int IDENTITY(1,1) NOT NULL ,
  [Name] nvarchar(255)  NOT NULL ,
	[ImageUrl] nvarchar(255) NULL ,
  [Genre] nvarchar(255)  NOT NULL ,
	[ReleaseDate] datetime  NOT NULL ,
  [Loose] decimal(8,2)  NOT NULL ,
	[Cib] decimal(8,2)  NOT NULL ,
	[New] decimal(8,2)  NOT NULL ,
  [ProductId] int NOT NULL,
    CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)
​
CREATE TABLE [Users] (
    -- Clustered
  [Id] int IDENTITY(1,1) NOT NULL ,
  [UserName] nvarchar(255)  NOT NULL ,
  [FirstName] nvarchar(255) NULL ,
  [LastName] nvarchar(255)  NULL ,
	[FavoriteGame] nvarchar(255) NULL,
  [Email] nvarchar(255)  NOT NULL ,
	[FireBaseUid] nvarchar(255) NOT NULL ,
	[IsDeleted] bit NOT NULL ,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)
​
CREATE TABLE [Wishlist] (
  [Id] int IDENTITY(1,1) NOT NULL ,
  [UserId] int  NOT NULL ,
  [CartId] int  NOT NULL ,
	[ImageUrl] nvarchar(255) NULL ,
	[Name] nvarchar(255)  NOT NULL ,
  [Genre] nvarchar(255)  NOT NULL ,
	[ReleaseDate] datetime  NOT NULL ,
	[Loose] decimal(8,2)  NOT NULL ,
	[ProductId] int NULL,
	[IsDeleted] bit NULL ,
    CONSTRAINT [PK_Wishlist] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)
​
CREATE TABLE [TradeList] (
  [Id] int IDENTITY(1,1) NOT NULL ,
  [UserId] int  NOT NULL ,
  [CartId] int  NOT NULL ,
	[ImageUrl] nvarchar(255) NULL ,
	[Name] nvarchar(255)  NOT NULL ,
  [Genre] nvarchar(255)  NOT NULL ,
	[ReleaseDate] datetime  NOT NULL ,
	[Loose] decimal(8,2)  NOT NULL ,
	[ProductId] int NULL,
	[IsDeleted] bit NULL ,
  CONSTRAINT [PK_TradeList] PRIMARY KEY CLUSTERED (
      [Id] ASC
    )
)
​
CREATE TABLE [MyCarts] (
    [Id] int IDENTITY(1,1) NOT NULL ,
	[Name] nvarchar(255)  NOT NULL ,
    [Genre] nvarchar(255)  NOT NULL ,
	[ReleaseDate] datetime  NOT NULL ,
	[ImageUrl] nvarchar(255) NULL ,
    [UserId] int  NOT NULL ,
    [CartsId] int  NOT NULL ,
	[Loose] decimal(8,2)  NOT NULL ,
	[ProductId] int NULL,
	[IsDeleted] bit NULL ,
    CONSTRAINT [PK_MyCarts] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)
​
--ALTER TABLE [Carts] WITH CHECK ADD CONSTRAINT [FK_Carts_Id] FOREIGN KEY([Id])
--REFERENCES [MyCarts] ([UserId])
​
--ALTER TABLE [Carts] CHECK CONSTRAINT [FK_Carts_Id]
​
ALTER TABLE [Wishlist] WITH CHECK ADD CONSTRAINT [FK_Wishlist_UserId] FOREIGN KEY([UserId])
REFERENCES [Users] ([Id])
​
ALTER TABLE [Wishlist] CHECK CONSTRAINT [FK_Wishlist_UserId]
​
ALTER TABLE [Wishlist] WITH CHECK ADD CONSTRAINT [FK_Wishlist_CartId] FOREIGN KEY([CartId])
REFERENCES [Carts] ([Id])
​
ALTER TABLE [Wishlist] CHECK CONSTRAINT [FK_Wishlist_CartId]
​
ALTER TABLE [MyCarts] WITH CHECK ADD CONSTRAINT [FK_MyCarts_UserId] FOREIGN KEY([UserId])
REFERENCES [Users] ([Id])
​
ALTER TABLE [MyCarts] CHECK CONSTRAINT [FK_MyCarts_UserId]
​
ALTER TABLE [MyCarts] WITH CHECK ADD CONSTRAINT [FK_MyCarts_CartsId] FOREIGN KEY([CartsId])
REFERENCES [Carts] ([Id])
​
ALTER TABLE [MyCarts] CHECK CONSTRAINT [FK_MyCarts_CartsId]
​
--CREATE INDEX [idx_Users_FirstName]
--ON [Users] ([FirstName])
​
COMMIT TRANSACTION NES_CREATE
​
USE [master]
GO
​
ALTER DATABASE [NesVault]
​
SET READ_WRITE
GO
​
BEGIN TRANSACTION NES_SEED
​
-- USERS
BEGIN
    USE [NesVault]
​
    INSERT INTO [dbo].[Users]
        ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Billy', 'Blanks', 'BlankMan2', 'Contra', 'myemail45@gmail.com', 'QUZNyHcNTDomtpT9Kjmg4PUY3iEr', '0')
​
    INSERT INTO [dbo].[Users]
       ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Roy', 'Thomas', 'ThomasIsHere', 'TMNT 2: The Arcade Game', 'myemail46@gmail.com', 'BxZHxeTU8myVsZr4zwGPJWDYykwe', '0')
​
    INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Jenny', 'Jumprope', 'JennyHatesYou7', 'Dr. Mario', 'myemail47@gmail.com', 'eZ2CWnThMXu7ZqbEjxNyQWZCoZhs', '0')

    INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Joey', 'Fatone', 'NsyncSucks', 'Tetris', 'myemail48@gmail.com', 'Qx4oZpGEsuWE7uPsHFETTYUyuprB', '0')
​
	INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Tinker', 'Jones', 'TinkTink45', 'Super Mario Bros. 3', 'myemail49@gmail.com', 'yY66USNBdQaZml8uxQ9K8v7eiVm6', '1')
​
		INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Jonathan', 'Mohan', 'NintenDork', 'The Legend of Zelda', 'myemail50@gmail.com', 'BOdzarezTGWZ1lgHt5uAm6neCnl2', '0')
​
END
​
-- Carts
BEGIN
  USE [NesVault]
​
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('10-Yard Fight', '','Football','1985-10-01',3.86,35.00,332.96,12168)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('10-Yard Fight [5 Screw]', '','Football','1985-10-01',4.67,25.69,44.32,37965)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('1942', '','Other','1986-11-01',10.18,39.47,399.99,12169)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('1942 [5 Screw]', '','Other','1986-11-01',13.61,35.42,113.34,37996)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('1943: The Battle of Midway', '','Other','1988-10-01',11.46,34.97,126.25,12170)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('3D WorldRunner', '','Action & Adventure','1987-09-01',7.66,24.19,73.16,8445)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('3D WorldRunner [5 Screw]', '','Action & Adventure','1987-09-01',9.31,70.25,82.17,38021)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('720', '','Sports','1989-06-01',4.24,22.19,41.73,12171)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('8 Eyes', '','Action & Adventure','1990-01-01',7.84,25.39,95.95,12172)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('A Boy and His Blob Trouble on Blobolonia', '','Action & Adventure','1990-01-01',8.80,33.00,119.99,12173)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('A Nightmare on Elm Street', '','Action & Adventure','1990-10-01',37.30,153.75,256.30,12174)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Abadox', '','Action & Adventure','1990-03-01',9.80,31.98,62.28,8451)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Action 52', '','Action & Adventure','1991-01-01',170.00,299.50,413.46,8453)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Addams Family', '','Action & Adventure','1992-01-01',12.38,34.99,106.06,8455)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Addams Family Pugsley''s Scavenger Hunt', '','Action & Adventure','1993-08-01',59.99,174.99,264.84,8456)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Advanced Dungeons & Dragons Dragon Strike', '','Strategy','1992-07-01',31.45,84.77,276.18,8458)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Advanced Dungeons & Dragons Heroes of the Lance', '','Strategy','1991-01-01',12.13,32.31,143.51,8459)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Advanced Dungeons & Dragons Hillsfar', '','Strategy','1993-02-01',89.91,164.08,524.70,8460)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Advanced Dungeons & Dragons Pool of Radiance', '','Strategy','1992-04-01',31.48,55.50,142.50,8462)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventure Island', '','Action & Adventure','1988-09-01',7.98,31.50,219.77,8464)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventure Island 3', '','Action & Adventure','1992-09-01',45.00,123.23,349.80,12176)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventure Island II', '','Action & Adventure','1991-02-01',16.99,59.27,149.63,8465)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures in the Magic Kingdom', '','Action & Adventure','1990-06-01',7.99,21.95,117.57,8466)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Bayou Billy', '','Action & Adventure','1989-06-01',3.59,18.75,76.34,8468)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Captain Comic', '','Action & Adventure','1989-01-01',12.00,25.37,39.00,12119)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Dino Riki', '','Action & Adventure','1989-09-01',7.60,25.18,83.91,12175)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Lolo', '','Action & Adventure','1989-04-01',10.00,28.99,127.97,11979)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Lolo 2', '','Action & Adventure','1990-03-01',27.72,58.63,112.56,11980)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Lolo 3', '','Puzzle','1991-09-01',40.50,74.45,219.96,8469)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Rad Gravity', '','Action & Adventure','1990-12-01',14.98,35.85,137.35,12377)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Adventures of Tom Sawyer', '','Action & Adventure','1989-08-01',7.91,17.00,64.47,8472)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('After Burner', '','Other','1989-01-01',8.79,25.60,82.42,12177)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Air Fortress', '','Other','1989-09-01',5.86,24.17,58.77,8488)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Airwolf', '','Action & Adventure','1989-06-01',6.08,17.00,41.79,12178)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Al Unser Turbo Racing', '','Racing','1988-06-01',4.66,10.50,49.56,8491)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Aladdin Deck Enhancer', '','Accessories','1993-01-01',12.79,34.53,46.06,39509)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Alfred Chicken', '','Action & Adventure','1994-02-01',55.11,150.00,449.99,8493)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Alien 3', '','Action & Adventure','1993-03-01',19.47,44.99,100.20,8495)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Alien Syndrome', '','Action & Adventure','1988-01-01',11.33,22.50,49.93,12179)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('All-Pro Basketball', '','Basketball','1989-12-01',4.97,17.78,63.04,12180)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Alpha Mission', '','Action & Adventure','1987-10-01',9.75,26.00,209.98,12181)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Alpha Mission [5 Screw]', '','Action & Adventure','1987-09-01',87.39,182.22,583.10,38035)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Amagon', '','Action & Adventure','1989-04-01',6.18,18.54,62.56,12183)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('American Gladiators', '','Sports','1991-10-01',6.44,17.85,34.75,8507)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Anticipation', '','Action & Adventure','1988-11-01',3.04,12.83,30.76,12184)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Arch Rivals', '','Basketball','1990-11-01',6.59,18.95,51.01,12185)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Archon', '','Action & Adventure','1989-12-01',9.99,22.68,67.56,12186)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Arkanoid', '','Arcade','1987-08-01',12.95,32.21,202.56,8527)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Arkanoid [5 Screw]', '','Action & Adventure','1987-08-01',10.05,33.08,105.86,38015)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Arkanoid [Controller Bundle]', '','Arcade','1987-08-01',42.50,110.00,224.50,37957)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Arkista''s Ring', '','Action & Adventure','1990-06-01',27.00,68.97,243.97,16264)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Astyanax', '','Action & Adventure','1990-03-01',3.95,22.18,68.27,8538)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Athena', '','Action & Adventure','1987-08-01',8.98,44.00,510.37,12187)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Athena [5 Screw]', '','Action & Adventure','1987-08-01',8.35,55.40,113.52,38016)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Athletic World', '','Sports','1987-07-01',6.12,24.99,45.99,12188)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Athletic World [5 Screw]', '','Sports','1987-05-01',11.76,32.95,105.44,38009)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Attack of the Killer Tomatoes', '','Action & Adventure','1992-01-01',25.52,80.86,114.99,8541)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Baby Boomer', '','Action & Adventure','1989-01-01',44.53,93.50,161.39,12189)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Back to the Future', '','Action & Adventure','1989-09-01',7.15,20.69,121.08,12190)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Back to the Future II and III', '','Action & Adventure','1990-09-01',10.86,35.63,143.35,12191)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bad Dudes', '','Action & Adventure','1990-07-01',5.72,19.47,98.37,12192)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bad News Baseball', '','Baseball','1990-06-01',7.37,27.11,111.78,12193)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bad Street Brawler', '','Fighting','1989-09-01',6.87,22.83,74.99,12194)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Balloon Fight', '','Action & Adventure','1986-06-01',17.48,103.73,1000.00,11981)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Balloon Fight [5 Screw]', '','Action & Adventure','1986-06-01',18.60,215.81,249.95,37983)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bandai Golf Challenge Pebble Beach', '','Sports','1989-02-01',3.30,7.94,29.76,12195)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bandit Kings of Ancient China', '','Strategy','1990-12-01',74.99,141.90,346.70,13109)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Barbie', '','Action & Adventure','1991-12-01',8.50,17.86,61.42,8554)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bard''s Tale', '','RPG','1991-11-01',13.26,34.95,106.18,8559)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Barker Bill''s Trick Shooting', '','Other','1990-08-01',7.99,16.72,39.99,8560)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Baseball', '','Baseball','1985-10-01',4.18,21.38,673.00,11982)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Baseball Simulator 1.000', '','Baseball','1990-03-01',6.05,17.01,87.35,13843)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Baseball Stars', '','Baseball','1989-07-01',10.02,25.00,123.94,12198)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Baseball Stars 2', '','Baseball','1992-07-01',14.17,34.75,69.96,8562)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Baseball [5 Screw]', '','Baseball','1985-10-01',4.24,31.49,41.57,37966)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bases Loaded', '','Baseball','1988-07-01',3.14,8.47,74.87,8564)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bases Loaded 2 Second Season', '','Baseball','1990-01-01',3.19,11.27,27.25,8565)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bases Loaded 3', '','Baseball','1991-09-01',4.99,13.53,45.73,12199)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bases Loaded 4', '','Baseball','1993-04-01',37.66,70.00,434.32,8566)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Batman Returns', '','Action & Adventure','1993-01-01',14.94,51.15,198.77,8574)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Batman The Video Game', '','Action & Adventure','1990-02-01',9.87,32.49,229.19,13844)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Batman: Return of the Joker', '','Action & Adventure','1991-12-01',29.00,126.64,187.45,8570)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Battle Chess', '','Strategy','1990-07-01',5.62,19.98,30.81,12200)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Battle of Olympus', '','Action & Adventure','1989-12-01',11.31,27.18,125.46,12201)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Battleship', '','Strategy','1993-09-01',15.55,24.97,35.91,8582)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Battletank', '','Action & Adventure','1990-09-01',7.24,18.99,36.57,12202)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Battletoads', '','Action & Adventure','1991-06-01',16.00,60.00,359.99,8586)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Battletoads and Double Dragon The Ultimate Team', '','Action & Adventure','1993-06-01',69.99,251.36,691.50,8588)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bee 52', '','Action & Adventure','1992-01-01',11.95,33.58,63.15,12203)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('BeetleJuice', '','Action & Adventure','1991-05-01',19.00,45.00,83.45,12204)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Best of the Best Championship Karate', '','Fighting','1992-12-01',44.99,129.64,408.99,8600)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bible Adventures', '','Action & Adventure','1990-01-01',8.99,24.14,85.00,8603)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bible Buffet', '','Other','1993-01-01',62.98,72.60,150.93,12205)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Big Nose Freaks Out', '','Action & Adventure','1992-01-01',90.29,90.87,171.96,12106)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Big Nose Freaks Out [Aladdin]', '','Action & Adventure','1987-01-01',14.99,14.99,124.42,39520)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Big Nose the Caveman', '','Action & Adventure','1991-01-01',10.47,25.00,54.99,16129)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bigfoot', '','Action & Adventure','1990-07-01',6.95,18.73,60.37,12206)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bill Elliott''s NASCAR Challenge', '','Racing','1991-04-01',6.60,15.25,32.45,8607)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bill and Ted''s Excellent Video Game', '','Action & Adventure','1991-12-01',10.44,29.49,91.22,8606)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bionic Commando', '','Action & Adventure','1988-12-01',8.79,48.13,180.50,12107)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Black Bass', '','Sports','1989-09-01',6.33,17.43,44.99,12108)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Blackjack', '','Other','1992-01-01',38.11,77.44,127.50,12109)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Blades of Steel', '','Sports','1988-12-01',5.79,15.74,132.44,8614)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Blades of Steel [Classic Series]', '','Sports','1988-01-01',14.92,45.91,123.82,39515)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Blaster Master', '','Action & Adventure','1988-11-01',6.83,33.99,167.26,12110)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Blue Marlin', '','Sports','1992-07-01',12.97,26.16,87.68,8625)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Blues Brothers', '','Action & Adventure','1992-09-01',19.72,42.88,123.74,8627)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bo Jackson Baseball', '','Baseball','1991-10-01',5.46,18.24,46.66,8628)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bomberman', '','Action & Adventure','1989-01-01',12.84,59.99,137.26,12111)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bomberman II', '','Puzzle','1993-02-01',132.48,255.85,565.00,8632)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bonk''s Adventure', '','Action & Adventure','1994-01-01',454.99,1267.30,2799.00,8636)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Boulder Dash', '','Action & Adventure','1990-06-01',12.98,25.26,116.36,12112)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bram Stoker''s Dracula', '','Action & Adventure','1993-09-01',35.69,76.82,124.33,8643)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Break Time The National Pool Tour', '','Sports','1993-01-01',6.87,18.63,45.92,8645)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('BreakThru', '','Puzzle','1987-11-01',6.41,24.50,700.00,12113)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Breakthru [5 Screw]', '','Action & Adventure','1987-09-01',9.70,9.97,62.25,38039)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bubble Bath Babes', '','Action & Adventure','1991-01-01',1489.45,2342.10,0.00,14930)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bubble Bobble', '','Action & Adventure','1988-11-01',14.65,47.18,416.11,11983)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bubble Bobble Part 2', '','Action & Adventure','1993-08-01',288.29,643.19,5299.99,8654)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bucky O''Hare', '','Action & Adventure','1992-01-01',100.95,242.28,678.75,8658)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bugs Bunny Birthday Blowout', '','Action & Adventure','1990-09-01',7.49,20.17,89.99,8661)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bugs Bunny Crazy Castle', '','Action & Adventure','1989-08-01',7.89,24.27,49.95,8662)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Bump ''n'' Jump', '','Action & Adventure','1988-12-01',6.52,22.23,60.01,12114)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Burai Fighter', '','Fighting','1990-03-01',9.74,29.99,69.45,12115)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('BurgerTime [5 Screw]', '','Action & Adventure','1987-04-01',13.49,20.00,98.19,38006)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Burgertime', '','Puzzle','1987-05-01',9.99,32.12,235.09,12116)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cabal', '','Action & Adventure','1990-06-01',7.02,21.23,82.37,12117)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Caesar''s Palace', '','Sports','1992-12-01',4.69,12.49,37.50,8683)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('California Games', '','Sports','1989-06-01',5.54,16.88,110.00,12118)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('California Raisins The Great Escape [Reproduction]', '','Action & Adventure','1990-04-01',48.00,90.00,340.82,8687)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Caltron 6-in-1', '','Action & Adventure','1992-01-01',265.95,306.73,430.62,14928)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Captain America and the Avengers', '','Action & Adventure','1991-12-01',21.25,76.29,144.38,8695)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Captain Planet and the Planeteers', '','Action & Adventure','1991-09-01',12.55,33.77,85.97,8696)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Captain Skyhawk', '','Action & Adventure','1990-06-01',4.86,13.04,46.64,12120)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Casino Kid', '','Other','1989-10-01',3.12,15.21,52.50,12121)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Casino Kid II', '','Other','1993-04-01',105.43,179.87,478.78,8701)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castelian', '','Action & Adventure','1991-06-01',17.95,47.21,77.02,8702)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castle of Deceit', '','Action & Adventure','1990-01-01',81.02,103.19,145.67,12122)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castle of Dragon', '','Action & Adventure','1990-06-01',10.97,23.84,87.09,12123)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castlequest', '','Action & Adventure','1989-09-01',5.99,21.65,77.50,12124)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castlevania', '','Action & Adventure','1987-05-01',18.70,66.50,454.31,8704)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castlevania II Simon''s Quest', '','Action & Adventure','1988-12-01',9.93,40.25,488.85,11984)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castlevania III Dracula''s Curse', '','Action & Adventure','1990-09-01',27.46,92.48,589.05,8706)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Castlevania [5 Screw]', '','Action & Adventure','1987-05-01',27.77,150.00,257.38,38007)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Caveman Games', '','Party','1990-10-01',7.00,28.29,161.79,12126)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Challenge of the Dragon', '','Action & Adventure','1990-01-01',89.93,125.97,238.37,16130)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Championship Bowling', '','Sports','1989-12-01',3.98,8.47,33.06,8713)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Championship Pool', '','Sports','1993-10-01',12.00,25.75,51.01,8714)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cheetahmen II', '','Action & Adventure','1993-01-01',1330.06,1737.48,2287.28,14927)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Chessmaster', '','Strategy','1990-01-01',3.09,10.49,36.10,8722)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Chiller', '','Action & Adventure','1990-01-01',70.59,121.75,252.37,8729)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Chip and Dale Rescue Rangers', '','Action & Adventure','1990-06-01',9.99,56.80,399.90,12127)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Chip and Dale Rescue Rangers 2', '','Action & Adventure','1994-01-01',184.45,455.98,1155.72,8730)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Chubby Cherub', '','Action & Adventure','1986-10-01',63.93,668.18,1033.45,12128)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Circus Caper', '','Action & Adventure','1990-07-01',8.99,20.09,86.47,12129)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('City Connection', '','Action & Adventure','1988-05-01',5.60,25.67,81.57,12130)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Clash at Demonhead', '','Action & Adventure','1990-01-01',14.76,38.48,97.64,12131)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Classic Concentration', '','Action & Adventure','1990-09-01',5.91,16.63,53.09,12132)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cleaning Kit', '','Accessories','1988-01-01',8.00,10.99,17.63,38378)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cliffhanger', '','Action & Adventure','1993-11-01',42.50,100.00,189.36,8738)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Clu Clu Land', '','Action & Adventure','1985-10-01',24.95,231.96,770.00,12133)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cobra Command', '','Action & Adventure','1988-11-01',4.70,17.89,50.99,12134)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cobra Triangle', '','Action & Adventure','1989-07-01',6.16,22.55,86.27,8743)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Code Name Viper', '','Action & Adventure','1990-03-01',6.29,25.33,71.51,8747)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Color A Dinosaur', '','Other','1993-07-01',77.61,358.02,627.52,8753)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Commando', '','Action & Adventure','1986-11-01',6.07,21.74,195.00,12135)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Commando [5 Screw]', '','Other','1986-11-01',6.44,25.01,67.20,37997)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Conan the Mysteries of Time', '','Action & Adventure','',39.33,70.00,149.99,12136)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Conflict', '','Action & Adventure','1990-03-01',11.11,34.24,86.34,12137)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Conquest of the Crystal Palace', '','Action & Adventure','1990-11-01',19.99,73.50,177.58,12138)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Contra', '','Action & Adventure','1988-02-01',19.99,70.43,925.00,12139)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Contra Force', '','Action & Adventure','1992-09-01',88.12,338.01,3000.00,12140)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Control Deck Test Cartridge', '','Other','1985-01-01',375.00,0.00,0.00,37258)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cool World', '','Action & Adventure','1993-06-01',48.77,129.59,426.92,8764)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cowboy Kid', '','Action & Adventure','1992-01-01',264.49,475.00,1000.00,12142)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Crash ''n'' the Boys: Street Challenge', '','Action & Adventure','1992-10-01',30.61,69.77,298.00,12143)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Crystal Mines', '','Action & Adventure','1989-01-01',25.82,40.50,100.34,8786)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Crystalis', '','Action & Adventure','1990-07-01',15.51,59.73,135.00,12144)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cyberball', '','Sports','1992-01-01',12.71,20.85,71.46,8794)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cybernoid The Fighting Machine', '','Action & Adventure','1989-12-01',3.82,14.50,30.47,8796)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Cyberstadium Series Base Wars', '','Sports','1991-01-01',8.17,19.38,43.81,12145)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dance Aerobics', '','Other','1989-03-01',4.68,14.95,29.00,8801)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Danny Sullivan''s Indy Heat', '','Racing','1992-08-01',17.95,43.05,144.99,8804)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Darkman', '','Action & Adventure','1991-10-01',14.12,54.99,99.99,8808)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Darkwing Duck', '','Action & Adventure','1992-06-01',37.60,109.99,389.75,8810)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dash Galaxy in the Alien Asylum', '','Action & Adventure','1990-02-01',4.62,12.51,39.16,12146)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Day Dreamin'' Davey', '','Action & Adventure','1992-07-01',12.76,35.54,165.12,8817)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Days Of Thunder', '','Racing','1990-10-01',4.00,14.99,69.99,8818)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Deadly Towers', '','Action & Adventure','1987-09-01',5.04,25.51,62.61,12147)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Deadly Towers [5 Screw]', '','Action & Adventure','1987-09-01',18.99,50.00,160.00,38022)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Death Race', '','Racing','1991-01-01',37.56,66.77,188.30,12148)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Deathbots', '','Action & Adventure','1990-01-01',16.97,37.63,77.98,12149)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Defender II', '','Action & Adventure','1988-07-01',5.50,19.99,38.87,12150)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Defender of the Crown', '','Action & Adventure','1989-07-01',7.37,20.79,54.21,12151)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Defenders of Dynatron City', '','Action & Adventure','1992-07-01',27.99,62.45,105.11,8836)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Deja Vu', '','Action & Adventure','1990-12-01',8.22,22.20,57.18,12152)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Demon Sword', '','Action & Adventure','1990-01-01',5.35,17.99,90.52,12153)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Desert Commander', '','Action & Adventure','1989-06-01',5.17,18.42,59.99,12154)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Destination Earthstar', '','Other','1990-02-01',3.45,12.99,32.39,12155)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Destiny of an Emperor', '','Action & Adventure','1990-09-01',19.56,77.75,246.21,12156)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dick Tracy', '','Action & Adventure','1990-08-01',5.96,22.00,103.37,12157)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Die Hard', '','Action & Adventure','1992-01-01',98.49,201.32,314.56,8841)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dig Dug II: Trouble in Paradise', '','Action & Adventure','1989-12-01',7.00,22.11,180.94,12159)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Digger T Rock', '','Action & Adventure','1990-12-01',10.39,32.95,96.83,12160)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dirty Harry', '','Action & Adventure','1990-12-01',7.13,20.95,50.96,12161)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dizzy the Adventurer', '','Puzzle','1993-01-01',19.59,109.15,349.28,39508)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dogbone Controller', '','Controllers','',18.51,49.99,129.99,21555)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong', '','Action & Adventure','1986-06-01',26.89,139.86,290.52,11985)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong 3', '','Action & Adventure','1986-06-01',11.69,72.69,232.16,12163)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong 3 [5 Screw]', '','Action & Adventure','1986-06-01',17.86,87.50,188.08,37986)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong Classics', '','Action & Adventure','1988-10-01',9.99,33.60,172.13,12164)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong Jr', '','Action & Adventure','1986-06-01',15.19,53.26,199.94,11986)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong Jr Math', '','Educational','1985-10-01',82.12,1000.00,1867.50,11987)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong Jr Math [5 Screw]', '','Educational','1985-10-01',78.51,1391.66,1391.66,37968)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong Jr [5 Screw]', '','Action & Adventure','1986-06-01',19.83,167.99,204.11,37985)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Donkey Kong [5 Screw]', '','Action & Adventure','1986-06-01',26.49,182.23,319.97,37984)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Dare', '','Action & Adventure','1990-04-01',9.59,36.00,87.45,12167)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Dragon', '','Action & Adventure','1988-06-01',9.59,37.00,497.23,12207)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Dragon II', '','Action & Adventure','1990-01-01',9.08,40.50,242.99,12208)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Dragon III', '','Action & Adventure','1991-02-01',12.84,49.95,153.58,12209)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Dribble', '','Basketball','1987-09-01',4.84,13.87,71.00,11988)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Dribble [5 Screw]', '','Basketball','1987-09-01',6.38,6.50,33.28,38023)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Double Strike', '','Action & Adventure','1990-01-01',17.12,59.95,64.17,12210)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dr Chaos', '','Action & Adventure','1988-11-01',6.63,24.12,57.73,12211)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dr Jekyll and Mr Hyde', '','Action & Adventure','1989-04-01',14.25,40.00,84.89,12212)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dr. Mario', '','Puzzle','1990-10-01',6.88,17.80,124.98,8859)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Fighter', '','Action & Adventure','1992-01-01',295.00,549.95,653.75,8864)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Power', '','Action & Adventure','1988-03-01',4.00,22.09,35.70,12213)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Spirit', '','Action & Adventure','1989-12-01',8.20,28.48,90.73,12214)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Warrior', '','RPG','1989-08-01',7.27,34.99,200.29,12216)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Warrior II', '','RPG','1990-09-01',26.02,80.00,265.52,12215)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Warrior III', '','RPG','1992-03-01',57.18,133.54,700.10,8868)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon Warrior IV', '','RPG','1992-10-01',79.01,155.03,774.44,8869)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dragon''s Lair the Legend', '','Action & Adventure','1990-12-01',15.92,33.24,110.88,12217)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Duck Hunt', '','Other','1985-10-18',6.00,36.91,134.75,12218)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Duck Hunt [5 Screw]', '','Action & Adventure','1985-10-18',6.50,42.91,67.98,37976)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Duck Tales', '','Action & Adventure','1989-09-01',14.92,64.63,600.00,12219)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Duck Tales 2', '','Action & Adventure','1993-10-01',146.75,396.23,1155.78,8878)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Duck Tales Gold Cartridge', '','Action & Adventure','2013-08-08',1200.00,1275.00,1415.15,34156)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dudes with Attitude', '','Action & Adventure','1990-01-01',7.01,22.24,50.00,12220)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dungeon Magic', '','RPG','1989-11-10',6.12,22.99,99.99,12221)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dusty Diamond''s All-Star Softball', '','Baseball','1990-07-01',49.98,87.50,245.80,12222)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Dynowarz The Destruction of Spondylus', '','Action & Adventure','1990-04-01',5.60,18.68,79.99,8889)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Elevator Action', '','Puzzle','1987-08-01',7.98,31.90,299.99,11989)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Elevator Action [5 Screw]', '','Action & Adventure','1987-08-01',7.36,64.98,88.64,38017)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Eliminator Boat Duel', '','Racing','1991-11-01',15.86,41.55,79.24,8906)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Excitebike', '','Racing','1985-10-18',4.99,32.75,350.01,11990)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Excitebike [5 Screw]', '','Racing','1985-10-18',9.69,64.84,112.00,37977)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Exodus Journey to the Promised Land', '','RPG','1990-01-01',10.98,23.38,71.86,12223)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('F-117A Stealth Fighter', '','Other','1992-12-01',11.99,23.99,247.65,8928)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('F-15 City War', '','Action & Adventure','1990-01-01',7.47,15.99,44.99,19760)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('F-15 Strike Eagle', '','Action & Adventure','1992-02-01',7.82,16.33,137.90,8929)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Family Feud', '','Other','1991-05-01',9.82,14.75,34.13,8935)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Family Fun Fitness Pad', '','Controllers','1990-01-01',0.00,0.00,0.00,45059)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Family Fun Fitness Stadium Events', '','Sports','1987-09-01',10100.00,21166.66,28554.41,12224)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fantastic Adventures of Dizzy', '','Action & Adventure','1993-01-01',10.00,30.01,70.27,12225)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fantastic Adventures of Dizzy [Aladdin]', '','Action & Adventure','1987-01-01',0.76,2.96,19.50,39521)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fantasy Zone', '','Action & Adventure','1989-01-01',18.98,34.89,85.03,12226)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Faria', '','RPG','1991-06-01',75.00,149.18,389.99,8939)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Faxanadu', '','Action & Adventure','1989-08-01',6.86,29.30,134.55,13717)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Felix the Cat', '','Action & Adventure','1992-10-01',62.74,191.20,369.79,8948)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ferrari Grand Prix Challenge', '','Racing','1992-06-01',6.86,21.51,56.46,8949)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fester''s Quest', '','Action & Adventure','1989-09-01',4.47,17.16,69.85,8950)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Final Fantasy', '','RPG','1990-05-01',15.31,79.99,555.00,8970)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fire ''N Ice', '','Puzzle','1993-03-01',124.49,228.97,510.29,8975)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Firehawk', '','Action & Adventure','1991-01-01',9.37,26.72,32.87,12229)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fisher Price I Can Remember', '','Other','1990-03-01',6.99,18.96,62.63,12230)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fisher Price Perfect Fit', '','Other','1990-03-01',9.21,25.79,86.30,12231)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fisher-Price Firehouse Rescue', '','Action & Adventure','1992-03-01',17.00,49.51,102.35,8976)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fist of the North Star', '','Fighting','1989-04-01',14.27,41.78,46.00,12232)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Flight of the Intruder', '','Action & Adventure','1991-05-01',6.13,16.49,39.47,8981)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Flintstones Surprise at Dinosaur Peak', '','Action & Adventure','1994-08-01',795.63,2070.01,6624.03,13107)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Flintstones The Rescue of Dino and Hoppy', '','Action & Adventure','1991-12-01',16.31,61.42,341.71,8983)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Flying Dragon', '','Action & Adventure','1989-08-01',6.32,18.42,64.00,12234)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Flying Warriors', '','Action & Adventure','1991-02-01',14.57,33.97,90.00,12235)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Formula One Built To Win', '','Racing','1990-11-01',14.99,57.58,81.33,14550)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Frankenstein the Monster Returns', '','Action & Adventure','1991-07-01',63.10,179.55,189.00,12236)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Freedom Force', '','Action & Adventure','1988-04-01',10.52,29.00,48.03,12237)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Friday the 13th', '','Action & Adventure','1989-02-01',9.10,44.36,152.75,12238)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Fun House', '','Action & Adventure','1991-01-01',8.18,24.49,77.18,12239)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('G.I. Joe: A Real American Hero', '','Action & Adventure','1991-01-01',50.23,144.20,465.05,12240)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('GI Joe The Atlantis Factor', '','Action & Adventure','1992-03-01',29.95,81.93,214.03,9034)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Galactic Crusader', '','Action & Adventure','1990-01-01',33.77,62.95,99.74,32330)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Galaga: Demons of Death', '','Other','1988-09-01',10.20,18.88,96.50,11991)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Galaxy 5000', '','Action & Adventure','1991-02-01',22.95,53.52,173.12,12242)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Galf', '','Sports','2018-08-01',18.00,46.87,64.04,52012)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Galf [White]', '','Sports','2018-08-01',102.38,150.00,169.99,52013)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Game Genie', '','Accessories','',10.07,34.35,48.01,13192)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Game Genie Top Loader Adaptor', '','Accessories','1994-01-01',219.17,397.37,1271.59,37040)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gargoyle''s Quest II The Demon Darkness', '','Action & Adventure','1994-12-01',56.51,177.75,429.25,9012)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gauntlet', '','Action & Adventure','1987-01-01',7.50,16.39,76.77,12243)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gauntlet II', '','Action & Adventure','1990-09-01',8.15,23.11,55.84,9013)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gauntlet [Gray Cart]', '','Action & Adventure','1987-01-01',9.99,26.99,83.08,39511)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gemfire', '','Strategy','1992-03-01',90.00,149.99,191.15,9018)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Genghis Khan', '','Action & Adventure','1990-01-01',9.99,30.88,98.82,12244)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('George Foreman''s KO Boxing', '','Sports','1992-12-01',7.50,16.50,54.05,9025)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ghost Lion', '','RPG','1992-10-01',49.58,117.50,190.01,9029)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ghostbusters', '','Action & Adventure','1988-10-01',8.34,35.14,71.22,12245)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ghostbusters II', '','Action & Adventure','1990-04-01',11.34,29.67,151.25,9032)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ghosts ''n Goblins', '','Action & Adventure','1986-11-01',9.99,46.00,414.58,11992)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ghosts ''n Goblins [5 Screw]', '','Action & Adventure','1986-11-01',12.98,74.09,143.50,37998)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ghoul School', '','Action & Adventure','1992-03-01',20.85,56.58,137.03,9033)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gilligan''s Island', '','Action & Adventure','1990-07-01',12.75,32.86,105.13,12247)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Goal', '','Soccer','1989-10-01',4.95,7.83,21.98,12248)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Goal Two', '','Soccer','1992-11-01',22.00,39.00,115.06,9039)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Godzilla', '','Action & Adventure','1989-10-01',14.32,41.50,118.85,12249)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Godzilla 2', '','Strategy','1992-02-01',82.60,201.00,900.00,9042)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gold Medal Challenge ''92', '','Sports','1992-08-01',12.99,29.99,83.24,9045)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Golf', '','Sports','1985-10-01',4.99,19.49,126.75,9050)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Golf Grand Slam', '','Sports','1991-12-01',13.03,31.64,63.70,9051)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Golf [5 Screw]', '','Sports','1985-10-01',6.00,22.34,50.22,37969)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Golgo 13 Top Secret Episode', '','Action & Adventure','1988-09-01',5.77,21.19,53.50,12250)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gotcha', '','Action & Adventure','1987-01-01',2.00,13.00,58.58,12251)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gotcha [5 Screw]', '','Action & Adventure','1987-01-01',377.10,978.10,3129.93,39516)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gradius', '','Other','1986-12-01',9.97,59.99,314.53,11993)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gradius [5 Screw]', '','Other','1986-12-01',10.16,59.99,122.84,37999)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Great Waldo Search', '','Puzzle','1992-12-01',13.46,37.72,70.51,9063)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Greg Norman''s Golf Power', '','Sports','1992-07-01',11.03,20.80,35.00,9068)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gremlins 2', '','Action & Adventure','1990-01-01',13.46,39.58,74.38,12252)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Guerrilla War', '','Action & Adventure','1989-06-01',9.48,30.37,124.86,12253)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gumshoe', '','Action & Adventure','1986-06-06',9.99,62.58,695.99,12254)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gumshoe [5 Screw]', '','Other','1986-06-01',9.99,65.37,100.90,37990)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gun-Nac', '','Action & Adventure','1991-09-01',200.00,560.28,849.95,12255)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gun.Smoke', '','Action & Adventure','1988-02-01',14.43,66.07,266.94,12256)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gyromite', '','Action & Adventure','1985-10-01',5.97,32.75,44.32,12257)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gyromite [5 Screw]', '','Other','1985-10-01',5.54,29.99,66.07,37970)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gyromite [ROB Bundle]', '','Action & Adventure','1985-10-01',203.78,550.21,1760.67,37958)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Gyruss', '','Action & Adventure','1989-02-01',6.20,27.47,52.25,12258)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Harlem Globetrotters', '','Basketball','1991-03-01',7.12,18.97,55.61,12259)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hatris', '','Puzzle','1992-04-01',15.39,33.98,49.95,9097)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Heavy Barrel', '','Action & Adventure','1990-03-01',12.45,40.60,122.22,12260)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Heavy Shreddin''', '','Action & Adventure','1990-06-01',4.22,16.99,59.84,12261)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('High Speed', '','Arcade','1991-07-01',7.84,17.95,45.61,9109)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hogan''s Alley', '','Other','1985-10-01',6.87,24.97,158.44,12262)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hogan''s Alley [5 Screw]', '','Other','1985-10-01',9.59,24.61,77.47,37971)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hollywood Squares', '','Other','1989-09-01',6.00,15.92,40.52,9115)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Holy Diver [Collectors Edition]', '','Platformer','2018-08-01',26.77,72.50,103.45,58103)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Home Alone', '','Action & Adventure','1991-10-01',9.63,23.55,81.00,9117)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Home Alone 2 Lost In New York', '','Action & Adventure','1992-10-01',5.26,16.88,69.00,9119)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hook', '','Action & Adventure','1992-04-01',7.69,20.75,101.32,9121)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hoops', '','Basketball','1989-06-01',3.00,10.42,27.50,12263)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hot Slots', '','Action & Adventure','1991-01-01',926.04,1429.25,2040.55,14931)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hudson Hawk', '','Action & Adventure','1992-02-01',13.15,23.99,55.92,9132)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hunt for Red October', '','Action & Adventure','1991-01-01',5.05,17.99,46.00,9133)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Hydlide', '','Action & Adventure','1989-06-01',4.97,18.99,52.24,12264)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ice Climber', '','Action & Adventure','1985-10-01',15.07,69.27,225.18,11994)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ice Climber [5 Screw]', '','Action & Adventure','1985-10-01',15.88,162.42,165.58,37972)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ice Hockey', '','Sports','1988-03-01',4.72,13.50,74.91,11995)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ikari Warriors', '','Action & Adventure','1987-05-01',6.19,24.99,80.58,12265)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ikari Warriors II', '','Action & Adventure','1988-04-01',8.24,26.28,101.18,12266)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ikari Warriors III', '','Action & Adventure','1991-02-01',19.03,59.88,232.63,12267)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ikari Warriors [5 Screw]', '','Action & Adventure','1987-05-01',9.02,96.00,96.00,38008)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Image Fight', '','Fighting','1990-07-01',12.50,56.51,71.54,12268)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Immortal', '','RPG','1990-11-01',8.98,23.97,50.00,9138)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Impossible Mission II', '','Action & Adventure','1990-01-01',18.86,27.55,51.63,12269)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Impossible Mission II [AVE]', '','Action & Adventure','1990-01-01',15.40,32.92,105.34,44966)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Impossible Mission II [SEI]', '','Action & Adventure','1990-01-01',23.00,29.95,165.92,39510)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Incredible Crash Dummies', '','Action & Adventure','1994-08-01',14.54,34.90,111.82,9143)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Indiana Jones and the Last Crusade', '','Action & Adventure','1993-12-01',20.26,58.39,200.01,12270)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Indiana Jones and the Last Crusade [Ubisoft]', '','Action & Adventure','',95.93,159.49,511.38,30748)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Indiana Jones and the Temple of Doom', '','Action & Adventure','1988-12-01',7.75,25.30,164.99,12271)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Indiana Jones and the Temple of Doom [Tengen]', '','Action & Adventure','1988-12-01',10.37,27.48,274.99,39513)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Infiltrator', '','Action & Adventure','1990-01-01',3.94,11.55,43.00,12272)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Iron Sword Wizards and Warriors II', '','RPG','1988-01-01',4.80,16.11,59.50,12274)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Iron Tank', '','Action & Adventure','1988-07-01',7.43,22.44,59.99,12273)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Isolated Warrior', '','Action & Adventure','1991-02-01',26.77,48.77,114.52,12275)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jack Nicklaus Golf', '','Sports','1989-04-01',3.57,8.35,17.49,9155)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jackal', '','Action & Adventure','1988-09-01',8.51,40.65,149.07,12276)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jackie Chan''s Action Kung Fu', '','Action & Adventure','1990-12-01',53.74,131.97,275.00,12277)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('James Bond Jr', '','Action & Adventure','1991-09-01',25.99,54.73,101.15,9161)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jaws', '','Action & Adventure','1987-11-01',5.97,29.92,138.14,12278)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jaws [5 Screw]', '','Action & Adventure','1987-01-01',0.00,0.00,0.00,39519)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jeopardy', '','Other','1988-09-01',2.99,10.98,30.63,9169)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jeopardy 25th Anniversary', '','Other','1990-06-01',3.73,9.28,19.99,9170)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jeopardy Jr', '','Other','1989-01-01',3.54,12.99,39.02,9172)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jetsons Cogswell''s Caper', '','Action & Adventure','1992-12-01',140.23,323.57,999.99,9176)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jimmy Connors Tennis', '','Sports','1993-11-01',64.55,141.41,299.99,9177)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Joe and Mac', '','Action & Adventure','1992-12-01',15.76,59.99,294.46,9179)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('John Elway''s Quarterback', '','Football','1989-03-01',3.21,8.00,25.50,12279)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jordan vs Bird One on One', '','Basketball','1989-08-01',4.18,17.13,60.00,12280)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Joshua: The Battle of Jericho', '','Action & Adventure','1992-01-01',12.72,34.03,60.75,12281)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Journey to Silius', '','Action & Adventure','1990-09-01',24.99,55.80,193.97,12282)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Joust', '','Action & Adventure','1988-10-01',7.04,24.95,56.58,12283)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Jurassic Park', '','Action & Adventure','1993-06-01',12.99,33.59,144.54,9190)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kabuki Quantum Fighter', '','Fighting','1991-01-01',16.26,46.08,86.57,12284)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Karate Champ', '','Fighting','1986-11-01',4.34,14.56,49.44,12285)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Karate Champ [5 Screw]', '','Sports','1986-11-01',6.19,45.00,56.36,39518)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Karnov', '','Action & Adventure','1988-01-01',7.28,31.07,509.99,12286)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kick Master', '','Action & Adventure','1992-07-01',71.33,144.99,318.02,9204)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kickle Cubicle', '','Action & Adventure','1990-09-01',14.02,44.14,96.00,12287)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kid Icarus', '','Action & Adventure','1987-07-01',16.50,60.97,870.59,11996)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kid Icarus [5 Screw]', '','Action & Adventure','1987-07-01',18.12,135.37,204.89,38010)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kid Klown in Night Mayor World', '','Action & Adventure','1993-04-01',252.07,399.38,1325.04,9205)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kid Kool', '','Action & Adventure','1988-01-01',9.99,34.49,87.00,12288)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kid Niki Radical Ninja', '','Action & Adventure','1987-11-01',8.25,38.95,121.51,12289)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kid Niki Radical Ninja [5 Screw]', '','Action & Adventure','1987-11-01',9.98,24.03,76.90,38041)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('King Neptune''s Adventure', '','Action & Adventure','1990-01-01',99.96,225.00,239.99,16437)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('King of Kings', '','RPG','1991-01-01',9.70,28.81,64.99,12290)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('King''s Knight', '','Strategy','1989-09-01',6.48,32.63,71.38,9212)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('King''s Quest V', '','RPG','1992-06-01',18.43,49.36,304.41,12291)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kings of the Beach', '','Sports','1990-01-01',3.87,13.74,42.00,12292)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kirby''s Adventure', '','Action & Adventure','1993-05-01',14.94,42.77,106.22,9213)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kiwi Kraze', '','Action & Adventure','1991-03-01',21.75,57.42,200.00,12293)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Klash Ball', '','Sports','1991-07-01',15.00,24.71,41.18,12294)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Klax', '','Puzzle','1990-01-01',6.50,15.97,44.39,12295)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Knight Rider', '','Racing','1989-12-01',7.69,31.68,64.03,12296)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Krazy Kreatures', '','Action & Adventure','1990-01-01',14.42,42.50,85.16,12297)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Krion Conquest', '','Action & Adventure','1991-01-01',63.58,118.69,324.97,12298)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Krusty''s Fun House', '','Puzzle','1992-09-01',10.02,31.08,147.82,9217)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kung Fu', '','Fighting','1985-10-01',5.65,36.99,279.10,12299)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kung Fu Heroes', '','Fighting','1989-03-01',5.53,21.20,66.25,12300)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Kung Fu [5 Screw]', '','Action & Adventure','1985-10-01',8.37,41.02,71.96,37973)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('L''Empereur', '','Strategy','1991-11-01',72.27,118.86,304.00,9242)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Laser Invasion', '','Action & Adventure','1991-06-01',13.23,30.00,80.52,9222)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Laserscope', '','Accessories','',30.00,77.78,99.82,19472)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Last Action Hero', '','Action & Adventure','1993-10-01',55.07,92.88,178.87,9224)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Last Starfighter', '','Action & Adventure','1990-06-01',10.31,28.24,104.50,12301)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lee Trevino''s Fighting Golf', '','Sports','1988-09-01',3.68,9.92,28.89,12302)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legacy of the Wizard', '','RPG','1989-04-01',4.14,21.93,70.21,12303)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legend of Kage', '','Action & Adventure','1987-08-01',7.05,22.57,149.49,11997)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legend of Kage [5 Screw]', '','Action & Adventure','1987-08-01',6.99,28.25,90.40,38018)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legend of Zelda', '','Strategy','1987-08-22',14.38,73.19,209.87,9236)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legend of Zelda [5 Screw]', '','Action & Adventure','1987-08-22',19.80,89.80,285.22,38020)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legend of Zelda [Gray Cart]', '','Action & Adventure','1993-01-01',18.02,45.00,154.43,38512)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legendary Wings', '','Other','1988-07-01',9.88,28.66,109.50,12304)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Legends of the Diamond', '','Baseball','1992-01-01',10.21,27.00,47.18,12305)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lemmings', '','Puzzle','1992-11-01',29.94,59.00,188.87,9240)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lethal Weapon', '','Action & Adventure','1993-04-01',25.00,64.20,174.72,9245)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Life Force', '','Action & Adventure','1988-08-01',9.71,40.45,198.73,12306)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Linus Spacehead''s Cosmic Adventure', '','Action & Adventure','1992-01-01',89.98,175.90,309.99,12307)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Linus Spacehead''s Cosmic Adventure [Aladdin]', '','Action & Adventure','1987-01-01',2.23,6.02,27.49,39522)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Little League Baseball', '','Baseball','1990-06-01',5.82,17.45,68.66,12308)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Little Mermaid', '','Action & Adventure','1991-07-01',8.02,30.62,59.43,9248)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Little Nemo The Dream Master', '','Action & Adventure','1990-09-01',12.59,39.39,148.86,9249)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Little Ninja Brothers', '','Action & Adventure','1990-12-01',34.99,105.54,341.24,12309)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Little Samson', '','Action & Adventure','1992-11-01',1076.84,2726.42,8925.63,9250)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lode Runner', '','Action & Adventure','1987-09-01',8.81,44.10,1150.00,11998)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lode Runner [5 Screw]', '','Action & Adventure','1987-09-01',13.44,31.40,100.48,38024)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lone Ranger', '','Action & Adventure','1991-08-01',38.29,78.54,150.62,9253)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Loopz', '','Puzzle','1990-10-01',6.72,15.00,27.78,12310)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Low G Man', '','Action & Adventure','1990-09-01',9.07,24.50,67.50,12311)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lunar Pool', '','Sports','1987-10-01',3.34,12.70,99.97,9260)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Lunar Pool [5 Screw]', '','Sports','1987-09-01',7.00,24.50,58.10,38036)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('M.C. Kids', '','Action & Adventure','1992-02-01',12.85,35.00,212.49,9307)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('M.U.L.E.', '','Other','1990-09-01',13.56,34.00,82.00,9387)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('MTV Remote Control', '','Action & Adventure','1990-05-01',2.49,17.18,55.88,12386)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('MUSCLE', '','Action & Adventure','1986-10-01',9.14,64.46,206.27,12312)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mach Rider', '','Racing','1985-10-18',6.77,38.84,1000.00,11999)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mach Rider [5 Screw]', '','Racing','1985-10-18',8.02,33.45,78.32,37978)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mad Max', '','Action & Adventure','1990-07-01',10.39,37.50,147.63,12313)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Magic Darts', '','Sports','1991-09-01',7.27,20.14,43.49,9275)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Magic Johnson''s Fast Break', '','Basketball','1994-03-01',3.87,13.36,28.05,12227)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Magician', '','Action & Adventure','1991-02-01',24.65,51.00,190.45,12314)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Magmax', '','Action & Adventure','1988-10-01',4.99,15.11,42.24,12315)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Major League Baseball', '','Baseball','1988-04-01',3.80,10.75,35.79,12316)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Maniac Mansion', '','Action & Adventure','1990-09-01',14.51,53.10,179.00,12317)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mappy-Land', '','Action & Adventure','1989-04-01',11.75,34.97,190.00,13766)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Marble Madness', '','Puzzle','1989-03-01',6.55,20.47,71.39,12319)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mario Bros', '','Action & Adventure','1986-06-01',15.99,91.00,768.61,12000)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mario Bros [5 Screw]', '','Action & Adventure','1986-06-01',19.92,82.49,197.37,37987)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mario Is Missing', '','Action & Adventure','1993-07-01',13.65,46.24,216.34,9287)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mario''s Time Machine', '','Action & Adventure','1994-06-01',44.49,108.16,369.99,9289)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Master Chu and the Drunkard Hu', '','Action & Adventure','1989-01-01',38.97,57.20,173.59,12321)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Maxi 15', '','Action & Adventure','1992-01-01',51.02,82.66,199.99,14925)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mechanized Attack', '','Action & Adventure','1990-06-01',12.82,35.00,110.40,12322)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man', '','Action & Adventure','1987-12-01',56.26,249.49,898.98,9314)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 10', '','Action & Adventure','2016-01-01',25.46,68.74,172.96,37373)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 2', '','Action & Adventure','1989-06-01',14.75,70.00,760.27,12323)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 2 [30th Anniversary Edition]', '','Action & Adventure','2018-07-01',17.99,66.55,90.14,53798)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 3', '','Action & Adventure','1990-11-01',13.84,66.93,439.95,9315)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 4', '','Action & Adventure','1992-01-01',24.00,69.25,307.85,12324)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 5', '','Action & Adventure','1992-12-01',70.00,184.00,748.62,9316)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 6', '','Action & Adventure','1994-03-01',29.99,115.39,462.50,9317)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man 9 Press Kit', '','Action & Adventure','2008-09-22',275.63,284.26,339.77,34155)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mega Man [5 Screw]', '','Action & Adventure','1987-12-01',0.00,0.00,0.00,38045)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Megacom 76', '','Other','',35.00,0.00,0.00,16294)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Menace Beach', '','Action & Adventure','1990-01-01',224.91,346.04,749.99,12325)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mendel Palace', '','Action & Adventure','1990-10-01',11.92,30.00,77.54,12326)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mermaids of Atlantis', '','Action & Adventure','1991-01-01',43.06,57.86,122.38,12327)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metal Fighter', '','Fighting','1989-01-01',15.89,39.40,49.19,12328)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metal Gear', '','Action & Adventure','1988-06-01',6.17,54.28,356.75,12329)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metal Mech', '','Action & Adventure','1991-03-01',9.90,26.67,74.21,12330)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metal Storm', '','Action & Adventure','1991-02-01',102.50,255.00,608.82,12331)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metroid', '','Action & Adventure','1986-08-01',14.58,60.67,556.77,9331)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metroid [5 Screw]', '','Action & Adventure','1986-08-01',14.99,99.99,223.46,37991)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Metroid [Yellow Label]', '','Action & Adventure','1993-01-01',15.43,60.03,151.84,38511)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Michael Andretti''s World GP', '','Racing','1990-06-01',6.60,15.20,45.41,12332)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mickey Mousecapade', '','Action & Adventure','1988-10-01',3.65,20.19,175.01,9337)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mickey''s Adventure in Numberland', '','Action & Adventure','1994-03-01',51.30,159.52,448.99,9338)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mickey''s Safari in Letterland', '','Action & Adventure','1993-03-01',7.50,43.88,66.96,9339)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Micro Machines', '','Racing','1991-01-01',23.14,39.13,101.18,12333)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Micro Machines [Aladdin]', '','Racing','1987-01-01',18.50,19.99,24.88,39523)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mig 29', '','Other','1989-01-01',7.64,19.97,40.04,12334)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Might and Magic', '','Strategy','1992-08-01',37.00,84.84,200.00,9349)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mighty Bomb Jack', '','Action & Adventure','1987-07-01',8.52,39.98,125.72,12002)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mighty Bomb Jack [5 Screw]', '','Action & Adventure','1987-07-01',9.44,9.50,43.20,38011)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mighty Final Fight', '','Action & Adventure','1993-07-01',187.21,529.99,650.00,9351)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mike Tyson''s Punch-Out', '','Sports','1987-10-01',16.29,103.89,1106.99,12001)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mike Tyson''s Punch-Out [5 Screw]', '','Sports','1987-01-01',600.00,1815.50,5809.60,39517)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Millipede', '','Arcade','1988-10-01',4.69,14.48,57.48,12336)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Milon''s Secret Castle', '','Action & Adventure','1988-09-01',5.74,21.24,68.79,12003)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Miracle Piano', '','Music','1990-01-01',11.73,194.55,199.98,12337)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Miracle Piano Keyboard', '','Accessories','1990-01-01',37.47,129.56,414.59,50113)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mission Cobra', '','Other','1990-01-01',40.58,55.27,138.67,19303)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mission Impossible', '','Action & Adventure','1990-09-01',5.07,15.07,44.41,9358)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Monopoly', '','Strategy','1991-05-01',5.15,11.71,37.41,9366)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Monster Party', '','Action & Adventure','1989-06-01',12.79,52.94,149.99,12338)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Monster Truck Rally', '','Racing','1991-09-01',14.26,29.99,75.97,12339)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Monster in My Pocket', '','Action & Adventure','1992-01-01',38.57,122.73,343.71,12340)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Moon Ranger', '','Action & Adventure','1990-01-01',186.10,247.08,276.25,21116)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Motor City Patrol', '','Action & Adventure','1992-01-01',39.52,79.18,130.01,9377)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ms. Pac-Man (Namco)', '','Action & Adventure','1993-11-01',29.70,52.50,169.99,9382)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ms. Pac-Man [Tengen]', '','Arcade','1990-01-01',14.88,29.70,103.62,30883)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Muppet Adventure', '','Action & Adventure','1990-11-01',8.37,21.88,70.00,12341)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mutant Virus', '','Action & Adventure','1992-03-01',17.75,39.99,65.25,9390)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Myriad 6-in-1', '','Action & Adventure','1992-01-01',1421.73,2628.51,3000.00,14929)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Mystery Quest', '','Action & Adventure','1989-04-01',7.73,21.99,59.38,12342)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NARC', '','Action & Adventure','1990-08-01',5.00,16.61,73.35,12343)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NES Advantage Controller', '','Controllers','',19.43,31.45,98.60,16388)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NES Four Score', '','Accessories','',17.31,46.71,49.29,16389)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NES Max Controller', '','Controllers','',12.02,27.08,79.99,21587)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NES Open Tournament Golf', '','Sports','1991-09-29',7.09,14.47,59.99,9449)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NES Satellite 4 Controller Port', '','Accessories','',13.66,36.85,117.92,19364)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NES Test Station', '','Systems','',0.00,0.00,0.00,62501)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NFL Football', '','Football','1989-09-01',3.92,15.58,34.00,9459)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('NTF2 Test Cartridge', '','Other','',304.00,530.00,0.00,21251)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nigel Mansell''s World Championship Racing', '','Racing','1993-10-01',12.15,32.81,103.30,9483)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nightshade', '','Action & Adventure','1992-01-01',22.45,47.72,127.97,9487)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ninja Crusaders', '','Action & Adventure','1990-12-01',23.58,81.23,149.99,12344)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ninja Gaiden', '','Action & Adventure','1989-03-01',10.00,51.00,71.12,9488)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ninja Gaiden II The Dark Sword of Chaos', '','Action & Adventure','1990-05-01',10.98,53.37,177.50,12004)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ninja Gaiden III Ancient Ship of Doom', '','Action & Adventure','1991-08-01',51.39,193.24,490.53,9490)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ninja Kid', '','Action & Adventure','1986-10-29',7.99,75.07,111.97,12345)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ninja Kid [5 Screw]', '','Action & Adventure','1986-10-01',10.11,26.59,85.09,37995)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo Campus Challenge 1991', '','Other','1991-12-01',20100.00,0.00,0.00,19387)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo Campus Challenge 1991 [Reproduction]', '','Action & Adventure','2010-01-01',75.00,83.00,85.00,34874)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo M82', '','Systems','1985-08-01',3000.00,8100.00,25439.50,58065)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Action Set Console', '','Systems','1990-01-01',47.09,109.99,574.69,38568)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Challenge Set Console', '','Systems','1990-01-01',64.50,112.25,672.00,38570)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Classic Edition', '','Systems','2016-11-12',41.01,42.28,53.00,37130)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Classic Edition Controller', '','Controllers','2016-11-20',15.01,17.27,17.95,37198)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Console', '','Systems','1985-10-18',24.10,79.99,200.03,13743)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Controller', '','Controllers','',11.72,23.57,75.41,13805)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Deluxe Set Console', '','Systems','1990-01-01',284.45,372.00,1409.26,39977)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Power Set Console', '','Systems','1990-01-01',109.99,109.99,912.92,40469)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Sports Set Console', '','Systems','1990-01-01',60.79,164.13,525.18,38569)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo NES Test Market Console', '','Systems','1985-01-01',365.74,475.00,3035.64,58047)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo World Championship', '','Action & Adventure','1990-12-01',18997.14,0.00,0.00,14933)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo World Championship Gold', '','Action & Adventure','1990-12-01',18944.25,0.00,0.00,16173)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo World Championship [25th Anniversary]', '','Other','2015-01-01',283.06,351.68,905.79,38640)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo World Championship [Reproduction]', '','Action & Adventure','2010-01-01',64.44,74.81,84.96,34873)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nintendo World Cup', '','Soccer','1990-12-01',4.31,16.20,49.60,9492)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nobunaga''s Ambition', '','Strategy','1989-06-01',9.69,22.48,67.59,9495)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Nobunaga''s Ambition 2', '','Strategy','1991-04-01',87.21,172.20,379.95,13108)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('North and South', '','Action & Adventure','1990-12-01',34.99,88.99,102.59,12346)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('ORB 3D', '','Action & Adventure','1990-10-01',5.71,14.47,40.50,12347)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Operation Secret Storm', '','Action & Adventure','1992-01-01',81.27,131.44,356.14,14281)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Operation Wolf', '','Action & Adventure','1989-05-01',4.36,15.70,69.95,12348)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Othello', '','Puzzle','1988-12-01',3.29,9.88,27.46,12349)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Overlord', '','Strategy','1993-01-01',10.89,25.12,80.00,9516)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('P''radikus Conflict', '','Strategy','1990-01-01',61.40,80.57,83.94,19390)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('POW Prisoners of War', '','Action & Adventure','1988-01-01',5.87,35.18,100.95,12350)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pac-Man [Namco]', '','Action & Adventure','1993-12-01',14.74,31.78,84.54,9518)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pac-Man [Tengen Gray]', '','Arcade','1991-01-01',9.46,16.40,73.95,40508)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pac-Man [Tengen]', '','Arcade','1987-01-01',10.00,20.69,129.95,30882)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pac-Mania', '','Action & Adventure','1993-11-01',13.38,34.95,158.05,12351)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Palamedes', '','Other','1990-11-01',12.50,31.78,67.99,16126)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Panic Restaurant', '','Action & Adventure','1992-10-01',475.41,1085.00,3405.33,9523)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Paperboy', '','Racing','1988-12-01',8.89,25.33,309.39,9528)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Paperboy 2', '','Action & Adventure','1992-04-01',11.04,29.99,196.12,9530)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Peek-a-Boo Poker', '','Action & Adventure','1991-01-01',741.82,1426.65,0.00,14932)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pesterminator', '','Action & Adventure','1990-01-01',51.96,109.99,499.88,19452)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Peter Pan and the Pirates', '','Action & Adventure','1991-01-01',10.00,20.00,65.00,12352)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Phantom Fighter', '','Other','1990-04-01',6.07,30.00,59.99,12353)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pictionary', '','Other','1990-07-01',5.63,9.31,39.95,12354)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pin-Bot', '','Action & Adventure','1990-04-01',3.45,16.70,44.07,12355)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pinball', '','Arcade','1985-10-18',6.98,16.78,144.56,12005)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pinball Quest', '','Arcade','1990-06-01',7.79,18.98,29.99,12356)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pinball [5 Screw]', '','Arcade','1985-10-18',8.59,22.94,72.21,37979)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pipe Dream', '','Puzzle','1990-09-01',5.85,16.39,39.83,12357)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pirates', '','Action & Adventure','1991-10-01',15.30,47.57,92.77,9558)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Platoon', '','Action & Adventure','1988-12-01',3.36,15.00,48.95,12358)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Play Action Football', '','Football','1990-09-01',1.98,7.97,29.94,9566)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Popeye', '','Action & Adventure','1986-06-01',13.37,55.05,142.10,12359)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Popeye [5 Screw]', '','Action & Adventure','1986-06-01',13.40,119.99,142.92,37988)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Power Blade', '','Action & Adventure','1991-03-01',43.00,102.30,153.29,9574)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Power Blade 2', '','Action & Adventure','1992-10-01',371.75,990.55,3169.76,9575)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Power Glove', '','Controllers','',56.61,110.00,469.69,13715)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Power Pad', '','Controllers','',12.99,39.53,126.50,13761)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Power Punch II', '','Fighting','1992-04-12',19.99,37.73,139.99,9577)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Predator', '','Action & Adventure','1989-04-01',12.35,41.54,167.77,12360)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Prince of Persia', '','Action & Adventure','1992-11-01',17.95,40.82,110.49,9584)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Princess Tomato in the Salad Kingdom', '','Action & Adventure','1991-02-01',122.47,187.62,545.84,12361)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pro Sports Hockey', '','Sports','1993-11-01',120.47,217.37,800.37,9592)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pro Wrestling', '','Wrestling','1987-03-01',4.77,58.30,174.47,12362)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pro Wrestling [5 Screw]', '','Wrestling','1987-02-01',8.03,61.11,92.74,38001)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Punch-Out', '','Sports','1990-08-01',9.42,26.98,103.93,12006)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Puss N'' Boots: Pero''s Great Adventure', '','Action & Adventure','1990-06-01',12.27,27.50,93.55,12364)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Puzzle', '','Puzzle','1990-01-01',12.05,27.34,84.78,12365)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Puzznic', '','Puzzle','1990-11-01',9.07,31.97,77.34,12366)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Pyramid', '','Action & Adventure','1992-01-01',7.25,20.25,54.00,12367)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Q*bert', '','Arcade','1989-01-01',7.99,20.37,134.93,12368)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Qix', '','Puzzle','1991-01-01',27.95,44.99,125.33,12369)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quattro Adventure', '','Action & Adventure','1991-01-01',7.38,19.99,49.59,12371)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quattro Adventure [Aladdin]', '','Action & Adventure','1987-01-01',1.61,4.35,18.50,39524)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quattro Arcade', '','Arcade','1992-01-01',14.86,31.44,49.99,19308)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quattro Sports', '','Sports','1991-01-01',6.18,18.47,35.92,12372)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quattro Sports [Aladdin]', '','Sports','1987-01-01',4.99,10.91,19.95,39525)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quickshot Joystick', '','Controllers','',8.11,21.04,67.33,21024)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Quickshot Sighting Scope', '','Accessories','',57.85,87.71,280.67,16260)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RBI Baseball', '','Baseball','1988-01-01',6.48,18.27,61.42,9635)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RBI Baseball 2', '','Baseball','1990-01-01',6.69,16.95,31.56,12373)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RBI Baseball 3', '','Baseball','1991-01-01',8.92,18.95,29.47,12374)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RBI Baseball [Gray Cart]', '','Baseball','1988-01-01',11.00,26.95,89.25,39512)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RC Pro-AM', '','Racing','1988-02-01',5.68,19.02,194.85,12375)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RC Pro-AM II', '','Racing','1992-12-01',68.89,184.85,458.95,9639)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('ROB the Robot', '','Accessories','1986-01-01',43.38,158.67,466.29,34135)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Race America', '','Racing','1992-05-01',41.95,73.00,133.88,9615)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Racermate Challenge II', '','Action & Adventure','',164.73,0.00,0.00,30824)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Racket Attack', '','Sports','1988-10-01',2.99,11.50,27.99,12376)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rad Racer', '','Racing','1987-01-01',4.72,27.57,564.72,12378)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rad Racer II', '','Racing','1990-06-01',7.00,19.99,78.96,12379)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rad Racer [5 Screw]', '','Racing','1987-01-01',7.85,33.50,66.23,38037)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rad Racket: Deluxe Tennis II', '','Sports','1991-01-01',47.14,97.00,310.53,30982)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Raid 2020', '','Action & Adventure','1989-01-01',24.99,36.60,57.11,12380)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Raid on Bungeling Bay', '','Action & Adventure','1987-09-01',7.48,24.26,90.64,12381)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Raid on Bungeling Bay [5 Screw]', '','Action & Adventure','1987-09-01',15.02,21.31,78.85,38025)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rainbow Islands', '','Action & Adventure','1991-06-01',22.94,71.05,193.94,12382)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rally Bike', '','Racing','1990-09-01',10.88,19.71,55.97,12383)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rambo', '','Action & Adventure','1988-05-01',6.23,21.19,55.39,12384)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rampage', '','Action & Adventure','1988-12-01',11.71,37.23,140.20,12385)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rampart', '','Racing','1992-01-01',12.17,22.90,94.99,9624)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Renegade', '','Action & Adventure','1988-01-01',7.87,32.28,133.05,12387)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rescue the Embassy Mission', '','Action & Adventure','1990-01-01',6.63,20.31,50.98,12388)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ring King', '','Action & Adventure','1987-09-01',6.90,38.86,104.85,12389)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ring King [5 Screw]', '','Sports','1987-09-01',6.57,25.91,82.91,38026)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('River City Ransom', '','Action & Adventure','1990-01-01',23.99,82.48,202.50,12390)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Road Runner', '','Action & Adventure','1989-01-01',9.21,21.48,255.93,12391)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RoadBlasters', '','Action & Adventure','1990-01-01',6.90,18.57,76.56,12392)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Robin Hood Prince of Thieves', '','Action & Adventure','1991-11-01',6.61,24.75,55.71,9669)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Robo Warrior', '','Action & Adventure','1988-12-01',6.72,16.49,47.22,12393)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('RoboCop 2', '','Action & Adventure','1991-04-01',13.25,41.67,120.00,9671)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Robocop', '','Action & Adventure','1989-12-01',6.00,20.48,86.07,12394)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Robocop 3', '','Action & Adventure','1992-08-01',23.66,44.80,201.64,9673)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Robodemons', '','Action & Adventure','1989-12-01',23.88,59.23,80.00,16141)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rock ''n Ball', '','Action & Adventure','1990-01-01',7.32,18.77,51.32,12395)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rocket Ranger', '','Action & Adventure','1990-06-01',5.00,12.72,37.84,12396)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rockin'' Kats', '','Action & Adventure','1991-09-01',69.29,171.93,539.87,9678)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Roger Clemens'' MVP Baseball', '','Baseball','1991-10-01',3.57,11.48,44.99,9681)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Roller Games', '','Sports','1990-09-01',7.71,18.48,45.00,12397)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rollerball', '','Action & Adventure','1990-02-01',5.75,17.75,44.63,12398)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rollerblade Racer', '','Sports','1993-02-01',12.70,41.09,131.12,9682)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rolling Thunder', '','Action & Adventure','1989-01-01',8.47,20.30,65.34,12399)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Romance of the Three Kingdoms', '','Strategy','1989-10-01',11.72,24.84,97.54,12400)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Romance of the Three Kingdoms II', '','Strategy','1991-09-01',64.30,99.74,325.00,12401)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Roundball 2-on-2 Challenge', '','Basketball','1992-05-01',8.90,22.74,60.87,9687)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rush''n Attack', '','Action & Adventure','1987-04-01',6.50,32.00,105.72,12402)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rush''n Attack [5 Screw]', '','Action & Adventure','1987-04-01',8.02,17.90,57.28,38004)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rygar', '','Action & Adventure','1987-07-01',8.24,49.95,475.00,12403)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Rygar [5 Screw]', '','Action & Adventure','1987-07-01',11.24,39.62,114.98,38012)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('SCAT Special Cybernetic Attack Team', '','Action & Adventure','1991-06-01',104.08,270.00,775.00,9697)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Secret Scout', '','Action & Adventure','1991-01-01',152.71,237.98,1222.26,12404)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Section Z', '','Action & Adventure','1987-07-01',5.50,35.48,129.99,12405)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Section-Z [5 Screw]', '','Action & Adventure','1987-07-01',6.99,28.15,68.98,38013)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Seicross', '','Action & Adventure','1988-10-01',5.24,23.70,51.98,12406)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sesame Street 123', '','Other','1989-01-01',3.00,9.99,45.03,13827)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sesame Street ABC', '','Other','1989-09-01',4.20,14.06,36.50,12408)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sesame Street ABC and 123', '','Other','1991-11-01',5.87,24.05,70.40,9720)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sesame Street Big Bird''s Hide and Speak', '','Other','1990-10-01',5.42,16.71,60.00,12409)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sesame Street Countdown', '','Other','1992-02-01',10.18,29.80,40.00,9721)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shadow of the Ninja', '','Action & Adventure','1990-12-01',39.44,142.48,373.79,12410)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shadowgate', '','Action & Adventure','1989-12-01',7.26,26.75,127.25,12411)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sharp Nintendo NES TV', '','Systems','1983-01-01',950.00,2564.02,7888.16,40395)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shatterhand', '','Action & Adventure','1991-12-01',44.44,126.94,184.02,9729)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shingen the Ruler', '','Action & Adventure','1990-06-01',8.44,19.27,69.00,12412)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shinobi', '','Action & Adventure','1989-01-01',11.18,25.99,143.50,12413)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shockwave', '','Action & Adventure','1990-01-01',18.36,35.65,41.19,12414)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Shooting Range', '','Other','1989-06-01',9.99,17.36,35.99,12415)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Short Order/Eggsplode', '','Action & Adventure','1989-12-01',9.77,18.33,55.00,12416)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Side Pocket', '','Sports','1987-06-01',4.66,19.49,70.00,12417)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Silent Assault', '','Action & Adventure','1990-01-01',13.30,29.67,57.79,12418)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Silent Service', '','Action & Adventure','1989-12-01',4.55,13.75,37.48,12419)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Silk Worm', '','Action & Adventure','1990-06-01',15.14,42.53,139.99,12420)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Silver Surfer', '','Action & Adventure','1990-11-01',15.99,50.50,105.26,12421)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Skate or Die', '','Extreme Sports','1988-12-01',4.51,16.30,129.53,12422)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Skate or Die 2', '','Extreme Sports','1990-09-01',9.18,30.12,96.37,12423)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ski or Die', '','Extreme Sports','1991-02-01',5.87,21.27,49.47,12424)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Skull and Crossbones', '','Action & Adventure','1990-01-01',7.18,19.98,47.27,12425)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sky Kid', '','Action & Adventure','1987-09-01',11.85,49.99,284.97,12426)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sky Kid [5 Screw]', '','Action & Adventure','1987-09-01',12.45,22.50,94.40,38027)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sky Shark', '','Action & Adventure','1989-09-01',4.99,15.50,39.07,12427)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Slalom', '','Sports','1987-08-01',6.03,58.62,186.44,12428)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Slalom [5 Screw]', '','Sports','1987-08-01',8.05,64.00,99.41,38019)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Smash TV', '','Action & Adventure','1991-09-01',8.84,28.00,74.99,9764)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Snake Rattle n Roll', '','Action & Adventure','1991-01-01',7.45,29.35,113.00,12429)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Snake''s Revenge', '','Action & Adventure','1990-04-01',9.00,46.30,185.47,9765)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Snoopy''s Silly Sports', '','Sports','1989-01-01',5.55,23.31,247.68,12430)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Snow Brothers', '','Puzzle','1991-11-01',188.23,609.00,2999.99,9768)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Soccer', '','Soccer','1987-03-01',6.97,60.66,250.42,12007)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Soccer [5 Screw]', '','Soccer','1987-03-01',12.23,107.50,144.99,38002)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Solar Jetman', '','Action & Adventure','1990-09-01',6.50,16.49,40.08,12431)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Solitaire', '','Other','1992-01-01',20.42,64.57,167.99,12432)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Solomon''s Key', '','Action & Adventure','1987-07-01',11.46,34.25,499.95,12008)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Solomon''s Key [5 Screw]', '','Action & Adventure','1987-07-01',13.73,39.95,122.51,38014)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Solstice', '','Puzzle','1989-12-01',4.86,15.31,49.00,9776)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Space Shuttle', '','Other','1991-11-01',16.21,50.57,81.00,9803)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spelunker', '','Action & Adventure','1987-09-01',10.89,23.00,80.10,12434)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spelunker [5 Screw]', '','Action & Adventure','1987-09-01',11.84,29.99,95.97,38028)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spiderman Return of the Sinister Six', '','Action & Adventure','1992-10-01',11.81,52.75,214.57,10594)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spiritual Warfare', '','Action & Adventure','1992-01-01',15.43,33.64,91.09,12436)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spot', '','Strategy','1990-09-01',8.90,19.99,65.48,9830)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spy Hunter', '','Action & Adventure','1987-09-01',5.45,21.00,110.67,12437)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spy Hunter [5 Screw]', '','Racing','1987-09-01',6.23,31.72,80.03,38029)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Spy vs. Spy', '','Action & Adventure','1988-10-01',7.04,22.50,121.76,9832)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sqoon', '','Action & Adventure','1987-09-01',65.74,646.06,2414.60,12438)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Stack Up', '','Other','1985-10-18',62.65,505.06,1224.47,16127)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Stanley The Search for Dr Livingston', '','Action & Adventure','1992-10-01',26.40,74.55,125.00,9839)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Force', '','Action & Adventure','1987-11-01',6.80,26.54,99.34,12439)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Force [5 Screw]', '','Action & Adventure','1987-11-01',154.07,399.62,1278.78,38042)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Soldier', '','Other','1989-01-01',7.97,20.67,49.99,12009)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Trek 25th Anniversary', '','Action & Adventure','1992-02-01',12.10,29.97,59.75,9842)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Trek The Next Generation', '','Action & Adventure','1993-09-01',17.32,45.08,115.25,9847)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Tropics', '','Strategy','1990-12-01',8.95,22.95,61.22,9848)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Tropics II: Zoda''s Revenge', '','RPG','1994-03-01',10.49,28.14,65.71,10238)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Voyager', '','Action & Adventure','1987-09-01',3.03,16.94,38.99,12440)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Voyager [5 Screw]', '','Action & Adventure','1987-09-01',7.45,19.90,61.84,38031)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Wars', '','Action & Adventure','1991-11-01',16.72,44.85,173.90,9849)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Wars The Empire Strikes Back', '','Action & Adventure','1992-03-01',22.77,52.08,182.98,9857)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Wars [Classic Edition]', '','Action & Adventure','2019-06-28',0.00,0.00,0.00,59746)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Star Wars [Premium Edition]', '','Action & Adventure','2019-06-28',0.00,0.00,0.00,60614)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Starship Hector', '','Action & Adventure','1990-06-01',11.17,32.95,65.24,12441)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Stealth', '','Other','1989-10-01',3.76,14.99,49.99,18720)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Stinger', '','Action & Adventure','1987-09-01',9.56,44.05,140.60,12443)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Street Cop', '','Action & Adventure','1989-06-01',24.58,49.99,75.06,12444)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Street Fighter 2010 the Final Fight', '','Fighting','1990-08-03',12.14,35.79,166.64,12445)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Strider', '','Action & Adventure','1989-07-01',9.00,29.97,110.75,12446)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Stunt Kids', '','Action & Adventure','1992-01-01',33.74,73.68,139.95,12447)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sunday Funday', '','Action & Adventure','1995-01-01',145.49,179.99,194.48,19476)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super C', '','Other','1990-04-01',12.07,49.31,302.63,9883)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Cars', '','Racing','1991-02-01',20.00,45.08,150.00,12448)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Dodge Ball', '','Sports','1989-06-01',11.95,40.00,100.00,12449)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Glove Ball', '','Sports','1990-10-01',4.88,18.38,37.74,12450)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Mario Bros', '','Action & Adventure','1985-10-18',9.63,57.63,571.75,9889)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Mario Bros 2', '','Action & Adventure','1988-10-01',9.95,27.81,437.90,12010)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Mario Bros 3', '','Action & Adventure','1990-02-12',9.99,34.25,450.01,9891)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Mario Bros Duck Hunt World Class Track Meet', '','Action & Adventure','1990-12-01',4.12,19.10,25.92,12452)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Mario Bros [5 Screw]', '','Action & Adventure','1985-10-18',12.99,159.00,306.00,37981)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Mario Bros and Duck Hunt', '','Action & Adventure','1988-11-01',1.37,24.78,42.79,12451)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Off Road', '','Racing','1992-02-01',7.81,22.14,66.32,12453)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Pitfall', '','Action & Adventure','1987-11-01',7.91,22.83,161.98,12454)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Pitfall [5 Screw]', '','Action & Adventure','1987-11-01',15.30,66.37,212.38,38043)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Russian Roulette [Homebrew]', '','Party','2017-07-03',0.00,0.00,0.00,61459)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Spike Volleyball', '','Sports','1990-06-01',4.62,15.42,45.09,9898)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Spike Volleyball and World Cup Soccer', '','Sports','1990-12-01',4.38,16.99,54.34,12455)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Sprint', '','Racing','1989-01-01',5.17,14.87,43.97,12456)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Spy Hunter', '','Racing','1992-02-01',29.99,64.32,201.60,9899)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Super Team Games', '','Sports','1988-11-01',4.43,14.66,39.99,12457)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Superman', '','Action & Adventure','1988-12-01',12.35,40.12,281.50,12458)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Swamp Thing', '','Action & Adventure','1992-12-01',97.81,280.50,590.38,9913)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Sword Master', '','Action & Adventure','1992-01-01',163.11,290.70,699.95,19306)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Swords and Serpents', '','Action & Adventure','1990-08-01',7.38,19.99,66.45,12459)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Taboo the Sixth Sense', '','Action & Adventure','1989-04-01',5.87,20.00,30.01,12462)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tag Team Wrestling', '','Wrestling','1986-10-01',4.93,14.70,51.69,12463)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tag Team Wrestling [5 Screw]', '','Wrestling','1986-10-01',5.00,20.51,51.63,37994)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tagin'' Dragon', '','Action & Adventure','1989-01-01',42.22,83.82,230.93,30846)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('TaleSpin', '','Action & Adventure','1991-12-01',14.77,43.99,195.65,12162)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Talking Super Jeopardy', '','Other','1991-09-01',5.35,9.99,34.50,12465)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Target Renegade', '','Action & Adventure','1990-03-01',5.99,21.43,49.28,12466)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tecmo Baseball', '','Baseball','1989-01-01',4.50,12.50,44.99,12467)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tecmo Bowl', '','Football','1989-02-01',5.75,16.50,90.00,9929)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tecmo Cup Soccer', '','Soccer','1992-09-01',46.99,98.07,261.27,9930)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tecmo NBA Basketball', '','Basketball','1992-11-01',7.56,13.47,54.00,9931)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tecmo Super Bowl', '','Football','1991-12-01',13.14,30.99,123.29,9934)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tecmo World Wrestling', '','Wrestling','1990-04-01',6.99,24.99,96.95,9938)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Teenage Mutant Ninja Turtles', '','Action & Adventure','1989-06-01',6.99,35.32,245.00,9941)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Teenage Mutant Ninja Turtles II', '','Action & Adventure','1990-12-01',10.98,45.77,282.90,12468)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Teenage Mutant Ninja Turtles III The Manhattan Project', '','Action & Adventure','1992-02-01',19.88,110.73,339.99,9942)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Teenage Mutant Ninja Turtles Tournament Fighters', '','Fighting','1994-02-01',116.32,425.00,1299.99,9944)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tennis', '','Sports','1985-10-18',5.65,29.18,93.48,12011)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tennis [5 Screw]', '','Sports','1985-10-18',9.18,30.00,83.58,37982)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Terminator', '','Action & Adventure','1992-12-01',15.00,36.29,144.79,9951)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Terminator 2 Judgment Day', '','Action & Adventure','1992-07-01',7.00,31.57,109.41,9953)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Terra Cresta', '','Action & Adventure','1990-03-01',32.74,56.36,165.85,12469)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tetris', '','Puzzle','1989-11-01',3.65,14.49,169.06,9964)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tetris 2', '','Puzzle','1993-10-01',4.27,13.97,50.00,9966)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tetris [Tengen]', '','Puzzle','',52.20,133.69,433.59,12595)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Adventures of Rocky and Bullwinkle and Friends', '','Action & Adventure','1992-12-01',11.12,30.89,92.78,8471)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Goonies II', '','Action & Adventure','1987-11-01',6.89,25.26,125.06,12471)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Goonies II [5 Screw]', '','Action & Adventure','1987-09-01',17.49,38.11,121.98,38040)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Guardian Legend', '','Action & Adventure','1989-04-01',12.53,44.99,146.74,12472)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Jungle Book', '','Action & Adventure','1994-08-01',27.15,71.00,149.95,9990)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Karate Kid', '','Action & Adventure','1987-11-01',6.11,40.30,140.00,12474)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Last Ninja', '','Action & Adventure','1991-02-01',15.23,65.27,209.27,12475)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Mafat Conspiracy', '','Action & Adventure','1990-06-01',8.87,20.50,32.74,12477)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Magic of Scheherazade', '','Action & Adventure','1989-12-01',12.77,35.42,106.01,12478)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Punisher', '','Action & Adventure','1990-11-01',17.99,68.79,184.99,9997)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Ren and Stimpy Show Buckeroos', '','Action & Adventure','1993-11-01',13.29,50.27,156.43,9648)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Rocketeer', '','Action & Adventure','1991-05-01',10.47,26.88,84.93,9677)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Simpsons Bart vs the Space Mutants', '','Action & Adventure','1991-02-01',7.89,34.07,167.25,12479)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Simpsons Bart vs the World', '','Action & Adventure','1991-12-01',7.57,27.37,137.60,12197)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Simpsons Bartman Meets Radioactive Man', '','Action & Adventure','1992-06-01',11.67,66.23,172.30,9751)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Three Stooges', '','Action & Adventure','1989-10-01',7.96,22.99,81.67,12480)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Uncanny X-Men', '','Action & Adventure','1989-12-01',9.75,38.69,136.97,12482)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('The Untouchables', '','Action & Adventure','1991-01-01',14.23,30.99,58.50,10096)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Thunder and Lightning', '','Action & Adventure','1990-12-01',11.55,34.29,107.45,12484)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Thunderbirds', '','Action & Adventure','1990-09-01',12.29,38.16,104.86,12485)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Thundercade', '','Action & Adventure','1989-07-01',7.95,20.78,61.61,12486)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tiger-Heli', '','Other','1987-09-01',3.80,17.24,72.13,12487)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tiger-Heli [5 Screw]', '','Action & Adventure','1987-09-01',16.82,29.70,95.04,38033)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tiles of Fate', '','Puzzle','1990-01-01',16.94,31.40,54.03,12488)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Time Lord', '','Action & Adventure','1990-09-01',5.65,17.45,41.04,12489)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Times of Lore', '','RPG','1991-05-01',47.28,113.50,363.20,10020)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tiny Toon Adventures', '','Action & Adventure','1991-12-01',9.84,31.50,118.48,10021)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tiny Toon Adventures 2 Trouble in Wackyland', '','Action & Adventure','1993-04-01',11.74,28.67,124.99,10022)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tiny Toon Adventures Cartoon Workshop', '','Action & Adventure','1992-12-01',11.97,26.66,52.98,10024)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('To the Earth', '','Action & Adventure','1989-11-01',3.79,15.07,41.62,12490)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Toki', '','Action & Adventure','1991-12-01',42.99,80.13,256.40,12491)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tom and Jerry', '','Action & Adventure','1991-12-01',9.23,36.76,84.66,10035)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Tombs and Treasure', '','Action & Adventure','1991-06-01',16.72,55.76,204.98,12492)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Toobin''', '','Action & Adventure','1989-01-01',12.00,24.36,77.90,12493)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Top Gun', '','Action & Adventure','1987-11-01',5.50,15.08,100.25,12494)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Top Gun The Second Mission', '','Other','1990-01-01',4.32,14.99,47.56,10052)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Top Gun [5 Screw]', '','Action & Adventure','1987-11-01',6.10,21.27,68.06,38044)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Top Loading Nintendo NES Console', '','Systems','',116.69,279.15,560.54,13883)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Top Players Tennis', '','Sports','1990-01-01',4.21,14.21,31.53,12495)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Total Recall', '','Action & Adventure','1990-08-01',6.49,19.99,90.00,10053)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Totally Rad', '','Racing','1991-03-01',13.99,46.69,129.79,12496)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Touchdown Fever', '','Football','1991-02-01',14.68,29.33,97.95,12497)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Town & Country II: Thrilla''s Surfari', '','Action & Adventure','1992-03-01',14.73,61.69,93.17,12483)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Town & Country Surf Designs: Wood and Water Rage', '','Sports','1988-02-01',4.82,23.97,90.94,12461)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Toxic Crusaders', '','Action & Adventure','1992-04-01',45.00,112.06,364.43,10056)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Track and Field', '','Sports','1987-04-01',6.61,28.24,51.89,12498)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Track and Field II', '','Sports','1989-06-01',3.95,13.50,55.98,12499)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Track and Field [5 Screw]', '','Sports','1987-04-01',7.75,29.20,66.14,38005)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Treasure Master', '','Action & Adventure','1991-12-01',13.74,34.99,146.21,10064)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Trog', '','Action & Adventure','1991-10-01',11.74,26.48,106.56,10068)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Trojan', '','Action & Adventure','1987-02-01',6.56,36.49,193.43,12500)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Trojan [5 Screw]', '','Action & Adventure','1987-02-01',7.32,25.95,83.04,38000)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Trolls on Treasure Island', '','Action & Adventure','1994-01-01',18.01,49.95,152.00,12501)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Twin Cobra', '','Action & Adventure','1990-01-01',11.44,24.40,59.99,12502)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Twin Eagle', '','Action & Adventure','1989-10-01',7.68,27.85,50.45,12503)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('UForce', '','Controllers','',19.42,55.00,161.79,54274)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultima Exodus', '','RPG','1989-02-01',9.53,19.99,166.11,12504)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultima Quest of the Avatar', '','RPG','1990-12-01',14.90,37.62,176.80,12505)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultima Warriors of Destiny', '','RPG','1993-01-01',56.58,94.10,338.97,10080)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultimate Air Combat', '','Action & Adventure','1992-04-01',19.95,41.81,119.99,10081)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultimate Basketball', '','Basketball','1990-09-01',3.97,14.97,44.37,12506)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultimate League Soccer', '','Soccer','1992-01-01',22.65,59.11,181.80,12507)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Ultimate Stuntman', '','Action & Adventure','1990-01-01',7.45,23.78,53.59,12481)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Uncharted Waters', '','Strategy','1991-11-01',60.11,94.98,199.31,10090)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Uninvited', '','Action & Adventure','1991-06-01',36.32,100.50,182.43,10091)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Urban Champion', '','Action & Adventure','1986-06-01',8.91,109.67,432.77,12012)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Urban Champion [5 Screw]', '','Action & Adventure','1986-06-01',10.45,26.89,86.05,37989)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Vegas Dream', '','Other','1990-03-01',3.67,9.85,43.00,12508)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Venice Beach Volleyball', '','Sports','1991-01-01',10.15,33.59,69.50,12509)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Vice Project Doom', '','Action & Adventure','1991-11-01',40.50,75.00,178.32,12510)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Videomation', '','Other','1991-06-01',7.45,21.21,39.96,10105)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Vindicators', '','Action & Adventure','1988-01-01',6.97,15.46,44.97,12511)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Volleyball', '','Sports','1987-03-01',11.37,41.17,445.69,12013)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Volleyball [5 Screw]', '','Sports','1987-03-01',9.75,82.21,149.80,38003)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('WCW World Championship Wrestling', '','Wrestling','1990-04-01',7.39,29.63,99.50,12512)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('WWF King of the Ring', '','Wrestling','1993-11-01',13.66,37.00,76.00,10214)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('WWF Wrestlemania', '','Wrestling','1989-01-01',3.73,18.13,99.85,10221)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('WWF Wrestlemania Challenge', '','Wrestling','1990-11-01',5.31,14.48,79.76,13833)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('WWF Wrestlemania Steel Cage Challenge', '','Wrestling','1992-09-01',7.00,21.61,62.76,10218)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wacky Races', '','Racing','1992-05-01',199.98,387.11,849.98,10132)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wall Street Kid', '','Strategy','1990-06-01',7.17,20.97,61.51,10133)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wally Bear and the No Gang', '','Action & Adventure','1992-01-01',31.05,70.23,227.37,12513)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wario''s Woods', '','Puzzle','1994-12-10',19.66,46.96,68.42,10138)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wayne Gretzky Hockey', '','Sports','1991-01-01',5.39,17.27,49.63,12514)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wayne''s World', '','Action & Adventure','1993-11-01',104.27,281.52,772.28,10146)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Werewolf', '','Action & Adventure','1990-11-01',11.63,36.46,133.02,12515)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wheel of Fortune', '','Other','1988-09-01',4.00,9.91,50.63,12517)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wheel of Fortune Family Edition', '','Other','1990-03-01',3.38,8.10,30.84,12516)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wheel of Fortune Featuring Vanna White', '','Other','1992-01-01',5.60,10.99,46.48,10149)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wheel of Fortune Junior Edition', '','Other','1989-10-01',4.34,11.78,80.00,12518)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Where in Time is Carmen Sandiego', '','Action & Adventure','1991-10-01',6.90,21.75,68.31,10152)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Where''s Waldo', '','Other','1991-09-01',5.32,23.98,61.11,12519)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Who Framed Roger Rabbit', '','Action & Adventure','1989-09-01',6.19,29.67,179.95,12520)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Whomp ''Em', '','Action & Adventure','1991-03-01',36.87,88.00,293.10,12521)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Widget', '','Action & Adventure','1992-11-01',44.85,132.33,249.95,10154)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wild Gunman', '','Other','1985-10-01',17.16,80.22,147.87,12522)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wild Gunman [5 Screw]', '','Action & Adventure','1985-10-01',17.55,69.07,151.14,37974)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Willow', '','Action & Adventure','1989-12-01',10.86,35.91,105.73,12523)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Win Lose or Draw', '','Other','1990-03-01',3.07,9.00,26.97,12524)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Winter Games', '','Sports','1987-09-01',3.00,16.75,623.79,12525)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Winter Games [5 Screw]', '','Sports','1987-09-01',6.99,16.58,53.06,38034)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wizardry: Knight of Diamonds Second Scenario', '','RPG','1992-04-01',23.45,53.74,159.90,10166)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wizardry: Proving Grounds of the Mad Overlord', '','RPG','1990-07-01',9.00,27.51,174.98,19592)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wizards and Warriors', '','RPG','1987-12-01',6.30,23.46,160.00,12528)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wizards and Warriors III Kuros Visions of Power', '','Action & Adventure','1992-03-01',14.99,45.74,115.77,10167)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wizards and Warriors [5 Screw]', '','Action & Adventure','1987-12-01',9.02,39.99,80.51,38046)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wolverine', '','Action & Adventure','1991-10-01',15.00,55.77,192.99,10169)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('World Champ', '','Sports','1991-04-01',25.74,69.50,97.00,10172)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('World Class Track Meet', '','Sports','1987-09-01',3.62,30.60,97.88,12530)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('World Games', '','Sports','1989-03-01',4.99,19.15,74.00,12532)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wrath of the Black Manta', '','Action & Adventure','1990-04-01',4.70,14.99,49.51,12533)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wrecking Crew', '','Action & Adventure','1985-10-01',13.99,86.48,1633.33,12014)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wrecking Crew [5 Screw]', '','Action & Adventure','1985-10-01',15.00,74.99,163.87,37975)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Wurm Journey to the Center of the Earth', '','Action & Adventure','1991-11-01',22.15,47.12,74.96,10208)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Xenophobe', '','Action & Adventure','1988-12-01',5.50,16.36,51.58,12534)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Xevious', '','Action & Adventure','1988-09-01',5.44,13.50,59.99,12015)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Xexyz', '','Action & Adventure','1990-04-01',12.00,32.51,134.52,12535)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Yo Noid', '','Action & Adventure','1990-11-01',12.25,38.99,227.96,12536)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Yoshi', '','Puzzle','1992-06-01',6.54,20.94,68.69,10228)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Yoshi''s Cookie', '','Puzzle','1993-04-01',4.48,15.50,68.99,10229)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Young Indiana Jones Chronicles', '','Action & Adventure','1992-12-01',45.00,91.10,125.00,10230)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zanac', '','Action & Adventure','1987-10-01',13.29,42.49,99.99,12016)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zanac [5 Screw]', '','Action & Adventure','1987-09-01',23.86,55.00,176.00,38038)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zapper Light Gun', '','Controllers','',11.73,33.05,97.36,13716)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zelda II The Adventure of Link', '','RPG','1988-09-01',10.68,56.50,356.64,10234)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zelda II The Adventure of Link [Gray Cart]', '','Action & Adventure','1993-01-01',11.95,37.64,105.33,38510)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zelda Test Cartridge', '','Other','',1312.51,0.00,0.00,20786)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zen Intergalactic Ninja', '','Action & Adventure','1993-03-01',60.00,149.99,581.00,10236)
  INSERT INTO [dbo].[Carts] ([Name],[ImageUrl],[Genre],[ReleaseDate],[Loose],[Cib],[New],[ProductId]) VALUES ('Zombie Nation', '','Other','1991-09-01',272.50,597.84,1789.99,10239)

END


-- MyCarts
BEGIN
    USE [NesVault]
​
    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('6', '5', 'Contra', 'Action/Adventure', '1988-02-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg', '18.09', null, '0')
​
    INSERT INTO [dbo].[MyCarts]
         ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('6', '4', 'Mike Tysons Punch Out','Sports', '1987-10-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/miketysonscart.jpg', '14.99', null, '0')
​
    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('2', '5', 'Contra', 'Action/Adventure', '1988-02-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg', '18.09', null, '0')
​
    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('3', '2', 'Double Dragon', 'Action/Adventure', '1988-06-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/doubledragoncart.jpg', '9.00', null, '0')
​
		INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('6', '2', 'Double Dragon', 'Action/Adventure', '1988-06-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/doubledragoncart.jpg', '9.00', null, '0')
​
		INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('4', '1', 'Teenage Mutant Ninja Turtles', 'Action/Adventure', '1989-06-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/tmnt1cart.jpg', '5.99', null, '0')
​
		INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('6', '1', 'Teenage Mutant Ninja Turtles', 'Action/Adventure', '1989-06-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/tmnt1cart.jpg', '5.99', null, '0')
​
		INSERT INTO [dbo].[MyCarts]
         ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('5', '3', 'Super Mario Bros 2', 'Action/Adventure', '1988-10-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/supermario2cart.jpg', '8.77', null, '0')
​
		INSERT INTO [dbo].[MyCarts]
         ([UserId], [CartsId], [Name], [Genre], [ReleaseDate], [ImageUrl], [Loose], [ProductId], [IsDeleted] )
    VALUES
        ('6', '3', 'Super Mario Bros 2', 'Action/Adventure', '1988-10-01', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/supermario2cart.jpg', '8.77', null, '0')
END
​
​
-- WishList
BEGIN
    USE [NesVault]
​
    INSERT INTO [dbo].[WishList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('1', '6', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/ducktalescart.jpg', 'Ducktales', 'Action/Adventure', '1989-09-01', '14.74', null, '0')
​
    INSERT INTO [dbo].[WishList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('1', '5', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg', 'Contra', 'Action/Adventure', '1988-02-01', '18.09', null , '0')
​
   INSERT INTO [dbo].[WishList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('2', '6', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/ducktalescart.jpg', 'Ducktales', 'Action/Adventure', '1989-09-01', '14.74', null, '0')
​
    INSERT INTO [dbo].[WishList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('3', '3', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/supermario2cart.jpg', 'Super Mario Bros 2', 'Action/Adventure', '1988-10-01', '8.77', null, '0')
​
		INSERT INTO [dbo].[WishList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('4', '5', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg', 'Contra', 'Action/Adventure', '1988-02-01', '18.09', null, '0')
​
	INSERT INTO [dbo].[WishList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('6', '2', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/doubledragoncart.jpg', 'Double Dragon', 'Action/Adventure', '1988-06-01', '9.00', null, '0' )
END

-- TradeList
BEGIN
    USE [NesVault]
​
    INSERT INTO [dbo].[TradeList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('1', '6', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/ducktalescart.jpg', 'Ducktales', 'Action/Adventure', '1989-09-01', '14.74', null, '0')
​
    INSERT INTO [dbo].[TradeList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('1', '5', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg', 'Contra', 'Action/Adventure', '1988-02-01', '18.09', null , '0')
​
   INSERT INTO [dbo].[TradeList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('2', '6', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/ducktalescart.jpg', 'Ducktales', 'Action/Adventure', '1989-09-01', '14.74', null, '0')
​
    INSERT INTO [dbo].[TradeList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('3', '3', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/supermario2cart.jpg', 'Super Mario Bros 2', 'Action/Adventure', '1988-10-01', '8.77', null, '0')
​
		INSERT INTO [dbo].[TradeList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('4', '5', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg', 'Contra', 'Action/Adventure', '1988-02-01', '18.09', null, '0')
​
	INSERT INTO [dbo].[TradeList]
        ([UserId], [CartId], [ImageUrl], [Name], [Genre], [ReleaseDate], [Loose], [ProductId], [IsDeleted])
    VALUES
        ('6', '2', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/doubledragoncart.jpg', 'Double Dragon', 'Action/Adventure', '1988-06-01', '9.00', null, '0' )
END
​
COMMIT TRANSACTION NES_SEED