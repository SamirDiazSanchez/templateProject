/*
================================================================================
File name          : User.sql
Description        : User table
Autor              : Samir Diaz
Created date       : 2-10-2024
Last update        : 2-10-2024 by Samir Diaz
Vertion            : 1.0
Notes              : notes
================================================================================
*/
CREATE TABLE [dbo].[User]
(
  [UserId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  [Email] VARCHAR(200) NOT NULL UNIQUE,
  [UserName] VARCHAR(150) NOT NULL,
  [ProfileId] UNIQUEIDENTIFIER NULL,
  [Password] VARCHAR(200) NOT NULL,
  [Created] DATETIME NOT NULL,
  [Updated] DATETIME NOT NULL,
  [UserCreated] UNIQUEIDENTIFIER NOT NULL,
  [UserUpdated] UNIQUEIDENTIFIER NOT NULL,
  [IsActive] BIT DEFAULT 1,
  CONSTRAINT [FK_USER_CREATED] FOREIGN KEY ([UserCreated]) REFERENCES [User]([UserId]),
  CONSTRAINT [FK_USER_UPDATED] FOREIGN KEY ([UserUpdated]) REFERENCES [User]([UserId])
)
GO