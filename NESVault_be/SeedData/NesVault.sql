--DROP DATABASE [ IF EXISTS ] { database_name | database_snapshot_name } [ ,...n ] [;]
IF EXISTS (
        SELECT [name]
FROM sys.databases
WHERE [name] = N'NesVault'
        )
BEGIN
    -- Delete Database Backup and Restore History from MSDB System Database
    EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'NesVault'

    -- GO
    -- Close Connections
    USE [master]

    -- GO
    ALTER DATABASE [NesVault]

    SET SINGLE_USER
    WITH

    ROLLBACK IMMEDIATE

    -- GO
    -- Drop Database in SQL Server
    DROP DATABASE [NesVault]
-- GO
END

-- Create a new database called 'NesVault'
-- Connect to the 'master' database to run this snippet
USE master
GO

-- Create the new database if it does not exist already
IF NOT EXISTS (
        SELECT [name]
FROM sys.databases
WHERE [name] = N'NesVault'
        )
    CREATE DATABASE NesVault
GO

USE NesVault
GO

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/sweMRF
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
SET XACT_ABORT ON

BEGIN TRANSACTION NES_CREATE

CREATE TABLE [Carts] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [Name] nvarchar(255)  NOT NULL ,
    [Genre] nvarchar(255)  NOT NULL ,
	[ReleaseDate] datetime  NOT NULL ,
    [Loose] decimal(8,2)  NOT NULL ,
	[Cib] decimal(8,2)  NOT NULL ,
	[New] decimal(8,2)  NOT NULL ,
    CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)

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

CREATE TABLE [Wishlist] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [UserId] int  NOT NULL ,
    [CartId] int  NOT NULL ,
    CONSTRAINT [PK_Wishlist] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)

CREATE TABLE [TradeList] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [InitiatingUserId] int  NOT NULL ,
    [AcceptinguserId] int  NOT NULL ,
    [TradeCartId] int  NOT NULL ,
    [ReceivingCartId] int  NOT NULL ,
    [Accepted] bit  NOT NULL ,
    CONSTRAINT [PK_TradeList] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)

CREATE TABLE [MyCarts] (
    [Id] int IDENTITY(1,1) NOT NULL ,
	[ImageUrl] nvarchar(255) NULL ,
    [UserId] int  NOT NULL ,
    [CartsId] int  NOT NULL ,
    CONSTRAINT [PK_MyCarts] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)

--ALTER TABLE [Carts] WITH CHECK ADD CONSTRAINT [FK_Carts_Id] FOREIGN KEY([Id])
--REFERENCES [MyCarts] ([UserId])

--ALTER TABLE [Carts] CHECK CONSTRAINT [FK_Carts_Id]

ALTER TABLE [Wishlist] WITH CHECK ADD CONSTRAINT [FK_Wishlist_UserId] FOREIGN KEY([UserId])
REFERENCES [Users] ([Id])

ALTER TABLE [Wishlist] CHECK CONSTRAINT [FK_Wishlist_UserId]

ALTER TABLE [Wishlist] WITH CHECK ADD CONSTRAINT [FK_Wishlist_CartId] FOREIGN KEY([CartId])
REFERENCES [Carts] ([Id])

ALTER TABLE [Wishlist] CHECK CONSTRAINT [FK_Wishlist_CartId]

ALTER TABLE [MyCarts] WITH CHECK ADD CONSTRAINT [FK_MyCarts_UserId] FOREIGN KEY([UserId])
REFERENCES [Users] ([Id])

ALTER TABLE [MyCarts] CHECK CONSTRAINT [FK_MyCarts_UserId]

ALTER TABLE [MyCarts] WITH CHECK ADD CONSTRAINT [FK_MyCarts_CartsId] FOREIGN KEY([CartsId])
REFERENCES [Carts] ([Id])

ALTER TABLE [MyCarts] CHECK CONSTRAINT [FK_MyCarts_CartsId]

--CREATE INDEX [idx_Users_FirstName]
--ON [Users] ([FirstName])

COMMIT TRANSACTION NES_CREATE

USE [master]
GO

ALTER DATABASE [NesVault]

SET READ_WRITE
GO

BEGIN TRANSACTION NES_SEED

-- USERS
BEGIN
    USE [NesVault]

    INSERT INTO [dbo].[Users]
        ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Billy', 'Blanks', 'BlankMan2', 'Contra', 'myemail45@gmail.com', 'QUZNyHcNTDomtpT9Kjmg4PUY3iEr', '0')

    INSERT INTO [dbo].[Users]
       ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Roy', 'Thomas', 'ThomasIsHere', 'TMNT 2: The Arcade Game', 'myemail46@gmail.com', 'BxZHxeTU8myVsZr4zwGPJWDYykwe', '0')

    INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Jenny', 'Jumprope', 'JennyHatesYou7', 'Dr. Mario', 'myemail47@gmail.com', 'eZ2CWnThMXu7ZqbEjxNyQWZCoZhs', '0')
    
    INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Joey', 'Fatone', 'NsyncSucks', 'Tetris', 'myemail48@gmail.com', 'Qx4oZpGEsuWE7uPsHFETTYUyuprB', '0')

	INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Tinker', 'Jones', 'TinkTink45', 'Super Mario Bros. 3', 'myemail49@gmail.com', 'yY66USNBdQaZml8uxQ9K8v7eiVm6', '1')

		INSERT INTO [dbo].[Users]
         ([FirstName], [LastName], [UserName], [FavoriteGame], [Email], [FireBaseUid], [IsDeleted])
    VALUES
        ('Jonathan', 'Mohan', 'CashVillin', 'The Legend of Zelda', 'myemail50@gmail.com', 'BOdzarezTGWZ1lgHt5uAm6neCnl2', '0')

END

-- Carts
BEGIN
    USE [NesVault]

    INSERT INTO [dbo].[Carts]
        ([Name], [Genre], [ReleaseDate], [Loose], [Cib], [New])
    VALUES
        ('Teenage Mutant Ninja Turtles', 'Action/Adventure', '1989-06-01', '5.99', '30.00', '245.00' )

    INSERT INTO [dbo].[Carts]
        ([Name], [Genre], [ReleaseDate], [Loose], [Cib], [New])
    VALUES
        ('Double Dragon', 'Action/Adventure', '1988-06-01', '9.00', '39.31', '499.13' )

    INSERT INTO [dbo].[Carts]
        ([Name], [Genre], [ReleaseDate], [Loose], [Cib], [New])
    VALUES
        ('Super Mario Bros 2', 'Action/Adventure', '1988-10-01', '8.77', '27.00', '404.50' )

    INSERT INTO [dbo].[Carts]
        ([Name], [Genre], [ReleaseDate], [Loose], [Cib], [New])
    VALUES
        ('Mike Tysons Punch Out', 'Sports', '1987-10-01', '14.99', '101.25', '1106.99' )

		INSERT INTO [dbo].[Carts]
        ([Name], [Genre], [ReleaseDate], [Loose], [Cib], [New])
    VALUES
        ('Contra', 'Action/Adventure', '1988-02-01', '18.09', '57.57', '917.50' )

	INSERT INTO [dbo].[Carts]
        ([Name], [Genre], [ReleaseDate], [Loose], [Cib], [New])
    VALUES
        ('Ducktales', 'Action/Adventure', '1989-09-01', '14.74', '56.28', '501.83' )
END

-- MyCarts
BEGIN
    USE [NesVault]

    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [ImageUrl])
    VALUES
        ('6', '5', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg')

    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [ImageUrl])
    VALUES
        ('6', '4', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/miketysonscart.jpg')

    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [ImageUrl])
    VALUES
        ('2', '5', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/contracart.jpg')

    INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [ImageUrl])
    VALUES
        ('3', '2', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/doubledragoncart.jpg')

		INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [ImageUrl])
    VALUES
        ('4', '1', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/tmnt1cart.jpg')

		INSERT INTO [dbo].[MyCarts]
        ([UserId], [CartsId], [ImageUrl])
    VALUES
        ('5', '3', 'https://images.lukiegames.com/t_300e2/assets/images/NES/Cartscans/supermario2cart.jpg')
END


-- WishList
BEGIN
    USE [NesVault]

    INSERT INTO [dbo].[WishList]
        ([UserId], [CartId])
    VALUES
        ('1', '6')

    INSERT INTO [dbo].[WishList]
        ([UserId], [CartId])
    VALUES
        ('1', '5')

   INSERT INTO [dbo].[WishList]
        ([UserId], [CartId])
    VALUES
        ('2', '6')

    INSERT INTO [dbo].[WishList]
        ([UserId], [CartId])
    VALUES
        ('3', '3')

		INSERT INTO [dbo].[WishList]
        ([UserId], [CartId])
    VALUES
        ('4', '5')

	INSERT INTO [dbo].[WishList]
        ([UserId], [CartId])
    VALUES
        ('5', '2')
END

-- TradeList
BEGIN
    USE [NesVault]

    INSERT INTO [dbo].[TradeList]
        ([InitiatingUserId], [AcceptingUserId], [TradeCartId], [ReceivingCartId], [Accepted])
    VALUES
        ('1', '5', '1', '3', '0')

    INSERT INTO [dbo].[TradeList]
        ([InitiatingUserId], [AcceptingUserId], [TradeCartId], [ReceivingCartId], [Accepted])
    VALUES
        ('2', '5', '2', '4', '1')

   INSERT INTO [dbo].[TradeList]
        ([InitiatingUserId], [AcceptingUserId], [TradeCartId], [ReceivingCartId], [Accepted])
    VALUES
        ('1', '2', '4', '2', '1')

    INSERT INTO [dbo].[TradeList]
        ([InitiatingUserId], [AcceptingUserId], [TradeCartId], [ReceivingCartId], [Accepted])
    VALUES
        ('4', '5', '5', '2', '0')

		INSERT INTO [dbo].[TradeList]
        ([InitiatingUserId], [AcceptingUserId], [TradeCartId], [ReceivingCartId], [Accepted])
    VALUES
        ('3', '1', '4', '3', '1')

	INSERT INTO [dbo].[TradeList]
        ([InitiatingUserId], [AcceptingUserId], [TradeCartId], [ReceivingCartId], [Accepted])
    VALUES
        ('1', '2', '2', '4', '1')
END

COMMIT TRANSACTION NES_SEED