/*
================================================================================
  File name          : Select_ModuleList.sql
  Description        : get module list store procedure
  Autor              : Samir Diaz
  Created date       : 2-10-2024
  Last update        : 2-10-2024 by Samir Diaz
  Vertion            : 1.0
  Notes              : notes
================================================================================
*/
CREATE PROCEDURE [dbo].[Select_ModuleList]
  @Page INT = 1,
  @RowsPerPage INT = 15,
  @Rows INT OUT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @Offset INT = (@Page - 1) * @RowsPerPage;
  SELECT @Rows = COUNT(*) FROM [module];

  SELECT
    [moduleId],
    [Created],
    [Updated],
    [UserCreated],
    [UserUpdated],
    [IsActive]
  FROM [module]
  ORDER BY [moduleId]
  OFFSET @Offset ROWS
  FETCH NEXT @RowsPerPage ROWS ONLY;
END
GO