/*
================================================================================
  File name          : Select_ModuleByProfile.sql
  Description        : get list module by profile
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE PROCEDURE [dbo].[Select_ModuleByProfile]
  @ProfileId UNIQUEIDENTIFIER = NULL
AS
BEGIN
  SET NOCOUNT ON;

  SELECT
    A.[ModuleId],
    B.[ModuleName],
    B.[ModulePath],
    B.[Created],
    B.[Updated],
    B.[UserCreated],
    B.[UserUpdated]
  FROM [Profile_Module] A
  INNER JOIN [Module] B ON A.[ModuleId] = B.[ModuleId] AND B.[IsActive] = 1
  
END
GO