/*
================================================================================
  File name          : Module.sql
  Description        : module table
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE TABLE [dbo].[Module]
(
  [ModuleId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  [ModuleName] VARCHAR(150) NOT NULL UNIQUE,
  [ModulePath] VARCHAR(200) NOT NULL,
  [Created] DATETIME NOT NULL,
  [Updated] DATETIME NOT NULL,
  [UserCreated] UNIQUEIDENTIFIER NOT NULL,
  [UserUpdated] UNIQUEIDENTIFIER NOT NULL,
  [IsActive] BIT DEFAULT 1,
  CONSTRAINT [FK_MODULE_CREATED] FOREIGN KEY ([UserCreated]) REFERENCES [User]([UserId]),
  CONSTRAINT [FK_MODULE_UPDATED] FOREIGN KEY ([UserUpdated]) REFERENCES [User]([UserId])
)
GO