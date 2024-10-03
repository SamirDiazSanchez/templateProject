/*
================================================================================
File name          : Profile.sql
Description        : table progile
Autor              : Samir Diaz
Created date       : 2-10-2024
Last update        : 2-10-2024 by Samir Diaz
Vertion            : 1.0
Notes              : notes
================================================================================
*/
CREATE TABLE [dbo].[Profile]
(
  [ProfileId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  [ProfileName] VARCHAR(100) NOT NULL,
  [Created] DATETIME NOT NULL,
  [Updated] DATETIME NOT NULL,
  [UserCreated] UNIQUEIDENTIFIER NOT NULL,
  [UserUpdated] UNIQUEIDENTIFIER NOT NULL,
  [IsActive] BIT DEFAULT 1,
  CONSTRAINT [FK_PROFILE_CREATED] FOREIGN KEY ([UserCreated]) REFERENCES [User]([UserId]),
  CONSTRAINT [FK_PROFILE_UPDATED] FOREIGN KEY ([UserUpdated]) REFERENCES [User]([UserId])
)
