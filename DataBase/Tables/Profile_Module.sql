/*
================================================================================
  File name          : Profile_Module.sql
  Description        : profile module relation table
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE TABLE [dbo].[Profile_Module]
(
  [ProfileId] UNIQUEIDENTIFIER NOT NULL,
  [ModuleId] UNIQUEIDENTIFIER NOT NULL,
  [Created] DATETIME NOT NULL,
  [Updated] DATETIME NOT NULL,
  [UserCreated] UNIQUEIDENTIFIER NOT NULL,
  [UserUpdated] UNIQUEIDENTIFIER NOT NULL,
  [IsActive] BIT DEFAULT 1,
  PRIMARY KEY ([ProfileId], [ModuleId]),
  CONSTRAINT [FK_PROFILE_MODULE_CREATED] FOREIGN KEY ([UserCreated]) REFERENCES [User]([UserId]),
  CONSTRAINT [FK_PROFILE_MODULE_UPDATED] FOREIGN KEY ([UserUpdated]) REFERENCES [User]([UserId])
)
GO